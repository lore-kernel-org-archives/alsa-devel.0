From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 12/14] ASoC: multi-component - Marvell Kirkwood
	Platform
Date: Wed, 11 Aug 2010 09:46:31 +0100
Message-ID: <1281516393-6060-13-git-send-email-lrg@slimlogic.co.uk>
References: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FAEE10387D
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 10:47:15 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 42so11847202wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 01:47:15 -0700 (PDT)
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
Cc: Arnaud Patard <apatard@mandriva.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Update the Marvell Kirkwood platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o Add platform devices for PCM.

CC: Arnaud Patard <apatard@mandriva.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 arch/arm/mach-kirkwood/common.c      |    6 +++
 sound/soc/kirkwood/kirkwood-dma.c    |   64 ++++++++++++++++++++++------------
 sound/soc/kirkwood/kirkwood-dma.h    |   17 ---------
 sound/soc/kirkwood/kirkwood-i2s.c    |   54 ++++++++++++++++-------------
 sound/soc/kirkwood/kirkwood-i2s.h    |   17 ---------
 sound/soc/kirkwood/kirkwood-openrd.c |   21 ++++-------
 6 files changed, 85 insertions(+), 94 deletions(-)
 delete mode 100644 sound/soc/kirkwood/kirkwood-dma.h
 delete mode 100644 sound/soc/kirkwood/kirkwood-i2s.h

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index e1f3efe..0769013 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -896,10 +896,16 @@ static struct platform_device kirkwood_i2s_device = {
 	},
 };
 
+static struct platform_device kirkwood_pcm_device = {
+	.name		= "kirkwood-pcm",
+	.id		= -1,
+};
+
 void __init kirkwood_audio_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_AUDIO;
 	platform_device_register(&kirkwood_i2s_device);
+	platform_device_register(&kirkwood_pcm_device);
 }
 
 /*****************************************************************************
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index a30205b..693049d 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -18,7 +18,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/mbus.h>
 #include <sound/soc.h>
-#include "kirkwood-dma.h"
 #include "kirkwood.h"
 
 #define KIRKWOOD_RATES \
@@ -123,9 +122,10 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 	int err;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct snd_soc_platform *platform = soc_runtime->platform;
+	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
 	struct kirkwood_dma_data *priv;
-	struct kirkwood_dma_priv *prdata = cpu_dai->private_data;
+	struct kirkwood_dma_priv *prdata = snd_soc_platform_get_drvdata(platform);
 	unsigned long addr;
 
 	priv = snd_soc_dai_get_dma_data(cpu_dai, substream);
@@ -151,7 +151,7 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		return err;
 
-	if (soc_runtime->dai->cpu_dai->private_data == NULL) {
+	if (prdata == NULL) {
 		prdata = kzalloc(sizeof(struct kirkwood_dma_priv), GFP_KERNEL);
 		if (prdata == NULL)
 			return -ENOMEM;
@@ -165,7 +165,7 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 			return -EBUSY;
 		}
 
-		soc_runtime->dai->cpu_dai->private_data = prdata;
+		snd_soc_platform_set_drvdata(platform, prdata);
 
 		/*
 		 * Enable Error interrupts. We're only ack'ing them but
@@ -191,8 +191,9 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 static int kirkwood_dma_close(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
-	struct kirkwood_dma_priv *prdata = cpu_dai->private_data;
+	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
+	struct snd_soc_platform *platform = soc_runtime->platform;
+	struct kirkwood_dma_priv *prdata = snd_soc_platform_get_drvdata(platform);
 	struct kirkwood_dma_data *priv;
 
 	priv = snd_soc_dai_get_dma_data(cpu_dai, substream);
@@ -209,7 +210,7 @@ static int kirkwood_dma_close(struct snd_pcm_substream *substream)
 		writel(0, priv->io + KIRKWOOD_ERR_MASK);
 		free_irq(priv->irq, prdata);
 		kfree(prdata);
-		soc_runtime->dai->cpu_dai->private_data = NULL;
+		snd_soc_platform_set_drvdata(platform, NULL);
 	}
 
 	return 0;
@@ -236,7 +237,7 @@ static int kirkwood_dma_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
 	struct kirkwood_dma_data *priv;
 	unsigned long size, count;
 
@@ -265,7 +266,7 @@ static snd_pcm_uframes_t kirkwood_dma_pointer(struct snd_pcm_substream
 						*substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
 	struct kirkwood_dma_data *priv;
 	snd_pcm_uframes_t count;
 
@@ -320,14 +321,14 @@ static int kirkwood_dma_new(struct snd_card *card,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = 0xffffffff;
 
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		ret = kirkwood_dma_preallocate_dma_buffer(pcm,
 				SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			return ret;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		ret = kirkwood_dma_preallocate_dma_buffer(pcm,
 				SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
@@ -357,25 +358,44 @@ static void kirkwood_dma_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
-struct snd_soc_platform kirkwood_soc_platform = {
-	.name		= "kirkwood-dma",
-	.pcm_ops	= &kirkwood_dma_ops,
+static struct snd_soc_platform_driver kirkwood_soc_platform = {
+	.ops		= &kirkwood_dma_ops,
 	.pcm_new	= kirkwood_dma_new,
 	.pcm_free	= kirkwood_dma_free_dma_buffers,
 };
-EXPORT_SYMBOL_GPL(kirkwood_soc_platform);
 
-static int __init kirkwood_soc_platform_init(void)
+static int __devinit kirkwood_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&kirkwood_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, &kirkwood_soc_platform);
 }
-module_init(kirkwood_soc_platform_init);
 
-static void __exit kirkwood_soc_platform_exit(void)
+static int __devexit kirkwood_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&kirkwood_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver kirkwood_pcm_driver = {
+	.driver = {
+			.name = "kirkwood-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = kirkwood_soc_platform_probe,
+	.remove = __devexit_p(kirkwood_soc_platform_remove),
+};
+
+static int __init kirkwood_pcm_init(void)
+{
+	return platform_driver_register(&kirkwood_pcm_driver);
+}
+module_init(kirkwood_pcm_init);
+
+static void __exit kirkwood_pcm_exit(void)
+{
+	platform_driver_unregister(&kirkwood_pcm_driver);
 }
-module_exit(kirkwood_soc_platform_exit);
+module_exit(kirkwood_pcm_exit);
 
 MODULE_AUTHOR("Arnaud Patard <apatard@mandriva.com>");
 MODULE_DESCRIPTION("Marvell Kirkwood Audio DMA module");
diff --git a/sound/soc/kirkwood/kirkwood-dma.h b/sound/soc/kirkwood/kirkwood-dma.h
deleted file mode 100644
index ba4454c..0000000
--- a/sound/soc/kirkwood/kirkwood-dma.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * kirkwood-dma.h
- *
- * (c) 2010 Arnaud Patard <apatard@mandriva.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#ifndef _KIRKWOOD_DMA_H
-#define _KIRKWOOD_DMA_H
-
-extern struct snd_soc_platform kirkwood_soc_platform;
-
-#endif
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 981ffc2..c3e6dac 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -20,10 +20,9 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <plat/audio.h>
-#include "kirkwood-i2s.h"
 #include "kirkwood.h"
 
-#define DRV_NAME	"kirkwood-i2s"
+#define DRV_NAME	"kirkwood-i2s-dai"
 
 #define KIRKWOOD_I2S_RATES \
 	(SNDRV_PCM_RATE_44100 | \
@@ -33,13 +32,10 @@
 	 SNDRV_PCM_FMTBIT_S24_LE | \
 	 SNDRV_PCM_FMTBIT_S32_LE)
 
-
-struct snd_soc_dai kirkwood_i2s_dai;
-static struct kirkwood_dma_data *priv;
-
 static int kirkwood_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	unsigned long mask;
 	unsigned long value;
 
@@ -101,10 +97,20 @@ static inline void kirkwood_set_dco(void __iomem *io, unsigned long rate)
 	} while (value == 0);
 }
 
+static int kirkwood_i2s_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_set_dma_data(dai, substream, priv);
+	return 0;
+}
+
 static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned int i2s_reg, reg;
 	unsigned long i2s_value, value;
 
@@ -171,6 +177,7 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned long value;
 
 	/*
@@ -244,6 +251,7 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 static int kirkwood_i2s_rec_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned long value;
 
 	value = readl(priv->io + KIRKWOOD_RECCTL);
@@ -323,9 +331,9 @@ static int kirkwood_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int kirkwood_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
+static int kirkwood_i2s_probe(struct snd_soc_dai *dai)
 {
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned long value;
 	unsigned int reg_data;
 
@@ -359,21 +367,20 @@ static int kirkwood_i2s_probe(struct platform_device *pdev,
 
 }
 
-static void kirkwood_i2s_remove(struct platform_device *pdev,
-				struct snd_soc_dai *dai)
+static int kirkwood_i2s_remove(struct snd_soc_dai *dai)
 {
+	return 0;
 }
 
 static struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
+	.startup	= kirkwood_i2s_startup,
 	.trigger	= kirkwood_i2s_trigger,
 	.hw_params      = kirkwood_i2s_hw_params,
 	.set_fmt        = kirkwood_i2s_set_fmt,
 };
 
 
-struct snd_soc_dai kirkwood_i2s_dai = {
-	.name = DRV_NAME,
-	.id = 0,
+static struct snd_soc_dai_driver kirkwood_i2s_dai = {
 	.probe = kirkwood_i2s_probe,
 	.remove = kirkwood_i2s_remove,
 	.playback = {
@@ -388,13 +395,13 @@ struct snd_soc_dai kirkwood_i2s_dai = {
 		.formats = KIRKWOOD_I2S_FORMATS,},
 	.ops = &kirkwood_i2s_dai_ops,
 };
-EXPORT_SYMBOL_GPL(kirkwood_i2s_dai);
 
 static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
 	struct kirkwood_asoc_platform_data *data =
 		pdev->dev.platform_data;
+	struct kirkwood_dma_data *priv;
 	int err;
 
 	priv = kzalloc(sizeof(struct kirkwood_dma_data), GFP_KERNEL);
@@ -403,6 +410,7 @@ static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		err = -ENOMEM;
 		goto error;
 	}
+	dev_set_drvdata(&pdev->dev, priv);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -441,10 +449,7 @@ static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	priv->dram = data->dram;
 	priv->burst = data->burst;
 
-	kirkwood_i2s_dai.capture.dma_data = priv;
-	kirkwood_i2s_dai.playback.dma_data = priv;
-
-	return snd_soc_register_dai(&kirkwood_i2s_dai);
+	return snd_soc_register_dai(&pdev->dev, &kirkwood_i2s_dai);
 
 err_ioremap:
 	iounmap(priv->io);
@@ -458,12 +463,13 @@ error:
 
 static __devexit int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 {
-	if (priv) {
-		iounmap(priv->io);
-		release_mem_region(priv->mem->start, SZ_16K);
-		kfree(priv);
-	}
-	snd_soc_unregister_dai(&kirkwood_i2s_dai);
+	struct kirkwood_dma_data *priv = dev_get_drvdata(&pdev->dev);
+
+	snd_soc_unregister_dai(&pdev->dev);
+	iounmap(priv->io);
+	release_mem_region(priv->mem->start, SZ_16K);
+	kfree(priv);
+
 	return 0;
 }
 
diff --git a/sound/soc/kirkwood/kirkwood-i2s.h b/sound/soc/kirkwood/kirkwood-i2s.h
deleted file mode 100644
index c5595c6..0000000
--- a/sound/soc/kirkwood/kirkwood-i2s.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * kirkwood-i2s.h
- *
- * (c) 2010 Arnaud Patard <apatard@mandriva.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#ifndef _KIRKWOOD_I2S_H
-#define _KIRKWOOD_I2S_H
-
-extern struct snd_soc_dai kirkwood_i2s_dai;
-
-#endif
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index 0353d06..6f9ac42 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -18,16 +18,14 @@
 #include <mach/kirkwood.h>
 #include <plat/audio.h>
 #include <asm/mach-types.h>
-#include "kirkwood-i2s.h"
-#include "kirkwood-dma.h"
 #include "../codecs/cs42l51.h"
 
 static int openrd_client_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 	unsigned int freq, fmt;
 
@@ -66,8 +64,10 @@ static struct snd_soc_dai_link openrd_client_dai[] = {
 {
 	.name = "CS42L51",
 	.stream_name = "CS42L51 HiFi",
-	.cpu_dai = &kirkwood_i2s_dai,
-	.codec_dai = &cs42l51_dai,
+	.cpu_dai_name = "kirkwood-i2s-dai",
+	.platform_name = "kirkwood-pcm-audio",
+	.codec_dai_name = "cs42l51_hifi",
+	.codec_name = "cs42l51-codec.0-0x4a",
 	.ops = &openrd_client_ops,
 },
 };
@@ -75,16 +75,10 @@ static struct snd_soc_dai_link openrd_client_dai[] = {
 
 static struct snd_soc_card openrd_client = {
 	.name = "OpenRD Client",
-	.platform = &kirkwood_soc_platform,
 	.dai_link = openrd_client_dai,
 	.num_links = ARRAY_SIZE(openrd_client_dai),
 };
 
-static struct snd_soc_device openrd_client_snd_devdata = {
-	.card = &openrd_client,
-	.codec_dev = &soc_codec_device_cs42l51,
-};
-
 static struct platform_device *openrd_client_snd_device;
 
 static int __init openrd_client_init(void)
@@ -99,8 +93,7 @@ static int __init openrd_client_init(void)
 		return -ENOMEM;
 
 	platform_set_drvdata(openrd_client_snd_device,
-			&openrd_client_snd_devdata);
-	openrd_client_snd_devdata.dev = &openrd_client_snd_device->dev;
+			&openrd_client);
 
 	ret = platform_device_add(openrd_client_snd_device);
 	if (ret) {
-- 
1.7.0.4
