From: Ben Dooks <ben-alsa@fluff.org>
Subject: AUDIO: Split WM8750 IO routines from core for SPI
Date: Mon, 23 Jun 2008 12:54:07 +0100
Message-ID: <20080623115406.920274505@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kira.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 86FC5248A3
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 13:54:13 +0200 (CEST)
Content-Disposition: inline;
	filename=simtec/jive/sound-asoc-wm8750-split-if.patch
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
Cc: Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

Add SPI support to the WM8750 ASoC codec by splitting
the I2C out of the WM8750 codec and adding an standard
SPI driver to the system.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc4-quilt3/sound/soc/codecs/Kconfig
===================================================================
--- linux-2.6.26-rc4-quilt3.orig/sound/soc/codecs/Kconfig	2008-05-26 23:17:51.000000000 +0100
+++ linux-2.6.26-rc4-quilt3/sound/soc/codecs/Kconfig	2008-06-02 15:26:21.000000000 +0100
@@ -10,6 +10,16 @@ config SND_SOC_WM8750
 	tristate
 	depends on SND_SOC
 
+config SND_SOC_WM8750_I2C
+	tristate
+	select SND_SOC_WM8750
+	depends on SND_SOC && (CONFIG_I2C || CONFIG_I2C_MODULE)
+
+config SND_SOC_WM8750_SPI
+	tristate
+	select SND_SOC_WM8750
+	depends on SND_SOC && CONFIG_SPI
+
 config SND_SOC_WM8753
 	tristate
 	depends on SND_SOC
Index: linux-2.6.26-rc4-quilt3/sound/soc/codecs/Makefile
===================================================================
--- linux-2.6.26-rc4-quilt3.orig/sound/soc/codecs/Makefile	2008-05-26 23:17:51.000000000 +0100
+++ linux-2.6.26-rc4-quilt3/sound/soc/codecs/Makefile	2008-06-02 15:26:57.000000000 +0100
@@ -1,6 +1,8 @@
 snd-soc-ac97-objs := ac97.o
 snd-soc-wm8731-objs := wm8731.o
 snd-soc-wm8750-objs := wm8750.o
+snd-soc-wm8750-spi-objs := wm8750-spi.o
+snd-soc-wm8750-i2c-objs := wm8750-i2c.o
 snd-soc-wm8753-objs := wm8753.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
@@ -10,6 +12,8 @@ snd-soc-tlv320aic3x-objs := tlv320aic3x.
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_WM8731)	+= snd-soc-wm8731.o
 obj-$(CONFIG_SND_SOC_WM8750)	+= snd-soc-wm8750.o
+obj-$(CONFIG_SND_SOC_WM8750_I2C) += snd-soc-wm8750-i2c.o
+obj-$(CONFIG_SND_SOC_WM8750_SPI) += snd-soc-wm8750-spi.o
 obj-$(CONFIG_SND_SOC_WM8753)	+= snd-soc-wm8753.o
 obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
Index: linux-2.6.26-rc4-quilt3/sound/soc/codecs/wm8750-i2c.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.26-rc4-quilt3/sound/soc/codecs/wm8750-i2c.c	2008-06-02 15:42:19.000000000 +0100
@@ -0,0 +1,175 @@
+/*
+ * wm8750-i2c.c -- WM8750 ALSA SoC I2C Driver
+ *
+ * Copyright 2005 Openedhand Ltd.
+ *
+ * Author: Richard Purdie <richard@openedhand.com>
+ *
+ * Based on WM8753.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include "wm8750.h"
+
+/* If the i2c layer weren't so broken, we could pass this kind of data
+   around */
+static struct snd_soc_device *wm8750_socdev;
+
+/*
+ * WM8731 2 wire address is determined by GPIO5
+ * state during powerup.
+ *    low  = 0x1a
+ *    high = 0x1b
+ */
+static unsigned short normal_i2c[] = { 0, I2C_CLIENT_END };
+
+/* Magic definition of all other variables and things */
+I2C_CLIENT_INSMOD;
+
+static struct i2c_driver wm8750_i2c_driver;
+static struct i2c_client client_template;
+
+static int wm8750_codec_probe(struct i2c_adapter *adap, int addr, int kind)
+{
+	struct snd_soc_device *socdev = wm8750_socdev;
+	struct wm8750_setup_data *setup = socdev->codec_data;
+	struct snd_soc_codec *codec = socdev->codec;
+	struct i2c_client *i2c;
+	int ret;
+
+	if (addr != setup->i2c_address)
+		return -ENODEV;
+
+	client_template.adapter = adap;
+	client_template.addr = addr;
+
+	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
+	if (i2c == NULL) {
+		kfree(codec);
+		return -ENOMEM;
+	}
+
+	i2c_set_clientdata(i2c, codec);
+	codec->control_data = i2c;
+
+	ret = i2c_attach_client(i2c);
+	if (ret < 0) {
+		err("failed to attach codec at addr %x\n", addr);
+		goto err;
+	}
+
+	ret = wm8750_init(socdev);
+	if (ret < 0) {
+		err("failed to initialise WM8750\n");
+		goto err;
+	}
+
+	return ret;
+
+err:
+	kfree(codec);
+	kfree(i2c);
+	return ret;
+}
+
+static int wm8750_i2c_detach(struct i2c_client *client)
+{
+	struct snd_soc_codec *codec = i2c_get_clientdata(client);
+	i2c_detach_client(client);
+	kfree(codec->reg_cache);
+	kfree(client);
+	return 0;
+}
+
+static int wm8750_i2c_attach(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, wm8750_codec_probe);
+}
+
+/* corgi i2c codec control layer */
+static struct i2c_driver wm8750_i2c_driver = {
+	.driver = {
+		.name = "WM8750 I2C Codec",
+		.owner = THIS_MODULE,
+	},
+	.id =             I2C_DRIVERID_WM8750,
+	.attach_adapter = wm8750_i2c_attach,
+	.detach_client =  wm8750_i2c_detach,
+	.command =        NULL,
+};
+
+static struct i2c_client client_template = {
+	.name =   "WM8750",
+	.driver = &wm8750_i2c_driver,
+};
+
+static int wm8750_probe_i2c(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct wm8750_setup_data *setup = socdev->codec_data;
+	struct snd_soc_codec *codec;
+
+	codec = wm8750_probe(pdev);
+	if (codec == NULL) {
+		dev_err(&pdev->dev, "No memory for CODEC device\n");
+		return -ENODEV;
+	}
+
+	/* initialise our interface */
+
+	if (setup->i2c_address) {
+		normal_i2c[0] = setup->i2c_address;
+		codec->hw_write = (hw_write_t)i2c_master_send;
+		ret = i2c_add_driver(&wm8750_i2c_driver);
+		if (ret != 0)
+			printk(KERN_ERR "can't add i2c driver");
+	}
+
+	return 0;
+}
+
+static int wm8750_remove_i2c(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = wm8750_remove(pdev);
+	if (ret)
+		return ret;
+
+	i2c_del_driver(&wm8750_i2c_driver);
+	wm8750_free(pdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_wm8750_i2c = {
+	.probe		= wm8750_probe_i2c,
+	.remove		= wm8750_remove_i2c,
+	.suspend	= wm8750_suspend,
+	.resume		= wm8750_resume,
+};
+
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8750_i2c);
+
+MODULE_DESCRIPTION("ASoC WM8750 I2C access driver");
+MODULE_AUTHOR("Liam Girdwood");
+MODULE_LICENSE("GPL");
Index: linux-2.6.26-rc4-quilt3/sound/soc/codecs/wm8750.c
===================================================================
--- linux-2.6.26-rc4-quilt3.orig/sound/soc/codecs/wm8750.c	2008-05-26 23:17:51.000000000 +0100
+++ linux-2.6.26-rc4-quilt3/sound/soc/codecs/wm8750.c	2008-06-02 19:59:08.000000000 +0100
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
-#include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -751,7 +750,7 @@ static void wm8750_work(struct work_stru
 	wm8750_dapm_event(codec, codec->dapm_state);
 }
 
-static int wm8750_suspend(struct platform_device *pdev, pm_message_t state)
+int wm8750_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->codec;
@@ -760,7 +759,9 @@ static int wm8750_suspend(struct platfor
 	return 0;
 }
 
-static int wm8750_resume(struct platform_device *pdev)
+EXPORT_SYMBOL_GPL(wm8750_suspend);
+
+int wm8750_resume(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->codec;
@@ -790,11 +791,13 @@ static int wm8750_resume(struct platform
 	return 0;
 }
 
+EXPORT_SYMBOL_GPL(wm8750_resume);
+
 /*
  * initialise the WM8750 driver
  * register the mixer and dsp interfaces with the kernel
  */
-static int wm8750_init(struct snd_soc_device *socdev)
+int wm8750_init(struct snd_soc_device *socdev)
 {
 	struct snd_soc_codec *codec = socdev->codec;
 	int reg, ret = 0;
@@ -860,139 +863,36 @@ pcm_err:
 	return ret;
 }
 
-/* If the i2c layer weren't so broken, we could pass this kind of data
-   around */
-static struct snd_soc_device *wm8750_socdev;
-
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-
-/*
- * WM8731 2 wire address is determined by GPIO5
- * state during powerup.
- *    low  = 0x1a
- *    high = 0x1b
- */
-static unsigned short normal_i2c[] = { 0, I2C_CLIENT_END };
-
-/* Magic definition of all other variables and things */
-I2C_CLIENT_INSMOD;
-
-static struct i2c_driver wm8750_i2c_driver;
-static struct i2c_client client_template;
-
-static int wm8750_codec_probe(struct i2c_adapter *adap, int addr, int kind)
-{
-	struct snd_soc_device *socdev = wm8750_socdev;
-	struct wm8750_setup_data *setup = socdev->codec_data;
-	struct snd_soc_codec *codec = socdev->codec;
-	struct i2c_client *i2c;
-	int ret;
-
-	if (addr != setup->i2c_address)
-		return -ENODEV;
-
-	client_template.adapter = adap;
-	client_template.addr = addr;
-
-	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (i2c == NULL) {
-		kfree(codec);
-		return -ENOMEM;
-	}
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
-
-	ret = i2c_attach_client(i2c);
-	if (ret < 0) {
-		err("failed to attach codec at addr %x\n", addr);
-		goto err;
-	}
-
-	ret = wm8750_init(socdev);
-	if (ret < 0) {
-	err("failed to initialise WM8750\n");
-		goto err;
-	}
-	return ret;
-
-err:
-	kfree(codec);
-	kfree(i2c);
-	return ret;
-}
-
-static int wm8750_i2c_detach(struct i2c_client *client)
-{
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	i2c_detach_client(client);
-	kfree(codec->reg_cache);
-	kfree(client);
-	return 0;
-}
-
-static int wm8750_i2c_attach(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data, wm8750_codec_probe);
-}
-
-/* corgi i2c codec control layer */
-static struct i2c_driver wm8750_i2c_driver = {
-	.driver = {
-		.name = "WM8750 I2C Codec",
-		.owner = THIS_MODULE,
-	},
-	.id =             I2C_DRIVERID_WM8750,
-	.attach_adapter = wm8750_i2c_attach,
-	.detach_client =  wm8750_i2c_detach,
-	.command =        NULL,
-};
-
-static struct i2c_client client_template = {
-	.name =   "WM8750",
-	.driver = &wm8750_i2c_driver,
-};
-#endif
+EXPORT_SYMBOL_GPL(wm8750_init);
 
-static int wm8750_probe(struct platform_device *pdev)
+struct snd_soc_codec *wm8750_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct wm8750_setup_data *setup = socdev->codec_data;
 	struct snd_soc_codec *codec;
 	struct wm8750_priv *wm8750;
-	int ret = 0;
 
 	info("WM8750 Audio Codec %s", WM8750_VERSION);
+
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
 	if (codec == NULL)
-		return -ENOMEM;
+		return NULL;
 
 	wm8750 = kzalloc(sizeof(struct wm8750_priv), GFP_KERNEL);
 	if (wm8750 == NULL) {
 		kfree(codec);
-		return -ENOMEM;
+		return NULL;
 	}
 
 	codec->private_data = wm8750;
 	socdev->codec = codec;
+	wm8750_socdev = socdev;
 	mutex_init(&codec->mutex);
+
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
-	wm8750_socdev = socdev;
 	INIT_DELAYED_WORK(&codec->delayed_work, wm8750_work);
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		normal_i2c[0] = setup->i2c_address;
-		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = i2c_add_driver(&wm8750_i2c_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add i2c driver");
-	}
-#else
-		/* Add other interfaces here */
-#endif
-
-	return ret;
+	return codec;
 }
 
 /*
@@ -1015,32 +915,33 @@ static int run_delayed_work(struct delay
 }
 
 /* power down chip */
-static int wm8750_remove(struct platform_device *pdev)
+int wm8750_remove(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->codec;
 
 	if (codec->control_data)
 		wm8750_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+
 	run_delayed_work(&codec->delayed_work);
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_del_driver(&wm8750_i2c_driver);
-#endif
-	kfree(codec->private_data);
-	kfree(codec);
 
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_wm8750 = {
-	.probe = 	wm8750_probe,
-	.remove = 	wm8750_remove,
-	.suspend = 	wm8750_suspend,
-	.resume =	wm8750_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8750);
+EXPORT_SYMBOL_GPL(wm8750_remove);
+
+void wm8750_free(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	kfree(codec->private_data);
+	kfree(codec);
+}
+
+EXPORT_SYMBOL_GPL(wm8750_free);
 
 MODULE_DESCRIPTION("ASoC WM8750 driver");
 MODULE_AUTHOR("Liam Girdwood");
Index: linux-2.6.26-rc4-quilt3/sound/soc/codecs/wm8750.h
===================================================================
--- linux-2.6.26-rc4-quilt3.orig/sound/soc/codecs/wm8750.h	2008-01-24 22:58:37.000000000 +0000
+++ linux-2.6.26-rc4-quilt3/sound/soc/codecs/wm8750.h	2008-06-02 15:26:21.000000000 +0100
@@ -62,6 +62,18 @@ struct wm8750_setup_data {
 };
 
 extern struct snd_soc_codec_dai wm8750_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8750;
+
+extern struct snd_soc_codec_device soc_codec_dev_wm8750_i2c;
+extern struct snd_soc_codec_device soc_codec_dev_wm8750_spi;
+
+/* internal items for the interface modules, not for SoC drivers */
+
+extern struct snd_soc_codec *wm8750_probe(struct platform_device *pdev);
+extern int wm8750_init(struct snd_soc_device *socdev);
+
+extern void wm8750_free(struct platform_device *pdev);
+extern int wm8750_suspend(struct platform_device *pdev, pm_message_t state);
+extern int wm8750_resume(struct platform_device *pdev);
+extern int wm8750_remove(struct platform_device *pdev);
 
 #endif
Index: linux-2.6.26-rc4-quilt3/sound/soc/pxa/spitz.c
===================================================================
--- linux-2.6.26-rc4-quilt3.orig/sound/soc/pxa/spitz.c	2008-05-26 23:17:51.000000000 +0100
+++ linux-2.6.26-rc4-quilt3/sound/soc/pxa/spitz.c	2008-06-02 15:26:21.000000000 +0100
@@ -351,7 +351,7 @@ static struct wm8750_setup_data spitz_wm
 static struct snd_soc_device spitz_snd_devdata = {
 	.machine = &snd_soc_machine_spitz,
 	.platform = &pxa2xx_soc_platform,
-	.codec_dev = &soc_codec_dev_wm8750,
+	.codec_dev = &soc_codec_dev_wm8750_i2c,
 	.codec_data = &spitz_wm8750_setup,
 };
 
Index: linux-2.6.26-rc4-quilt3/sound/soc/pxa/Kconfig
===================================================================
--- linux-2.6.26-rc4-quilt3.orig/sound/soc/pxa/Kconfig	2008-04-17 09:49:21.000000000 +0100
+++ linux-2.6.26-rc4-quilt3/sound/soc/pxa/Kconfig	2008-06-02 15:26:21.000000000 +0100
@@ -31,6 +31,7 @@ config SND_PXA2XX_SOC_SPITZ
 	tristate "SoC Audio support for Sharp Zaurus SL-Cxx00"
 	depends on SND_PXA2XX_SOC && PXA_SHARP_Cxx00
 	select SND_PXA2XX_SOC_I2S
+	select SND_SOC_WM8750_I2C
 	select SND_SOC_WM8750
 	help
 	  Say Y if you want to add support for SoC audio on Sharp
Index: linux-2.6.26-rc4-quilt3/sound/soc/codecs/wm8750-spi.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.26-rc4-quilt3/sound/soc/codecs/wm8750-spi.c	2008-06-02 19:58:55.000000000 +0100
@@ -0,0 +1,161 @@
+/* sound/asoc/codecs/wm8750-spi.c
+ *
+ * Copyright 2007 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+
+#include <linux/spi/spi.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include "wm8750.h"
+
+static struct snd_soc_device *wm8750_socdev;
+
+struct wm8750_spi {
+	struct snd_soc_device	*socdev;
+	struct spi_device	*dev;
+	struct spi_message	message;
+	struct spi_transfer	transfer;
+};
+
+static int wm8750_spi_write(void *ctrl, const char *data, int size)
+{
+	struct wm8750_spi *spi = ctrl;
+
+	spi_message_init(&spi->message);
+	spi_message_add_tail(&spi->transfer, &spi->message);
+
+	spi->transfer.tx_buf = data;
+	spi->transfer.len = size;
+	spi->transfer.bits_per_word = 8;
+
+	return spi_sync(spi->dev, &spi->message);
+}
+
+static int __devinit wm8750_spi_probe(struct spi_device *spi)
+{
+	struct snd_soc_device *socdev = wm8750_socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	struct wm8750_spi *spidata;
+	int ret;
+
+	dev_info(&spi->dev, "probing device\n");
+
+	spidata = kmalloc(sizeof(struct wm8750_spi), GFP_KERNEL);
+	if (spidata == NULL) {
+		dev_err(&spi->dev, "failed to allocate state\n");
+		kfree(codec);
+		return -ENOMEM;
+	}
+
+	spidata->dev = spi;
+	spidata->socdev = socdev;
+	codec->control_data = spi;
+
+	dev_set_drvdata(&spi->dev, spi);
+
+	ret = wm8750_init(socdev);
+	if (ret < 0) {
+		dev_err(&spi->dev, "failed to initialise codec\n");
+		kfree(spi);
+		kfree(codec);
+		return ret;
+	}
+
+	dev_info(&spi->dev, "CODEC initialised\n");
+
+	return 0;
+}
+
+static int __devexit wm8750_spi_remove(struct spi_device *spi)
+{
+	struct wm8750_spi *spidata = dev_get_drvdata(&spi->dev);
+	struct snd_soc_codec *codec = spidata->socdev->codec;
+
+	dev_info(&spi->dev, "removing device\n");
+
+	kfree(codec->reg_cache);
+	kfree(spi);
+
+	return 0;
+}
+
+static struct spi_driver wm8750_spi_driver = {
+	.driver = {
+		.name		= "WM8750",
+		.owner		= THIS_MODULE,
+	},
+	.probe		= wm8750_spi_probe,
+	.remove		= __devexit_p(wm8750_spi_remove),
+};
+
+
+static int wm8750_probe_spi(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret;
+
+	codec = wm8750_probe(pdev);
+	if (codec == NULL) {
+		dev_err(&pdev->dev, "No memory for CODEC device\n");
+		return -ENODEV;
+	}
+
+	wm8750_socdev = socdev;
+
+	codec->hw_write = wm8750_spi_write;
+
+	ret = spi_register_driver(&wm8750_spi_driver);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register spi driver\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int wm8750_remove_spi(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = wm8750_remove(pdev);
+	if (ret)
+		return ret;
+
+	spi_unregister_driver(&wm8750_spi_driver);
+	wm8750_free(pdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_wm8750_spi = {
+	.probe		= wm8750_probe_spi,
+	.remove		= wm8750_remove_spi,
+	.suspend	= wm8750_suspend,
+	.resume		= wm8750_resume,
+};
+
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8750_spi);
+
+MODULE_DESCRIPTION("ASoC WM8750 SPI access driver");
+MODULE_AUTHOR("Ben Dooks");
+MODULE_LICENSE("GPL");

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
