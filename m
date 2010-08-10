From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 08/17] ASoC: multi-component - Wolfson WM85xx
	CODECs
Date: Wed, 11 Aug 2010 00:02:59 +0100
Message-ID: <1281481388-3000-9-git-send-email-lrg@slimlogic.co.uk>
References: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E0AB103865
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:03:41 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 36so2366031wwa.20
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 16:03:41 -0700 (PDT)
In-Reply-To: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Moved Wolfson WM85xx CODECs to multi-component model

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform driver
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/wm8510.c |  290 +++++++++++++++------------------------------
 sound/soc/codecs/wm8510.h |    3 -
 sound/soc/codecs/wm8523.c |  180 ++++++++---------------------
 sound/soc/codecs/wm8523.h |    3 -
 sound/soc/codecs/wm8580.c |  186 +++++++++--------------------
 sound/soc/codecs/wm8580.h |    3 -
 6 files changed, 199 insertions(+), 466 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 0f7bcb6..dbfa05d 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -31,8 +31,6 @@
 
 #define WM8510_VERSION "0.6"
 
-struct snd_soc_codec_device soc_codec_dev_wm8510;
-
 /*
  * wm8510 register cache
  * We can't read the WM8510 register space when we are
@@ -61,6 +59,12 @@ static const u16 wm8510_reg[WM8510_CACHEREGNUM] = {
 
 #define wm8510_reset(c)	snd_soc_write(c, WM8510_RESET, 0)
 
+/* codec private data */
+struct wm8510_priv {
+	enum snd_soc_control_type control_type;
+	void *control_data;
+};
+
 static const char *wm8510_companding[] = { "Off", "NC", "u-law", "A-law" };
 static const char *wm8510_deemp[] = { "None", "32kHz", "44.1kHz", "48kHz" };
 static const char *wm8510_alc[] = { "ALC", "Limiter" };
@@ -403,8 +407,7 @@ static int wm8510_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u16 iface = snd_soc_read(codec, WM8510_IFACE) & 0x19f;
 	u16 adn = snd_soc_read(codec, WM8510_ADD) & 0x1f1;
 
@@ -514,8 +517,8 @@ static struct snd_soc_dai_ops wm8510_dai_ops = {
 	.set_pll	= wm8510_set_dai_pll,
 };
 
-struct snd_soc_dai wm8510_dai = {
-	.name = "WM8510 HiFi",
+static struct snd_soc_dai_driver wm8510_dai = {
+	.name = "wm8510-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
@@ -531,21 +534,15 @@ struct snd_soc_dai wm8510_dai = {
 	.ops = &wm8510_dai_ops,
 	.symmetric_rates = 1,
 };
-EXPORT_SYMBOL_GPL(wm8510_dai);
 
-static int wm8510_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8510_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8510_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int wm8510_resume(struct platform_device *pdev)
+static int wm8510_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	u8 data[2];
 	u16 *cache = codec->reg_cache;
@@ -561,43 +558,22 @@ static int wm8510_resume(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * initialise the WM8510 driver
- * register the mixer and dsp interfaces with the kernel
- */
-static int wm8510_init(struct snd_soc_device *socdev,
-		       enum snd_soc_control_type control)
+static int wm8510_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret = 0;
-
-	codec->name = "WM8510";
-	codec->owner = THIS_MODULE;
-	codec->set_bias_level = wm8510_set_bias_level;
-	codec->dai = &wm8510_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(wm8510_reg);
-	codec->reg_cache = kmemdup(wm8510_reg, sizeof(wm8510_reg), GFP_KERNEL);
+	struct wm8510_priv *wm8510 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
+	pr_info("WM8510 Audio Codec %s", WM8510_VERSION);
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
+	codec->control_data = wm8510->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9,  wm8510->control_type);
 	if (ret < 0) {
-		printk(KERN_ERR "wm8510: failed to set cache I/O: %d\n",
-		       ret);
-		goto err;
+		printk(KERN_ERR "wm8510: failed to set cache I/O: %d\n", ret);
+		return ret;
 	}
 
 	wm8510_reset(codec);
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "wm8510: failed to create pcms\n");
-		goto err;
-	}
-
 	/* power on device */
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	wm8510_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -606,119 +582,53 @@ static int wm8510_init(struct snd_soc_device *socdev,
 	wm8510_add_widgets(codec);
 
 	return ret;
-
-err:
-	kfree(codec->reg_cache);
-	return ret;
 }
 
-static struct snd_soc_device *wm8510_socdev;
-
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-
-/*
- * WM8510 2 wire address is 0x1a
- */
-
-static int wm8510_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+/* power down chip */
+static int wm8510_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = wm8510_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
-
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
-
-	ret = wm8510_init(socdev, SND_SOC_I2C);
-	if (ret < 0)
-		pr_err("failed to initialise WM8510\n");
-
-	return ret;
-}
+	struct wm8510_priv *wm8510 = snd_soc_codec_get_drvdata(codec);
 
-static int wm8510_i2c_remove(struct i2c_client *client)
-{
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
+	wm8510_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	kfree(wm8510);
 	return 0;
 }
 
-static const struct i2c_device_id wm8510_i2c_id[] = {
-	{ "wm8510", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, wm8510_i2c_id);
-
-static struct i2c_driver wm8510_i2c_driver = {
-	.driver = {
-		.name = "WM8510 I2C Codec",
-		.owner = THIS_MODULE,
-	},
-	.probe =    wm8510_i2c_probe,
-	.remove =   wm8510_i2c_remove,
-	.id_table = wm8510_i2c_id,
+static struct snd_soc_codec_driver soc_codec_dev_wm8510 = {
+	.probe =	wm8510_probe,
+	.remove =	wm8510_remove,
+	.suspend =	wm8510_suspend,
+	.resume =	wm8510_resume,
+	.set_bias_level = wm8510_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(wm8510_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default =wm8510_reg,
 };
 
-static int wm8510_add_i2c_device(struct platform_device *pdev,
-				 const struct wm8510_setup_data *setup)
-{
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
-
-	ret = i2c_add_driver(&wm8510_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "wm8510", I2C_NAME_SIZE);
-
-	adapter = i2c_get_adapter(setup->i2c_bus);
-	if (!adapter) {
-		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
-			setup->i2c_bus);
-		goto err_driver;
-	}
-
-	client = i2c_new_device(adapter, &info);
-	i2c_put_adapter(adapter);
-	if (!client) {
-		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
-			(unsigned int)info.addr);
-		goto err_driver;
-	}
-
-	return 0;
-
-err_driver:
-	i2c_del_driver(&wm8510_i2c_driver);
-	return -ENODEV;
-}
-#endif
-
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8510_spi_probe(struct spi_device *spi)
 {
-	struct snd_soc_device *socdev = wm8510_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct wm8510_priv *wm8510;
 	int ret;
 
-	codec->control_data = spi;
+	wm8510 = kzalloc(sizeof(struct wm8510_priv), GFP_KERNEL);
+	if (wm8510 == NULL)
+		return -ENOMEM;
+
+	wm8510->control_data = spi;
+	wm8510->control_type = SND_SOC_SPI;
+	spi_set_drvdata(spi, wm8510);
 
-	ret = wm8510_init(socdev, SND_SOC_SPI);
+	ret = snd_soc_register_codec(&spi->dev,
+			&soc_codec_dev_wm8510, &wm8510_dai, 1);
 	if (ret < 0)
-		dev_err(&spi->dev, "failed to initialise WM8510\n");
-
+		kfree(wm8510);
 	return ret;
 }
 
 static int __devexit wm8510_spi_remove(struct spi_device *spi)
 {
+	snd_soc_unregister_codec(&spi->dev);
 	return 0;
 }
 
@@ -733,84 +643,80 @@ static struct spi_driver wm8510_spi_driver = {
 };
 #endif /* CONFIG_SPI_MASTER */
 
-static int wm8510_probe(struct platform_device *pdev)
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int wm8510_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct wm8510_setup_data *setup;
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	pr_info("WM8510 Audio Codec %s", WM8510_VERSION);
+	struct wm8510_priv *wm8510;
+	int ret;
 
-	setup = socdev->codec_data;
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
+	wm8510 = kzalloc(sizeof(struct wm8510_priv), GFP_KERNEL);
+	if (wm8510 == NULL)
 		return -ENOMEM;
 
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
+	i2c_set_clientdata(i2c, wm8510);
+	wm8510->control_data = i2c;
+	wm8510->control_type = SND_SOC_I2C;
 
-	wm8510_socdev = socdev;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		ret = wm8510_add_i2c_device(pdev, setup);
-	}
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	if (setup->spi) {
-		ret = spi_register_driver(&wm8510_spi_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add spi driver");
-	}
-#endif
-
-	if (ret != 0)
-		kfree(codec);
+	ret =  snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_wm8510, &wm8510_dai, 1);
+	if (ret < 0)
+		kfree(wm8510);
 	return ret;
 }
 
-/* power down chip */
-static int wm8510_remove(struct platform_device *pdev)
+static __devexit int wm8510_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->control_data)
-		wm8510_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
-	i2c_del_driver(&wm8510_i2c_driver);
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	spi_unregister_driver(&wm8510_spi_driver);
-#endif
-	kfree(codec);
-
+	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_wm8510 = {
-	.probe = 	wm8510_probe,
-	.remove = 	wm8510_remove,
-	.suspend = 	wm8510_suspend,
-	.resume =	wm8510_resume,
+static const struct i2c_device_id wm8510_i2c_id[] = {
+	{ "wm8510", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8510_i2c_id);
+
+static struct i2c_driver wm8510_i2c_driver = {
+	.driver = {
+		.name = "wm8510-codec",
+		.owner = THIS_MODULE,
+	},
+	.probe =    wm8510_i2c_probe,
+	.remove =   __devexit_p(wm8510_i2c_remove),
+	.id_table = wm8510_i2c_id,
 };
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8510);
+#endif
 
 static int __init wm8510_modinit(void)
 {
-	return snd_soc_register_dai(&wm8510_dai);
+	int ret = 0;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&wm8510_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register WM8510 I2C driver: %d\n",
+		       ret);
+	}
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&wm8510_spi_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register WM8510 SPI driver: %d\n",
+		       ret);
+	}
+#endif
+	return ret;
 }
 module_init(wm8510_modinit);
 
 static void __exit wm8510_exit(void)
 {
-	snd_soc_unregister_dai(&wm8510_dai);
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&wm8510_i2c_driver);
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&wm8510_spi_driver);
+#endif
 }
 module_exit(wm8510_exit);
 
diff --git a/sound/soc/codecs/wm8510.h b/sound/soc/codecs/wm8510.h
index bdefcf5..b3e26ed 100644
--- a/sound/soc/codecs/wm8510.h
+++ b/sound/soc/codecs/wm8510.h
@@ -99,7 +99,4 @@ struct wm8510_setup_data {
 	unsigned short i2c_address;
 };
 
-extern struct snd_soc_dai wm8510_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8510;
-
 #endif
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 0ad039b..58d411b 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -30,9 +30,6 @@
 
 #include "wm8523.h"
 
-static struct snd_soc_codec *wm8523_codec;
-struct snd_soc_codec_device soc_codec_dev_wm8523;
-
 #define WM8523_NUM_SUPPLIES 2
 static const char *wm8523_supply_names[WM8523_NUM_SUPPLIES] = {
 	"AVDD",
@@ -43,7 +40,8 @@ static const char *wm8523_supply_names[WM8523_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct wm8523_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	u16 reg_cache[WM8523_REGISTER_COUNT];
 	struct regulator_bulk_data supplies[WM8523_NUM_SUPPLIES];
 	unsigned int sysclk;
@@ -162,8 +160,7 @@ static int wm8523_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
 	int i;
 	u16 aifctrl1 = snd_soc_read(codec, WM8523_AIF_CTRL1);
@@ -387,8 +384,8 @@ static struct snd_soc_dai_ops wm8523_dai_ops = {
 	.set_fmt	= wm8523_set_dai_fmt,
 };
 
-struct snd_soc_dai wm8523_dai = {
-	.name = "WM8523",
+static struct snd_soc_dai_driver wm8523_dai = {
+	.name = "wm8523-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,  /* Mono modes not yet supported */
@@ -398,25 +395,17 @@ struct snd_soc_dai wm8523_dai = {
 	},
 	.ops = &wm8523_dai_ops,
 };
-EXPORT_SYMBOL_GPL(wm8523_dai);
 
 #ifdef CONFIG_PM
-static int wm8523_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8523_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8523_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int wm8523_resume(struct platform_device *pdev)
+static int wm8523_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8523_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 }
 #else
@@ -424,93 +413,21 @@ static int wm8523_resume(struct platform_device *pdev)
 #define wm8523_resume NULL
 #endif
 
-static int wm8523_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	if (wm8523_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = wm8523_codec;
-	codec = wm8523_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
-	}
-
-	snd_soc_add_controls(codec, wm8523_snd_controls,
-			     ARRAY_SIZE(wm8523_snd_controls));
-	wm8523_add_widgets(codec);
-
-	return ret;
-
-pcm_err:
-	return ret;
-}
-
-static int wm8523_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8523 = {
-	.probe = 	wm8523_probe,
-	.remove = 	wm8523_remove,
-	.suspend = 	wm8523_suspend,
-	.resume =	wm8523_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8523);
-
-static int wm8523_register(struct wm8523_priv *wm8523,
-			   enum snd_soc_control_type control)
+static int wm8523_probe(struct snd_soc_codec *codec)
 {
-	int ret;
-	struct snd_soc_codec *codec = &wm8523->codec;
-	int i;
-
-	if (wm8523_codec) {
-		dev_err(codec->dev, "Another WM8523 is registered\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8523);
-	codec->name = "WM8523";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8523_set_bias_level;
-	codec->dai = &wm8523_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = WM8523_REGISTER_COUNT;
-	codec->reg_cache = &wm8523->reg_cache;
-	codec->volatile_register = wm8523_volatile_register;
+	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
+	int ret, i;
 
+	codec->hw_write = (hw_write_t)i2c_master_send;
+	codec->control_data = wm8523->control_data;
 	wm8523->rate_constraint.list = &wm8523->rate_constraint_list[0];
 	wm8523->rate_constraint.count =
 		ARRAY_SIZE(wm8523->rate_constraint_list);
 
-	memcpy(codec->reg_cache, wm8523_reg, sizeof(wm8523_reg));
-
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, control);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, wm8523->control_type);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(wm8523->supplies); i++)
@@ -520,7 +437,7 @@ static int wm8523_register(struct wm8523_priv *wm8523,
 				 wm8523->supplies);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8523->supplies),
@@ -555,8 +472,6 @@ static int wm8523_register(struct wm8523_priv *wm8523,
 		goto err_enable;
 	}
 
-	wm8523_dai.dev = codec->dev;
-
 	/* Change some default settings - latch VU and enable ZC */
 	wm8523->reg_cache[WM8523_DAC_GAINR] |= WM8523_DACR_VU;
 	wm8523->reg_cache[WM8523_DAC_CTRL3] |= WM8523_ZC;
@@ -566,69 +481,68 @@ static int wm8523_register(struct wm8523_priv *wm8523,
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(wm8523->supplies), wm8523->supplies);
 
-	wm8523_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err_enable;
-	}
-
-	ret = snd_soc_register_dai(&wm8523_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
+	snd_soc_add_controls(codec, wm8523_snd_controls,
+			     ARRAY_SIZE(wm8523_snd_controls));
+	wm8523_add_widgets(codec);
 
 	return 0;
 
-err_codec:
-	snd_soc_unregister_codec(codec);
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8523->supplies), wm8523->supplies);
 err_get:
 	regulator_bulk_free(ARRAY_SIZE(wm8523->supplies), wm8523->supplies);
-err:
-	kfree(wm8523);
+
 	return ret;
 }
 
-static void wm8523_unregister(struct wm8523_priv *wm8523)
+static int wm8523_remove(struct snd_soc_codec *codec)
 {
-	wm8523_set_bias_level(&wm8523->codec, SND_SOC_BIAS_OFF);
+	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
+
+	wm8523_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	regulator_bulk_free(ARRAY_SIZE(wm8523->supplies), wm8523->supplies);
-	snd_soc_unregister_dai(&wm8523_dai);
-	snd_soc_unregister_codec(&wm8523->codec);
-	kfree(wm8523);
-	wm8523_codec = NULL;
+	return 0;
 }
 
+static struct snd_soc_codec_driver soc_codec_dev_wm8523 = {
+	.probe =	wm8523_probe,
+	.remove =	wm8523_remove,
+	.suspend =	wm8523_suspend,
+	.resume =	wm8523_resume,
+	.set_bias_level = wm8523_set_bias_level,
+	.reg_cache_size = WM8523_REGISTER_COUNT,
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8523_reg,
+	.volatile_register = wm8523_volatile_register,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8523_priv *wm8523;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8523 = kzalloc(sizeof(struct wm8523_priv), GFP_KERNEL);
 	if (wm8523 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8523->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
-
 	i2c_set_clientdata(i2c, wm8523);
-	codec->control_data = i2c;
+	wm8523->control_data = i2c;
+	wm8523->control_type = SND_SOC_I2C;
 
-	codec->dev = &i2c->dev;
+	ret =  snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_wm8523, &wm8523_dai, 1);
+	if (ret < 0)
+		kfree(wm8523);
+	return ret;
 
-	return wm8523_register(wm8523, SND_SOC_I2C);
 }
 
 static __devexit int wm8523_i2c_remove(struct i2c_client *client)
 {
-	struct wm8523_priv *wm8523 = i2c_get_clientdata(client);
-	wm8523_unregister(wm8523);
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -640,7 +554,7 @@ MODULE_DEVICE_TABLE(i2c, wm8523_i2c_id);
 
 static struct i2c_driver wm8523_i2c_driver = {
 	.driver = {
-		.name = "WM8523",
+		.name = "wm8523-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8523_i2c_probe,
diff --git a/sound/soc/codecs/wm8523.h b/sound/soc/codecs/wm8523.h
index 1aa9ce3..4d5b1eb 100644
--- a/sound/soc/codecs/wm8523.h
+++ b/sound/soc/codecs/wm8523.h
@@ -154,7 +154,4 @@
 #define WM8523_ZD_COUNT_SHIFT                        0  /* ZD_COUNT - [1:0] */
 #define WM8523_ZD_COUNT_WIDTH                        2  /* ZD_COUNT - [1:0] */
 
-extern struct snd_soc_dai wm8523_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8523;
-
 #endif
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index c3571ee..cae5894 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -199,7 +199,8 @@ static const char *wm8580_supply_names[WM8580_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct wm8580_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	struct regulator_bulk_data supplies[WM8580_NUM_SUPPLIES];
 	u16 reg_cache[WM8580_MAX_REGISTER + 1];
 	struct pll_state a;
@@ -484,9 +485,8 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	u16 paifb = snd_soc_read(codec, WM8580_PAIF3 + dai->id);
+	struct snd_soc_codec *codec = rtd->codec;
+	u16 paifb = snd_soc_read(codec, WM8580_PAIF3 + dai->driver->id);
 
 	paifb &= ~WM8580_AIF_LENGTH_MASK;
 	/* bit size */
@@ -506,7 +506,7 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8580_PAIF3 + dai->id, paifb);
+	snd_soc_write(codec, WM8580_PAIF3 + dai->driver->id, paifb);
 	return 0;
 }
 
@@ -518,8 +518,8 @@ static int wm8580_set_paif_dai_fmt(struct snd_soc_dai *codec_dai,
 	unsigned int aifb;
 	int can_invert_lrclk;
 
-	aifa = snd_soc_read(codec, WM8580_PAIF1 + codec_dai->id);
-	aifb = snd_soc_read(codec, WM8580_PAIF3 + codec_dai->id);
+	aifa = snd_soc_read(codec, WM8580_PAIF1 + codec_dai->driver->id);
+	aifb = snd_soc_read(codec, WM8580_PAIF3 + codec_dai->driver->id);
 
 	aifb &= ~(WM8580_AIF_FMT_MASK | WM8580_AIF_LRP | WM8580_AIF_BCP);
 
@@ -585,8 +585,8 @@ static int wm8580_set_paif_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8580_PAIF1 + codec_dai->id, aifa);
-	snd_soc_write(codec, WM8580_PAIF3 + codec_dai->id, aifb);
+	snd_soc_write(codec, WM8580_PAIF1 + codec_dai->driver->id, aifa);
+	snd_soc_write(codec, WM8580_PAIF3 + codec_dai->driver->id, aifb);
 
 	return 0;
 }
@@ -746,10 +746,10 @@ static struct snd_soc_dai_ops wm8580_dai_ops_capture = {
 	.set_pll	= wm8580_set_dai_pll,
 };
 
-struct snd_soc_dai wm8580_dai[] = {
+static struct snd_soc_dai_driver wm8580_dai[] = {
 	{
-		.name = "WM8580 PAIFRX",
-		.id = 0,
+		.name = "wm8580-hifi-playback",
+		.id	= WM8580_DAI_PAIFRX,
 		.playback = {
 			.stream_name = "Playback",
 			.channels_min = 1,
@@ -760,8 +760,8 @@ struct snd_soc_dai wm8580_dai[] = {
 		.ops = &wm8580_dai_ops_playback,
 	},
 	{
-		.name = "WM8580 PAIFTX",
-		.id = 1,
+		.name = "wm8580-hifi-capture",
+		.id	=	WM8580_DAI_PAIFTX,
 		.capture = {
 			.stream_name = "Capture",
 			.channels_min = 2,
@@ -772,90 +772,17 @@ struct snd_soc_dai wm8580_dai[] = {
 		.ops = &wm8580_dai_ops_capture,
 	},
 };
-EXPORT_SYMBOL_GPL(wm8580_dai);
 
-static struct snd_soc_codec *wm8580_codec;
-
-static int wm8580_probe(struct platform_device *pdev)
+static int wm8580_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	if (wm8580_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = wm8580_codec;
-	codec = wm8580_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
-	}
-
-	snd_soc_add_controls(codec, wm8580_snd_controls,
-			     ARRAY_SIZE(wm8580_snd_controls));
-	wm8580_add_widgets(codec);
-
-	return ret;
-
-pcm_err:
-	return ret;
-}
-
-/* power down chip */
-static int wm8580_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8580 = {
-	.probe = 	wm8580_probe,
-	.remove = 	wm8580_remove,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8580);
-
-static int wm8580_register(struct wm8580_priv *wm8580,
-			   enum snd_soc_control_type control)
-{
-	int ret, i;
-	struct snd_soc_codec *codec = &wm8580->codec;
-
-	if (wm8580_codec) {
-		dev_err(codec->dev, "Another WM8580 is registered\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8580);
-	codec->name = "WM8580";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8580_set_bias_level;
-	codec->dai = wm8580_dai;
-	codec->num_dai = ARRAY_SIZE(wm8580_dai);
-	codec->reg_cache_size = ARRAY_SIZE(wm8580->reg_cache);
-	codec->reg_cache = &wm8580->reg_cache;
-
-	memcpy(codec->reg_cache, wm8580_reg, sizeof(wm8580_reg));
+	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0,i;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
+	codec->control_data = wm8580->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8580->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(wm8580->supplies); i++)
@@ -865,7 +792,7 @@ static int wm8580_register(struct wm8580_priv *wm8580,
 				 wm8580->supplies);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8580->supplies),
@@ -882,74 +809,69 @@ static int wm8580_register(struct wm8580_priv *wm8580,
 		goto err_regulator_enable;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(wm8580_dai); i++)
-		wm8580_dai[i].dev = codec->dev;
-
 	wm8580_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	wm8580_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err_regulator_enable;
-	}
-
-	ret = snd_soc_register_dais(wm8580_dai, ARRAY_SIZE(wm8580_dai));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
+	snd_soc_add_controls(codec, wm8580_snd_controls,
+			     ARRAY_SIZE(wm8580_snd_controls));
+	wm8580_add_widgets(codec);
 
 	return 0;
 
-err_codec:
-	snd_soc_unregister_codec(codec);
 err_regulator_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8580->supplies), wm8580->supplies);
 err_regulator_get:
 	regulator_bulk_free(ARRAY_SIZE(wm8580->supplies), wm8580->supplies);
-err:
-	kfree(wm8580);
 	return ret;
 }
 
-static void wm8580_unregister(struct wm8580_priv *wm8580)
+/* power down chip */
+static int wm8580_remove(struct snd_soc_codec *codec)
 {
-	wm8580_set_bias_level(&wm8580->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dais(wm8580_dai, ARRAY_SIZE(wm8580_dai));
-	snd_soc_unregister_codec(&wm8580->codec);
+	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
+
+	wm8580_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
 	regulator_bulk_disable(ARRAY_SIZE(wm8580->supplies), wm8580->supplies);
 	regulator_bulk_free(ARRAY_SIZE(wm8580->supplies), wm8580->supplies);
-	kfree(wm8580);
-	wm8580_codec = NULL;
+
+	return 0;
 }
 
+static struct snd_soc_codec_driver soc_codec_dev_wm8580 = {
+	.probe =	wm8580_probe,
+	.remove =	wm8580_remove,
+	.set_bias_level = wm8580_set_bias_level,
+	.reg_cache_size = sizeof(wm8580_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = &wm8580_reg,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static int wm8580_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8580_priv *wm8580;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8580 = kzalloc(sizeof(struct wm8580_priv), GFP_KERNEL);
 	if (wm8580 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8580->codec;
-
 	i2c_set_clientdata(i2c, wm8580);
-	codec->control_data = i2c;
-
-	codec->dev = &i2c->dev;
+	wm8580->control_data = i2c;
+	wm8580->control_type = SND_SOC_I2C;
 
-	return wm8580_register(wm8580, SND_SOC_I2C);
+	ret =  snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_wm8580, wm8580_dai, ARRAY_SIZE(wm8580_dai));
+	if (ret < 0)
+		kfree(wm8580);
+	return ret;
 }
 
 static int wm8580_i2c_remove(struct i2c_client *client)
 {
-	struct wm8580_priv *wm8580 = i2c_get_clientdata(client);
-	wm8580_unregister(wm8580);
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -961,7 +883,7 @@ MODULE_DEVICE_TABLE(i2c, wm8580_i2c_id);
 
 static struct i2c_driver wm8580_i2c_driver = {
 	.driver = {
-		.name = "wm8580",
+		.name = "wm8580-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8580_i2c_probe,
@@ -972,7 +894,7 @@ static struct i2c_driver wm8580_i2c_driver = {
 
 static int __init wm8580_modinit(void)
 {
-	int ret;
+	int ret = 0;
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8580_i2c_driver);
@@ -981,7 +903,7 @@ static int __init wm8580_modinit(void)
 	}
 #endif
 
-	return 0;
+	return ret;
 }
 module_init(wm8580_modinit);
 
diff --git a/sound/soc/codecs/wm8580.h b/sound/soc/codecs/wm8580.h
index 0dfb5dd..8328ef6 100644
--- a/sound/soc/codecs/wm8580.h
+++ b/sound/soc/codecs/wm8580.h
@@ -31,8 +31,5 @@
 #define WM8580_DAI_PAIFRX 0
 #define WM8580_DAI_PAIFTX 1
 
-extern struct snd_soc_dai wm8580_dai[];
-extern struct snd_soc_codec_device soc_codec_dev_wm8580;
-
 #endif
 
-- 
1.7.0.4
