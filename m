From: Frank Mandarino <fmandarino@endrelia.com>
Subject: [PATCH] ASoC: Remove references to Endrelia ETI-B1
	board
Date: Tue, 30 Sep 2008 10:42:40 -0400
Message-ID: <48E23AE0.3040805@endrelia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010804040001090509000102"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ironport2-out.teksavvy.com (ironport2-out.pppoe.ca
	[206.248.154.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C2752452B
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 16:42:45 +0200 (CEST)
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
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010804040001090509000102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

See attached.

-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada

--------------010804040001090509000102
Content-Type: text/plain;
 name="asoc-at91-remove-eti-b1-board.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asoc-at91-remove-eti-b1-board.txt"

The ASoC machine drivers for this board were only provided as examples
for the new AT91 ASoC platform driver.  Since the ETI-B1 board is
proprietary and there are other AT91 ASoC machine drivers available,
it makes sense to remove these drivers.

Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
---
 sound/soc/at91/Kconfig           |   27 ---
 sound/soc/at91/Makefile          |    7 -
 sound/soc/at91/eti_b1_bluecore.c |  284 -------------------------------
 sound/soc/at91/eti_b1_wm8731.c   |  350 --------------------------------------
 4 files changed, 0 insertions(+), 668 deletions(-)

diff --git a/sound/soc/at91/Kconfig b/sound/soc/at91/Kconfig
index 5bdd98f..85a8832 100644
--- a/sound/soc/at91/Kconfig
+++ b/sound/soc/at91/Kconfig
@@ -8,30 +8,3 @@ config SND_AT91_SOC
 
 config SND_AT91_SOC_SSC
 	tristate
-
-config SND_AT91_SOC_ETI_B1_WM8731
-	tristate "SoC Audio support for WM8731-based Endrelia ETI-B1 boards"
-	depends on SND_AT91_SOC && (MACH_ETI_B1 || MACH_ETI_C1)
-	select SND_AT91_SOC_SSC
-	select SND_SOC_WM8731
-	help
-	  Say Y if you want to add support for SoC audio on WM8731-based
-	  Endrelia Technologies Inc ETI-B1 or ETI-C1 boards.
-
-config SND_AT91_SOC_ETI_SLAVE
-	bool "Run codec in slave Mode on Endrelia boards"
-	depends on SND_AT91_SOC_ETI_B1_WM8731
-	default n
-	help
-	  Say Y if you want to run with the AT91 SSC generating the BCLK
-	  and LRC signals on Endrelia boards.
-
-config SND_AT91_SOC_ETI_B1_BLUECORE
-	tristate "SoC Audio support for BlueCore PCM on Endrelia ETI-B1 boards"
-	depends on SND_AT91_SOC && (MACH_ETI_B1 || MACH_ETI_C1)
-	select SND_AT91_SOC_SSC
-	help
-	  Say Y if you want to add support for SoC audio on the CSR BlueCore
-	  Bluetooth PCM interface on Endrelia Technologies Inc ETI-B1 or
-	  ETI-C1 boards.
-
diff --git a/sound/soc/at91/Makefile b/sound/soc/at91/Makefile
index 0003740..b817f11 100644
--- a/sound/soc/at91/Makefile
+++ b/sound/soc/at91/Makefile
@@ -4,10 +4,3 @@ snd-soc-at91-ssc-objs := at91-ssc.o
 
 obj-$(CONFIG_SND_AT91_SOC) += snd-soc-at91.o
 obj-$(CONFIG_SND_AT91_SOC_SSC) += snd-soc-at91-ssc.o
-
-# AT91 Machine Support
-snd-soc-eti-b1-wm8731-objs := eti_b1_wm8731.o
-snd-soc-eti-b1-bluecore-objs := eti_b1_bluecore.o
-
-obj-$(CONFIG_SND_AT91_SOC_ETI_B1_WM8731) += snd-soc-eti-b1-wm8731.o
-obj-$(CONFIG_SND_AT91_SOC_ETI_B1_BLUECORE) += snd-soc-eti-b1-bluecore.o
diff --git a/sound/soc/at91/eti_b1_bluecore.c b/sound/soc/at91/eti_b1_bluecore.c
deleted file mode 100644
index 00e1dfc..0000000
--- a/sound/soc/at91/eti_b1_bluecore.c
+++ /dev/null
@@ -1,284 +0,0 @@
-/*
- * eti_b1_bluecore  --  SoC audio for AT91RM9200-based Endrelia ETI_B1 board
- *
- * ASoC Codec and Machine driver for CSR BlueCore PCM interface.
- *
- * Author:	Frank Mandarino <fmandarino@endrelia.com>
- *		Endrelia Technologies Inc.
- * Created:	Mar 16, 2007
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/version.h>
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <sound/driver.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-
-#include <asm/arch/hardware.h>
-#include <asm/arch/at91_pio.h>
-#include <asm/arch/gpio.h>
-
-#include "at91-pcm.h"
-#include "at91-ssc.h"
-
-#if 0
-#define	DBG(x...)	printk(KERN_INFO "eti_b1_bluecore: " x)
-#else
-#define	DBG(x...)
-#endif
-
-
-/*
- * CSR BlueCore PCM interface codec driver.
- */
-#define BLUECORE_VERSION "0.1"
-
-#define BLUECORE_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE)
-
-static struct snd_soc_codec_dai bluecore_dai = {
-	.name = "BlueCore",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 1,
-		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
-		.formats = BLUECORE_FORMATS,},
-	.capture = {
-		.stream_name = "Capture",
-		.channels_min = 1,
-		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
-		.formats = BLUECORE_FORMATS,},
-};
-
-static int bluecore_soc_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	printk(KERN_INFO "bluecore: BlueCore PCM SoC Audio %s\n", BLUECORE_VERSION);
-
-	socdev->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (socdev->codec == NULL)
-		return -ENOMEM;
-	codec = socdev->codec;
-	mutex_init(&codec->mutex);
-
-	codec->name = "BlueCore";
-	codec->owner = THIS_MODULE;
-	codec->dai = &bluecore_dai;
-	codec->num_dai = 1;
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if(ret < 0)
-		goto err;
-
-	ret = snd_soc_register_card(socdev);
-	if (ret < 0)
-		goto bus_err;
-	return 0;
-
-bus_err:
-	snd_soc_free_pcms(socdev);
-
-err:
-	kfree(socdev->codec);
-	socdev->codec = NULL;
-	return ret;
-}
-
-static int bluecore_soc_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->codec;
-
-	if(codec == NULL)
-		return 0;
-
-	snd_soc_free_pcms(socdev);
-	kfree(socdev->codec);
-
-	return 0;
-}
-
-static struct snd_soc_codec_device soc_codec_dev_bluecore = {
-	.probe = 	bluecore_soc_probe,
-	.remove = 	bluecore_soc_remove,
-};
-
-
-/*
- * Endrelia ETI_B1 BlueCore Machine driver.
- */
-#define AT91_PIO_TF2	(1 << (AT91_PIN_PB12 - PIN_BASE) % 32)
-#define AT91_PIO_TK2	(1 << (AT91_PIN_PB13 - PIN_BASE) % 32)
-#define AT91_PIO_TD2	(1 << (AT91_PIN_PB14 - PIN_BASE) % 32)
-#define AT91_PIO_RD2	(1 << (AT91_PIN_PB15 - PIN_BASE) % 32)
-#define AT91_PIO_RK2	(1 << (AT91_PIN_PB16 - PIN_BASE) % 32)
-#define AT91_PIO_RF2	(1 << (AT91_PIN_PB17 - PIN_BASE) % 32)
-
-
-/*
- * CSR BlueCore PCM interface machine driver operations.
- *
- * Only hw_params() is required, and only the CPU_DAI needs to be
- * initiailzed, as there is no real CODEC DAI.  The CODEC DAI
- * is controlled by BlueZ BCCMD and SCO operations.
- */
-static int eti_b1_bcore_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
-	int ret;
-	int cmr_div, period;
-
-	/* set cpu DAI configuration */
-	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * The BlueCore PCM interface only operates at 8kHz, and
-	 * the PCM_CLK signal must be less than 2048kHz.
-	 */
-	cmr_div = 75;	/* PCM_CLK = 60MHz/(2*75) = 400kHz */
-	period = 24;	/* PCM_SYNC = PCM_CLK/(2*(24+1)) = 8000Hz */
-
-	/* set the MCK divider for PCM_CLK */
-	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, AT91SSC_CMR_DIV, cmr_div);
-	if (ret < 0)
-		return ret;
-
-	/* set the BCLK divider for DACLRC */
-	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, AT91SSC_TCMR_PERIOD, period);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static struct snd_soc_ops eti_b1_bcore_ops = {
-	.hw_params = eti_b1_bcore_hw_params,
-};
-
-static struct snd_soc_dai_link eti_b1_bcore_dai = {
-	.name = "BlueCore PCM",
-	.stream_name = "BlueCore",
-	.cpu_dai = &at91_ssc_dai[2],
-	.codec_dai = &bluecore_dai,
-	.ops = &eti_b1_bcore_ops,
-};
-
-static struct snd_soc_machine snd_soc_machine_eti_b1_bcore = {
-	.name = "ETI_B1_BLUECORE",
-	.dai_link = &eti_b1_bcore_dai,
-	.num_links = 1,
-};
-
-static struct snd_soc_device eti_b1_bcore_snd_devdata = {
-	.machine = &snd_soc_machine_eti_b1_bcore,
-	.platform = &at91_soc_platform,
-	.codec_dev = &soc_codec_dev_bluecore,
-};
-
-static struct platform_device *eti_b1_bcore_snd_device;
-
-static int __init eti_b1_bcore_init(void)
-{
-	int ret;
-	u32 ssc_pio_lines;
-	struct at91_ssc_periph *ssc = eti_b1_bcore_dai.cpu_dai->private_data;
-
-	if (!request_mem_region(AT91RM9200_BASE_SSC2, SZ_16K, "soc-audio-2")) {
-		DBG("SSC2 memory region is busy\n");
-		return -EBUSY;
-	}
-
-	ssc->base = ioremap(AT91RM9200_BASE_SSC2, SZ_16K);
-	if (!ssc->base) {
-		DBG("SSC2 memory ioremap failed\n");
-		ret = -ENOMEM;
-		goto fail_release_mem;
-	}
-
-	ssc->pid = AT91RM9200_ID_SSC2;
-
-	eti_b1_bcore_snd_device = platform_device_alloc("soc-audio", 2);
-	if (!eti_b1_bcore_snd_device) {
-		DBG("platform device allocation failed\n");
-		ret = -ENOMEM;
-		goto fail_io_unmap;
-	}
-
-	platform_set_drvdata(eti_b1_bcore_snd_device, &eti_b1_bcore_snd_devdata);
-	eti_b1_bcore_snd_devdata.dev = &eti_b1_bcore_snd_device->dev;
-
-	ret = platform_device_add(eti_b1_bcore_snd_device);
-	if (ret) {
-		DBG("platform device add failed\n");
-		platform_device_put(eti_b1_bcore_snd_device);
-		goto fail_io_unmap;
-	}
-
- 	ssc_pio_lines = AT91_PIO_TF2 | AT91_PIO_TK2 | AT91_PIO_TD2
-			| AT91_PIO_RD2 /* | AT91_PIO_RK1 | AT91_PIO_RF1 */;
-
-	/* Reset all PIO registers and assign lines to peripheral A */
- 	at91_sys_write(AT91_PIOB + PIO_PDR,  ssc_pio_lines);
- 	at91_sys_write(AT91_PIOB + PIO_ODR,  ssc_pio_lines);
- 	at91_sys_write(AT91_PIOB + PIO_IFDR, ssc_pio_lines);
- 	at91_sys_write(AT91_PIOB + PIO_CODR, ssc_pio_lines);
- 	at91_sys_write(AT91_PIOB + PIO_IDR,  ssc_pio_lines);
- 	at91_sys_write(AT91_PIOB + PIO_MDDR, ssc_pio_lines);
- 	at91_sys_write(AT91_PIOB + PIO_PUDR, ssc_pio_lines);
- 	at91_sys_write(AT91_PIOB + PIO_ASR,  ssc_pio_lines);
- 	at91_sys_write(AT91_PIOB + PIO_OWDR, ssc_pio_lines);
-
-	printk(KERN_INFO "eti_b1_bcore: BlueCore PCM in Slave Mode\n");
-	return ret;
-
-fail_io_unmap:
-	iounmap(ssc->base);
-fail_release_mem:
-	release_mem_region(AT91RM9200_BASE_SSC2, SZ_16K);
-	return ret;
-}
-
-static void __exit eti_b1_bcore_exit(void)
-{
-	struct at91_ssc_periph *ssc = eti_b1_bcore_dai.cpu_dai->private_data;
-
-	platform_device_unregister(eti_b1_bcore_snd_device);
-
-	iounmap(ssc->base);
-	release_mem_region(AT91RM9200_BASE_SSC2, SZ_16K);
-}
-
-module_init(eti_b1_bcore_init);
-module_exit(eti_b1_bcore_exit);
-
-/* Module information */
-MODULE_AUTHOR("Frank Mandarino <fmandarino@endrelia.com>");
-MODULE_DESCRIPTION("ALSA SoC ETI-B1-BlueCore");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/at91/eti_b1_wm8731.c b/sound/soc/at91/eti_b1_wm8731.c
deleted file mode 100644
index cdc388f..0000000
--- a/sound/soc/at91/eti_b1_wm8731.c
+++ /dev/null
@@ -1,350 +0,0 @@
-/*
- * eti_b1_wm8731  --  SoC audio for AT91RM9200-based Endrelia ETI_B1 board.
- *
- * Author:	Frank Mandarino <fmandarino@endrelia.com>
- *		Endrelia Technologies Inc.
- * Created:	Mar 29, 2006
- *
- * Based on corgi.c by:
- *
- * Copyright 2005 Wolfson Microelectronics PLC.
- * Copyright 2005 Openedhand Ltd.
- *
- * Authors: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
- *          Richard Purdie <richard@openedhand.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/version.h>
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-
-#include <mach/hardware.h>
-#include <mach/gpio.h>
-
-#include "../codecs/wm8731.h"
-#include "at91-pcm.h"
-#include "at91-ssc.h"
-
-#if 0
-#define	DBG(x...)	printk(KERN_INFO "eti_b1_wm8731: " x)
-#else
-#define	DBG(x...)
-#endif
-
-static struct clk *pck1_clk;
-static struct clk *pllb_clk;
-
-
-static int eti_b1_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	int ret;
-
-	/* cpu clock is the AT91 master clock sent to the SSC */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, AT91_SYSCLK_MCK,
-		60000000, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	/* codec system clock is supplied by PCK1, set to 12MHz */
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
-		12000000, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	/* Start PCK1 clock. */
-	clk_enable(pck1_clk);
-	DBG("pck1 started\n");
-
-	return 0;
-}
-
-static void eti_b1_shutdown(struct snd_pcm_substream *substream)
-{
-	/* Stop PCK1 clock. */
-	clk_disable(pck1_clk);
-	DBG("pck1 stopped\n");
-}
-
-static int eti_b1_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	int ret;
-
-#ifdef CONFIG_SND_AT91_SOC_ETI_SLAVE
-	unsigned int rate;
-	int cmr_div, period;
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * The SSC clock dividers depend on the sample rate.  The CMR.DIV
-	 * field divides the system master clock MCK to drive the SSC TK
-	 * signal which provides the codec BCLK.  The TCMR.PERIOD and
-	 * RCMR.PERIOD fields further divide the BCLK signal to drive
-	 * the SSC TF and RF signals which provide the codec DACLRC and
-	 * ADCLRC clocks.
-	 *
-	 * The dividers were determined through trial and error, where a
-	 * CMR.DIV value is chosen such that the resulting BCLK value is
-	 * divisible, or almost divisible, by (2 * sample rate), and then
-	 * the TCMR.PERIOD or RCMR.PERIOD is BCLK / (2 * sample rate) - 1.
-	 */
-	rate = params_rate(params);
-
-	switch (rate) {
-	case 8000:
-		cmr_div = 25;	/* BCLK = 60MHz/(2*25) = 1.2MHz */
-		period = 74;	/* LRC = BCLK/(2*(74+1)) = 8000Hz */
-		break;
-	case 32000:
-		cmr_div = 7;	/* BCLK = 60MHz/(2*7) ~= 4.28571428MHz */
-		period = 66;	/* LRC = BCLK/(2*(66+1)) = 31982.942Hz */
-		break;
-	case 48000:
-		cmr_div = 13;	/* BCLK = 60MHz/(2*13) ~= 2.3076923MHz */
-		period = 23;	/* LRC = BCLK/(2*(23+1)) = 48076.923Hz */
-		break;
-	default:
-		printk(KERN_WARNING "unsupported rate %d on ETI-B1 board\n", rate);
-		return -EINVAL;
-	}
-
-	/* set the MCK divider for BCLK */
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, AT91SSC_CMR_DIV, cmr_div);
-	if (ret < 0)
-		return ret;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		/* set the BCLK divider for DACLRC */
-		ret = snd_soc_dai_set_clkdiv(cpu_dai,
-						AT91SSC_TCMR_PERIOD, period);
-	} else {
-		/* set the BCLK divider for ADCLRC */
-		ret = snd_soc_dai_set_clkdiv(cpu_dai,
-						AT91SSC_RCMR_PERIOD, period);
-	}
-	if (ret < 0)
-		return ret;
-
-#else /* CONFIG_SND_AT91_SOC_ETI_SLAVE */
-	/*
-	 * Codec in Master Mode.
-	 */
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-#endif /* CONFIG_SND_AT91_SOC_ETI_SLAVE */
-
-	return 0;
-}
-
-static struct snd_soc_ops eti_b1_ops = {
-	.startup = eti_b1_startup,
-	.hw_params = eti_b1_hw_params,
-	.shutdown = eti_b1_shutdown,
-};
-
-
-static const struct snd_soc_dapm_widget eti_b1_dapm_widgets[] = {
-	SND_SOC_DAPM_MIC("Int Mic", NULL),
-	SND_SOC_DAPM_SPK("Ext Spk", NULL),
-};
-
-static const struct snd_soc_dapm_route intercon[] = {
-
-	/* speaker connected to LHPOUT */
-	{"Ext Spk", NULL, "LHPOUT"},
-
-	/* mic is connected to Mic Jack, with WM8731 Mic Bias */
-	{"MICIN", NULL, "Mic Bias"},
-	{"Mic Bias", NULL, "Int Mic"},
-};
-
-/*
- * Logic for a wm8731 as connected on a Endrelia ETI-B1 board.
- */
-static int eti_b1_wm8731_init(struct snd_soc_codec *codec)
-{
-	DBG("eti_b1_wm8731_init() called\n");
-
-	/* Add specific widgets */
-	snd_soc_dapm_new_controls(codec, eti_b1_dapm_widgets,
-				  ARRAY_SIZE(eti_b1_dapm_widgets));
-
-	/* Set up specific audio path interconnects */
-	snd_soc_dapm_add_route(codec, intercon, ARRAY_SIZE(intercon));
-
-	/* not connected */
-	snd_soc_dapm_disable_pin(codec, "RLINEIN");
-	snd_soc_dapm_disable_pin(codec, "LLINEIN");
-
-	/* always connected */
-	snd_soc_dapm_enable_pin(codec, "Int Mic");
-	snd_soc_dapm_enable_pin(codec, "Ext Spk");
-
-	snd_soc_dapm_sync(codec);
-
-	return 0;
-}
-
-static struct snd_soc_dai_link eti_b1_dai = {
-	.name = "WM8731",
-	.stream_name = "WM8731 PCM",
-	.cpu_dai = &at91_ssc_dai[1],
-	.codec_dai = &wm8731_dai,
-	.init = eti_b1_wm8731_init,
-	.ops = &eti_b1_ops,
-};
-
-static struct snd_soc_machine snd_soc_machine_eti_b1 = {
-	.name = "ETI_B1_WM8731",
-	.dai_link = &eti_b1_dai,
-	.num_links = 1,
-};
-
-static struct wm8731_setup_data eti_b1_wm8731_setup = {
-	.i2c_bus = 0,
-	.i2c_address = 0x1a,
-};
-
-static struct snd_soc_device eti_b1_snd_devdata = {
-	.machine = &snd_soc_machine_eti_b1,
-	.platform = &at91_soc_platform,
-	.codec_dev = &soc_codec_dev_wm8731,
-	.codec_data = &eti_b1_wm8731_setup,
-};
-
-static struct platform_device *eti_b1_snd_device;
-
-static int __init eti_b1_init(void)
-{
-	int ret;
-	struct at91_ssc_periph *ssc = eti_b1_dai.cpu_dai->private_data;
-
-	if (!request_mem_region(AT91RM9200_BASE_SSC1, SZ_16K, "soc-audio-1")) {
-		DBG("SSC1 memory region is busy\n");
-		return -EBUSY;
-	}
-
-	ssc->base = ioremap(AT91RM9200_BASE_SSC1, SZ_16K);
-	if (!ssc->base) {
-		DBG("SSC1 memory ioremap failed\n");
-		ret = -ENOMEM;
-		goto fail_release_mem;
-	}
-
-	ssc->pid = AT91RM9200_ID_SSC1;
-
-	eti_b1_snd_device = platform_device_alloc("soc-audio", 1);
-	if (!eti_b1_snd_device) {
-		DBG("platform device allocation failed\n");
-		ret = -ENOMEM;
-		goto fail_io_unmap;
-	}
-
-	platform_set_drvdata(eti_b1_snd_device, &eti_b1_snd_devdata);
-	eti_b1_snd_devdata.dev = &eti_b1_snd_device->dev;
-
-	ret = platform_device_add(eti_b1_snd_device);
-	if (ret) {
-		DBG("platform device add failed\n");
-		platform_device_put(eti_b1_snd_device);
-		goto fail_io_unmap;
-	}
-
-	at91_set_A_periph(AT91_PIN_PB6, 0);	/* TF1 */
-	at91_set_A_periph(AT91_PIN_PB7, 0);	/* TK1 */
-	at91_set_A_periph(AT91_PIN_PB8, 0);	/* TD1 */
-	at91_set_A_periph(AT91_PIN_PB9, 0);	/* RD1 */
-/*	at91_set_A_periph(AT91_PIN_PB10, 0);*/	/* RK1 */
-	at91_set_A_periph(AT91_PIN_PB11, 0);	/* RF1 */
-
-	/*
-	 * Set PCK1 parent to PLLB and its rate to 12 Mhz.
-	 */
-	pllb_clk = clk_get(NULL, "pllb");
-	pck1_clk = clk_get(NULL, "pck1");
-
-	clk_set_parent(pck1_clk, pllb_clk);
-	clk_set_rate(pck1_clk, 12000000);
-
-	DBG("MCLK rate %luHz\n", clk_get_rate(pck1_clk));
-
-	/* assign the GPIO pin to PCK1 */
-	at91_set_B_periph(AT91_PIN_PA24, 0);
-
-#ifdef CONFIG_SND_AT91_SOC_ETI_SLAVE
-	printk(KERN_INFO "eti_b1_wm8731: Codec in Slave Mode\n");
-#else
-	printk(KERN_INFO "eti_b1_wm8731: Codec in Master Mode\n");
-#endif
-	return ret;
-
-fail_io_unmap:
-	iounmap(ssc->base);
-fail_release_mem:
-	release_mem_region(AT91RM9200_BASE_SSC1, SZ_16K);
-	return ret;
-}
-
-static void __exit eti_b1_exit(void)
-{
-	struct at91_ssc_periph *ssc = eti_b1_dai.cpu_dai->private_data;
-
-	clk_put(pck1_clk);
-	clk_put(pllb_clk);
-
-	platform_device_unregister(eti_b1_snd_device);
-
-	iounmap(ssc->base);
-	release_mem_region(AT91RM9200_BASE_SSC1, SZ_16K);
-}
-
-module_init(eti_b1_init);
-module_exit(eti_b1_exit);
-
-/* Module information */
-MODULE_AUTHOR("Frank Mandarino <fmandarino@endrelia.com>");
-MODULE_DESCRIPTION("ALSA SoC ETI-B1-WM8731");
-MODULE_LICENSE("GPL");
-- 
1.4.2


--------------010804040001090509000102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010804040001090509000102--
