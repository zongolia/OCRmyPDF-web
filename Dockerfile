FROM jbarlow83/ocrmypdf

# 安装中英文语言包
USER root
RUN apt-get update && \
    apt-get install -y tesseract-ocr-chi-sim tesseract-ocr-eng && \
    rm -rf /var/lib/apt/lists/*

# 创建应用目录
RUN mkdir /app
WORKDIR /app

# 添加依赖文件并安装
ADD requirements.txt /app
RUN . /appenv/bin/activate && pip install -r requirements.txt

# 添加应用文件
ADD server.py index.htm entrypoint.sh /app/
ADD static /app/static/

# 暴露Web访问端口
EXPOSE 12345

# 切换用户并设置入口点
USER docker
ENTRYPOINT ["/app/entrypoint.sh"]
