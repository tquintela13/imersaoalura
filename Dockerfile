# Use uma imagem oficial do Python como imagem base.
# O readme menciona Python 3.10+, então `python:3.10-slim` é uma boa escolha por ser leve.
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
# Copiamos este arquivo separadamente para aproveitar o cache de camadas do Docker.
COPY requirements.txt .

# Instala as dependências do projeto.
# A flag --no-cache-dir reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta em que o Uvicorn será executado.
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner for iniciado.
# Usamos "0.0.0.0" para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]