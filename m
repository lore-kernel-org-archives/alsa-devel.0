From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Add spi_write support for all
	I/O types
Date: Mon,  4 Oct 2010 11:25:13 +0100
Message-ID: <1286187913-6600-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A69B243F8
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 12:25:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Ensure that all drivers that use SPI and I2C will work properly
by providing SPI write functions for all different I/O types.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   96 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 62f1e2b..d214f02 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -211,6 +211,36 @@ static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 	return cache[reg];
 }
 
+#if defined(CONFIG_SPI_MASTER)
+static int snd_soc_8_8_spi_write(void *control_data, const char *data,
+				 int len)
+{
+	struct spi_device *spi = control_data;
+	struct spi_transfer t;
+	struct spi_message m;
+	u8 msg[2];
+
+	if (len <= 0)
+		return 0;
+
+	msg[0] = data[0];
+	msg[1] = data[1];
+
+	spi_message_init(&m);
+	memset(&t, 0, (sizeof t));
+
+	t.tx_buf = &msg[0];
+	t.len = len;
+
+	spi_message_add_tail(&t, &m);
+	spi_sync(spi, &m);
+
+	return len;
+}
+#else
+#define snd_soc_8_8_spi_write NULL
+#endif
+
 static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 			      unsigned int value)
 {
@@ -254,6 +284,37 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 	}
 }
 
+#if defined(CONFIG_SPI_MASTER)
+static int snd_soc_8_16_spi_write(void *control_data, const char *data,
+				 int len)
+{
+	struct spi_device *spi = control_data;
+	struct spi_transfer t;
+	struct spi_message m;
+	u8 msg[3];
+
+	if (len <= 0)
+		return 0;
+
+	msg[0] = data[0];
+	msg[1] = data[1];
+	msg[2] = data[2];
+
+	spi_message_init(&m);
+	memset(&t, 0, (sizeof t));
+
+	t.tx_buf = &msg[0];
+	t.len = len;
+
+	spi_message_add_tail(&t, &m);
+	spi_sync(spi, &m);
+
+	return len;
+}
+#else
+#define snd_soc_8_16_spi_write NULL
+#endif
+
 #if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
 static unsigned int snd_soc_8_8_read_i2c(struct snd_soc_codec *codec,
 					  unsigned int r)
@@ -518,6 +579,38 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 		return -EIO;
 }
 
+#if defined(CONFIG_SPI_MASTER)
+static int snd_soc_16_16_spi_write(void *control_data, const char *data,
+				 int len)
+{
+	struct spi_device *spi = control_data;
+	struct spi_transfer t;
+	struct spi_message m;
+	u8 msg[4];
+
+	if (len <= 0)
+		return 0;
+
+	msg[0] = data[0];
+	msg[1] = data[1];
+	msg[2] = data[2];
+	msg[3] = data[3];
+
+	spi_message_init(&m);
+	memset(&t, 0, (sizeof t));
+
+	t.tx_buf = &msg[0];
+	t.len = len;
+
+	spi_message_add_tail(&t, &m);
+	spi_sync(spi, &m);
+
+	return len;
+}
+#else
+#define snd_soc_16_16_spi_write NULL
+#endif
+
 static struct {
 	int addr_bits;
 	int data_bits;
@@ -540,11 +633,13 @@ static struct {
 		.addr_bits = 8, .data_bits = 8,
 		.write = snd_soc_8_8_write, .read = snd_soc_8_8_read,
 		.i2c_read = snd_soc_8_8_read_i2c,
+		.spi_write = snd_soc_8_8_spi_write,
 	},
 	{
 		.addr_bits = 8, .data_bits = 16,
 		.write = snd_soc_8_16_write, .read = snd_soc_8_16_read,
 		.i2c_read = snd_soc_8_16_read_i2c,
+		.spi_write = snd_soc_8_16_spi_write,
 	},
 	{
 		.addr_bits = 16, .data_bits = 8,
@@ -556,6 +651,7 @@ static struct {
 		.addr_bits = 16, .data_bits = 16,
 		.write = snd_soc_16_16_write, .read = snd_soc_16_16_read,
 		.i2c_read = snd_soc_16_16_read_i2c,
+		.spi_write = snd_soc_16_16_spi_write,
 	},
 };
 
-- 
1.7.3.1
