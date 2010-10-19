From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 21/25] ASoC: S3C64XX: Remove obsoleted I2S
	drivers
Date: Tue, 19 Oct 2010 16:08:19 +0900
Message-ID: <1287472099-31083-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 559CE103955
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:17:48 +0200 (CEST)
In-Reply-To: <1P85Z9-0007a6-27>
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
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Now that we have better I2S CPU drivers and no need for the old
ones, discard them.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig          |   10 --
 sound/soc/s3c24xx/Makefile         |    4 -
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c |  230 ----------------------------------
 sound/soc/s3c24xx/s3c64xx-i2s.c    |  242 ------------------------------------
 sound/soc/s3c24xx/s3c64xx-i2s.h    |   41 ------
 5 files changed, 0 insertions(+), 527 deletions(-)
 delete mode 100644 sound/soc/s3c24xx/s3c64xx-i2s-v4.c
 delete mode 100644 sound/soc/s3c24xx/s3c64xx-i2s.c
 delete mode 100644 sound/soc/s3c24xx/s3c64xx-i2s.h

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 085a7b0..32f1877 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -19,16 +19,6 @@ config SND_S3C2412_SOC_I2S
 	select SND_S3C_I2SV2_SOC
 	select S3C2410_DMA
 
-config SND_S3C64XX_SOC_I2S
-	tristate
-	select SND_S3C_I2SV2_SOC
-	select S3C64XX_DMA
-
-config SND_S3C64XX_SOC_I2S_V4
-	tristate
-	select SND_S3C_I2SV2_SOC
-	select S3C64XX_DMA
-
 config SND_S3C_SOC_PCM
 	tristate
 
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 1d6fc07..dac41ee 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -2,9 +2,7 @@
 snd-soc-s3c24xx-objs := dma.o
 snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
 snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
-snd-soc-s3c64xx-i2s-objs := s3c64xx-i2s.o
 snd-soc-ac97-objs := ac97.o
-snd-soc-s3c64xx-i2s-v4-objs := s3c64xx-i2s-v4.o
 snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
 snd-soc-samsung-spdif-objs := spdif.o
 snd-soc-pcm-objs := pcm.o
@@ -14,8 +12,6 @@ obj-$(CONFIG_SND_S3C24XX_SOC) += snd-soc-s3c24xx.o
 obj-$(CONFIG_SND_S3C24XX_SOC_I2S) += snd-soc-s3c24xx-i2s.o
 obj-$(CONFIG_SND_S3C_SOC_AC97) += snd-soc-ac97.o
 obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
-obj-$(CONFIG_SND_S3C64XX_SOC_I2S) += snd-soc-s3c64xx-i2s.o
-obj-$(CONFIG_SND_S3C64XX_SOC_I2S_V4) += snd-soc-s3c64xx-i2s-v4.o
 obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
 obj-$(CONFIG_SND_S5P_SOC_SPDIF) += snd-soc-samsung-spdif.o
 obj-$(CONFIG_SND_S3C_SOC_PCM) += snd-soc-pcm.o
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
deleted file mode 100644
index 8a08041..0000000
--- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+++ /dev/null
@@ -1,230 +0,0 @@
-/* sound/soc/s3c24xx/s3c64xx-i2s-v4.c
- *
- * ALSA SoC Audio Layer - S3C64XX I2Sv4 driver
- * Copyright (c) 2010 Samsung Electronics Co. Ltd
- * 	Author: Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/clk.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-
-#include <sound/soc.h>
-#include <sound/pcm_params.h>
-
-#include <plat/audio.h>
-
-#include <mach/map.h>
-#include <mach/dma.h>
-
-#include "dma.h"
-#include "regs-i2s-v2.h"
-#include "s3c64xx-i2s.h"
-
-static struct s3c2410_dma_client s3c64xx_dma_client_out = {
-	.name		= "I2Sv4 PCM Stereo out"
-};
-
-static struct s3c2410_dma_client s3c64xx_dma_client_in = {
-	.name		= "I2Sv4 PCM Stereo in"
-};
-
-static struct s3c_dma_params s3c64xx_i2sv4_pcm_stereo_out;
-static struct s3c_dma_params s3c64xx_i2sv4_pcm_stereo_in;
-static struct s3c_i2sv2_info s3c64xx_i2sv4;
-
-static int s3c64xx_i2sv4_probe(struct snd_soc_dai *dai)
-{
-	struct s3c_i2sv2_info *i2s = &s3c64xx_i2sv4;
-	int ret = 0;
-
-	snd_soc_dai_set_drvdata(dai, i2s);
-
-	ret = s3c_i2sv2_probe(dai, i2s, i2s->base);
-
-	return ret;
-}
-
-static int s3c_i2sv4_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params,
-				 struct snd_soc_dai *cpu_dai)
-{
-	struct s3c_i2sv2_info *i2s = snd_soc_dai_get_drvdata(cpu_dai);
-	struct s3c_dma_params *dma_data;
-	u32 iismod;
-
-	dev_dbg(cpu_dai->dev, "Entered %s\n", __func__);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_data = i2s->dma_playback;
-	else
-		dma_data = i2s->dma_capture;
-
-	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
-
-	iismod = readl(i2s->regs + S3C2412_IISMOD);
-	dev_dbg(cpu_dai->dev, "%s: r: IISMOD: %x\n", __func__, iismod);
-
-	iismod &= ~S3C64XX_IISMOD_BLC_MASK;
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:
-		iismod |= S3C64XX_IISMOD_BLC_8BIT;
-		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		iismod |= S3C64XX_IISMOD_BLC_24BIT;
-		break;
-	}
-
-	writel(iismod, i2s->regs + S3C2412_IISMOD);
-	dev_dbg(cpu_dai->dev, "%s: w: IISMOD: %x\n", __func__, iismod);
-
-	return 0;
-}
-
-static struct snd_soc_dai_ops s3c64xx_i2sv4_dai_ops = {
-	.hw_params	= s3c_i2sv4_hw_params,
-};
-
-static struct snd_soc_dai_driver s3c64xx_i2s_v4_dai = {
-	.symmetric_rates = 1,
-	.playback = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = S3C64XX_I2S_RATES,
-		.formats = S3C64XX_I2S_FMTS,
-	},
-	.capture = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = S3C64XX_I2S_RATES,
-		.formats = S3C64XX_I2S_FMTS,
-	},
-	.probe = s3c64xx_i2sv4_probe,
-	.ops = &s3c64xx_i2sv4_dai_ops,
-};
-
-static __devinit int s3c64xx_i2sv4_dev_probe(struct platform_device *pdev)
-{
-	struct s3c_audio_pdata *i2s_pdata;
-	struct s3c_i2sv2_info *i2s;
-	struct resource *res;
-	int ret;
-
-	i2s = &s3c64xx_i2sv4;
-
-	i2s->feature |= S3C_FEATURE_CDCLKCON;
-
-	i2s->dma_capture = &s3c64xx_i2sv4_pcm_stereo_in;
-	i2s->dma_playback = &s3c64xx_i2sv4_pcm_stereo_out;
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get I2S-TX dma resource\n");
-		return -ENXIO;
-	}
-	i2s->dma_playback->channel = res->start;
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get I2S-RX dma resource\n");
-		return -ENXIO;
-	}
-	i2s->dma_capture->channel = res->start;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get I2S SFR address\n");
-		return -ENXIO;
-	}
-
-	if (!request_mem_region(res->start, resource_size(res),
-				"s3c64xx-i2s-v4")) {
-		dev_err(&pdev->dev, "Unable to request SFR region\n");
-		return -EBUSY;
-	}
-	i2s->dma_capture->dma_addr = res->start + S3C2412_IISRXD;
-	i2s->dma_playback->dma_addr = res->start + S3C2412_IISTXD;
-
-	i2s->dma_capture->client = &s3c64xx_dma_client_in;
-	i2s->dma_capture->dma_size = 4;
-	i2s->dma_playback->client = &s3c64xx_dma_client_out;
-	i2s->dma_playback->dma_size = 4;
-
-	i2s->base = res->start;
-
-	i2s_pdata = pdev->dev.platform_data;
-	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
-		dev_err(&pdev->dev, "Unable to configure gpio\n");
-		return -EINVAL;
-	}
-
-	i2s->iis_cclk = clk_get(&pdev->dev, "audio-bus");
-	if (IS_ERR(i2s->iis_cclk)) {
-		dev_err(&pdev->dev, "failed to get audio-bus\n");
-		ret = PTR_ERR(i2s->iis_cclk);
-		goto err;
-	}
-
-	clk_enable(i2s->iis_cclk);
-
-	ret = s3c_i2sv2_register_dai(&pdev->dev, pdev->id, &s3c64xx_i2s_v4_dai);
-	if (ret != 0)
-		goto err_i2sv2;
-
-	return 0;
-
-err_i2sv2:
-	clk_put(i2s->iis_cclk);
-err:
-	return ret;
-}
-
-static __devexit int s3c64xx_i2sv4_dev_remove(struct platform_device *pdev)
-{
-	struct s3c_i2sv2_info *i2s = &s3c64xx_i2sv4;
-	struct resource *res;
-
-	snd_soc_unregister_dai(&pdev->dev);
-	clk_put(i2s->iis_cclk);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
-		release_mem_region(res->start, resource_size(res));
-	else
-		dev_warn(&pdev->dev, "Unable to get I2S SFR address\n");
-		
-	return 0;
-}
-
-static struct platform_driver s3c64xx_i2sv4_driver = {
-	.probe  = s3c64xx_i2sv4_dev_probe,
-	.remove = s3c64xx_i2sv4_dev_remove,
-	.driver = {
-		.name = "samsung-i2s-v4",
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init s3c64xx_i2sv4_init(void)
-{
-	return platform_driver_register(&s3c64xx_i2sv4_driver);
-}
-module_init(s3c64xx_i2sv4_init);
-
-static void __exit s3c64xx_i2sv4_exit(void)
-{
-	platform_driver_unregister(&s3c64xx_i2sv4_driver);
-}
-module_exit(s3c64xx_i2sv4_exit);
-
-/* Module information */
-MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
-MODULE_DESCRIPTION("S3C64XX I2Sv4 SoC Interface");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:samsung-i2s-v4");
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
deleted file mode 100644
index 0fefbb5..0000000
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ /dev/null
@@ -1,242 +0,0 @@
-/* sound/soc/s3c24xx/s3c64xx-i2s.c
- *
- * ALSA SoC Audio Layer - S3C64XX I2S driver
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-
-#include <sound/soc.h>
-
-#include <plat/audio.h>
-
-#include <mach/map.h>
-#include <mach/dma.h>
-
-#include "dma.h"
-#include "regs-i2s-v2.h"
-#include "s3c64xx-i2s.h"
-
-/* The value should be set to maximum of the total number
- * of I2Sv3 controllers that any supported SoC has.
- */
-#define MAX_I2SV3	2
-
-static struct s3c2410_dma_client s3c64xx_dma_client_out = {
-	.name		= "I2S PCM Stereo out"
-};
-
-static struct s3c2410_dma_client s3c64xx_dma_client_in = {
-	.name		= "I2S PCM Stereo in"
-};
-
-static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_out[MAX_I2SV3];
-static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_in[MAX_I2SV3];
-static struct s3c_i2sv2_info s3c64xx_i2s[MAX_I2SV3];
-
-struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai)
-{
-	struct s3c_i2sv2_info *i2s = snd_soc_dai_get_drvdata(dai);
-	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
-
-	if (iismod & S3C2412_IISMOD_IMS_SYSMUX)
-		return i2s->iis_cclk;
-	else
-		return i2s->iis_pclk;
-}
-EXPORT_SYMBOL_GPL(s3c64xx_i2s_get_clock);
-
-static int s3c64xx_i2s_probe(struct snd_soc_dai *dai)
-{
-	struct s3c_i2sv2_info *i2s;
-	int ret;
-
-	if (dai->id >= MAX_I2SV3) {
-		dev_err(dai->dev, "id %d out of range\n", dai->id);
-		return -EINVAL;
-	}
-
-	i2s = &s3c64xx_i2s[dai->id];
-	snd_soc_dai_set_drvdata(dai, i2s);
-
-	i2s->iis_cclk = clk_get(dai->dev, "audio-bus");
-	if (IS_ERR(i2s->iis_cclk)) {
-		dev_err(dai->dev, "failed to get audio-bus\n");
-		ret = PTR_ERR(i2s->iis_cclk);
-		goto err;
-	}
-
-	clk_enable(i2s->iis_cclk);
-
-	ret = s3c_i2sv2_probe(dai, i2s, i2s->base);
-	if (ret)
-		goto err_clk;
-
-	return 0;
-
-err_clk:
-	clk_disable(i2s->iis_cclk);
-	clk_put(i2s->iis_cclk);
-err:
-	kfree(i2s);
-	return ret;
-}
-
-static int s3c64xx_i2s_remove(struct snd_soc_dai *dai)
-{
-	struct s3c_i2sv2_info *i2s = snd_soc_dai_get_drvdata(dai);
-
-	clk_disable(i2s->iis_cclk);
-	clk_put(i2s->iis_cclk);
-	kfree(i2s);
-	return 0;
-}
-
-static struct snd_soc_dai_ops s3c64xx_i2s_dai_ops;
-
-static struct snd_soc_dai_driver s3c64xx_i2s_dai[MAX_I2SV3] = {
-{
-	.name = "s3c64xx-i2s-0",
-	.probe = s3c64xx_i2s_probe,
-	.remove = s3c64xx_i2s_remove,
-	.playback = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = S3C64XX_I2S_RATES,
-		.formats = S3C64XX_I2S_FMTS,},
-	.capture = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = S3C64XX_I2S_RATES,
-		.formats = S3C64XX_I2S_FMTS,},
-	.ops = &s3c64xx_i2s_dai_ops,
-	.symmetric_rates = 1,
-}, {
-	.name = "s3c64xx-i2s-1",
-	.probe = s3c64xx_i2s_probe,
-	.remove = s3c64xx_i2s_remove,
-	.playback = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = S3C64XX_I2S_RATES,
-		.formats = S3C64XX_I2S_FMTS,},
-	.capture = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = S3C64XX_I2S_RATES,
-		.formats = S3C64XX_I2S_FMTS,},
-	.ops = &s3c64xx_i2s_dai_ops,
-	.symmetric_rates = 1,
-},};
-
-static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
-{
-	struct s3c_audio_pdata *i2s_pdata;
-	struct s3c_i2sv2_info *i2s;
-	struct resource *res;
-	int i, ret;
-
-	if (pdev->id >= MAX_I2SV3) {
-		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
-		return -EINVAL;
-	}
-
-	i2s = &s3c64xx_i2s[pdev->id];
-
-	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[pdev->id];
-	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[pdev->id];
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get I2S-TX dma resource\n");
-		return -ENXIO;
-	}
-	i2s->dma_playback->channel = res->start;
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get I2S-RX dma resource\n");
-		return -ENXIO;
-	}
-	i2s->dma_capture->channel = res->start;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get I2S SFR address\n");
-		return -ENXIO;
-	}
-
-	if (!request_mem_region(res->start, resource_size(res),
-				"s3c64xx-i2s")) {
-		dev_err(&pdev->dev, "Unable to request SFR region\n");
-		return -EBUSY;
-	}
-	i2s->base = res->start;
-
-	i2s_pdata = pdev->dev.platform_data;
-	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
-		dev_err(&pdev->dev, "Unable to configure gpio\n");
-		return -EINVAL;
-	}
-	i2s->dma_capture->dma_addr = res->start + S3C2412_IISRXD;
-	i2s->dma_playback->dma_addr = res->start + S3C2412_IISTXD;
-
-	i2s->dma_capture->client = &s3c64xx_dma_client_in;
-	i2s->dma_capture->dma_size = 4;
-	i2s->dma_playback->client = &s3c64xx_dma_client_out;
-	i2s->dma_playback->dma_size = 4;
-
-	for (i = 0; i < ARRAY_SIZE(s3c64xx_i2s_dai); i++) {
-		ret = s3c_i2sv2_register_dai(&pdev->dev, i,
-						&s3c64xx_i2s_dai[i]);
-		if (ret != 0)
-			return ret;
-	}
-
-	return 0;
-}
-
-static __devexit int s3c64xx_iis_dev_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(s3c64xx_i2s_dai));
-	return 0;
-}
-
-static struct platform_driver s3c64xx_iis_driver = {
-	.probe  = s3c64xx_iis_dev_probe,
-	.remove = s3c64xx_iis_dev_remove,
-	.driver = {
-		.name = "samsung-i2s",
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init s3c64xx_i2s_init(void)
-{
-	return platform_driver_register(&s3c64xx_iis_driver);
-}
-module_init(s3c64xx_i2s_init);
-
-static void __exit s3c64xx_i2s_exit(void)
-{
-	platform_driver_unregister(&s3c64xx_iis_driver);
-}
-module_exit(s3c64xx_i2s_exit);
-
-/* Module information */
-MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("S3C64XX I2S SoC Interface");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:samsung-i2s");
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.h b/sound/soc/s3c24xx/s3c64xx-i2s.h
deleted file mode 100644
index de4075d..0000000
--- a/sound/soc/s3c24xx/s3c64xx-i2s.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* sound/soc/s3c24xx/s3c64xx-i2s.h
- *
- * ALSA SoC Audio Layer - S3C64XX I2S driver
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __SND_SOC_S3C24XX_S3C64XX_I2S_H
-#define __SND_SOC_S3C24XX_S3C64XX_I2S_H __FILE__
-
-struct clk;
-
-#include "s3c-i2s-v2.h"
-
-#define S3C64XX_DIV_BCLK	S3C_I2SV2_DIV_BCLK
-#define S3C64XX_DIV_RCLK	S3C_I2SV2_DIV_RCLK
-#define S3C64XX_DIV_PRESCALER	S3C_I2SV2_DIV_PRESCALER
-
-#define S3C64XX_CLKSRC_PCLK	S3C_I2SV2_CLKSRC_PCLK
-#define S3C64XX_CLKSRC_MUX	S3C_I2SV2_CLKSRC_AUDIOBUS
-#define S3C64XX_CLKSRC_CDCLK    S3C_I2SV2_CLKSRC_CDCLK
-
-#define S3C64XX_I2S_RATES \
-	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
-	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
-	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
-
-#define S3C64XX_I2S_FMTS \
-	(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |\
-	 SNDRV_PCM_FMTBIT_S24_LE)
-
-struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai);
-
-#endif /* __SND_SOC_S3C24XX_S3C64XX_I2S_H */
-- 
1.6.2.5
