From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/7] ASoC: Shuffle WM8753 device registration
	code
Date: Wed, 25 Feb 2009 10:48:20 +0000
Message-ID: <1235558902-20314-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090225104701.GA20221@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A95B24443
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 11:48:24 +0100 (CET)
In-Reply-To: <20090225104701.GA20221@rakim.wolfsonmicro.main>
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

This patch should be pure code motion, separating that out from the
functional changes to move to new style device registration.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8753.c |  209 +++++++++++++++++++++++----------------------
 1 files changed, 105 insertions(+), 104 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 93c22c4..4b42688 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -51,6 +51,11 @@
 
 #include "wm8753.h"
 
+#ifdef CONFIG_SPI_MASTER
+static struct spi_driver wm8753_spi_driver;
+static int wm8753_spi_write(struct spi_device *spi, const char *data, int len);
+#endif
+
 static int caps_charge = 2000;
 module_param(caps_charge, int, 0);
 MODULE_PARM_DESC(caps_charge, "WM8753 cap charge time (msecs)");
@@ -1626,53 +1631,7 @@ pcm_err:
 static struct snd_soc_device *wm8753_socdev;
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-
-/*
- * WM8753 2 wire address is determined by GPIO5
- * state during powerup.
- *    low  = 0x1a
- *    high = 0x1b
- */
-
-static int wm8753_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
-{
-	struct snd_soc_device *socdev = wm8753_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
-
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
-
-	ret = wm8753_init(socdev);
-	if (ret < 0)
-		pr_err("failed to initialise WM8753\n");
-
-	return ret;
-}
-
-static int wm8753_i2c_remove(struct i2c_client *client)
-{
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
-	return 0;
-}
-
-static const struct i2c_device_id wm8753_i2c_id[] = {
-	{ "wm8753", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, wm8753_i2c_id);
-
-static struct i2c_driver wm8753_i2c_driver = {
-	.driver = {
-		.name = "WM8753 I2C Codec",
-		.owner = THIS_MODULE,
-	},
-	.probe =    wm8753_i2c_probe,
-	.remove =   wm8753_i2c_remove,
-	.id_table = wm8753_i2c_id,
-};
+static struct i2c_driver wm8753_i2c_driver;
 
 static int wm8753_add_i2c_device(struct platform_device *pdev,
 				 const struct wm8753_setup_data *setup)
@@ -1715,63 +1674,6 @@ err_driver:
 }
 #endif
 
-#if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8753_spi_probe(struct spi_device *spi)
-{
-	struct snd_soc_device *socdev = wm8753_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
-
-	codec->control_data = spi;
-
-	ret = wm8753_init(socdev);
-	if (ret < 0)
-		dev_err(&spi->dev, "failed to initialise WM8753\n");
-
-	return ret;
-}
-
-static int __devexit wm8753_spi_remove(struct spi_device *spi)
-{
-	return 0;
-}
-
-static struct spi_driver wm8753_spi_driver = {
-	.driver = {
-		.name	= "wm8753",
-		.bus	= &spi_bus_type,
-		.owner	= THIS_MODULE,
-	},
-	.probe		= wm8753_spi_probe,
-	.remove		= __devexit_p(wm8753_spi_remove),
-};
-
-static int wm8753_spi_write(struct spi_device *spi, const char *data, int len)
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
-#endif
-
-
 static int wm8753_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
@@ -1876,6 +1778,105 @@ struct snd_soc_codec_device soc_codec_dev_wm8753 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8753);
 
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+
+static int wm8753_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct snd_soc_device *socdev = wm8753_socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	int ret;
+
+	i2c_set_clientdata(i2c, codec);
+	codec->control_data = i2c;
+
+	ret = wm8753_init(socdev);
+	if (ret < 0)
+		pr_err("failed to initialise WM8753\n");
+
+	return ret;
+}
+
+static int wm8753_i2c_remove(struct i2c_client *client)
+{
+	struct snd_soc_codec *codec = i2c_get_clientdata(client);
+	kfree(codec->reg_cache);
+	return 0;
+}
+
+static const struct i2c_device_id wm8753_i2c_id[] = {
+	{ "wm8753", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8753_i2c_id);
+
+static struct i2c_driver wm8753_i2c_driver = {
+	.driver = {
+		.name = "WM8753 I2C Codec",
+		.owner = THIS_MODULE,
+	},
+	.probe =    wm8753_i2c_probe,
+	.remove =   wm8753_i2c_remove,
+	.id_table = wm8753_i2c_id,
+};
+#endif
+
+#if defined(CONFIG_SPI_MASTER)
+static int wm8753_spi_write(struct spi_device *spi, const char *data, int len)
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
+
+static int __devinit wm8753_spi_probe(struct spi_device *spi)
+{
+	struct snd_soc_device *socdev = wm8753_socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	int ret;
+
+	codec->control_data = spi;
+
+	ret = wm8753_init(socdev);
+	if (ret < 0)
+		dev_err(&spi->dev, "failed to initialise WM8753\n");
+
+	return ret;
+}
+
+static int __devexit wm8753_spi_remove(struct spi_device *spi)
+{
+	return 0;
+}
+
+static struct spi_driver wm8753_spi_driver = {
+	.driver = {
+		.name	= "wm8753",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= wm8753_spi_probe,
+	.remove		= __devexit_p(wm8753_spi_remove),
+};
+#endif
+
 static int __init wm8753_modinit(void)
 {
 	return snd_soc_register_dais(wm8753_dai, ARRAY_SIZE(wm8753_dai));
-- 
1.6.1.3
