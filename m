From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH] ASoC: UDA1380: refactor device registration
Date: Mon, 15 Jun 2009 22:18:23 +0200
Message-ID: <1245097103-9486-1-git-send-email-philipp.zabel@gmail.com>
References: <20090614145128.GB4482@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E5C1103808
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 22:18:24 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3840837fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2009 13:18:23 -0700 (PDT)
In-Reply-To: <20090614145128.GB4482@sirena.org.uk>
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
Cc: Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch mostly follows commit 5998102b9095fdb7c67755812038612afea315c5
"ASoC: Refactor WM8731 device registration" to make UDA1380 use standard
device instantiation. Similarly, the I2C device registration temporarily
moves into the magician machine driver before it will find its final
resting place in the board file.

At the same time, platform specific configuration is moved to platform data
and common power/reset GPIO handling moves into the codec driver.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 include/sound/uda1380.h    |   22 +++
 sound/soc/codecs/uda1380.c |  313 ++++++++++++++++++++++++--------------------
 sound/soc/codecs/uda1380.h |    8 -
 sound/soc/pxa/magician.c   |   54 ++++----
 4 files changed, 221 insertions(+), 176 deletions(-)
 create mode 100644 include/sound/uda1380.h

diff --git a/include/sound/uda1380.h b/include/sound/uda1380.h
new file mode 100644
index 0000000..381319c
--- /dev/null
+++ b/include/sound/uda1380.h
@@ -0,0 +1,22 @@
+/*
+ * UDA1380 ALSA SoC Codec driver
+ *
+ * Copyright 2009 Philipp Zabel
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __UDA1380_H
+#define __UDA1380_H
+
+struct uda1380_platform_data {
+	int gpio_power;
+	int gpio_reset;
+	int dac_clk;
+#define UDA1380_DAC_CLK_SYSCLK 0
+#define UDA1380_DAC_CLK_WSPLL  1
+};
+
+#endif /* __UDA1380_H */
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 5b21594..92ec034 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -5,9 +5,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Copyright (c) 2007 Philipp Zabel <philipp.zabel@gmail.com>
- * Improved support for DAPM and audio routing/mixing capabilities,
- * added TLV support.
+ * Copyright (c) 2007-2009 Philipp Zabel <philipp.zabel@gmail.com>
  *
  * Modified by Richard Purdie <richard@openedhand.com> to fit into SoC
  * codec model.
@@ -19,26 +17,32 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
-#include <linux/ioctl.h>
+#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/workqueue.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/initval.h>
-#include <sound/info.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/tlv.h>
+#include <sound/uda1380.h>
 
 #include "uda1380.h"
 
-static struct work_struct uda1380_work;
 static struct snd_soc_codec *uda1380_codec;
 
+/* codec private data */
+struct uda1380_priv {
+	struct snd_soc_codec codec;
+	u16 reg_cache[UDA1380_CACHEREGNUM];
+	unsigned int dac_clk;
+	struct work_struct work;
+};
+
 /*
  * uda1380 register cache
  */
@@ -473,6 +477,7 @@ static int uda1380_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
+	struct uda1380_priv *uda1380 = codec->private_data;
 	int mixer = uda1380_read_reg_cache(codec, UDA1380_MIXER);
 
 	switch (cmd) {
@@ -480,13 +485,13 @@ static int uda1380_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		uda1380_write_reg_cache(codec, UDA1380_MIXER,
 					mixer & ~R14_SILENCE);
-		schedule_work(&uda1380_work);
+		schedule_work(&uda1380->work);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		uda1380_write_reg_cache(codec, UDA1380_MIXER,
 					mixer | R14_SILENCE);
-		schedule_work(&uda1380_work);
+		schedule_work(&uda1380->work);
 		break;
 	}
 	return 0;
@@ -670,44 +675,33 @@ static int uda1380_resume(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * initialise the UDA1380 driver
- * register mixer and dsp interfaces with the kernel
- */
-static int uda1380_init(struct snd_soc_device *socdev, int dac_clk)
+static int uda1380_probe(struct platform_device *pdev)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	struct uda1380_platform_data *pdata;
 	int ret = 0;
 
-	codec->name = "UDA1380";
-	codec->owner = THIS_MODULE;
-	codec->read = uda1380_read_reg_cache;
-	codec->write = uda1380_write;
-	codec->set_bias_level = uda1380_set_bias_level;
-	codec->dai = uda1380_dai;
-	codec->num_dai = ARRAY_SIZE(uda1380_dai);
-	codec->reg_cache = kmemdup(uda1380_reg, sizeof(uda1380_reg),
-				   GFP_KERNEL);
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
-	codec->reg_cache_size = ARRAY_SIZE(uda1380_reg);
-	codec->reg_cache_step = 1;
-	uda1380_reset(codec);
+	if (uda1380_codec == NULL) {
+		dev_err(&pdev->dev, "Codec device not registered\n");
+		return -ENODEV;
+	}
 
-	uda1380_codec = codec;
-	INIT_WORK(&uda1380_work, uda1380_flush_work);
+	socdev->card->codec = uda1380_codec;
+	codec = uda1380_codec;
+	pdata = codec->dev->platform_data;
 
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
-		pr_err("uda1380: failed to create pcms\n");
+		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
 		goto pcm_err;
 	}
 
 	/* power on device */
 	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	/* set clock input */
-	switch (dac_clk) {
+	switch (pdata->dac_clk) {
 	case UDA1380_DAC_CLK_SYSCLK:
 		uda1380_write(codec, UDA1380_CLK, 0);
 		break;
@@ -716,13 +710,12 @@ static int uda1380_init(struct snd_soc_device *socdev, int dac_clk)
 		break;
 	}
 
-	/* uda1380 init */
 	snd_soc_add_controls(codec, uda1380_snd_controls,
 				ARRAY_SIZE(uda1380_snd_controls));
 	uda1380_add_widgets(codec);
 	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
-		pr_err("uda1380: failed to register card\n");
+		dev_err(codec->dev, "failed to register card: %d\n", ret);
 		goto card_err;
 	}
 
@@ -732,165 +725,201 @@ card_err:
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 pcm_err:
-	kfree(codec->reg_cache);
 	return ret;
 }
 
-static struct snd_soc_device *uda1380_socdev;
-
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-
-static int uda1380_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+/* power down chip */
+static int uda1380_remove(struct platform_device *pdev)
 {
-	struct snd_soc_device *socdev = uda1380_socdev;
-	struct uda1380_setup_data *setup = socdev->codec_data;
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
-
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
 
-	ret = uda1380_init(socdev, setup->dac_clk);
-	if (ret < 0)
-		pr_err("uda1380: failed to initialise UDA1380\n");
+	if (codec->control_data)
+		uda1380_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	return ret;
-}
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
 
-static int uda1380_i2c_remove(struct i2c_client *client)
-{
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
 	return 0;
 }
 
-static const struct i2c_device_id uda1380_i2c_id[] = {
-	{ "uda1380", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, uda1380_i2c_id);
-
-static struct i2c_driver uda1380_i2c_driver = {
-	.driver = {
-		.name =  "UDA1380 I2C Codec",
-		.owner = THIS_MODULE,
-	},
-	.probe =    uda1380_i2c_probe,
-	.remove =   uda1380_i2c_remove,
-	.id_table = uda1380_i2c_id,
+struct snd_soc_codec_device soc_codec_dev_uda1380 = {
+	.probe = 	uda1380_probe,
+	.remove = 	uda1380_remove,
+	.suspend = 	uda1380_suspend,
+	.resume =	uda1380_resume,
 };
+EXPORT_SYMBOL_GPL(soc_codec_dev_uda1380);
 
-static int uda1380_add_i2c_device(struct platform_device *pdev,
-				  const struct uda1380_setup_data *setup)
+static int uda1380_register(struct uda1380_priv *uda1380)
 {
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
+	int ret, i;
+	struct snd_soc_codec *codec = &uda1380->codec;
+	struct uda1380_platform_data *pdata = codec->dev->platform_data;
 
-	ret = i2c_add_driver(&uda1380_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
+	if (uda1380_codec) {
+		dev_err(codec->dev, "Another UDA1380 is registered\n");
+		return -EINVAL;
+	}
+
+	if (!pdata || !pdata->gpio_power || !pdata->gpio_reset)
+		return -EINVAL;
+
+	ret = gpio_request(pdata->gpio_power, "uda1380 power");
+	if (ret)
+		goto err_out;
+	ret = gpio_request(pdata->gpio_reset, "uda1380 reset");
+	if (ret)
+		goto err_gpio;
+
+	gpio_direction_output(pdata->gpio_power, 1);
+
+	/* we may need to have the clock running here - pH5 */
+	gpio_direction_output(pdata->gpio_reset, 1);
+	udelay(5);
+	gpio_set_value(pdata->gpio_reset, 0);
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->private_data = uda1380;
+	codec->name = "UDA1380";
+	codec->owner = THIS_MODULE;
+	codec->read = uda1380_read_reg_cache;
+	codec->write = uda1380_write;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->set_bias_level = uda1380_set_bias_level;
+	codec->dai = uda1380_dai;
+	codec->num_dai = ARRAY_SIZE(uda1380_dai);
+	codec->reg_cache_size = ARRAY_SIZE(uda1380_reg);
+	codec->reg_cache = &uda1380->reg_cache;
+	codec->reg_cache_step = 1;
+
+	memcpy(codec->reg_cache, uda1380_reg, sizeof(uda1380_reg));
+
+	ret = uda1380_reset(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to issue reset\n");
+		goto err_reset;
 	}
 
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "uda1380", I2C_NAME_SIZE);
+	INIT_WORK(&uda1380->work, uda1380_flush_work);
+
+	for (i = 0; i < ARRAY_SIZE(uda1380_dai); i++)
+		uda1380_dai[i].dev = codec->dev;
 
-	adapter = i2c_get_adapter(setup->i2c_bus);
-	if (!adapter) {
-		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
-			setup->i2c_bus);
-		goto err_driver;
+	uda1380_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		goto err_reset;
 	}
 
-	client = i2c_new_device(adapter, &info);
-	i2c_put_adapter(adapter);
-	if (!client) {
-		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
-			(unsigned int)info.addr);
-		goto err_driver;
+	ret = snd_soc_register_dais(uda1380_dai, ARRAY_SIZE(uda1380_dai));
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register DAIs: %d\n", ret);
+		goto err_dai;
 	}
 
 	return 0;
 
-err_driver:
-	i2c_del_driver(&uda1380_i2c_driver);
-	return -ENODEV;
+err_dai:
+	snd_soc_unregister_codec(codec);
+err_reset:
+	gpio_set_value(pdata->gpio_power, 0);
+	gpio_free(pdata->gpio_reset);
+err_gpio:
+	gpio_free(pdata->gpio_power);
+err_out:
+	return ret;
 }
-#endif
 
-static int uda1380_probe(struct platform_device *pdev)
+static void uda1380_unregister(struct uda1380_priv *uda1380)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct uda1380_setup_data *setup;
+	struct snd_soc_codec *codec = &uda1380->codec;
+	struct uda1380_platform_data *pdata = codec->dev->platform_data;
+
+	snd_soc_unregister_dais(uda1380_dai, ARRAY_SIZE(uda1380_dai));
+	snd_soc_unregister_codec(&uda1380->codec);
+
+	gpio_set_value(pdata->gpio_power, 0);
+	gpio_free(pdata->gpio_reset);
+	gpio_free(pdata->gpio_power);
+
+	kfree(uda1380);
+	uda1380_codec = NULL;
+}
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int uda1380_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
+{
+	struct uda1380_priv *uda1380;
 	struct snd_soc_codec *codec;
 	int ret;
 
-	setup = socdev->codec_data;
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
+	uda1380 = kzalloc(sizeof(struct uda1380_priv), GFP_KERNEL);
+	if (uda1380 == NULL)
 		return -ENOMEM;
 
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
+	codec = &uda1380->codec;
+	codec->hw_write = (hw_write_t)i2c_master_send;
 
-	uda1380_socdev = socdev;
-	ret = -ENODEV;
+	i2c_set_clientdata(i2c, uda1380);
+	codec->control_data = i2c;
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = uda1380_add_i2c_device(pdev, setup);
-	}
-#endif
+	codec->dev = &i2c->dev;
 
+	ret = uda1380_register(uda1380);
 	if (ret != 0)
-		kfree(codec);
+		kfree(uda1380);
+
 	return ret;
 }
 
-/* power down chip */
-static int uda1380_remove(struct platform_device *pdev)
+static int __devexit uda1380_i2c_remove(struct i2c_client *i2c)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->control_data)
-		uda1380_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
-	i2c_del_driver(&uda1380_i2c_driver);
-#endif
-	kfree(codec);
-
+	struct uda1380_priv *uda1380 = i2c_get_clientdata(i2c);
+	uda1380_unregister(uda1380);
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_uda1380 = {
-	.probe = 	uda1380_probe,
-	.remove = 	uda1380_remove,
-	.suspend = 	uda1380_suspend,
-	.resume =	uda1380_resume,
+static const struct i2c_device_id uda1380_i2c_id[] = {
+	{ "uda1380", 0 },
+	{ }
 };
-EXPORT_SYMBOL_GPL(soc_codec_dev_uda1380);
+MODULE_DEVICE_TABLE(i2c, uda1380_i2c_id);
+
+static struct i2c_driver uda1380_i2c_driver = {
+	.driver = {
+		.name =  "UDA1380 I2C Codec",
+		.owner = THIS_MODULE,
+	},
+	.probe =    uda1380_i2c_probe,
+	.remove =   __devexit_p(uda1380_i2c_remove),
+	.id_table = uda1380_i2c_id,
+};
+#endif
 
 static int __init uda1380_modinit(void)
 {
-	return snd_soc_register_dais(uda1380_dai, ARRAY_SIZE(uda1380_dai));
+	int ret;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&uda1380_i2c_driver);
+	if (ret != 0)
+		pr_err("Failed to register UDA1380 I2C driver: %d\n", ret);
+#endif
+	return 0;
 }
 module_init(uda1380_modinit);
 
 static void __exit uda1380_exit(void)
 {
-	snd_soc_unregister_dais(uda1380_dai, ARRAY_SIZE(uda1380_dai));
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&uda1380_i2c_driver);
+#endif
 }
 module_exit(uda1380_exit);
 
diff --git a/sound/soc/codecs/uda1380.h b/sound/soc/codecs/uda1380.h
index c55c17a..9cefa8a 100644
--- a/sound/soc/codecs/uda1380.h
+++ b/sound/soc/codecs/uda1380.h
@@ -72,14 +72,6 @@
 #define R22_SKIP_DCFIL	0x0002
 #define R23_AGC_EN	0x0001
 
-struct uda1380_setup_data {
-	int            i2c_bus;
-	unsigned short i2c_address;
-	int            dac_clk;
-#define UDA1380_DAC_CLK_SYSCLK 0
-#define UDA1380_DAC_CLK_WSPLL  1
-};
-
 #define UDA1380_DAI_DUPLEX	0 /* playback and capture on single DAI */
 #define UDA1380_DAI_PLAYBACK	1 /* playback DAI */
 #define UDA1380_DAI_CAPTURE	2 /* capture DAI */
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index c89a3cd..9fe4ad2 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -20,12 +20,14 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/i2c.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/uda1380.h>
 
 #include <mach/magician.h>
 #include <asm/mach-types.h>
@@ -447,34 +449,47 @@ static struct snd_soc_card snd_soc_card_magician = {
 	.platform = &pxa2xx_soc_platform,
 };
 
-/* magician audio private data */
-static struct uda1380_setup_data magician_uda1380_setup = {
-	.i2c_address = 0x18,
-	.dac_clk = UDA1380_DAC_CLK_WSPLL,
-};
-
 /* magician audio subsystem */
 static struct snd_soc_device magician_snd_devdata = {
 	.card = &snd_soc_card_magician,
 	.codec_dev = &soc_codec_dev_uda1380,
-	.codec_data = &magician_uda1380_setup,
 };
 
 static struct platform_device *magician_snd_device;
 
+/*
+ * FIXME: move into magician board file once merged into the pxa tree
+ */
+static struct uda1380_platform_data uda1380_info = {
+	.gpio_power = EGPIO_MAGICIAN_CODEC_POWER,
+	.gpio_reset = EGPIO_MAGICIAN_CODEC_RESET,
+	.dac_clk    = UDA1380_DAC_CLK_WSPLL,
+};
+
+static struct i2c_board_info i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("uda1380", 0x18),
+		.platform_data = &uda1380_info,
+	},
+};
+
 static int __init magician_init(void)
 {
 	int ret;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
 
 	if (!machine_is_magician())
 		return -ENODEV;
 
-	ret = gpio_request(EGPIO_MAGICIAN_CODEC_POWER, "CODEC_POWER");
-	if (ret)
-		goto err_request_power;
-	ret = gpio_request(EGPIO_MAGICIAN_CODEC_RESET, "CODEC_RESET");
-	if (ret)
-		goto err_request_reset;
+	adapter = i2c_get_adapter(0);
+	if (!adapter)
+		return -ENODEV;
+	client = i2c_new_device(adapter, i2c_board_info);
+	i2c_put_adapter(adapter);
+	if (!client)
+		return -ENODEV;
+
 	ret = gpio_request(EGPIO_MAGICIAN_SPK_POWER, "SPK_POWER");
 	if (ret)
 		goto err_request_spk;
@@ -491,14 +506,8 @@ static int __init magician_init(void)
 	if (ret)
 		goto err_request_in_sel1;
 
-	gpio_set_value(EGPIO_MAGICIAN_CODEC_POWER, 1);
 	gpio_set_value(EGPIO_MAGICIAN_IN_SEL0, 0);
 
-	/* we may need to have the clock running here - pH5 */
-	gpio_set_value(EGPIO_MAGICIAN_CODEC_RESET, 1);
-	udelay(5);
-	gpio_set_value(EGPIO_MAGICIAN_CODEC_RESET, 0);
-
 	magician_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!magician_snd_device) {
 		ret = -ENOMEM;
@@ -526,10 +535,6 @@ err_request_mic:
 err_request_ep:
 	gpio_free(EGPIO_MAGICIAN_SPK_POWER);
 err_request_spk:
-	gpio_free(EGPIO_MAGICIAN_CODEC_RESET);
-err_request_reset:
-	gpio_free(EGPIO_MAGICIAN_CODEC_POWER);
-err_request_power:
 	return ret;
 }
 
@@ -540,15 +545,12 @@ static void __exit magician_exit(void)
 	gpio_set_value(EGPIO_MAGICIAN_SPK_POWER, 0);
 	gpio_set_value(EGPIO_MAGICIAN_EP_POWER, 0);
 	gpio_set_value(EGPIO_MAGICIAN_MIC_POWER, 0);
-	gpio_set_value(EGPIO_MAGICIAN_CODEC_POWER, 0);
 
 	gpio_free(EGPIO_MAGICIAN_IN_SEL1);
 	gpio_free(EGPIO_MAGICIAN_IN_SEL0);
 	gpio_free(EGPIO_MAGICIAN_MIC_POWER);
 	gpio_free(EGPIO_MAGICIAN_EP_POWER);
 	gpio_free(EGPIO_MAGICIAN_SPK_POWER);
-	gpio_free(EGPIO_MAGICIAN_CODEC_RESET);
-	gpio_free(EGPIO_MAGICIAN_CODEC_POWER);
 }
 
 module_init(magician_init);
-- 
1.6.3.1
