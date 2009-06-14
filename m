From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH,
	RFC 2/3] ASoC: UDA1380: register from board files,
	configure via pdata
Date: Sun, 14 Jun 2009 12:51:31 +0200
Message-ID: <1244976692-5189-4-git-send-email-philipp.zabel@gmail.com>
References: <1244976692-5189-1-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-2-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-3-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218])
	by alsa0.perex.cz (Postfix) with ESMTP id 9073C246C4
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Jun 2009 12:51:50 +0200 (CEST)
Received: by mail-fx0-f218.google.com with SMTP id 18so2976723fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2009 03:51:50 -0700 (PDT)
In-Reply-To: <1244976692-5189-3-git-send-email-philipp.zabel@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch removes the I2C board info registration from the codec driver.
Instead, device instantiation will be done via global i2c_board_info from
board files. At the same time, platform specific configuration is moved
to platform data and common power/reset GPIO handling moves into the
codec driver.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 include/sound/uda1380.h    |   22 ++++++++++
 sound/soc/codecs/uda1380.c |   95 +++++++++++++++++++++----------------------
 sound/soc/codecs/uda1380.h |   13 ------
 sound/soc/pxa/magician.c   |   26 ------------
 4 files changed, 68 insertions(+), 88 deletions(-)
 create mode 100644 include/sound/uda1380.h

diff --git a/include/sound/uda1380.h b/include/sound/uda1380.h
new file mode 100644
index 0000000..69f8775
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
+#ifndef _UDA1380_H
+#define _UDA1380_H
+
+struct uda1380_platform_data {
+	int gpio_power;
+	int gpio_reset;
+	int dac_clk;
+#define UDA1380_DAC_CLK_SYSCLK 0
+#define UDA1380_DAC_CLK_WSPLL  1
+};
+
+#endif /* _UDA1380_H */
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 5b21594..87f3e12 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -19,20 +19,19 @@
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
 
@@ -740,28 +739,59 @@ static struct snd_soc_device *uda1380_socdev;
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 
-static int uda1380_i2c_probe(struct i2c_client *i2c,
+static int uda1380_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
+	struct uda1380_platform_data *pdata = client->dev.platform_data;
 	struct snd_soc_device *socdev = uda1380_socdev;
-	struct uda1380_setup_data *setup = socdev->codec_data;
 	struct snd_soc_codec *codec = socdev->card->codec;
 	int ret;
 
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
+	if (!pdata || !pdata->gpio_power || !pdata->gpio_reset)
+		return -EINVAL;
+
+	ret = gpio_request(pdata->gpio_power, "uda1380 power");
+	if (ret)
+		goto err_power;
+	ret = gpio_request(pdata->gpio_reset, "uda1380 reset");
+	if (ret)
+		goto err_reset;
+
+	gpio_direction_output(pdata->gpio_power, 1);
 
-	ret = uda1380_init(socdev, setup->dac_clk);
-	if (ret < 0)
+	/* we may need to have the clock running here - pH5 */
+	gpio_direction_output(pdata->gpio_reset, 1);
+	udelay(5);
+	gpio_set_value(pdata->gpio_reset, 0);
+
+	i2c_set_clientdata(client, codec);
+	codec->control_data = client;
+
+	ret = uda1380_init(socdev, pdata->dac_clk);
+	if (ret) {
 		pr_err("uda1380: failed to initialise UDA1380\n");
+		goto err_init;
+	}
 
+	return 0;
+
+err_init:
+	gpio_free(pdata->gpio_reset);
+err_reset:
+	gpio_free(pdata->gpio_power);
+err_power:
 	return ret;
 }
 
 static int uda1380_i2c_remove(struct i2c_client *client)
 {
+	struct uda1380_platform_data *pdata = client->dev.platform_data;
 	struct snd_soc_codec *codec = i2c_get_clientdata(client);
+
 	kfree(codec->reg_cache);
+	gpio_set_value(pdata->gpio_power, 0);
+	gpio_free(pdata->gpio_reset);
+	gpio_free(pdata->gpio_power);
 	return 0;
 }
 
@@ -781,55 +811,24 @@ static struct i2c_driver uda1380_i2c_driver = {
 	.id_table = uda1380_i2c_id,
 };
 
-static int uda1380_add_i2c_device(struct platform_device *pdev,
-				  const struct uda1380_setup_data *setup)
+static int uda1380_add_i2c_device(struct platform_device *pdev)
 {
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
+	int ret = 0;
 
 	ret = i2c_add_driver(&uda1380_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "uda1380", I2C_NAME_SIZE);
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
+	if (ret != 0)
+		dev_err(&pdev->dev, "can't add i2c driver: %d\n", ret);
 
-err_driver:
-	i2c_del_driver(&uda1380_i2c_driver);
-	return -ENODEV;
+	return ret;
 }
 #endif
 
 static int uda1380_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct uda1380_setup_data *setup;
 	struct snd_soc_codec *codec;
 	int ret;
 
-	setup = socdev->codec_data;
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
 	if (codec == NULL)
 		return -ENOMEM;
@@ -843,10 +842,8 @@ static int uda1380_probe(struct platform_device *pdev)
 	ret = -ENODEV;
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = uda1380_add_i2c_device(pdev, setup);
-	}
+	codec->hw_write = (hw_write_t)i2c_master_send;
+	ret = uda1380_add_i2c_device(pdev);
 #endif
 
 	if (ret != 0)
diff --git a/sound/soc/codecs/uda1380.h b/sound/soc/codecs/uda1380.h
index c55c17a..d7904c5 100644
--- a/sound/soc/codecs/uda1380.h
+++ b/sound/soc/codecs/uda1380.h
@@ -8,9 +8,6 @@
  * Copyright (c) 2005 Giorgio Padrin <giorgio@mandarinlogiq.org>
  */
 
-#ifndef _UDA1380_H
-#define _UDA1380_H
-
 #define UDA1380_CLK	0x00
 #define UDA1380_IFACE	0x01
 #define UDA1380_PM	0x02
@@ -72,19 +69,9 @@
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
 
 extern struct snd_soc_dai uda1380_dai[3];
 extern struct snd_soc_codec_device soc_codec_dev_uda1380;
-
-#endif /* _UDA1380_H */
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index fa0e7e6..cc7dbe5 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -448,17 +448,10 @@ static struct snd_soc_card snd_soc_card_magician = {
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
@@ -470,12 +463,6 @@ static int __init magician_init(void)
 	if (!machine_is_magician())
 		return -ENODEV;
 
-	ret = gpio_request(EGPIO_MAGICIAN_CODEC_POWER, "CODEC_POWER");
-	if (ret)
-		goto err_request_power;
-	ret = gpio_request(EGPIO_MAGICIAN_CODEC_RESET, "CODEC_RESET");
-	if (ret)
-		goto err_request_reset;
 	ret = gpio_request(EGPIO_MAGICIAN_SPK_POWER, "SPK_POWER");
 	if (ret)
 		goto err_request_spk;
@@ -492,14 +479,8 @@ static int __init magician_init(void)
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
@@ -527,10 +508,6 @@ err_request_mic:
 err_request_ep:
 	gpio_free(EGPIO_MAGICIAN_SPK_POWER);
 err_request_spk:
-	gpio_free(EGPIO_MAGICIAN_CODEC_RESET);
-err_request_reset:
-	gpio_free(EGPIO_MAGICIAN_CODEC_POWER);
-err_request_power:
 	return ret;
 }
 
@@ -541,15 +518,12 @@ static void __exit magician_exit(void)
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
