From: Ben Dooks <ben-alsa@fluff.org>
Subject: Re: [patch 6/9] S3C64XX: Add s3c64xx-i2s support
Date: Wed, 4 Mar 2009 00:56:59 +0000
Message-ID: <20090304005659.GQ30710@trinity.fluff.org>
References: <20090304004925.530566010@fluff.org.uk>
	<20090304005139.012781244@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A5CF24406
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 01:57:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304005139.012781244@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 12:49:31AM +0000, Ben Dooks wrote:
> From: Ben Dooks <ben@simtec.co.uk>
> 
> Add the initial code to support the S3C64XX I2S hardware using the
> s3c-i2s-v2 core code.
> 
> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
> 
> Index: linux.git/sound/soc/s3c24xx/Makefile
> ===================================================================
> --- linux.git.orig/sound/soc/s3c24xx/Makefile	2009-03-04 00:44:28.000000000 +0000
> +++ linux.git/sound/soc/s3c24xx/Makefile	2009-03-04 00:44:31.000000000 +0000
> @@ -2,6 +2,7 @@
>  snd-soc-s3c24xx-objs := s3c24xx-pcm.o
>  snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
>  snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
> +snd-soc-s3c64xx-i2s-objs := s3c64xx-i2s.o
>  snd-soc-s3c2443-ac97-objs := s3c2443-ac97.o
>  snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
>  
> @@ -9,6 +10,7 @@ obj-$(CONFIG_SND_S3C24XX_SOC) += snd-soc
>  obj-$(CONFIG_SND_S3C24XX_SOC_I2S) += snd-soc-s3c24xx-i2s.o
>  obj-$(CONFIG_SND_S3C2443_SOC_AC97) += snd-soc-s3c2443-ac97.o
>  obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
> +obj-$(CONFIG_SND_S3C64XX_SOC_I2S) += snd-soc-s3c64xx-i2s.o
>  obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
>  
>  # S3C24XX Machine Support
> Index: linux.git/sound/soc/s3c24xx/s3c64xx-i2s.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux.git/sound/soc/s3c24xx/s3c64xx-i2s.c	2009-03-04 00:44:31.000000000 +0000
> @@ -0,0 +1,220 @@
> +/* sound/soc/s3c24xx/s3c64xx-i2s.c
> + *
> + * ALSA SoC Audio Layer - S3C64XX I2S driver
> + *
> + * Copyright 2008 Openmoko, Inc.
> + * Copyright 2008 Simtec Electronics
> + *      Ben Dooks <ben@simtec.co.uk>
> + *      http://armlinux.simtec.co.uk/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

sorry, forgot to update copyright before sending

> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/kernel.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +
> +#include <plat/regs-s3c2412-iis.h>
> +#include <plat/gpio-bank-d.h>
> +#include <plat/gpio-bank-e.h>
> +#include <plat/gpio-cfg.h>
> +#include <plat/audio.h>
> +
> +#include <mach/map.h>
> +#include <mach/dma.h>
> +
> +#include "s3c24xx-pcm.h"
> +#include "s3c64xx-i2s.h"
> +
> +static struct s3c2410_dma_client s3c64xx_dma_client_out = {
> +	.name		= "I2S PCM Stereo out"
> +};
> +
> +static struct s3c2410_dma_client s3c64xx_dma_client_in = {
> +	.name		= "I2S PCM Stereo in"
> +};
> +
> +static struct s3c24xx_pcm_dma_params s3c64xx_i2s_pcm_stereo_out[2] = {
> +	[0] = {
> +		.channel	= DMACH_I2S0_OUT,
> +		.client		= &s3c64xx_dma_client_out,
> +		.dma_addr	= S3C64XX_PA_IIS0 + S3C2412_IISTXD,
> +		.dma_size	= 4,
> +	},
> +	[1] = {
> +		.channel	= DMACH_I2S1_OUT,
> +		.client		= &s3c64xx_dma_client_out,
> +		.dma_addr	= S3C64XX_PA_IIS1 + S3C2412_IISTXD,
> +		.dma_size	= 4,
> +	},
> +};
> +
> +static struct s3c24xx_pcm_dma_params s3c64xx_i2s_pcm_stereo_in[2] = {
> +	[0] = {
> +		.channel	= DMACH_I2S0_IN,
> +		.client		= &s3c64xx_dma_client_in,
> +		.dma_addr	= S3C64XX_PA_IIS0 + S3C2412_IISRXD,
> +		.dma_size	= 4,
> +	},
> +	[1] = {
> +		.channel	= DMACH_I2S1_IN,
> +		.client		= &s3c64xx_dma_client_in,
> +		.dma_addr	= S3C64XX_PA_IIS1 + S3C2412_IISRXD,
> +		.dma_size	= 4,
> +	},
> +};
> +
> +static struct s3c_i2sv2_info s3c64xx_i2s[2];
> +
> +static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
> +{
> +	return cpu_dai->private_data;
> +}
> +
> +static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
> +				  int clk_id, unsigned int freq, int dir)
> +{
> +	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
> +	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
> +
> +	switch (clk_id) {
> +	case S3C64XX_CLKSRC_PCLK:
> +		iismod &= ~S3C64XX_IISMOD_IMS_SYSMUX;
> +		break;
> +
> +	case S3C64XX_CLKSRC_MUX:
> +		iismod |= S3C64XX_IISMOD_IMS_SYSMUX;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	writel(iismod, i2s->regs + S3C2412_IISMOD);
> +
> +	return 0;
> +}
> +
> +
> +unsigned long s3c64xx_i2s_get_clockrate(struct snd_soc_dai *dai)
> +{
> +	struct s3c_i2sv2_info *i2s = to_info(dai);
> +
> +	return clk_get_rate(i2s->iis_cclk);
> +}
> +EXPORT_SYMBOL_GPL(s3c64xx_i2s_get_clockrate);
> +
> +static int s3c64xx_i2s_probe(struct platform_device *pdev,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct s3c_i2sv2_info *i2s;
> +	int ret;
> +
> +	dev_dbg(dev, "%s: probing dai %d\n", __func__, pdev->id);
> +
> +	if (pdev->id < 0 || pdev->id > ARRAY_SIZE(s3c64xx_i2s)) {
> +		dev_err(dev, "id %d out of range\n", pdev->id);
> +		return -EINVAL;
> +	}
> +
> +	i2s = &s3c64xx_i2s[pdev->id];
> +
> +	ret = s3c_i2sv2_probe(pdev, dai, i2s,
> +			      pdev->id ? S3C64XX_PA_IIS1 : S3C64XX_PA_IIS0);
> +	if (ret)
> +		return ret;
> +
> +	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[pdev->id];
> +	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[pdev->id];
> +
> +	i2s->iis_cclk = clk_get(dev, "audio-bus");
> +	if (IS_ERR(i2s->iis_cclk)) {
> +		dev_err(dev, "failed to get audio-bus");
> +		iounmap(i2s->regs);
> +		return -ENODEV;
> +	}
> +
> +	/* configure GPIO for i2s port */
> +	switch (pdev->id) {
> +	case 0:
> +		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_I2S0_CLK);
> +		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_I2S0_CDCLK);
> +		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_I2S0_LRCLK);
> +		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_I2S0_DI);
> +		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_I2S0_D0);
> +		break;
> +	case 1:
> +		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_I2S1_CLK);
> +		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_I2S1_CDCLK);
> +		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_I2S1_LRCLK);
> +		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_I2S1_DI);
> +		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
> +	}
> +
> +	return 0;
> +}
> +
> +
> +#define S3C64XX_I2S_RATES \
> +	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
> +	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
> +	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
> +
> +#define S3C64XX_I2S_FMTS \
> +	(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE)
> +
> +struct snd_soc_dai s3c64xx_i2s_dai = {
> +	.name		= "s3c64xx-i2s",
> +	.id		= 0,
> +	.probe		= s3c64xx_i2s_probe,
> +	.playback = {
> +		.channels_min	= 2,
> +		.channels_max	= 2,
> +		.rates		= S3C64XX_I2S_RATES,
> +		.formats	= S3C64XX_I2S_FMTS,
> +	},
> +	.capture = {
> +		.channels_min	= 2,
> +		.channels_max	= 2,
> +		.rates		= S3C64XX_I2S_RATES,
> +		.formats	= S3C64XX_I2S_FMTS,
> +	},
> +	.ops = {
> +		.set_sysclk	= s3c64xx_i2s_set_sysclk,
> +	},
> +};
> +EXPORT_SYMBOL_GPL(s3c64xx_i2s_dai);
> +
> +static int __init s3c64xx_i2s_init(void)
> +{
> +	return  s3c_i2sv2_register_dai(&s3c64xx_i2s_dai);
> +}
> +module_init(s3c64xx_i2s_init);
> +
> +static void __exit s3c64xx_i2s_exit(void)
> +{
> +	snd_soc_unregister_dai(&s3c64xx_i2s_dai);
> +}
> +module_exit(s3c64xx_i2s_exit);
> +
> +/* Module information */
> +MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
> +MODULE_DESCRIPTION("S3C64XX I2S SoC Interface");
> +MODULE_LICENSE("GPL");
> +
> +
> +
> Index: linux.git/sound/soc/s3c24xx/s3c64xx-i2s.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux.git/sound/soc/s3c24xx/s3c64xx-i2s.h	2009-03-04 00:44:31.000000000 +0000
> @@ -0,0 +1,31 @@
> +/* sound/soc/s3c24xx/s3c64xx-i2s.h
> + *
> + * ALSA SoC Audio Layer - S3C64XX I2S driver
> + *
> + * Copyright 2008 Openmoko, Inc.
> + * Copyright 2008 Simtec Electronics
> + *      Ben Dooks <ben@simtec.co.uk>
> + *      http://armlinux.simtec.co.uk/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __SND_SOC_S3C24XX_S3C64XX_I2S_H
> +#define __SND_SOC_S3C24XX_S3C64XX_I2S_H __FILE__
> +
> +#include "s3c-i2s-v2.h"
> +
> +#define S3C64XX_DIV_BCLK	S3C_I2SV2_DIV_BCLK
> +#define S3C64XX_DIV_RCLK	S3C_I2SV2_DIV_RCLK
> +#define S3C64XX_DIV_PRESCALER	S3C_I2SV2_DIV_PRESCALER
> +
> +#define S3C64XX_CLKSRC_PCLK	(0)
> +#define S3C64XX_CLKSRC_MUX	(1)
> +
> +extern struct snd_soc_dai s3c64xx_i2s_dai;
> +
> +extern unsigned long s3c64xx_i2s_get_clockrate(struct snd_soc_dai *cpu_dai);
> +
> +#endif /* __SND_SOC_S3C24XX_S3C64XX_I2S_H */
> Index: linux.git/sound/soc/s3c24xx/Kconfig
> ===================================================================
> --- linux.git.orig/sound/soc/s3c24xx/Kconfig	2009-03-04 00:44:28.000000000 +0000
> +++ linux.git/sound/soc/s3c24xx/Kconfig	2009-03-04 00:44:31.000000000 +0000
> @@ -1,6 +1,6 @@
>  config SND_S3C24XX_SOC
>  	tristate "SoC Audio for the Samsung S3C24XX chips"
> -	depends on ARCH_S3C2410
> +	depends on ARCH_S3C2410 || ARCH_S3C64XX
>  	help
>  	  Say Y or M if you want to add support for codecs attached to
>  	  the S3C24XX AC97, I2S or SSP interface. You will also need
> @@ -16,6 +16,10 @@ config SND_S3C2412_SOC_I2S
>  	tristate
>  	select SND_S3C_I2SV2_SOC
>  
> +config SND_S3C64XX_SOC_I2S
> +	tristate
> +	select SND_S3C_I2SV2_SOC
> +
>  config SND_S3C2443_SOC_AC97
>  	tristate
>  	select AC97_BUS
> Index: linux.git/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
> ===================================================================
> --- linux.git.orig/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h	2009-03-04 00:44:10.000000000 +0000
> +++ linux.git/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h	2009-03-04 00:44:31.000000000 +0000
> @@ -33,6 +33,9 @@
>  #define S3C2412_IISCON_RXDMA_ACTIVE	(1 << 1)
>  #define S3C2412_IISCON_IIS_ACTIVE	(1 << 0)
>  
> +#define S3C64XX_IISMOD_IMS_PCLK		(0 << 10)
> +#define S3C64XX_IISMOD_IMS_SYSMUX	(1 << 10)
> +
>  #define S3C2412_IISMOD_MASTER_INTERNAL	(0 << 10)
>  #define S3C2412_IISMOD_MASTER_EXTERNAL	(1 << 10)
>  #define S3C2412_IISMOD_SLAVE		(2 << 10)
> 
> -- 
> Ben (ben@fluff.org, http://www.fluff.org/)
> 
>   'a smiley only costs 4 bytes'
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
