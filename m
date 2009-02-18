From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 10/11] ASoC: Refactor WM8731 device registration
Date: Wed, 18 Feb 2009 12:02:32 +0000
Message-ID: <1234958553-16049-10-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BE06C1038A8
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:02:46 +0100 (CET)
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

Move the WM8731 driver to use a more standard device registration
scheme where the device can be registered independantly of the ASoC
probe.

As a transition measure push the current manual code for registering
the WM8731 into the individual machine driver probes. This allows
separate patches to update the relevant architecture files with less
risk of merge issues.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |   43 +++++-
 sound/soc/codecs/wm8731.c        |  334 +++++++++++++++++---------------------
 sound/soc/codecs/wm8731.h        |    6 -
 sound/soc/pxa/corgi.c            |   43 ++++-
 sound/soc/pxa/poodle.c           |   41 ++++-
 5 files changed, 256 insertions(+), 211 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index aa52423..173a239 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -36,6 +36,7 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/i2c.h>
 
 #include <linux/atmel-ssc.h>
 
@@ -280,15 +281,41 @@ static struct snd_soc_card snd_soc_at91sam9g20ek = {
 	.set_bias_level = at91sam9g20ek_set_bias_level,
 };
 
-static struct wm8731_setup_data at91sam9g20ek_wm8731_setup = {
-	.i2c_bus = 0,
-	.i2c_address = 0x1b,
-};
+/*
+ * FIXME: This is a temporary bodge to avoid cross-tree merge issues.
+ * New drivers should register the wm8731 I2C device in the machine
+ * setup code (under arch/arm for ARM systems).
+ */
+static int wm8731_i2c_register(void)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = 0x1b;
+	strlcpy(info.type, "wm8731", I2C_NAME_SIZE);
+
+	adapter = i2c_get_adapter(0);
+	if (!adapter) {
+		printk(KERN_ERR "can't get i2c adapter 0\n");
+		return -ENODEV;
+	}
+
+	client = i2c_new_device(adapter, &info);
+	i2c_put_adapter(adapter);
+	if (!client) {
+		printk(KERN_ERR "can't add i2c device at 0x%x\n",
+			(unsigned int)info.addr);
+		return -ENODEV;
+	}
+
+	return 0;
+}
 
 static struct snd_soc_device at91sam9g20ek_snd_devdata = {
 	.card = &snd_soc_at91sam9g20ek,
 	.codec_dev = &soc_codec_dev_wm8731,
-	.codec_data = &at91sam9g20ek_wm8731_setup,
 };
 
 static struct platform_device *at91sam9g20ek_snd_device;
@@ -340,6 +367,10 @@ static int __init at91sam9g20ek_init(void)
 	}
 	ssc_p->ssc = ssc;
 
+	ret = wm8731_i2c_register();
+	if (ret != 0)
+		goto err_ssc;
+
 	at91sam9g20ek_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!at91sam9g20ek_snd_device) {
 		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
@@ -359,6 +390,8 @@ static int __init at91sam9g20ek_init(void)
 	return ret;
 
 err_ssc:
+	ssc_free(ssc);
+	ssc_p->ssc = NULL;
 err_mclk:
 	clk_put(mclk);
 	mclk = NULL;
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 3ff971a..a2c478e 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -29,16 +29,18 @@
 
 #include "wm8731.h"
 
+static struct snd_soc_codec *wm8731_codec;
 struct snd_soc_codec_device soc_codec_dev_wm8731;
 
 /* codec private data */
 struct wm8731_priv {
+	struct snd_soc_codec codec;
+	u16 reg_cache[WM8731_CACHEREGNUM];
 	unsigned int sysclk;
 };
 
 #ifdef CONFIG_SPI_MASTER
 static int wm8731_spi_write(struct spi_device *spi, const char *data, int len);
-static struct spi_driver wm8731_spi_driver;
 #endif
 
 /*
@@ -485,55 +487,33 @@ static int wm8731_resume(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * initialise the WM8731 driver
- * register the mixer and dsp interfaces with the kernel
- */
-static int wm8731_init(struct snd_soc_device *socdev)
+static int wm8731_probe(struct platform_device *pdev)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int reg, ret = 0;
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
 
-	codec->name = "WM8731";
-	codec->owner = THIS_MODULE;
-	codec->read = wm8731_read_reg_cache;
-	codec->write = wm8731_write;
-	codec->set_bias_level = wm8731_set_bias_level;
-	codec->dai = &wm8731_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(wm8731_reg);
-	codec->reg_cache = kmemdup(wm8731_reg, sizeof(wm8731_reg), GFP_KERNEL);
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
+	if (wm8731_codec == NULL) {
+		dev_err(&pdev->dev, "Codec device not registered\n");
+		return -ENODEV;
+	}
 
-	wm8731_reset(codec);
+	socdev->card->codec = wm8731_codec;
+	codec = wm8731_codec;
 
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
-		printk(KERN_ERR "wm8731: failed to create pcms\n");
+		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
 		goto pcm_err;
 	}
 
-	/* power on device */
-	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	/* set the update bits */
-	reg = wm8731_read_reg_cache(codec, WM8731_LOUT1V);
-	wm8731_write(codec, WM8731_LOUT1V, reg & ~0x0100);
-	reg = wm8731_read_reg_cache(codec, WM8731_ROUT1V);
-	wm8731_write(codec, WM8731_ROUT1V, reg & ~0x0100);
-	reg = wm8731_read_reg_cache(codec, WM8731_LINVOL);
-	wm8731_write(codec, WM8731_LINVOL, reg & ~0x0100);
-	reg = wm8731_read_reg_cache(codec, WM8731_RINVOL);
-	wm8731_write(codec, WM8731_RINVOL, reg & ~0x0100);
-
 	snd_soc_add_controls(codec, wm8731_snd_controls,
-				ARRAY_SIZE(wm8731_snd_controls));
+			     ARRAY_SIZE(wm8731_snd_controls));
 	wm8731_add_widgets(codec);
 	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
-		printk(KERN_ERR "wm8731: failed to register card\n");
+		dev_err(codec->dev, "failed to register card: %d\n", ret);
 		goto card_err;
 	}
 
@@ -543,104 +523,6 @@ card_err:
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 pcm_err:
-	kfree(codec->reg_cache);
-	return ret;
-}
-
-static struct snd_soc_device *wm8731_socdev;
-
-
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static struct i2c_driver wm8731_i2c_driver;
-
-static int wm8731_add_i2c_device(struct platform_device *pdev,
-				 const struct wm8731_setup_data *setup)
-{
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
-
-	ret = i2c_add_driver(&wm8731_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "wm8731", I2C_NAME_SIZE);
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
-	i2c_del_driver(&wm8731_i2c_driver);
-	return -ENODEV;
-}
-#endif
-
-static int wm8731_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct wm8731_setup_data *setup;
-	struct snd_soc_codec *codec;
-	struct wm8731_priv *wm8731;
-	int ret = 0;
-
-	setup = socdev->codec_data;
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
-
-	wm8731 = kzalloc(sizeof(struct wm8731_priv), GFP_KERNEL);
-	if (wm8731 == NULL) {
-		kfree(codec);
-		return -ENOMEM;
-	}
-
-	codec->private_data = wm8731;
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	wm8731_socdev = socdev;
-	ret = -ENODEV;
-
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = wm8731_add_i2c_device(pdev, setup);
-	}
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	if (setup->spi) {
-		codec->hw_write = (hw_write_t)wm8731_spi_write;
-		ret = spi_register_driver(&wm8731_spi_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add spi driver");
-	}
-#endif
-
-	if (ret != 0) {
-		kfree(codec->private_data);
-		kfree(codec);
-	}
 	return ret;
 }
 
@@ -648,22 +530,9 @@ static int wm8731_probe(struct platform_device *pdev)
 static int wm8731_remove(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->control_data)
-		wm8731_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
-	i2c_del_driver(&wm8731_i2c_driver);
-#endif
-#if defined(CONFIG_SPI_MASTER)
-	spi_unregister_driver(&wm8731_spi_driver);
-#endif
-	kfree(codec->private_data);
-	kfree(codec);
 
 	return 0;
 }
@@ -676,37 +545,78 @@ struct snd_soc_codec_device soc_codec_dev_wm8731 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8731);
 
-#if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8731_spi_probe(struct spi_device *spi)
+static int wm8731_register(struct wm8731_priv *wm8731)
 {
-	struct snd_soc_device *socdev = wm8731_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int ret;
+	struct snd_soc_codec *codec = &wm8731->codec;
+	u16 reg;
 
-	codec->control_data = spi;
+	if (wm8731_codec) {
+		dev_err(codec->dev, "Another WM8731 is registered\n");
+		return -EINVAL;
+	}
 
-	ret = wm8731_init(socdev);
-	if (ret < 0)
-		dev_err(&spi->dev, "failed to initialise WM8731\n");
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
 
-	return ret;
-}
+	codec->private_data = wm8731;
+	codec->name = "WM8731";
+	codec->owner = THIS_MODULE;
+	codec->read = wm8731_read_reg_cache;
+	codec->write = wm8731_write;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->set_bias_level = wm8731_set_bias_level;
+	codec->dai = &wm8731_dai;
+	codec->num_dai = 1;
+	codec->reg_cache_size = WM8731_CACHEREGNUM;
+	codec->reg_cache = &wm8731->reg_cache;
+
+	memcpy(codec->reg_cache, wm8731_reg, sizeof(wm8731_reg));
+
+	wm8731_dai.dev = codec->dev;
+
+	wm8731_reset(codec);
+	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	/* Latch the update bits */
+	reg = wm8731_read_reg_cache(codec, WM8731_LOUT1V);
+	wm8731_write(codec, WM8731_LOUT1V, reg & ~0x0100);
+	reg = wm8731_read_reg_cache(codec, WM8731_ROUT1V);
+	wm8731_write(codec, WM8731_ROUT1V, reg & ~0x0100);
+	reg = wm8731_read_reg_cache(codec, WM8731_LINVOL);
+	wm8731_write(codec, WM8731_LINVOL, reg & ~0x0100);
+	reg = wm8731_read_reg_cache(codec, WM8731_RINVOL);
+	wm8731_write(codec, WM8731_RINVOL, reg & ~0x0100);
+
+	wm8731_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_register_dai(&wm8731_dai);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
+		snd_soc_unregister_codec(codec);
+		return ret;
+	}
 
-static int __devexit wm8731_spi_remove(struct spi_device *spi)
-{
 	return 0;
 }
 
-static struct spi_driver wm8731_spi_driver = {
-	.driver = {
-		.name	= "wm8731",
-		.bus	= &spi_bus_type,
-		.owner	= THIS_MODULE,
-	},
-	.probe		= wm8731_spi_probe,
-	.remove		= __devexit_p(wm8731_spi_remove),
-};
+static void wm8731_unregister(struct wm8731_priv *wm8731)
+{
+	wm8731_set_bias_level(&wm8731->codec, SND_SOC_BIAS_OFF);
+	snd_soc_unregister_dai(&wm8731_dai);
+	snd_soc_unregister_codec(&wm8731->codec);
+	kfree(wm8731);
+	wm8731_codec = NULL;
+}
 
+#if defined(CONFIG_SPI_MASTER)
 static int wm8731_spi_write(struct spi_device *spi, const char *data, int len)
 {
 	struct spi_transfer t;
@@ -730,37 +640,67 @@ static int wm8731_spi_write(struct spi_device *spi, const char *data, int len)
 
 	return len;
 }
+
+static int __devinit wm8731_spi_probe(struct spi_device *spi)
+{
+	struct snd_soc_codec *codec;
+	struct wm8731_priv *wm8731;
+
+	wm8731 = kzalloc(sizeof(struct wm8731_priv), GFP_KERNEL);
+	if (wm8731 == NULL)
+		return -ENOMEM;
+
+	codec = &wm8731->codec;
+	codec->control_data = spi;
+	codec->hw_write = (hw_write_t)wm8731_spi_write;
+	codec->dev = &spi->dev;
+
+	return wm8731_register(wm8731);
+}
+
+static int __devexit wm8731_spi_remove(struct spi_device *spi)
+{
+	/* FIXME: This isn't actually implemented... */
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
 #endif /* CONFIG_SPI_MASTER */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-/*
- * WM8731 2 wire address is determined by GPIO5
- * state during powerup.
- *    low  = 0x1a
- *    high = 0x1b
- */
-
 static int wm8731_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = wm8731_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
+	struct wm8731_priv *wm8731;
+	struct snd_soc_codec *codec;
 
-	i2c_set_clientdata(i2c, codec);
+	wm8731 = kzalloc(sizeof(struct wm8731_priv), GFP_KERNEL);
+	if (wm8731 == NULL)
+		return -ENOMEM;
+
+	codec = &wm8731->codec;
+	codec->hw_write = (hw_write_t)i2c_master_send;
+
+	i2c_set_clientdata(i2c, wm8731);
 	codec->control_data = i2c;
 
-	ret = wm8731_init(socdev);
-	if (ret < 0)
-		pr_err("failed to initialise WM8731\n");
+	codec->dev = &i2c->dev;
 
-	return ret;
+	return wm8731_register(wm8731);
 }
 
 static int wm8731_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
+	struct wm8731_priv *wm8731 = i2c_get_clientdata(client);
+	wm8731_unregister(wm8731);
 	return 0;
 }
 
@@ -783,13 +723,33 @@ static struct i2c_driver wm8731_i2c_driver = {
 
 static int __init wm8731_modinit(void)
 {
-	return snd_soc_register_dai(&wm8731_dai);
+	int ret;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&wm8731_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register WM8731 I2C driver: %d\n",
+		       ret);
+	}
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&wm8731_spi_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register WM8731 SPI driver: %d\n",
+		       ret);
+	}
+#endif
+	return 0;
 }
 module_init(wm8731_modinit);
 
 static void __exit wm8731_exit(void)
 {
-	snd_soc_unregister_dai(&wm8731_dai);
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&wm8731_i2c_driver);
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&wm8731_spi_driver);
+#endif
 }
 module_exit(wm8731_exit);
 
diff --git a/sound/soc/codecs/wm8731.h b/sound/soc/codecs/wm8731.h
index 95190e9..cd7b806 100644
--- a/sound/soc/codecs/wm8731.h
+++ b/sound/soc/codecs/wm8731.h
@@ -34,12 +34,6 @@
 #define WM8731_SYSCLK	0
 #define WM8731_DAI		0
 
-struct wm8731_setup_data {
-	int            spi;
-	int            i2c_bus;
-	unsigned short i2c_address;
-};
-
 extern struct snd_soc_dai wm8731_dai;
 extern struct snd_soc_codec_device soc_codec_dev_wm8731;
 
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 0d41be3..eaa6691 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -317,19 +317,44 @@ static struct snd_soc_card snd_soc_corgi = {
 	.num_links = 1,
 };
 
-/* corgi audio private data */
-static struct wm8731_setup_data corgi_wm8731_setup = {
-	.i2c_bus = 0,
-	.i2c_address = 0x1b,
-};
-
 /* corgi audio subsystem */
 static struct snd_soc_device corgi_snd_devdata = {
 	.card = &snd_soc_corgi,
 	.codec_dev = &soc_codec_dev_wm8731,
-	.codec_data = &corgi_wm8731_setup,
 };
 
+/*
+ * FIXME: This is a temporary bodge to avoid cross-tree merge issues.
+ * New drivers should register the wm8731 I2C device in the machine
+ * setup code (under arch/arm for ARM systems).
+ */
+static int wm8731_i2c_register(void)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = 0x1b;
+	strlcpy(info.type, "wm8731", I2C_NAME_SIZE);
+
+	adapter = i2c_get_adapter(0);
+	if (!adapter) {
+		printk(KERN_ERR "can't get i2c adapter 0\n");
+		return -ENODEV;
+	}
+
+	client = i2c_new_device(adapter, &info);
+	i2c_put_adapter(adapter);
+	if (!client) {
+		printk(KERN_ERR "can't add i2c device at 0x%x\n",
+			(unsigned int)info.addr);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static struct platform_device *corgi_snd_device;
 
 static int __init corgi_init(void)
@@ -340,6 +365,10 @@ static int __init corgi_init(void)
 	      machine_is_husky()))
 		return -ENODEV;
 
+	ret = wm8731_i2c_setup();
+	if (ret != 0)
+		return ret;
+
 	corgi_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!corgi_snd_device)
 		return -ENOMEM;
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 3a62d43..fd683a0 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -283,17 +283,42 @@ static struct snd_soc_card snd_soc_poodle = {
 	.num_links = 1,
 };
 
-/* poodle audio private data */
-static struct wm8731_setup_data poodle_wm8731_setup = {
-	.i2c_bus = 0,
-	.i2c_address = 0x1b,
-};
+/*
+ * FIXME: This is a temporary bodge to avoid cross-tree merge issues.
+ * New drivers should register the wm8731 I2C device in the machine
+ * setup code (under arch/arm for ARM systems).
+ */
+static int wm8731_i2c_register(void)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = 0x1b;
+	strlcpy(info.type, "wm8731", I2C_NAME_SIZE);
+
+	adapter = i2c_get_adapter(0);
+	if (!adapter) {
+		printk(KERN_ERR "can't get i2c adapter 0\n");
+		return -ENODEV;
+	}
+
+	client = i2c_new_device(adapter, &info);
+	i2c_put_adapter(adapter);
+	if (!client) {
+		printk(KERN_ERR "can't add i2c device at 0x%x\n",
+			(unsigned int)info.addr);
+		return -ENODEV;
+	}
+
+	return 0;
+}
 
 /* poodle audio subsystem */
 static struct snd_soc_device poodle_snd_devdata = {
 	.card = &snd_soc_poodle,
 	.codec_dev = &soc_codec_dev_wm8731,
-	.codec_data = &poodle_wm8731_setup,
 };
 
 static struct platform_device *poodle_snd_device;
@@ -305,6 +330,10 @@ static int __init poodle_init(void)
 	if (!machine_is_poodle())
 		return -ENODEV;
 
+	ret = wm8731_i2c_setup();
+	if (ret != 0)
+		return ret;
+
 	locomo_gpio_set_dir(&poodle_locomo_device.dev,
 		POODLE_LOCOMO_GPIO_AMP_ON, 0);
 	/* should we mute HP at startup - burning power ?*/
-- 
1.5.6.3
