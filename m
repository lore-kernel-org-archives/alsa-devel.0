From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 09/11] ASoC: Shuffle WM8731 SPI and I2C device
	registration
Date: Wed, 18 Feb 2009 12:02:31 +0000
Message-ID: <1234958553-16049-9-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B927F10388D
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:18:16 +0100 (CET)
In-Reply-To: <20090218120135.GA15414@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is a pure code motion patch intended to improve reviewability of a
following patch moving WM8731 to use more standard device registration.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |  215 +++++++++++++++++++++++---------------------
 1 files changed, 112 insertions(+), 103 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index c6db677..3ff971a 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -36,6 +36,11 @@ struct wm8731_priv {
 	unsigned int sysclk;
 };
 
+#ifdef CONFIG_SPI_MASTER
+static int wm8731_spi_write(struct spi_device *spi, const char *data, int len);
+static struct spi_driver wm8731_spi_driver;
+#endif
+
 /*
  * wm8731 register cache
  * We can't read the WM8731 register space when we are
@@ -544,54 +549,9 @@ pcm_err:
 
 static struct snd_soc_device *wm8731_socdev;
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-
-/*
- * WM8731 2 wire address is determined by GPIO5
- * state during powerup.
- *    low  = 0x1a
- *    high = 0x1b
- */
-
-static int wm8731_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
-{
-	struct snd_soc_device *socdev = wm8731_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
-
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
-
-	ret = wm8731_init(socdev);
-	if (ret < 0)
-		pr_err("failed to initialise WM8731\n");
-
-	return ret;
-}
 
-static int wm8731_i2c_remove(struct i2c_client *client)
-{
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
-	return 0;
-}
-
-static const struct i2c_device_id wm8731_i2c_id[] = {
-	{ "wm8731", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, wm8731_i2c_id);
-
-static struct i2c_driver wm8731_i2c_driver = {
-	.driver = {
-		.name = "WM8731 I2C Codec",
-		.owner = THIS_MODULE,
-	},
-	.probe =    wm8731_i2c_probe,
-	.remove =   wm8731_i2c_remove,
-	.id_table = wm8731_i2c_id,
-};
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static struct i2c_driver wm8731_i2c_driver;
 
 static int wm8731_add_i2c_device(struct platform_device *pdev,
 				 const struct wm8731_setup_data *setup)
@@ -634,62 +594,6 @@ err_driver:
 }
 #endif
 
-#if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8731_spi_probe(struct spi_device *spi)
-{
-	struct snd_soc_device *socdev = wm8731_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
-
-	codec->control_data = spi;
-
-	ret = wm8731_init(socdev);
-	if (ret < 0)
-		dev_err(&spi->dev, "failed to initialise WM8731\n");
-
-	return ret;
-}
-
-static int __devexit wm8731_spi_remove(struct spi_device *spi)
-{
-	return 0;
-}
-
-static struct spi_driver wm8731_spi_driver = {
-	.driver = {
-		.name	= "wm8731",
-		.bus	= &spi_bus_type,
-		.owner	= THIS_MODULE,
-	},
-	.probe		= wm8731_spi_probe,
-	.remove		= __devexit_p(wm8731_spi_remove),
-};
-
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
-#endif /* CONFIG_SPI_MASTER */
-
 static int wm8731_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
@@ -772,6 +676,111 @@ struct snd_soc_codec_device soc_codec_dev_wm8731 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8731);
 
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit wm8731_spi_probe(struct spi_device *spi)
+{
+	struct snd_soc_device *socdev = wm8731_socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	int ret;
+
+	codec->control_data = spi;
+
+	ret = wm8731_init(socdev);
+	if (ret < 0)
+		dev_err(&spi->dev, "failed to initialise WM8731\n");
+
+	return ret;
+}
+
+static int __devexit wm8731_spi_remove(struct spi_device *spi)
+{
+	return 0;
+}
+
+static struct spi_driver wm8731_spi_driver = {
+	.driver = {
+		.name	= "wm8731",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= wm8731_spi_probe,
+	.remove		= __devexit_p(wm8731_spi_remove),
+};
+
+static int wm8731_spi_write(struct spi_device *spi, const char *data, int len)
+{
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
+#endif /* CONFIG_SPI_MASTER */
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+/*
+ * WM8731 2 wire address is determined by GPIO5
+ * state during powerup.
+ *    low  = 0x1a
+ *    high = 0x1b
+ */
+
+static int wm8731_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct snd_soc_device *socdev = wm8731_socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	int ret;
+
+	i2c_set_clientdata(i2c, codec);
+	codec->control_data = i2c;
+
+	ret = wm8731_init(socdev);
+	if (ret < 0)
+		pr_err("failed to initialise WM8731\n");
+
+	return ret;
+}
+
+static int wm8731_i2c_remove(struct i2c_client *client)
+{
+	struct snd_soc_codec *codec = i2c_get_clientdata(client);
+	kfree(codec->reg_cache);
+	return 0;
+}
+
+static const struct i2c_device_id wm8731_i2c_id[] = {
+	{ "wm8731", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8731_i2c_id);
+
+static struct i2c_driver wm8731_i2c_driver = {
+	.driver = {
+		.name = "WM8731 I2C Codec",
+		.owner = THIS_MODULE,
+	},
+	.probe =    wm8731_i2c_probe,
+	.remove =   wm8731_i2c_remove,
+	.id_table = wm8731_i2c_id,
+};
+#endif
+
 static int __init wm8731_modinit(void)
 {
 	return snd_soc_register_dai(&wm8731_dai);
-- 
1.5.6.3
