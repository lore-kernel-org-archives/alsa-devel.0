From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/14] ASoC: ep93xx: Use ep93xx_dma_params
	instead of ep93xx_pcm_dma_params
Date: Fri, 22 Mar 2013 14:12:10 +0100
Message-ID: <1363957934-20059-11-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id D75B426652F
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:11:09 +0100 (CET)
In-Reply-To: <1363957934-20059-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>
List-Id: alsa-devel@alsa-project.org

Currently the ep93xx_dma_params struct which is passed to the dmaengine driver
is constructed at runtime from the ep93xx_pcm_dma_params that gets passed to the
ep93xx PCM driver from one of the ep93xx DAI drivers. The ep93xx_pcm_dma_params
struct is almost identical to the ep93xx_dma_params struct. The only missing
field is the 'direction' field, which is computed at runtime in the PCM driver
based on the current substream. Since we know in advance which
ep93xx_pcm_dma_params struct is being used for which substream at compile time,
we also already know which direction to use at compile time. So we can easily
replace all instances of ep93xx_pcm_dma_params with their ep93xx_dma_params
counterpart. This allows us to simplify the code in the ep93xx pcm driver quite
a bit.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
---
 sound/soc/cirrus/edb93xx.c     |  1 -
 sound/soc/cirrus/ep93xx-ac97.c |  9 +++++----
 sound/soc/cirrus/ep93xx-i2s.c  | 12 ++++++------
 sound/soc/cirrus/ep93xx-pcm.c  | 37 +++----------------------------------
 sound/soc/cirrus/ep93xx-pcm.h  | 20 --------------------
 sound/soc/cirrus/simone.c      |  2 --
 sound/soc/cirrus/snappercl15.c |  1 -
 7 files changed, 14 insertions(+), 68 deletions(-)
 delete mode 100644 sound/soc/cirrus/ep93xx-pcm.h

diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
index 5db68cf..c43fb21 100644
--- a/sound/soc/cirrus/edb93xx.c
+++ b/sound/soc/cirrus/edb93xx.c
@@ -27,7 +27,6 @@
 #include <sound/soc.h>
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
-#include "ep93xx-pcm.h"
 
 static int edb93xx_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index 1738d28..8d30886 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -23,7 +23,6 @@
 #include <sound/soc.h>
 
 #include <linux/platform_data/dma-ep93xx.h>
-#include "ep93xx-pcm.h"
 
 /*
  * Per channel (1-4) registers.
@@ -101,14 +100,16 @@ struct ep93xx_ac97_info {
 /* currently ALSA only supports a single AC97 device */
 static struct ep93xx_ac97_info *ep93xx_ac97_info;
 
-static struct ep93xx_pcm_dma_params ep93xx_ac97_pcm_out = {
+static struct ep93xx_dma_data ep93xx_ac97_pcm_out = {
 	.name		= "ac97-pcm-out",
 	.dma_port	= EP93XX_DMA_AAC1,
+	.direction	= DMA_MEM_TO_DEV,
 };
 
-static struct ep93xx_pcm_dma_params ep93xx_ac97_pcm_in = {
+static struct ep93xx_dma_data ep93xx_ac97_pcm_in = {
 	.name		= "ac97-pcm-in",
 	.dma_port	= EP93XX_DMA_AAC1,
+	.direction	= DMA_DEV_TO_MEM,
 };
 
 static inline unsigned ep93xx_ac97_read_reg(struct ep93xx_ac97_info *info,
@@ -316,7 +317,7 @@ static int ep93xx_ac97_trigger(struct snd_pcm_substream *substream,
 static int ep93xx_ac97_startup(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
-	struct ep93xx_pcm_dma_params *dma_data;
+	struct ep93xx_dma_data *dma_data;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_data = &ep93xx_ac97_pcm_out;
diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 323ed69..aa124f8 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -30,8 +30,6 @@
 #include <mach/ep93xx-regs.h>
 #include <linux/platform_data/dma-ep93xx.h>
 
-#include "ep93xx-pcm.h"
-
 #define EP93XX_I2S_TXCLKCFG		0x00
 #define EP93XX_I2S_RXCLKCFG		0x04
 #define EP93XX_I2S_GLCTRL		0x0C
@@ -62,18 +60,20 @@ struct ep93xx_i2s_info {
 	struct clk			*mclk;
 	struct clk			*sclk;
 	struct clk			*lrclk;
-	struct ep93xx_pcm_dma_params	*dma_params;
+	struct ep93xx_dma_data		*dma_data;
 	void __iomem			*regs;
 };
 
-struct ep93xx_pcm_dma_params ep93xx_i2s_dma_params[] = {
+struct ep93xx_dma_data ep93xx_i2s_dma_data[] = {
 	[SNDRV_PCM_STREAM_PLAYBACK] = {
 		.name		= "i2s-pcm-out",
 		.dma_port	= EP93XX_DMA_I2S1,
+		.direction	= DMA_MEM_TO_DEV,
 	},
 	[SNDRV_PCM_STREAM_CAPTURE] = {
 		.name		= "i2s-pcm-in",
 		.dma_port	= EP93XX_DMA_I2S1,
+		.direction	= DMA_DEV_TO_MEM,
 	},
 };
 
@@ -147,7 +147,7 @@ static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 	snd_soc_dai_set_dma_data(cpu_dai, substream,
-				 &info->dma_params[substream->stream]);
+				 &info->dma_data[substream->stream]);
 	return 0;
 }
 
@@ -403,7 +403,7 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
 	}
 
 	dev_set_drvdata(&pdev->dev, info);
-	info->dma_params = ep93xx_i2s_dma_params;
+	info->dma_data = ep93xx_i2s_dma_data;
 
 	err = snd_soc_register_dai(&pdev->dev, &ep93xx_i2s_dai);
 	if (err)
diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index 72eb7a4..298946f 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -29,8 +29,6 @@
 #include <mach/hardware.h>
 #include <mach/ep93xx-regs.h>
 
-#include "ep93xx-pcm.h"
-
 static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
 	.info			= (SNDRV_PCM_INFO_MMAP		|
 				   SNDRV_PCM_INFO_MMAP_VALID	|
@@ -68,40 +66,11 @@ static bool ep93xx_pcm_dma_filter(struct dma_chan *chan, void *filter_param)
 static int ep93xx_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct ep93xx_pcm_dma_params *dma_params;
-	struct ep93xx_dma_data *dma_data;
-	int ret;
 
 	snd_soc_set_runtime_hwparams(substream, &ep93xx_pcm_hardware);
 
-	dma_data = kmalloc(sizeof(*dma_data), GFP_KERNEL);
-	if (!dma_data)
-		return -ENOMEM;
-
-	dma_params = snd_soc_dai_get_dma_data(cpu_dai, substream);
-	dma_data->port = dma_params->dma_port;
-	dma_data->name = dma_params->name;
-	dma_data->direction = snd_pcm_substream_to_dma_direction(substream);
-
-	ret = snd_dmaengine_pcm_open(substream, ep93xx_pcm_dma_filter, dma_data);
-	if (ret) {
-		kfree(dma_data);
-		return ret;
-	}
-
-	snd_dmaengine_pcm_set_data(substream, dma_data);
-
-	return 0;
-}
-
-static int ep93xx_pcm_close(struct snd_pcm_substream *substream)
-{
-	struct dma_data *dma_data = snd_dmaengine_pcm_get_data(substream);
-
-	snd_dmaengine_pcm_close(substream);
-	kfree(dma_data);
-	return 0;
+	return snd_dmaengine_pcm_open(substream, ep93xx_pcm_dma_filter,
+			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
 }
 
 static int ep93xx_pcm_hw_params(struct snd_pcm_substream *substream,
@@ -131,7 +100,7 @@ static int ep93xx_pcm_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops ep93xx_pcm_ops = {
 	.open		= ep93xx_pcm_open,
-	.close		= ep93xx_pcm_close,
+	.close		= snd_dmaengine_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= ep93xx_pcm_hw_params,
 	.hw_free	= ep93xx_pcm_hw_free,
diff --git a/sound/soc/cirrus/ep93xx-pcm.h b/sound/soc/cirrus/ep93xx-pcm.h
deleted file mode 100644
index 111e112..0000000
--- a/sound/soc/cirrus/ep93xx-pcm.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * sound/soc/ep93xx/ep93xx-pcm.h - EP93xx ALSA PCM interface
- *
- * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
- * Copyright (C) 2006 Applied Data Systems
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _EP93XX_SND_SOC_PCM_H
-#define _EP93XX_SND_SOC_PCM_H
-
-struct ep93xx_pcm_dma_params {
-	char	*name;
-	int	dma_port;
-};
-
-#endif /* _EP93XX_SND_SOC_PCM_H */
diff --git a/sound/soc/cirrus/simone.c b/sound/soc/cirrus/simone.c
index a397bb0..4d094d0 100644
--- a/sound/soc/cirrus/simone.c
+++ b/sound/soc/cirrus/simone.c
@@ -21,8 +21,6 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 
-#include "ep93xx-pcm.h"
-
 static struct snd_soc_dai_link simone_dai = {
 	.name		= "AC97",
 	.stream_name	= "AC97 HiFi",
diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
index 9d77fe2..6904107 100644
--- a/sound/soc/cirrus/snappercl15.c
+++ b/sound/soc/cirrus/snappercl15.c
@@ -21,7 +21,6 @@
 #include <mach/hardware.h>
 
 #include "../codecs/tlv320aic23.h"
-#include "ep93xx-pcm.h"
 
 #define CODEC_CLOCK 5644800
 
-- 
1.8.0
