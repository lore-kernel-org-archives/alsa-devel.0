From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: ALSA:ATMEL: common arch for audio via ssc(patch 3/3:
 adding directories)
Date: Fri, 26 Sep 2008 11:24:10 +0200
Message-ID: <48DCAA3A.8030209@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 637AF10381C
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 11:25:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>, Geoffrey Wossum <geoffrey@pager.net>, Mark Brown <broonie@sirena.org.uk>, Haavard Skinnemoen <haavard.skinnemoen>
List-Id: alsa-devel@alsa-project.org

This last patch contains the board specific files.
I have not changed playpaq_wm8510.c, and I did few changes on eti_b1_wm8731.c.

Regards,
Sedji
 
diff --git a/sound/soc/atmel/eti_b1_wm8731.c b/sound/soc/atmel/eti_b1_wm8731.c
new file mode 100644
index 0000000..afa1aaf
--- /dev/null
+++ b/sound/soc/atmel/eti_b1_wm8731.c
@@ -0,0 +1,353 @@
+/*
+ * eti_b1_wm8731  --  SoC audio for AT91RM9200-based Endrelia ETI_B1 board.
+ *
+ * Author:	Frank Mandarino <fmandarino@endrelia.com>
+ *		Endrelia Technologies Inc.
+ * Created:	Mar 29, 2006
+ *
+ * Based on corgi.c by:
+ *
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Copyright 2005 Openedhand Ltd.
+ *
+ * Authors: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
+ *          Richard Purdie <richard@openedhand.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+
+#include "../codecs/wm8731.h"
+#include "atmel_pcm.h"
+#include "atmel_ssc_dai.h"
+
+#if 0
+#define	DBG(x...)	printk(KERN_INFO "eti_b1_wm8731: " x)
+#else
+#define	DBG(x...)
+#endif
+
+static struct clk *pck1_clk;
+static struct clk *pllb_clk;
+
+
+static int eti_b1_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	/* cpu clock is the AT91 master clock sent to the SSC */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, ATMEL_SYSCLK_MCK,
+		60000000, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* codec system clock is supplied by PCK1, set to 12MHz */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
+		12000000, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* Start PCK1 clock. */
+	clk_enable(pck1_clk);
+	DBG("pck1 started\n");
+
+	return 0;
+}
+
+static void eti_b1_shutdown(struct snd_pcm_substream *substream)
+{
+	/* Stop PCK1 clock. */
+	clk_disable(pck1_clk);
+	DBG("pck1 stopped\n");
+}
+
+static int eti_b1_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+#ifdef CONFIG_SND_AT91_SOC_ETI_SLAVE
+	unsigned int rate;
+	int cmr_div, period;
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The SSC clock dividers depend on the sample rate.  The CMR.DIV
+	 * field divides the system master clock MCK to drive the SSC TK
+	 * signal which provides the codec BCLK.  The TCMR.PERIOD and
+	 * RCMR.PERIOD fields further divide the BCLK signal to drive
+	 * the SSC TF and RF signals which provide the codec DACLRC and
+	 * ADCLRC clocks.
+	 *
+	 * The dividers were determined through trial and error, where a
+	 * CMR.DIV value is chosen such that the resulting BCLK value is
+	 * divisible, or almost divisible, by (2 * sample rate), and then
+	 * the TCMR.PERIOD or RCMR.PERIOD is BCLK / (2 * sample rate) - 1.
+	 */
+	rate = params_rate(params);
+
+	switch (rate) {
+	case 8000:
+		cmr_div = 25;	/* BCLK = 60MHz/(2*25) = 1.2MHz */
+		period = 74;	/* LRC = BCLK/(2*(74+1)) = 8000Hz */
+		break;
+	case 32000:
+		cmr_div = 7;	/* BCLK = 60MHz/(2*7) ~= 4.28571428MHz */
+		period = 66;	/* LRC = BCLK/(2*(66+1)) = 31982.942Hz */
+		break;
+	case 48000:
+		cmr_div = 13;	/* BCLK = 60MHz/(2*13) ~= 2.3076923MHz */
+		period = 23;	/* LRC = BCLK/(2*(23+1)) = 48076.923Hz */
+		break;
+	default:
+		printk(KERN_WARNING "unsupported rate %d"
+				" on ETI-B1 board\n", rate);
+		return -EINVAL;
+	}
+
+	/* set the MCK divider for BCLK */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, ATMEL_SSC_CMR_DIV, cmr_div);
+	if (ret < 0)
+		return ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* set the BCLK divider for DACLRC */
+		ret = snd_soc_dai_set_clkdiv(cpu_dai,
+						ATMEL_SSC_TCMR_PERIOD, period);
+	} else {
+		/* set the BCLK divider for ADCLRC */
+		ret = snd_soc_dai_set_clkdiv(cpu_dai,
+						ATMEL_SSC_RCMR_PERIOD, period);
+	}
+	if (ret < 0)
+		return ret;
+
+#else /* CONFIG_SND_AT91_SOC_ETI_SLAVE */
+	/*
+	 * Codec in Master Mode.
+	 */
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+#endif /* CONFIG_SND_AT91_SOC_ETI_SLAVE */
+
+	return 0;
+}
+
+static struct snd_soc_ops eti_b1_ops = {
+	.startup = eti_b1_startup,
+	.hw_params = eti_b1_hw_params,
+	.shutdown = eti_b1_shutdown,
+};
+
+
+static const struct snd_soc_dapm_widget eti_b1_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+
+	/* speaker connected to LHPOUT */
+	{"Ext Spk", NULL, "LHPOUT"},
+
+	/* mic is connected to Mic Jack, with WM8731 Mic Bias */
+	{"MICIN", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Int Mic"},
+};
+
+/*
+ * Logic for a wm8731 as connected on a Endrelia ETI-B1 board.
+ */
+static int eti_b1_wm8731_init(struct snd_soc_codec *codec)
+{
+	DBG("eti_b1_wm8731_init() called\n");
+
+	/* Add specific widgets */
+	snd_soc_dapm_new_controls(codec, eti_b1_dapm_widgets,
+				  ARRAY_SIZE(eti_b1_dapm_widgets));
+
+	/* Set up specific audio path interconnects */
+	snd_soc_dapm_add_route(codec, intercon, ARRAY_SIZE(intercon));
+
+	/* not connected */
+	snd_soc_dapm_disable_pin(codec, "RLINEIN");
+	snd_soc_dapm_disable_pin(codec, "LLINEIN");
+
+	/* always connected */
+	snd_soc_dapm_enable_pin(codec, "Int Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link eti_b1_dai = {
+	.name = "WM8731",
+	.stream_name = "WM8731 PCM",
+	.cpu_dai = &atmel_ssc_dai[1],
+	.codec_dai = &wm8731_dai,
+	.init = eti_b1_wm8731_init,
+	.ops = &eti_b1_ops,
+};
+
+static struct snd_soc_machine snd_soc_machine_eti_b1 = {
+	.name = "ETI_B1_WM8731",
+	.dai_link = &eti_b1_dai,
+	.num_links = 1,
+};
+
+static struct wm8731_setup_data eti_b1_wm8731_setup = {
+	.i2c_address = 0x1a,
+};
+
+static struct snd_soc_device eti_b1_snd_devdata = {
+	.machine = &snd_soc_machine_eti_b1,
+	.platform = &atmel_soc_platform,
+	.codec_dev = &soc_codec_dev_wm8731,
+	.codec_data = &eti_b1_wm8731_setup,
+};
+
+static struct platform_device *eti_b1_snd_device;
+
+static int __init eti_b1_init(void)
+{
+	int ret;
+	struct atmel_ssc_periph *ssc = eti_b1_dai.cpu_dai->private_data;
+	struct ssc_device *ssc = NULL;
+
+	/*
+	 * Request SSC device
+	 */
+	ssc = ssc_request(1);
+	if (IS_ERR(ssc)) {
+		ret = PTR_ERR(ssc);
+		ssc = NULL;
+		goto err_ssc;
+	}
+	ssc_p->ssc = ssc;
+
+	eti_b1_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!eti_b1_snd_device) {
+		DBG("platform device allocation failed\n");
+		ret = -ENOMEM;
+		goto fail_io_unmap;
+	}
+
+	platform_set_drvdata(eti_b1_snd_device, &eti_b1_snd_devdata);
+	eti_b1_snd_devdata.dev = &eti_b1_snd_device->dev;
+
+	ret = platform_device_add(eti_b1_snd_device);
+	if (ret) {
+		DBG("platform device add failed\n");
+		platform_device_put(eti_b1_snd_device);
+		goto fail_io_unmap;
+	}
+
+	at91_set_A_periph(AT91_PIN_PB6, 0);	/* TF1 */
+	at91_set_A_periph(AT91_PIN_PB7, 0);	/* TK1 */
+	at91_set_A_periph(AT91_PIN_PB8, 0);	/* TD1 */
+	at91_set_A_periph(AT91_PIN_PB9, 0);	/* RD1 */
+/*	at91_set_A_periph(AT91_PIN_PB10, 0);*/	/* RK1 */
+	at91_set_A_periph(AT91_PIN_PB11, 0);	/* RF1 */
+
+	/*
+	 * Set PCK1 parent to PLLB and its rate to 12 Mhz.
+	 */
+	pllb_clk = clk_get(NULL, "pllb");
+	pck1_clk = clk_get(NULL, "pck1");
+
+	clk_set_parent(pck1_clk, pllb_clk);
+	clk_set_rate(pck1_clk, 12000000);
+
+	DBG("MCLK rate %luHz\n", clk_get_rate(pck1_clk));
+
+	/* assign the GPIO pin to PCK1 */
+	at91_set_B_periph(AT91_PIN_PA24, 0);
+
+#ifdef CONFIG_SND_AT91_SOC_ETI_SLAVE
+	printk(KERN_INFO "eti_b1_wm8731: Codec in Slave Mode\n");
+#else
+	printk(KERN_INFO "eti_b1_wm8731: Codec in Master Mode\n");
+#endif
+	return ret;
+err_ssc:
+	return ret;
+fail_io_unmap:
+	iounmap(ssc->base);
+fail_release_mem:
+	release_mem_region(AT91RM9200_BASE_SSC1, SZ_16K);
+	return ret;
+}
+
+static void __exit eti_b1_exit(void)
+{
+	struct atmel_ssc_periph *ssc_p = eti_b1_dai.cpu_dai->private_data;
+	struct ssc_device *ssc;
+
+	clk_put(pck1_clk);
+	clk_put(pllb_clk);
+
+	if (ssc_p != NULL) {
+		ssc = ssc_p->ssc;
+		if (ssc != NULL)
+			ssc_free(ssc);
+		ssc_p->ssc = NULL;
+	}
+
+	platform_device_unregister(eti_b1_snd_device);
+}
+
+module_init(eti_b1_init);
+module_exit(eti_b1_exit);
+
+/* Module information */
+MODULE_AUTHOR("Frank Mandarino <fmandarino@endrelia.com>");
+MODULE_DESCRIPTION("ALSA SoC ETI-B1-WM8731");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
new file mode 100644
index 0000000..3f32621
--- /dev/null
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -0,0 +1,522 @@
+/* sound/soc/at32/playpaq_wm8510.c
+ * ASoC machine driver for PlayPaq using WM8510 codec
+ *
+ * Copyright (C) 2008 Long Range Systems
+ *    Geoffrey Wossum <gwossum@acm.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This code is largely inspired by sound/soc/at91/eti_b1_wm8731.c
+ *
+ * NOTE: If you don't have the AT32 enhanced portmux configured (which
+ * isn't currently in the mainline or Atmel patched kernel), you will
+ * need to set the MCLK pin (PA30) to peripheral A in your board initialization
+ * code.  Something like:
+ *	at32_select_periph(GPIO_PIN_PA(30), GPIO_PERIPH_A, 0);
+ *
+ */
+
+/* #define DEBUG */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <mach/at32ap700x.h>
+#include <mach/portmux.h>
+
+#include "../codecs/wm8510.h"
+#include "at32-pcm.h"
+#include "at32-ssc.h"
+
+
+/*-------------------------------------------------------------------------*\
+ * constants
+\*-------------------------------------------------------------------------*/
+#define MCLK_PIN		GPIO_PIN_PA(30)
+#define MCLK_PERIPH		GPIO_PERIPH_A
+
+
+/*-------------------------------------------------------------------------*\
+ * data types
+\*-------------------------------------------------------------------------*/
+/* SSC clocking data */
+struct ssc_clock_data {
+	/* CMR div */
+	unsigned int cmr_div;
+
+	/* Frame period (as needed by xCMR.PERIOD) */
+	unsigned int period;
+
+	/* The SSC clock rate these settings where calculated for */
+	unsigned long ssc_rate;
+};
+
+
+/*-------------------------------------------------------------------------*\
+ * module data
+\*-------------------------------------------------------------------------*/
+static struct clk *_gclk0;
+static struct clk *_pll0;
+
+#define CODEC_CLK (_gclk0)
+
+
+/*-------------------------------------------------------------------------*\
+ * Sound SOC operations
+\*-------------------------------------------------------------------------*/
+#if defined CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE
+static struct ssc_clock_data playpaq_wm8510_calc_ssc_clock(
+	struct snd_pcm_hw_params *params,
+	struct snd_soc_dai *cpu_dai)
+{
+	struct at32_ssc_info *ssc_p = cpu_dai->private_data;
+	struct ssc_device *ssc = ssc_p->ssc;
+	struct ssc_clock_data cd;
+	unsigned int rate, width_bits, channels;
+	unsigned int bitrate, ssc_div;
+	unsigned actual_rate;
+
+
+	/*
+	 * Figure out required bitrate
+	 */
+	rate = params_rate(params);
+	channels = params_channels(params);
+	width_bits = snd_pcm_format_physical_width(params_format(params));
+	bitrate = rate * width_bits * channels;
+
+
+	/*
+	 * Figure out required SSC divider and period for required bitrate
+	 */
+	cd.ssc_rate = clk_get_rate(ssc->clk);
+	ssc_div = cd.ssc_rate / bitrate;
+	cd.cmr_div = ssc_div / 2;
+	if (ssc_div & 1) {
+		/* round cmr_div up */
+		cd.cmr_div++;
+	}
+	cd.period = width_bits - 1;
+
+
+	/*
+	 * Find actual rate, compare to requested rate
+	 */
+	actual_rate = (cd.ssc_rate / (cd.cmr_div * 2)) / (2 * (cd.period + 1));
+	pr_debug("playpaq_wm8510: Request rate = %d, actual rate = %d\n",
+		 rate, actual_rate);
+
+
+	return cd;
+}
+#endif /* CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE */
+
+
+
+static int playpaq_wm8510_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct at32_ssc_info *ssc_p = cpu_dai->private_data;
+	struct ssc_device *ssc = ssc_p->ssc;
+	unsigned int pll_out = 0, bclk = 0, mclk_div = 0;
+	int ret;
+
+
+	/* Due to difficulties with getting the correct clocks from the AT32's
+	 * PLL0, we're going to let the CODEC be in charge of all the clocks
+	 */
+#if !defined CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE
+	const unsigned int fmt = (SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+#else
+	struct ssc_clock_data cd;
+	const unsigned int fmt = (SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+#endif
+
+	if (ssc == NULL) {
+		pr_warning("playpaq_wm8510_hw_params: ssc is NULL!\n");
+		return -EINVAL;
+	}
+
+
+	/*
+	 * Figure out PLL and BCLK dividers for WM8510
+	 */
+	switch (params_rate(params)) {
+	case 48000:
+		pll_out = 12288000;
+		mclk_div = WM8510_MCLKDIV_1;
+		bclk = WM8510_BCLKDIV_8;
+		break;
+
+	case 44100:
+		pll_out = 11289600;
+		mclk_div = WM8510_MCLKDIV_1;
+		bclk = WM8510_BCLKDIV_8;
+		break;
+
+	case 22050:
+		pll_out = 11289600;
+		mclk_div = WM8510_MCLKDIV_2;
+		bclk = WM8510_BCLKDIV_8;
+		break;
+
+	case 16000:
+		pll_out = 12288000;
+		mclk_div = WM8510_MCLKDIV_3;
+		bclk = WM8510_BCLKDIV_8;
+		break;
+
+	case 11025:
+		pll_out = 11289600;
+		mclk_div = WM8510_MCLKDIV_4;
+		bclk = WM8510_BCLKDIV_8;
+		break;
+
+	case 8000:
+		pll_out = 12288000;
+		mclk_div = WM8510_MCLKDIV_6;
+		bclk = WM8510_BCLKDIV_8;
+		break;
+
+	default:
+		pr_warning("playpaq_wm8510: Unsupported sample rate %d\n",
+			   params_rate(params));
+		return -EINVAL;
+	}
+
+
+	/*
+	 * set CPU and CODEC DAI configuration
+	 */
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: "
+			   "Failed to set CODEC DAI format (%d)\n",
+			   ret);
+		return ret;
+	}
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: "
+			   "Failed to set CPU DAI format (%d)\n",
+			   ret);
+		return ret;
+	}
+
+
+	/*
+	 * Set CPU clock configuration
+	 */
+#if defined CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE
+	cd = playpaq_wm8510_calc_ssc_clock(params, cpu_dai);
+	pr_debug("playpaq_wm8510: cmr_div = %d, period = %d\n",
+		 cd.cmr_div, cd.period);
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, AT32_SSC_CMR_DIV, cd.cmr_div);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: Failed to set CPU CMR_DIV (%d)\n",
+			   ret);
+		return ret;
+	}
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, AT32_SSC_TCMR_PERIOD,
+					  cd.period);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: "
+			   "Failed to set CPU transmit period (%d)\n",
+			   ret);
+		return ret;
+	}
+#endif /* CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE */
+
+
+	/*
+	 * Set CODEC clock configuration
+	 */
+	pr_debug("playpaq_wm8510: "
+		 "pll_in = %ld, pll_out = %u, bclk = %x, mclk = %x\n",
+		 clk_get_rate(CODEC_CLK), pll_out, bclk, mclk_div);
+
+
+#if !defined CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8510_BCLKDIV, bclk);
+	if (ret < 0) {
+		pr_warning
+		    ("playpaq_wm8510: Failed to set CODEC DAI BCLKDIV (%d)\n",
+		     ret);
+		return ret;
+	}
+#endif /* CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE */
+
+
+	ret = snd_soc_dai_set_pll(codec_dai, 0,
+					 clk_get_rate(CODEC_CLK), pll_out);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: Failed to set CODEC DAI PLL (%d)\n",
+			   ret);
+		return ret;
+	}
+
+
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8510_MCLKDIV, mclk_div);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: Failed to set CODEC MCLKDIV (%d)\n",
+			   ret);
+		return ret;
+	}
+
+
+	return 0;
+}
+
+
+
+static struct snd_soc_ops playpaq_wm8510_ops = {
+	.hw_params = playpaq_wm8510_hw_params,
+};
+
+
+
+static const struct snd_soc_dapm_widget playpaq_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+
+
+static const char *intercon[][3] = {
+	/* speaker connected to SPKOUT */
+	{"Ext Spk", NULL, "SPKOUTP"},
+	{"Ext Spk", NULL, "SPKOUTN"},
+
+	{"Mic Bias", NULL, "Int Mic"},
+	{"MICN", NULL, "Mic Bias"},
+	{"MICP", NULL, "Mic Bias"},
+
+	/* Terminator */
+	{NULL, NULL, NULL},
+};
+
+
+
+static int playpaq_wm8510_init(struct snd_soc_codec *codec)
+{
+	int i;
+
+	/*
+	 * Add DAPM widgets
+	 */
+	for (i = 0; i < ARRAY_SIZE(playpaq_dapm_widgets); i++)
+		snd_soc_dapm_new_control(codec, &playpaq_dapm_widgets[i]);
+
+
+
+	/*
+	 * Setup audio path interconnects
+	 */
+	for (i = 0; intercon[i][0] != NULL; i++) {
+		snd_soc_dapm_connect_input(codec,
+					   intercon[i][0],
+					   intercon[i][1], intercon[i][2]);
+	}
+
+
+	/* always connected pins */
+	snd_soc_dapm_enable_pin(codec, "Int Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	snd_soc_dapm_sync(codec);
+
+
+
+	/* Make CSB show PLL rate */
+	snd_soc_dai_set_clkdiv(codec->dai, WM8510_OPCLKDIV,
+				       WM8510_OPCLKDIV_1 | 4);
+
+	return 0;
+}
+
+
+
+static struct snd_soc_dai_link playpaq_wm8510_dai = {
+	.name = "WM8510",
+	.stream_name = "WM8510 PCM",
+	.cpu_dai = &at32_ssc_dai[0],
+	.codec_dai = &wm8510_dai,
+	.init = playpaq_wm8510_init,
+	.ops = &playpaq_wm8510_ops,
+};
+
+
+
+static struct snd_soc_machine snd_soc_machine_playpaq = {
+	.name = "LRS_PlayPaq_WM8510",
+	.dai_link = &playpaq_wm8510_dai,
+	.num_links = 1,
+};
+
+
+
+static struct wm8510_setup_data playpaq_wm8510_setup = {
+	.i2c_address = 0x1a,
+};
+
+
+
+static struct snd_soc_device playpaq_wm8510_snd_devdata = {
+	.machine = &snd_soc_machine_playpaq,
+	.platform = &at32_soc_platform,
+	.codec_dev = &soc_codec_dev_wm8510,
+	.codec_data = &playpaq_wm8510_setup,
+};
+
+static struct platform_device *playpaq_snd_device;
+
+
+static int __init playpaq_asoc_init(void)
+{
+	int ret = 0;
+	struct at32_ssc_info *ssc_p = playpaq_wm8510_dai.cpu_dai->private_data;
+	struct ssc_device *ssc = NULL;
+
+
+	/*
+	 * Request SSC device
+	 */
+	ssc = ssc_request(0);
+	if (IS_ERR(ssc)) {
+		ret = PTR_ERR(ssc);
+		ssc = NULL;
+		goto err_ssc;
+	}
+	ssc_p->ssc = ssc;
+
+
+	/*
+	 * Configure MCLK for WM8510
+	 */
+	_gclk0 = clk_get(NULL, "gclk0");
+	if (IS_ERR(_gclk0)) {
+		_gclk0 = NULL;
+		goto err_gclk0;
+	}
+	_pll0 = clk_get(NULL, "pll0");
+	if (IS_ERR(_pll0)) {
+		_pll0 = NULL;
+		goto err_pll0;
+	}
+	if (clk_set_parent(_gclk0, _pll0)) {
+		pr_warning("snd-soc-playpaq: "
+			   "Failed to set PLL0 as parent for DAC clock\n");
+		goto err_set_clk;
+	}
+	clk_set_rate(CODEC_CLK, 12000000);
+	clk_enable(CODEC_CLK);
+
+#if defined CONFIG_AT32_ENHANCED_PORTMUX
+	at32_select_periph(MCLK_PIN, MCLK_PERIPH, 0);
+#endif
+
+
+	/*
+	 * Create and register platform device
+	 */
+	playpaq_snd_device = platform_device_alloc("soc-audio", 0);
+	if (playpaq_snd_device == NULL) {
+		ret = -ENOMEM;
+		goto err_device_alloc;
+	}
+
+	platform_set_drvdata(playpaq_snd_device, &playpaq_wm8510_snd_devdata);
+	playpaq_wm8510_snd_devdata.dev = &playpaq_snd_device->dev;
+
+	ret = platform_device_add(playpaq_snd_device);
+	if (ret) {
+		pr_warning("playpaq_wm8510: platform_device_add failed (%d)\n",
+			   ret);
+		goto err_device_add;
+	}
+
+	return 0;
+
+
+err_device_add:
+	if (playpaq_snd_device != NULL) {
+		platform_device_put(playpaq_snd_device);
+		playpaq_snd_device = NULL;
+	}
+err_device_alloc:
+err_set_clk:
+	if (_pll0 != NULL) {
+		clk_put(_pll0);
+		_pll0 = NULL;
+	}
+err_pll0:
+	if (_gclk0 != NULL) {
+		clk_put(_gclk0);
+		_gclk0 = NULL;
+	}
+err_gclk0:
+	if (ssc != NULL) {
+		ssc_free(ssc);
+		ssc = NULL;
+	}
+err_ssc:
+	return ret;
+}
+
+
+static void __exit playpaq_asoc_exit(void)
+{
+	struct at32_ssc_info *ssc_p = playpaq_wm8510_dai.cpu_dai->private_data;
+	struct ssc_device *ssc;
+
+	if (ssc_p != NULL) {
+		ssc = ssc_p->ssc;
+		if (ssc != NULL)
+			ssc_free(ssc);
+		ssc_p->ssc = NULL;
+	}
+
+	if (_gclk0 != NULL) {
+		clk_put(_gclk0);
+		_gclk0 = NULL;
+	}
+	if (_pll0 != NULL) {
+		clk_put(_pll0);
+		_pll0 = NULL;
+	}
+
+#if defined CONFIG_AT32_ENHANCED_PORTMUX
+	at32_free_pin(MCLK_PIN);
+#endif
+
+	platform_device_unregister(playpaq_snd_device);
+	playpaq_snd_device = NULL;
+}
+
+module_init(playpaq_asoc_init);
+module_exit(playpaq_asoc_exit);
+
+MODULE_AUTHOR("Geoffrey Wossum <gwossum@acm.org>");
+MODULE_DESCRIPTION("ASoC machine driver for LRS PlayPaq");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
new file mode 100644
index 0000000..6b1aa3a
--- /dev/null
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -0,0 +1,328 @@
+/*
+ * sam9g20_wm8731  --  SoC audio for AT91SAM9G20-based
+ * 			ATMEL AT91SAM9G20ek board.
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2008 Atmel
+ *
+ * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *
+ * Based on ati_b1_wm8731.c by:
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Copyright 2006 Endrelia Technologies Inc.
+ * Based on corgi.c by:
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Copyright 2005 Openedhand Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#include <linux/atmel-ssc.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+
+#include "../codecs/wm8731.h"
+#include "atmel-pcm.h"
+#include "atmel_ssc_dai.h"
+
+
+static int at91sam9g20ek_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	int ret;
+
+	/* codec system clock is supplied by PCK0, set to 12MHz */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
+		12000000, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void at91sam9g20ek_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+
+	dev_dbg(rtd->socdev->dev, "shutdown");
+}
+
+static int at91sam9g20ek_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct atmel_ssc_info *ssc_p = cpu_dai->private_data;
+	struct ssc_device *ssc = ssc_p->ssc;
+	int ret;
+
+	unsigned int rate;
+	int cmr_div, period;
+
+	if (ssc == NULL) {
+		printk(KERN_INFO "at91sam9g20ek_hw_params: ssc is NULL!\n");
+		return -EINVAL;
+	}
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The SSC clock dividers depend on the sample rate.  The CMR.DIV
+	 * field divides the system master clock MCK to drive the SSC TK
+	 * signal which provides the codec BCLK.  The TCMR.PERIOD and
+	 * RCMR.PERIOD fields further divide the BCLK signal to drive
+	 * the SSC TF and RF signals which provide the codec DACLRC and
+	 * ADCLRC clocks.
+	 *
+	 * The dividers were determined through trial and error, where a
+	 * CMR.DIV value is chosen such that the resulting BCLK value is
+	 * divisible, or almost divisible, by (2 * sample rate), and then
+	 * the TCMR.PERIOD or RCMR.PERIOD is BCLK / (2 * sample rate) - 1.
+	 */
+	rate = params_rate(params);
+
+	switch (rate) {
+	case 8000:
+		cmr_div = 55;	/* BCLK = 133MHz/(2*55) = 1.209MHz */
+		period = 74;	/* LRC = BCLK/(2*(74+1)) ~= 8060,6Hz */
+		break;
+	case 11025:
+		cmr_div = 67;	/* BCLK = 133MHz/(2*60) = 1.108MHz */
+		period = 45;	/* LRC = BCLK/(2*(49+1)) = 11083,3Hz */
+		break;
+	case 16000:
+		cmr_div = 63;	/* BCLK = 133MHz/(2*63) = 1.055MHz */
+		period = 32;	/* LRC = BCLK/(2*(32+1)) = 15993,2Hz */
+		break;
+	case 22050:
+		cmr_div = 52;	/* BCLK = 133MHz/(2*52) = 1.278MHz */
+		period = 28;	/* LRC = BCLK/(2*(28+1)) = 22049Hz */
+		break;
+	case 32000:
+		cmr_div = 66;	/* BCLK = 133MHz/(2*66) = 1.007MHz */
+		period = 15;	/* LRC = BCLK/(2*(15+1)) = 31486,742Hz */
+		break;
+	case 44100:
+		cmr_div = 29;	/* BCLK = 133MHz/(2*29) = 2.293MHz */
+		period = 25;	/* LRC = BCLK/(2*(25+1)) = 44098Hz */
+		break;
+	case 48000:
+		cmr_div = 33;	/* BCLK = 133MHz/(2*33) = 2.015MHz */
+		period = 20;	/* LRC = BCLK/(2*(20+1)) = 47979,79Hz */
+		break;
+	case 88200:
+		cmr_div = 29;	/* BCLK = 133MHz/(2*29) = 2.293MHz */
+		period = 12;	/* LRC = BCLK/(2*(12+1)) = 88196Hz */
+		break;
+	case 96000:
+		cmr_div = 23;	/* BCLK = 133MHz/(2*23) = 2.891MHz */
+		period = 14;	/* LRC = BCLK/(2*(14+1)) = 96376Hz */
+		break;
+	default:
+		printk(KERN_WARNING "unsupported rate %d"
+				" on at91sam9g20ek board\n", rate);
+		return -EINVAL;
+	}
+
+	/* set the MCK divider for BCLK */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, ATMEL_SSC_CMR_DIV, cmr_div);
+	if (ret < 0)
+		return ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* set the BCLK divider for DACLRC */
+		ret = snd_soc_dai_set_clkdiv(cpu_dai,
+						ATMEL_SSC_TCMR_PERIOD, period);
+	} else {
+		/* set the BCLK divider for ADCLRC */
+		ret = snd_soc_dai_set_clkdiv(cpu_dai,
+						ATMEL_SSC_RCMR_PERIOD, period);
+	}
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops at91sam9g20ek_ops = {
+	.startup = at91sam9g20ek_startup,
+	.hw_params = at91sam9g20ek_hw_params,
+	.shutdown = at91sam9g20ek_shutdown,
+};
+
+
+static const struct snd_soc_dapm_widget at91sam9g20ek_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+
+	/* speaker connected to LHPOUT */
+	{"Ext Spk", NULL, "LHPOUT"},
+
+	/* mic is connected to Mic Jack, with WM8731 Mic Bias */
+	{"MICIN", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Int Mic"},
+};
+
+/*
+ * Logic for a wm8731 as connected on a at91sam9g20ek board.
+ */
+static int at91sam9g20ek_wm8731_init(struct snd_soc_codec *codec)
+{
+	printk(KERN_DEBUG
+			"at91sam9g20ek_wm8731 "
+			": at91sam9g20ek_wm8731_init() called\n");
+
+	/* Add specific widgets */
+	snd_soc_dapm_new_controls(codec, at91sam9g20ek_dapm_widgets,
+				  ARRAY_SIZE(at91sam9g20ek_dapm_widgets));
+	/* Set up specific audio path interconnects */
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+
+	/* not connected */
+	snd_soc_dapm_disable_pin(codec, "RLINEIN");
+	snd_soc_dapm_disable_pin(codec, "LLINEIN");
+
+	/* always connected */
+	snd_soc_dapm_enable_pin(codec, "Int Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link at91sam9g20ek_dai = {
+	.name = "WM8731",
+	.stream_name = "WM8731 PCM",
+	.cpu_dai = &atmel_ssc_dai[0],
+	.codec_dai = &wm8731_dai,
+	.init = at91sam9g20ek_wm8731_init,
+	.ops = &at91sam9g20ek_ops,
+};
+
+static struct snd_soc_machine snd_soc_machine_at91sam9g20ek = {
+	.name = "WM8731",
+	.dai_link = &at91sam9g20ek_dai,
+	.num_links = 1,
+};
+
+static struct wm8731_setup_data at91sam9g20ek_wm8731_setup = {
+	.i2c_address = 0x1b,
+};
+
+static struct snd_soc_device at91sam9g20ek_snd_devdata = {
+	.machine = &snd_soc_machine_at91sam9g20ek,
+	.platform = &atmel_soc_platform,
+	.codec_dev = &soc_codec_dev_wm8731,
+	.codec_data = &at91sam9g20ek_wm8731_setup,
+};
+
+static struct platform_device *at91sam9g20ek_snd_device;
+
+static int __init at91sam9g20ek_init(void)
+{
+	struct atmel_ssc_info *ssc_p = at91sam9g20ek_dai.cpu_dai->private_data;
+	struct ssc_device *ssc = NULL;
+	int ret;
+
+	/*
+	 * Request SSC device
+	 */
+	ssc = ssc_request(0);
+	if (IS_ERR(ssc)) {
+		ret = PTR_ERR(ssc);
+		ssc = NULL;
+		goto err_ssc;
+	}
+	ssc_p->ssc = ssc;
+
+	at91sam9g20ek_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!at91sam9g20ek_snd_device) {
+		printk(KERN_DEBUG
+				"platform device allocation failed\n");
+		ret = -ENOMEM;
+	}
+
+	platform_set_drvdata(at91sam9g20ek_snd_device,
+			&at91sam9g20ek_snd_devdata);
+	at91sam9g20ek_snd_devdata.dev = &at91sam9g20ek_snd_device->dev;
+
+	ret = platform_device_add(at91sam9g20ek_snd_device);
+	if (ret) {
+		printk(KERN_DEBUG
+				"platform device allocation failed\n");
+		platform_device_put(at91sam9g20ek_snd_device);
+	}
+
+	return ret;
+
+err_ssc:
+	return ret;
+}
+
+static void __exit at91sam9g20ek_exit(void)
+{
+	struct atmel_ssc_info *ssc_p = at91sam9g20ek_dai.cpu_dai->private_data;
+	struct ssc_device *ssc;
+
+	if (ssc_p != NULL) {
+		ssc = ssc_p->ssc;
+		if (ssc != NULL)
+			ssc_free(ssc);
+		ssc_p->ssc = NULL;
+	}
+
+	platform_device_unregister(at91sam9g20ek_snd_device);
+	at91sam9g20ek_snd_device = NULL;
+}
+
+module_init(at91sam9g20ek_init);
+module_exit(at91sam9g20ek_exit);
+
+/* Module information */
+MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
+MODULE_DESCRIPTION("ALSA SoC AT91SAM9G20EK_WM8731");
+MODULE_LICENSE("GPL");
