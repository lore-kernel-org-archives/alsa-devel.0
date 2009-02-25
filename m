From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/7] ASoC: Convert WM8753 to register via
	normal device probe
Date: Wed, 25 Feb 2009 10:48:21 +0000
Message-ID: <1235558902-20314-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090225104701.GA20221@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D5CA24445
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

The base support for the only in-tree user, the GTA01, is out of tree
and will be updated separately.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8753.c          |  369 +++++++++++++++++-------------------
 sound/soc/codecs/wm8753.h          |    6 -
 sound/soc/s3c24xx/neo1973_wm8753.c |    6 -
 3 files changed, 171 insertions(+), 210 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 4b42688..bc29558 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -63,12 +63,6 @@ MODULE_PARM_DESC(caps_charge, "WM8753 cap charge time (msecs)");
 static void wm8753_set_dai_mode(struct snd_soc_codec *codec,
 	unsigned int mode);
 
-/* codec private data */
-struct wm8753_priv {
-	unsigned int sysclk;
-	unsigned int pcmclk;
-};
-
 /*
  * wm8753 register cache
  * We can't read the WM8753 register space when we
@@ -93,6 +87,14 @@ static const u16 wm8753_reg[] = {
 	0x0000, 0x0000
 };
 
+/* codec private data */
+struct wm8753_priv {
+	unsigned int sysclk;
+	unsigned int pcmclk;
+	struct snd_soc_codec codec;
+	u16 reg_cache[ARRAY_SIZE(wm8753_reg)];
+};
+
 /*
  * read wm8753 register cache
  */
@@ -1542,36 +1544,24 @@ static int wm8753_resume(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * initialise the WM8753 driver
- * register the mixer and dsp interfaces with the kernel
- */
-static int wm8753_init(struct snd_soc_device *socdev)
+static struct snd_soc_codec *wm8753_codec;
+
+static int wm8753_probe(struct platform_device *pdev)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int reg, ret = 0;
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
 
-	codec->name = "WM8753";
-	codec->owner = THIS_MODULE;
-	codec->read = wm8753_read_reg_cache;
-	codec->write = wm8753_write;
-	codec->set_bias_level = wm8753_set_bias_level;
-	codec->dai = wm8753_dai;
-	codec->num_dai = 2;
-	codec->reg_cache_size = ARRAY_SIZE(wm8753_reg);
-	codec->reg_cache = kmemdup(wm8753_reg, sizeof(wm8753_reg), GFP_KERNEL);
+	if (!wm8753_codec) {
+		dev_err(&pdev->dev, "WM8753 codec not yet registered\n");
+		return -EINVAL;
+	}
 
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
+	socdev->card->codec = wm8753_codec;
+	codec = wm8753_codec;
 
 	wm8753_set_dai_mode(codec, 0);
 
-	ret = wm8753_reset(codec);
-	if (ret < 0) {
-		printk(KERN_ERR "wm8753: failed to reset device\n");
-		return ret;
-	}
-
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
@@ -1579,36 +1569,7 @@ static int wm8753_init(struct snd_soc_device *socdev)
 		goto pcm_err;
 	}
 
-	/* charge output caps */
-	wm8753_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
-	codec->bias_level = SND_SOC_BIAS_STANDBY;
-	schedule_delayed_work(&codec->delayed_work,
-		msecs_to_jiffies(caps_charge));
-
-	/* set the update bits */
-	reg = wm8753_read_reg_cache(codec, WM8753_LDAC);
-	wm8753_write(codec, WM8753_LDAC, reg | 0x0100);
-	reg = wm8753_read_reg_cache(codec, WM8753_RDAC);
-	wm8753_write(codec, WM8753_RDAC, reg | 0x0100);
-	reg = wm8753_read_reg_cache(codec, WM8753_LADC);
-	wm8753_write(codec, WM8753_LADC, reg | 0x0100);
-	reg = wm8753_read_reg_cache(codec, WM8753_RADC);
-	wm8753_write(codec, WM8753_RADC, reg | 0x0100);
-	reg = wm8753_read_reg_cache(codec, WM8753_LOUT1V);
-	wm8753_write(codec, WM8753_LOUT1V, reg | 0x0100);
-	reg = wm8753_read_reg_cache(codec, WM8753_ROUT1V);
-	wm8753_write(codec, WM8753_ROUT1V, reg | 0x0100);
-	reg = wm8753_read_reg_cache(codec, WM8753_LOUT2V);
-	wm8753_write(codec, WM8753_LOUT2V, reg | 0x0100);
-	reg = wm8753_read_reg_cache(codec, WM8753_ROUT2V);
-	wm8753_write(codec, WM8753_ROUT2V, reg | 0x0100);
-	reg = wm8753_read_reg_cache(codec, WM8753_LINVOL);
-	wm8753_write(codec, WM8753_LINVOL, reg | 0x0100);
-	reg = wm8753_read_reg_cache(codec, WM8753_RINVOL);
-	wm8753_write(codec, WM8753_RINVOL, reg | 0x0100);
-
-	snd_soc_add_controls(codec, wm8753_snd_controls,
-				ARRAY_SIZE(wm8753_snd_controls));
+	wm8753_add_controls(codec);
 	wm8753_add_widgets(codec);
 	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
@@ -1616,110 +1577,13 @@ static int wm8753_init(struct snd_soc_device *socdev)
 		goto card_err;
 	}
 
-	return ret;
+	return 0;
 
 card_err:
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-pcm_err:
-	kfree(codec->reg_cache);
-	return ret;
-}
-
-/* If the i2c layer weren't so broken, we could pass this kind of data
-   around */
-static struct snd_soc_device *wm8753_socdev;
-
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static struct i2c_driver wm8753_i2c_driver;
-
-static int wm8753_add_i2c_device(struct platform_device *pdev,
-				 const struct wm8753_setup_data *setup)
-{
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
-
-	ret = i2c_add_driver(&wm8753_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "wm8753", I2C_NAME_SIZE);
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
-	i2c_del_driver(&wm8753_i2c_driver);
-	return -ENODEV;
-}
-#endif
-
-static int wm8753_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct wm8753_setup_data *setup;
-	struct snd_soc_codec *codec;
-	struct wm8753_priv *wm8753;
-	int ret = 0;
-
-	setup = socdev->codec_data;
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
-
-	wm8753 = kzalloc(sizeof(struct wm8753_priv), GFP_KERNEL);
-	if (wm8753 == NULL) {
-		kfree(codec);
-		return -ENOMEM;
-	}
-
-	codec->private_data = wm8753;
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-	wm8753_socdev = socdev;
-	INIT_DELAYED_WORK(&codec->delayed_work, wm8753_work);
-
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = wm8753_add_i2c_device(pdev, setup);
-	}
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	if (setup->spi) {
-		codec->hw_write = (hw_write_t)wm8753_spi_write;
-		ret = spi_register_driver(&wm8753_spi_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add spi driver");
-	}
-#endif
 
-	if (ret != 0) {
-		kfree(codec->private_data);
-		kfree(codec);
-	}
+pcm_err:
 	return ret;
 }
 
@@ -1746,26 +1610,9 @@ static int run_delayed_work(struct delayed_work *dwork)
 static int wm8753_remove(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-	struct wm8753_setup_data *setup = socdev->codec_data;
 
-	if (codec->control_data)
-		wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	run_delayed_work(&codec->delayed_work);
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		i2c_unregister_device(codec->control_data);
-		i2c_del_driver(&wm8753_i2c_driver);
-	}
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	if (setup->spi)
-		spi_unregister_driver(&wm8753_spi_driver);
-#endif
-	kfree(codec->private_data);
-	kfree(codec);
 
 	return 0;
 }
@@ -1778,30 +1625,134 @@ struct snd_soc_codec_device soc_codec_dev_wm8753 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8753);
 
+static int wm8753_register(struct wm8753_priv *wm8753)
+{
+	int ret, i;
+	struct snd_soc_codec *codec = &wm8753->codec;
+	u16 reg;
+
+	if (wm8753_codec) {
+		dev_err(codec->dev, "Multiple WM8753 devices not supported\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->name = "WM8753";
+	codec->owner = THIS_MODULE;
+	codec->read = wm8753_read_reg_cache;
+	codec->write = wm8753_write;
+	codec->bias_level = SND_SOC_BIAS_STANDBY;
+	codec->set_bias_level = wm8753_set_bias_level;
+	codec->dai = wm8753_dai;
+	codec->num_dai = 2;
+	codec->reg_cache_size = ARRAY_SIZE(wm8753->reg_cache);
+	codec->reg_cache = &wm8753->reg_cache;
+	codec->private_data = wm8753;
+
+	memcpy(codec->reg_cache, wm8753_reg, sizeof(codec->reg_cache));
+	INIT_DELAYED_WORK(&codec->delayed_work, wm8753_work);
+
+	ret = wm8753_reset(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to issue reset\n");
+		goto err;
+	}
+
+	/* charge output caps */
+	wm8753_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
+	schedule_delayed_work(&codec->delayed_work,
+			      msecs_to_jiffies(caps_charge));
+
+	/* set the update bits */
+	reg = wm8753_read_reg_cache(codec, WM8753_LDAC);
+	wm8753_write(codec, WM8753_LDAC, reg | 0x0100);
+	reg = wm8753_read_reg_cache(codec, WM8753_RDAC);
+	wm8753_write(codec, WM8753_RDAC, reg | 0x0100);
+	reg = wm8753_read_reg_cache(codec, WM8753_LADC);
+	wm8753_write(codec, WM8753_LADC, reg | 0x0100);
+	reg = wm8753_read_reg_cache(codec, WM8753_RADC);
+	wm8753_write(codec, WM8753_RADC, reg | 0x0100);
+	reg = wm8753_read_reg_cache(codec, WM8753_LOUT1V);
+	wm8753_write(codec, WM8753_LOUT1V, reg | 0x0100);
+	reg = wm8753_read_reg_cache(codec, WM8753_ROUT1V);
+	wm8753_write(codec, WM8753_ROUT1V, reg | 0x0100);
+	reg = wm8753_read_reg_cache(codec, WM8753_LOUT2V);
+	wm8753_write(codec, WM8753_LOUT2V, reg | 0x0100);
+	reg = wm8753_read_reg_cache(codec, WM8753_ROUT2V);
+	wm8753_write(codec, WM8753_ROUT2V, reg | 0x0100);
+	reg = wm8753_read_reg_cache(codec, WM8753_LINVOL);
+	wm8753_write(codec, WM8753_LINVOL, reg | 0x0100);
+	reg = wm8753_read_reg_cache(codec, WM8753_RINVOL);
+	wm8753_write(codec, WM8753_RINVOL, reg | 0x0100);
+
+	wm8753_codec = codec;
+
+	for (i = 0; i < ARRAY_SIZE(wm8753_dai); i++)
+		wm8753_dai[i].dev = codec->dev;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		goto err;
+	}
+
+	ret = snd_soc_register_dais(&wm8753_dai[0], ARRAY_SIZE(wm8753_dai));
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register DAIs: %d\n", ret);
+		goto err_codec;
+	}
+
+	return 0;
+
+err_codec:
+	run_delayed_work(&codec->delayed_work);
+	snd_soc_unregister_codec(codec);
+err:
+	kfree(wm8753);
+	return ret;
+}
+
+static void wm8753_unregister(struct wm8753_priv *wm8753)
+{
+	wm8753_set_bias_level(&wm8753->codec, SND_SOC_BIAS_OFF);
+	run_delayed_work(&wm8753->codec.delayed_work);
+	snd_soc_unregister_dais(&wm8753_dai[0], ARRAY_SIZE(wm8753_dai));
+	snd_soc_unregister_codec(&wm8753->codec);
+	kfree(wm8753);
+	wm8753_codec = NULL;
+}
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 
 static int wm8753_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = wm8753_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
+	struct snd_soc_codec *codec;
+	struct wm8753_priv *wm8753;
 
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
+	wm8753 = kzalloc(sizeof(struct wm8753_priv), GFP_KERNEL);
+	if (wm8753 == NULL)
+		return -ENOMEM;
 
-	ret = wm8753_init(socdev);
-	if (ret < 0)
-		pr_err("failed to initialise WM8753\n");
+        codec = &wm8753->codec;
+        codec->hw_write = (hw_write_t)i2c_master_send;
+        codec->control_data = i2c;
+        i2c_set_clientdata(i2c, wm8753);
 
-	return ret;
+        codec->dev = &i2c->dev;
+
+	return wm8753_register(wm8753);
 }
 
 static int wm8753_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
-	return 0;
+        struct wm8753_priv *wm8753 = i2c_get_clientdata(client);
+        wm8753_unregister(wm8753);
+        return 0;
 }
 
 static const struct i2c_device_id wm8753_i2c_id[] = {
@@ -1812,7 +1763,7 @@ MODULE_DEVICE_TABLE(i2c, wm8753_i2c_id);
 
 static struct i2c_driver wm8753_i2c_driver = {
 	.driver = {
-		.name = "WM8753 I2C Codec",
+		.name = "wm8753",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8753_i2c_probe,
@@ -1848,21 +1799,27 @@ static int wm8753_spi_write(struct spi_device *spi, const char *data, int len)
 
 static int __devinit wm8753_spi_probe(struct spi_device *spi)
 {
-	struct snd_soc_device *socdev = wm8753_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
+	struct snd_soc_codec *codec;
+	struct wm8753_priv *wm8753;
+
+	wm8753 = kzalloc(sizeof(struct wm8753_priv), GFP_KERNEL);
+	if (wm8753 == NULL)
+		return -ENOMEM;
 
+	codec = &wm8753->codec;
 	codec->control_data = spi;
+	codec->hw_write = (hw_write_t)wm8753_spi_write;
+	codec->dev = &spi->dev;
 
-	ret = wm8753_init(socdev);
-	if (ret < 0)
-		dev_err(&spi->dev, "failed to initialise WM8753\n");
+	spi->dev.driver_data = wm8753;
 
-	return ret;
+	return wm8753_register(wm8753);
 }
 
 static int __devexit wm8753_spi_remove(struct spi_device *spi)
 {
+	struct wm8753_priv *wm8753 = spi->dev.driver_data;
+	wm8753_unregister(wm8753);
 	return 0;
 }
 
@@ -1879,13 +1836,29 @@ static struct spi_driver wm8753_spi_driver = {
 
 static int __init wm8753_modinit(void)
 {
-	return snd_soc_register_dais(wm8753_dai, ARRAY_SIZE(wm8753_dai));
+	int ret;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&wm8753_i2c_driver);
+	if (ret != 0)
+		pr_err("Failed to register WM8753 I2C driver: %d\n", ret);
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&wm8753_spi_driver);
+	if (ret != 0)
+		pr_err("Failed to register WM8753 SPI driver: %d\n", ret);
+#endif
+	return 0;
 }
 module_init(wm8753_modinit);
 
 static void __exit wm8753_exit(void)
 {
-	snd_soc_unregister_dais(wm8753_dai, ARRAY_SIZE(wm8753_dai));
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&wm8753_i2c_driver);
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&wm8753_spi_driver);
+#endif
 }
 module_exit(wm8753_exit);
 
diff --git a/sound/soc/codecs/wm8753.h b/sound/soc/codecs/wm8753.h
index f55704c..57b2ba2 100644
--- a/sound/soc/codecs/wm8753.h
+++ b/sound/soc/codecs/wm8753.h
@@ -77,12 +77,6 @@
 #define WM8753_BIASCTL		0x3d
 #define WM8753_ADCTL2		0x3f
 
-struct wm8753_setup_data {
-	int spi;
-	int i2c_bus;
-	unsigned short i2c_address;
-};
-
 #define WM8753_PLL1			0
 #define WM8753_PLL2			1
 
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 45bb12e..286e11a 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -585,15 +585,9 @@ static struct snd_soc_card neo1973 = {
 	.num_links = ARRAY_SIZE(neo1973_dai),
 };
 
-static struct wm8753_setup_data neo1973_wm8753_setup = {
-	.i2c_bus = 0,
-	.i2c_address = 0x1a,
-};
-
 static struct snd_soc_device neo1973_snd_devdata = {
 	.card = &neo1973,
 	.codec_dev = &soc_codec_dev_wm8753,
-	.codec_data = &neo1973_wm8753_setup,
 };
 
 static int lm4857_i2c_probe(struct i2c_client *client,
-- 
1.6.1.3
