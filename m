From: Ben Dooks <ben-alsa@fluff.org>
Subject: [patch 2/9] JIVE: Add ASoC audio support
Date: Wed, 04 Mar 2009 00:49:27 +0000
Message-ID: <20090304005138.373218569@fluff.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D4AE24406
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 01:54:00 +0100 (CET)
Content-Disposition: inline; filename=audio/jive-audio-alsa.patch
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Ben Dooks <ben@simtec.co.uk>

Add support for the Jive's WM8750 codec attached via the S3C2412 IIS.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

Index: linux.git/sound/soc/s3c24xx/Kconfig
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/Kconfig	2009-01-24 19:45:32.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/Kconfig	2009-01-24 20:10:46.000000000 +0000
@@ -26,6 +26,15 @@ config SND_S3C24XX_SOC_NEO1973_WM8753
 	  Say Y if you want to add support for SoC audio on smdk2440
 	  with the WM8753.
 
+config SND_S3C24XX_SOC_JIVE_WM8750
+	tristate "SoC I2S Audio support for Jive"
+	depends on SND_S3C24XX_SOC && MACH_JIVE
+	select SND_SOC_WM8750
+	select SND_SOC_WM8750_SPI
+	select SND_S3C2412_SOC_I2S
+	help
+	  Sat Y if you want to add support for SoC audio on the Jive.
+
 config SND_S3C24XX_SOC_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
 	depends on SND_S3C24XX_SOC && MACH_SMDK2443
Index: linux.git/sound/soc/s3c24xx/Makefile
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/Makefile	2009-01-15 21:41:03.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/Makefile	2009-01-24 20:10:46.000000000 +0000
@@ -10,11 +10,13 @@ obj-$(CONFIG_SND_S3C2443_SOC_AC97) += sn
 obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
 
 # S3C24XX Machine Support
+snd-soc-jive-wm8750-objs := jive_wm8750.o
 snd-soc-neo1973-wm8753-objs := neo1973_wm8753.o
 snd-soc-smdk2443-wm9710-objs := smdk2443_wm9710.o
 snd-soc-ln2440sbc-alc650-objs := ln2440sbc_alc650.o
 snd-soc-s3c24xx-uda134x-objs := s3c24xx_uda134x.o
 
+obj-$(CONFIG_SND_S3C24XX_SOC_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SMDK2443_WM9710) += snd-soc-smdk2443-wm9710.o
 obj-$(CONFIG_SND_S3C24XX_SOC_LN2440SBC_ALC650) += snd-soc-ln2440sbc-alc650.o
Index: linux.git/sound/soc/s3c24xx/jive_wm8750.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/jive_wm8750.c	2009-01-24 20:13:32.000000000 +0000
@@ -0,0 +1,216 @@
+/* sound/soc/s3c24xx/jive_wm8750.c
+ *
+ * Copyright 2007,2008 Simtec Electronics
+ *
+ * Based on sound/soc/pxa/spitz.c
+ *	Copyright 2005 Wolfson Microelectronics PLC.
+ *	Copyright 2005 Openedhand Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+
+#include "s3c24xx-pcm.h"
+#include "s3c2412-i2s.h"
+
+#include "../codecs/wm8750.h"
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{ "Headphone Jack", NULL, "LOUT1" },
+	{ "Headphone Jack", NULL, "ROUT1" },
+	{ "Internal Speaker", NULL, "LOUT2" },
+	{ "Internal Speaker", NULL, "ROUT2" },
+	{ "LINPUT1", NULL, "Line Input" },
+	{ "RINPUT1", NULL, "Line Input" },
+};
+
+static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Internal Speaker", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+};
+
+static int jive_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->socdev->codec;
+
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Internal Speaker");
+	snd_soc_dapm_enable_pin(codec, "Line In");
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static int jive_hw_params(struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct s3c2412_rate_calc div;
+	unsigned int clk = 0;
+	int ret = 0;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 48000:
+	case 96000:
+		clk = 12288000;
+		break;
+	case 11025:
+	case 22050:
+	case 44100:
+		clk = 11289600;
+		break;
+	}
+
+	s3c2412_iis_calc_rate(&div, NULL, params_rate(params),
+			      s3c2412_get_iisclk());
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8750_SYSCLK, clk,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C2412_DIV_RCLK, div.fs_div);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C2412_DIV_PRESCALER,
+				     div.clk_div - 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops jive_ops = {
+	.startup	= jive_startup,
+	.hw_params	= jive_hw_params,
+};
+
+static int jive_wm8750_init(struct snd_soc_codec *codec)
+{
+	int err;
+
+	/* These endpoints are not being used. */
+	snd_soc_dapm_disable_pin(codec, "LINPUT2");
+	snd_soc_dapm_disable_pin(codec, "RINPUT2");
+	snd_soc_dapm_disable_pin(codec, "LINPUT3");
+	snd_soc_dapm_disable_pin(codec, "RINPUT3");
+	snd_soc_dapm_disable_pin(codec, "OUT3");
+	snd_soc_dapm_disable_pin(codec, "MONO");
+
+	/* Add jive specific widgets */
+	err = snd_soc_dapm_new_controls(codec, wm8750_dapm_widgets,
+					ARRAY_SIZE(wm8750_dapm_widgets));
+	if (err) {
+		printk(KERN_ERR "%s: failed to add widgets (%d)\n",
+		       __func__, err);
+		return err;
+	}
+
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link jive_dai = {
+	.name		= "wm8750",
+	.stream_name	= "WM8750",
+	.cpu_dai	= &s3c2412_i2s_dai,
+	.codec_dai	= &wm8750_dai,
+	.init		= jive_wm8750_init,
+	.ops		= &jive_ops,
+};
+
+/* jive audio machine driver */
+static struct snd_soc_machine snd_soc_machine_jive = {
+	.name		= "Jive",
+	.dai_link	= &jive_dai,
+	.num_links	= 1,
+};
+
+/* jive audio private data */
+static struct wm8750_setup_data jive_wm8750_setup = {
+};
+
+/* jive audio subsystem */
+static struct snd_soc_device jive_snd_devdata = {
+	.machine	= &snd_soc_machine_jive,
+	.platform	= &s3c24xx_soc_platform,
+	.codec_dev	= &soc_codec_dev_wm8750_spi,
+	.codec_data	= &jive_wm8750_setup,
+};
+
+static struct platform_device *jive_snd_device;
+
+static int __init jive_init(void)
+{
+	int ret;
+
+	if (!machine_is_jive())
+		return 0;
+
+	printk("JIVE WM8750 Audio support\n");
+
+	jive_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!jive_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(jive_snd_device, &jive_snd_devdata);
+	jive_snd_devdata.dev = &jive_snd_device->dev;
+	ret = platform_device_add(jive_snd_device);
+
+	if (ret)
+		platform_device_put(jive_snd_device);
+
+	return ret;
+}
+
+static void __exit jive_exit(void)
+{
+	platform_device_unregister(jive_snd_device);
+}
+
+module_init(jive_init);
+module_exit(jive_exit);
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("ALSA SoC Jive Audio support");
+MODULE_LICENSE("GPL");

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
