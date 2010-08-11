From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 11/14] ASoC: multi-component - Cirrus Logic
	ep93xx Platform
Date: Wed, 11 Aug 2010 09:46:30 +0100
Message-ID: <1281516393-6060-12-git-send-email-lrg@slimlogic.co.uk>
References: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CA2C10388E
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 10:47:13 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 42so11847202wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 01:47:13 -0700 (PDT)
In-Reply-To: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Ryan Mallon <ryan@bluewatersys.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Update the Cirrus Logic EP93xx platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DMA drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o Add platform devices for I2S and PCM.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 arch/arm/mach-ep93xx/clock.c   |    6 +++---
 arch/arm/mach-ep93xx/core.c    |    8 +++++++-
 sound/soc/ep93xx/ep93xx-i2s.c  |   38 +++++++++++++++-----------------------
 sound/soc/ep93xx/ep93xx-i2s.h  |   18 ------------------
 sound/soc/ep93xx/ep93xx-pcm.c  |   37 ++++++++++++++++++++++++++++---------
 sound/soc/ep93xx/ep93xx-pcm.h  |    2 --
 sound/soc/ep93xx/snappercl15.c |   24 ++++++++++--------------
 7 files changed, 63 insertions(+), 70 deletions(-)
 delete mode 100644 sound/soc/ep93xx/ep93xx-i2s.h

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 8031624..73a41e4 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -215,9 +215,9 @@ static struct clk_lookup clocks[] = {
 	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
 	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
 	INIT_CK("ep93xx-spi.0",		NULL,		&clk_spi),
-	INIT_CK("ep93xx-i2s",		"mclk",		&clk_i2s_mclk),
-	INIT_CK("ep93xx-i2s",		"sclk",		&clk_i2s_sclk),
-	INIT_CK("ep93xx-i2s",		"lrclk",	&clk_i2s_lrclk),
+	INIT_CK("ep93xx-i2s-dai",	"mclk",		&clk_i2s_mclk),
+	INIT_CK("ep93xx-i2s-dai",	"sclk",		&clk_i2s_sclk),
+	INIT_CK("ep93xx-i2s-dai",	"lrclk",	&clk_i2s_lrclk),
 	INIT_CK(NULL,			"pwm_clk",	&clk_pwm),
 	INIT_CK(NULL,			"m2p0",		&clk_m2p0),
 	INIT_CK(NULL,			"m2p1",		&clk_m2p1),
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index b4ee540..d4dd508 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -726,15 +726,21 @@ static struct resource ep93xx_i2s_resource[] = {
 };
 
 static struct platform_device ep93xx_i2s_device = {
-	.name		= "ep93xx-i2s",
+	.name		= "ep93xx-i2s-dai",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(ep93xx_i2s_resource),
 	.resource	= ep93xx_i2s_resource,
 };
 
+static struct platform_device ep93xx_pcm_device = {
+	.name		= "ep93xx-pcm-audio",
+	.id		= -1,
+};
+
 void __init ep93xx_register_i2s(void)
 {
 	platform_device_register(&ep93xx_i2s_device);
+	platform_device_register(&ep93xx_pcm_device);
 }
 
 #define EP93XX_SYSCON_DEVCFG_I2S_MASK	(EP93XX_SYSCON_DEVCFG_I2SONSSP | \
diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
index 00b9466..db3e63b 100644
--- a/sound/soc/ep93xx/ep93xx-i2s.c
+++ b/sound/soc/ep93xx/ep93xx-i2s.c
@@ -31,7 +31,6 @@
 #include <mach/dma.h>
 
 #include "ep93xx-pcm.h"
-#include "ep93xx-i2s.h"
 
 #define EP93XX_I2S_TXCLKCFG		0x00
 #define EP93XX_I2S_RXCLKCFG		0x04
@@ -145,8 +144,8 @@ static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct ep93xx_i2s_info *info = rtd->dai->cpu_dai->private_data;
+	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 	snd_soc_dai_set_dma_data(cpu_dai, substream,
 				 &info->dma_params[substream->stream]);
@@ -156,8 +155,7 @@ static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
 static void ep93xx_i2s_shutdown(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct ep93xx_i2s_info *info = rtd->dai->cpu_dai->private_data;
+	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
 
 	ep93xx_i2s_disable(info, substream->stream);
 }
@@ -165,7 +163,7 @@ static void ep93xx_i2s_shutdown(struct snd_pcm_substream *substream,
 static int ep93xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				  unsigned int fmt)
 {
-	struct ep93xx_i2s_info *info = cpu_dai->private_data;
+	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(cpu_dai);
 	unsigned int clk_cfg, lin_ctrl;
 
 	clk_cfg  = ep93xx_i2s_read_reg(info, EP93XX_I2S_RXCLKCFG);
@@ -242,9 +240,7 @@ static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct ep93xx_i2s_info *info = cpu_dai->private_data;
+	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
 	unsigned word_len, div, sdiv, lrdiv;
 	int found = 0, err;
 
@@ -302,7 +298,7 @@ out:
 static int ep93xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
 				 unsigned int freq, int dir)
 {
-	struct ep93xx_i2s_info *info = cpu_dai->private_data;
+	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(cpu_dai);
 
 	if (dir == SND_SOC_CLOCK_IN || clk_id != 0)
 		return -EINVAL;
@@ -313,7 +309,7 @@ static int ep93xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
 #ifdef CONFIG_PM
 static int ep93xx_i2s_suspend(struct snd_soc_dai *dai)
 {
-	struct ep93xx_i2s_info *info = dai->private_data;
+	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
 
 	if (!dai->active)
 		return;
@@ -324,7 +320,7 @@ static int ep93xx_i2s_suspend(struct snd_soc_dai *dai)
 
 static int ep93xx_i2s_resume(struct snd_soc_dai *dai)
 {
-	struct ep93xx_i2s_info *info = dai->private_data;
+	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
 
 	if (!dai->active)
 		return;
@@ -349,9 +345,7 @@ static struct snd_soc_dai_ops ep93xx_i2s_dai_ops = {
 			    SNDRV_PCM_FMTBIT_S24_LE | \
 			    SNDRV_PCM_FMTBIT_S32_LE)
 
-struct snd_soc_dai ep93xx_i2s_dai = {
-	.name		= "ep93xx-i2s",
-	.id		= 0,
+static struct snd_soc_dai_driver ep93xx_i2s_dai = {
 	.symmetric_rates= 1,
 	.suspend	= ep93xx_i2s_suspend,
 	.resume		= ep93xx_i2s_resume,
@@ -369,7 +363,6 @@ struct snd_soc_dai ep93xx_i2s_dai = {
 	},
 	.ops		= &ep93xx_i2s_dai_ops,
 };
-EXPORT_SYMBOL_GPL(ep93xx_i2s_dai);
 
 static int ep93xx_i2s_probe(struct platform_device *pdev)
 {
@@ -383,8 +376,7 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ep93xx_i2s_dai.dev = &pdev->dev;
-	ep93xx_i2s_dai.private_data = info;
+	dev_set_drvdata(&pdev->dev, info);
 	info->dma_params = ep93xx_i2s_dma_params;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -424,7 +416,7 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
 		goto fail_put_sclk;
 	}
 
-	err = snd_soc_register_dai(&ep93xx_i2s_dai);
+	err = snd_soc_register_dai(&pdev->dev, &ep93xx_i2s_dai);
 	if (err)
 		goto fail_put_lrclk;
 
@@ -447,9 +439,9 @@ fail:
 
 static int __devexit ep93xx_i2s_remove(struct platform_device *pdev)
 {
-	struct ep93xx_i2s_info *info = ep93xx_i2s_dai.private_data;
+	struct ep93xx_i2s_info *info = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_dai(&ep93xx_i2s_dai);
+	snd_soc_unregister_dai(&pdev->dev);
 	clk_put(info->lrclk);
 	clk_put(info->sclk);
 	clk_put(info->mclk);
@@ -463,7 +455,7 @@ static struct platform_driver ep93xx_i2s_driver = {
 	.probe	= ep93xx_i2s_probe,
 	.remove	= __devexit_p(ep93xx_i2s_remove),
 	.driver	= {
-		.name	= "ep93xx-i2s",
+		.name	= "ep93xx-i2s-dai",
 		.owner	= THIS_MODULE,
 	},
 };
@@ -481,7 +473,7 @@ static void __exit ep93xx_i2s_exit(void)
 module_init(ep93xx_i2s_init);
 module_exit(ep93xx_i2s_exit);
 
-MODULE_ALIAS("platform:ep93xx-i2s");
+MODULE_ALIAS("platform:ep93xx-i2s-dai");
 MODULE_AUTHOR("Ryan Mallon <ryan@bluewatersys.com>");
 MODULE_DESCRIPTION("EP93XX I2S driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/ep93xx/ep93xx-i2s.h b/sound/soc/ep93xx/ep93xx-i2s.h
deleted file mode 100644
index 3bd4ebf..0000000
--- a/sound/soc/ep93xx/ep93xx-i2s.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * linux/sound/soc/ep93xx-i2s.h
- * EP93xx I2S driver
- *
- * Copyright (C) 2010 Ryan Mallon <ryan@bluewatersys.com>
- *  
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#ifndef _EP93XX_SND_SOC_I2S_H
-#define _EP93XX_SND_SOC_I2S_H
-
-extern struct snd_soc_dai ep93xx_i2s_dai;
-
-#endif /* _EP93XX_SND_SOC_I2S_H */
diff --git a/sound/soc/ep93xx/ep93xx-pcm.c b/sound/soc/ep93xx/ep93xx-pcm.c
index 4ba9384..2f121dd 100644
--- a/sound/soc/ep93xx/ep93xx-pcm.c
+++ b/sound/soc/ep93xx/ep93xx-pcm.c
@@ -95,7 +95,7 @@ static void ep93xx_pcm_buffer_finished(void *cookie,
 static int ep93xx_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = soc_rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = soc_rtd->cpu_dai;
 	struct ep93xx_pcm_dma_params *dma_params;
 	struct ep93xx_runtime_data *rtd;    
 	int ret;
@@ -276,14 +276,14 @@ static int ep93xx_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = 0xffffffff;
 
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		ret = ep93xx_pcm_preallocate_dma_buffer(pcm,
 					SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			return ret;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		ret = ep93xx_pcm_preallocate_dma_buffer(pcm,
 					SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
@@ -293,22 +293,41 @@ static int ep93xx_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 	return 0;
 }
 
-struct snd_soc_platform ep93xx_soc_platform = {
-	.name		= "ep93xx-audio",
-	.pcm_ops	= &ep93xx_pcm_ops,
+static struct snd_soc_platform_driver ep93xx_soc_platform = {
+	.ops		= &ep93xx_pcm_ops,
 	.pcm_new	= &ep93xx_pcm_new,
 	.pcm_free	= &ep93xx_pcm_free_dma_buffers,
 };
-EXPORT_SYMBOL_GPL(ep93xx_soc_platform);
+
+static int __devinit ep93xx_soc_platform_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_platform(&pdev->dev, &ep93xx_soc_platform);
+}
+
+static int __devexit ep93xx_soc_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver ep93xx_pcm_driver = {
+	.driver = {
+			.name = "ep93xx-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = ep93xx_soc_platform_probe,
+	.remove = __devexit_p(ep93xx_soc_platform_remove),
+};
 
 static int __init ep93xx_soc_platform_init(void)
 {
-	return snd_soc_register_platform(&ep93xx_soc_platform);
+	return platform_driver_register(&ep93xx_pcm_driver);
 }
 
 static void __exit ep93xx_soc_platform_exit(void)
 {
-	snd_soc_unregister_platform(&ep93xx_soc_platform);
+	platform_driver_unregister(&ep93xx_pcm_driver);
 }
 
 module_init(ep93xx_soc_platform_init);
diff --git a/sound/soc/ep93xx/ep93xx-pcm.h b/sound/soc/ep93xx/ep93xx-pcm.h
index 4ffdd3f..111e112 100644
--- a/sound/soc/ep93xx/ep93xx-pcm.h
+++ b/sound/soc/ep93xx/ep93xx-pcm.h
@@ -17,6 +17,4 @@ struct ep93xx_pcm_dma_params {
 	int	dma_port;
 };
 
-extern struct snd_soc_platform ep93xx_soc_platform;
-
 #endif /* _EP93XX_SND_SOC_PCM_H */
diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
index 6495534..539e839 100644
--- a/sound/soc/ep93xx/snappercl15.c
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -22,7 +22,6 @@
 
 #include "../codecs/tlv320aic23.h"
 #include "ep93xx-pcm.h"
-#include "ep93xx-i2s.h"
 
 #define CODEC_CLOCK 5644800
 
@@ -30,8 +29,8 @@ static int snappercl15_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int err;
 
 	err = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
@@ -77,8 +76,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"MICIN", NULL, "Mic Jack"},
 };
 
-static int snappercl15_tlv320aic23_init(struct snd_soc_codec *codec)
+static int snappercl15_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+
 	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
 				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
 
@@ -89,24 +90,20 @@ static int snappercl15_tlv320aic23_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link snappercl15_dai = {
 	.name		= "tlv320aic23",
 	.stream_name	= "AIC23",
-	.cpu_dai	= &ep93xx_i2s_dai,
-	.codec_dai	= &tlv320aic23_dai,
+	.cpu_dai_name	= "ep93xx-i2s-dai",
+	.codec_dai_name	= "tlv320aic23-hifi",
+	.codec_name	= "tlv320aic23-codec.0-0x1a",
+	.platform_name	=  "ep93xx-pcm-audio",
 	.init		= snappercl15_tlv320aic23_init,
 	.ops		= &snappercl15_ops,
 };
 
 static struct snd_soc_card snd_soc_snappercl15 = {
 	.name		= "Snapper CL15",
-	.platform	= &ep93xx_soc_platform,
 	.dai_link	= &snappercl15_dai,
 	.num_links	= 1,
 };
 
-static struct snd_soc_device snappercl15_snd_devdata = {
-	.card		= &snd_soc_snappercl15,
-	.codec_dev	= &soc_codec_dev_tlv320aic23,
-};
-
 static struct platform_device *snappercl15_snd_device;
 
 static int __init snappercl15_init(void)
@@ -126,8 +123,7 @@ static int __init snappercl15_init(void)
 	if (!snappercl15_snd_device)
 		return -ENOMEM;
 	
-	platform_set_drvdata(snappercl15_snd_device, &snappercl15_snd_devdata);
-	snappercl15_snd_devdata.dev = &snappercl15_snd_device->dev;
+	platform_set_drvdata(snappercl15_snd_device, &snd_soc_snappercl15);
 	ret = platform_device_add(snappercl15_snd_device);
 	if (ret)
 		platform_device_put(snappercl15_snd_device);
-- 
1.7.0.4
