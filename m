From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 8/8] ASoC: Factor out 7 bit register 9 bit data
	SPI write
Date: Mon,  3 Aug 2009 17:09:50 +0100
Message-ID: <1249315790-22814-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1249315790-22814-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7C9B24795
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 18:09:54 +0200 (CEST)
In-Reply-To: <1249315790-22814-7-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This converts all the Wolfson drivers using this format (the only devices
that do) except WM8753 to use it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8510.c |   25 -------------------------
 sound/soc/codecs/wm8728.c |   25 -------------------------
 sound/soc/codecs/wm8731.c |   25 -------------------------
 sound/soc/codecs/wm8750.c |   25 -------------------------
 sound/soc/codecs/wm8988.c |   25 -------------------------
 sound/soc/soc-cache.c     |   39 ++++++++++++++++++++++++++++++++++++---
 6 files changed, 36 insertions(+), 128 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 4ca724f..bcd6a40 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -737,30 +737,6 @@ static struct spi_driver wm8510_spi_driver = {
 	.probe		= wm8510_spi_probe,
 	.remove		= __devexit_p(wm8510_spi_remove),
 };
-
-static int wm8510_spi_write(struct spi_device *spi, const char *data, int len)
-{
-	struct spi_transfer t;
-	struct spi_message m;
-	u8 msg[2];
-
-	if (len <= 0)
-		return 0;
-
-	msg[0] = data[0];
-	msg[1] = data[1];
-
-	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
-}
 #endif /* CONFIG_SPI_MASTER */
 
 static int wm8510_probe(struct platform_device *pdev)
@@ -790,7 +766,6 @@ static int wm8510_probe(struct platform_device *pdev)
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	if (setup->spi) {
-		codec->hw_write = (hw_write_t)wm8510_spi_write;
 		ret = spi_register_driver(&wm8510_spi_driver);
 		if (ret != 0)
 			printk(KERN_ERR "can't add spi driver");
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index a28630d..16e969a 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -425,30 +425,6 @@ static struct spi_driver wm8728_spi_driver = {
 	.probe		= wm8728_spi_probe,
 	.remove		= __devexit_p(wm8728_spi_remove),
 };
-
-static int wm8728_spi_write(struct spi_device *spi, const char *data, int len)
-{
-	struct spi_transfer t;
-	struct spi_message m;
-	u8 msg[2];
-
-	if (len <= 0)
-		return 0;
-
-	msg[0] = data[0];
-	msg[1] = data[1];
-
-	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
-}
 #endif /* CONFIG_SPI_MASTER */
 
 static int wm8728_probe(struct platform_device *pdev)
@@ -478,7 +454,6 @@ static int wm8728_probe(struct platform_device *pdev)
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	if (setup->spi) {
-		codec->hw_write = (hw_write_t)wm8728_spi_write;
 		ret = spi_register_driver(&wm8728_spi_driver);
 		if (ret != 0)
 			printk(KERN_ERR "can't add spi driver");
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 27fc942..6232afd 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -591,30 +591,6 @@ static void wm8731_unregister(struct wm8731_priv *wm8731)
 }
 
 #if defined(CONFIG_SPI_MASTER)
-static int wm8731_spi_write(struct spi_device *spi, const char *data, int len)
-{
-	struct spi_transfer t;
-	struct spi_message m;
-	u8 msg[2];
-
-	if (len <= 0)
-		return 0;
-
-	msg[0] = data[0];
-	msg[1] = data[1];
-
-	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
-}
-
 static int __devinit wm8731_spi_probe(struct spi_device *spi)
 {
 	struct snd_soc_codec *codec;
@@ -626,7 +602,6 @@ static int __devinit wm8731_spi_probe(struct spi_device *spi)
 
 	codec = &wm8731->codec;
 	codec->control_data = spi;
-	codec->hw_write = (hw_write_t)wm8731_spi_write;
 	codec->dev = &spi->dev;
 
 	dev_set_drvdata(&spi->dev, wm8731);
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index e6422b1..4ba1e7e 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -911,30 +911,6 @@ static struct spi_driver wm8750_spi_driver = {
 	.probe		= wm8750_spi_probe,
 	.remove		= __devexit_p(wm8750_spi_remove),
 };
-
-static int wm8750_spi_write(struct spi_device *spi, const char *data, int len)
-{
-	struct spi_transfer t;
-	struct spi_message m;
-	u8 msg[2];
-
-	if (len <= 0)
-		return 0;
-
-	msg[0] = data[0];
-	msg[1] = data[1];
-
-	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
-}
 #endif
 
 static int wm8750_probe(struct platform_device *pdev)
@@ -973,7 +949,6 @@ static int wm8750_probe(struct platform_device *pdev)
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	if (setup->spi) {
-		codec->hw_write = (hw_write_t)wm8750_spi_write;
 		ret = spi_register_driver(&wm8750_spi_driver);
 		if (ret != 0)
 			printk(KERN_ERR "can't add spi driver");
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 7486d3e..1c86535 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -979,30 +979,6 @@ static struct i2c_driver wm8988_i2c_driver = {
 #endif
 
 #if defined(CONFIG_SPI_MASTER)
-static int wm8988_spi_write(struct spi_device *spi, const char *data, int len)
-{
-	struct spi_transfer t;
-	struct spi_message m;
-	u8 msg[2];
-
-	if (len <= 0)
-		return 0;
-
-	msg[0] = data[0];
-	msg[1] = data[1];
-
-	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
-}
-
 static int __devinit wm8988_spi_probe(struct spi_device *spi)
 {
 	struct wm8988_priv *wm8988;
@@ -1013,7 +989,6 @@ static int __devinit wm8988_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	codec = &wm8988->codec;
-	codec->hw_write = (hw_write_t)wm8988_spi_write;
 	codec->control_data = spi;
 	codec->dev = &spi->dev;
 
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index ab058b8..56ec3f2 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <sound/soc.h>
 
 static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
@@ -46,6 +47,36 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 		return -EIO;
 }
 
+#if defined(CONFIG_SPI_MASTER)
+static int snd_soc_7_9_spi_write(void *control_data, const char *data,
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
+#define snd_soc_7_9_spi_write NULL
+#endif
+
 static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 			      unsigned int value)
 {
@@ -115,12 +146,12 @@ static struct {
 	int addr_bits;
 	int data_bits;
 	int (*write)(struct snd_soc_codec *codec, unsigned int, unsigned int);
+	int (*spi_write)(void *, const char *, int);
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	unsigned int (*i2c_read)(struct snd_soc_codec *, unsigned int);
 } io_types[] = {
-	{ 7, 9, snd_soc_7_9_write, snd_soc_7_9_read },
-	{ 8, 16,
-	  snd_soc_8_16_write, snd_soc_8_16_read,
+	{ 7, 9, snd_soc_7_9_write, snd_soc_7_9_spi_write, snd_soc_7_9_read },
+	{ 8, 16, snd_soc_8_16_write, NULL, snd_soc_8_16_read,
 	  snd_soc_8_16_read_i2c },
 };
 
@@ -177,6 +208,8 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_SPI:
+		if (io_types[i].spi_write)
+			codec->hw_write = io_types[i].spi_write;
 		break;
 	}
 
-- 
1.6.3.3
