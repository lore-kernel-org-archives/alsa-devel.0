From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] sound/soc/davinci: remove sffsdr machine support
Date: Mon, 17 Jun 2013 14:16:31 +0530
Message-ID: <1371458791-7530-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Hugo Villeneuve <hugo-rg2e/+w5TaNBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

sffsdr machine support does not build since at least v2.6.36
(~3 years). There is little hope of it being fixed, so remove
the support.

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 sound/soc/davinci/Kconfig          |   10 --
 sound/soc/davinci/Makefile         |    2 -
 sound/soc/davinci/davinci-sffsdr.c |  181 ------------------------------------
 3 files changed, 193 deletions(-)
 delete mode 100644 sound/soc/davinci/davinci-sffsdr.c

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 9e11a14..c82f89c 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -54,16 +54,6 @@ config  SND_DM6467_SOC_EVM
 	help
 	  Say Y if you want to add support for SoC audio on TI
 
-config SND_DAVINCI_SOC_SFFSDR
-	tristate "SoC Audio support for SFFSDR"
-	depends on SND_DAVINCI_SOC && MACH_SFFSDR
-	select SND_DAVINCI_SOC_I2S
-	select SND_SOC_PCM3008
-	select SFFSDR_FPGA
-	help
-	  Say Y if you want to add support for SoC audio on
-	  Lyrtech SFFSDR board.
-
 config  SND_DA830_SOC_EVM
 	tristate "SoC Audio support for DA830/OMAP-L137 EVM"
 	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA830_EVM
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index a93679d..a396ab6 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -11,10 +11,8 @@ obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
 
 # DAVINCI Machine Support
 snd-soc-evm-objs := davinci-evm.o
-snd-soc-sffsdr-objs := davinci-sffsdr.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DM6467_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DA830_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DA850_SOC_EVM) += snd-soc-evm.o
-obj-$(CONFIG_SND_DAVINCI_SOC_SFFSDR) += snd-soc-sffsdr.o
diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
deleted file mode 100644
index 5be65aa..0000000
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ /dev/null
@@ -1,181 +0,0 @@
-/*
- * ASoC driver for Lyrtech SFFSDR board.
- *
- * Author:	Hugo Villeneuve
- * Copyright (C) 2008 Lyrtech inc
- *
- * Based on ASoC driver for TI DAVINCI EVM platform, original copyright follow:
- * Copyright:   (C) 2007 MontaVista Software, Inc., <source-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-
-#include <asm/dma.h>
-#include <asm/mach-types.h>
-#ifdef CONFIG_SFFSDR_FPGA
-#include <asm/plat-sffsdr/sffsdr-fpga.h>
-#endif
-
-#include <mach/edma.h>
-
-#include "../codecs/pcm3008.h"
-#include "davinci-pcm.h"
-#include "davinci-i2s.h"
-
-/*
- * CLKX and CLKR are the inputs for the Sample Rate Generator.
- * FSX and FSR are outputs, driven by the sample Rate Generator.
- */
-#define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B |	\
-		      SND_SOC_DAIFMT_CBM_CFS |	\
-		      SND_SOC_DAIFMT_IB_NF)
-
-static int sffsdr_hw_params(struct snd_pcm_substream *substream,
-			    struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int fs;
-	int ret = 0;
-
-	/* Fsref can be 32000, 44100 or 48000. */
-	fs = params_rate(params);
-
-#ifndef CONFIG_SFFSDR_FPGA
-	/* Without the FPGA module, the Fs is fixed at 44100 Hz */
-	if (fs != 44100) {
-		pr_debug("warning: only 44.1 kHz is supported without SFFSDR FPGA module\n");
-		return -EINVAL;
-	}
-#endif
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
-	if (ret < 0)
-		return ret;
-
-	pr_debug("sffsdr_hw_params: rate = %d Hz\n", fs);
-
-#ifndef CONFIG_SFFSDR_FPGA
-	return 0;
-#else
-	return sffsdr_fpga_set_codec_fs(fs);
-#endif
-}
-
-static struct snd_soc_ops sffsdr_ops = {
-	.hw_params = sffsdr_hw_params,
-};
-
-/* davinci-sffsdr digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link sffsdr_dai = {
-	.name = "PCM3008", /* Codec name */
-	.stream_name = "PCM3008 HiFi",
-	.cpu_dai_name = "davinci-mcbsp",
-	.codec_dai_name = "pcm3008-hifi",
-	.codec_name = "pcm3008-codec",
-	.platform_name = "davinci-mcbsp",
-	.ops = &sffsdr_ops,
-};
-
-/* davinci-sffsdr audio machine driver */
-static struct snd_soc_card snd_soc_sffsdr = {
-	.name = "DaVinci SFFSDR",
-	.owner = THIS_MODULE,
-	.dai_link = &sffsdr_dai,
-	.num_links = 1,
-};
-
-/* sffsdr audio private data */
-static struct pcm3008_setup_data sffsdr_pcm3008_setup = {
-	.dem0_pin = GPIO(45),
-	.dem1_pin = GPIO(46),
-	.pdad_pin = GPIO(47),
-	.pdda_pin = GPIO(38),
-};
-
-struct platform_device pcm3008_codec = {
-		.name = "pcm3008-codec",
-		.id = 0,
-		.dev = {
-				.platform_data = &sffsdr_pcm3008_setup,
-		},
-};
-
-static struct resource sffsdr_snd_resources[] = {
-	{
-		.start = DAVINCI_MCBSP_BASE,
-		.end = DAVINCI_MCBSP_BASE + SZ_8K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-static struct evm_snd_platform_data sffsdr_snd_data = {
-	.tx_dma_ch	= DAVINCI_DMA_MCBSP_TX,
-	.rx_dma_ch	= DAVINCI_DMA_MCBSP_RX,
-};
-
-static struct platform_device *sffsdr_snd_device;
-
-static int __init sffsdr_init(void)
-{
-	int ret;
-
-	if (!machine_is_sffsdr())
-		return -EINVAL;
-
-	platform_device_register(&pcm3008_codec);
-
-	sffsdr_snd_device = platform_device_alloc("soc-audio", 0);
-	if (!sffsdr_snd_device) {
-		printk(KERN_ERR "platform device allocation failed\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(sffsdr_snd_device, &snd_soc_sffsdr);
-	platform_device_add_data(sffsdr_snd_device, &sffsdr_snd_data,
-				 sizeof(sffsdr_snd_data));
-
-	ret = platform_device_add_resources(sffsdr_snd_device,
-					    sffsdr_snd_resources,
-					    ARRAY_SIZE(sffsdr_snd_resources));
-	if (ret) {
-		printk(KERN_ERR "platform device add resources failed\n");
-		goto error;
-	}
-
-	ret = platform_device_add(sffsdr_snd_device);
-	if (ret)
-		goto error;
-
-	return ret;
-
-error:
-	platform_device_put(sffsdr_snd_device);
-	return ret;
-}
-
-static void __exit sffsdr_exit(void)
-{
-	platform_device_unregister(sffsdr_snd_device);
-	platform_device_unregister(&pcm3008_codec);
-}
-
-module_init(sffsdr_init);
-module_exit(sffsdr_exit);
-
-MODULE_AUTHOR("Hugo Villeneuve");
-MODULE_DESCRIPTION("Lyrtech SFFSDR ASoC driver");
-MODULE_LICENSE("GPL");
-- 
1.7.10.1
