From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v5 2/3] ASoC: Add HP iPAQ RX1950 support
Date: Sun, 29 Aug 2010 21:53:46 +0300
Message-ID: <1283108026-16903-1-git-send-email-anarsoul@gmail.com>
References: <201008291939.39530.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 23BCC103801
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 20:54:10 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2760130eyd.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2010 11:54:09 -0700 (PDT)
In-Reply-To: <201008291939.39530.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, marek.vasut
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/s3c24xx/Kconfig          |    8 +
 sound/soc/s3c24xx/Makefile         |    2 +
 sound/soc/s3c24xx/rx1950_uda1380.c |  335 ++++++++++++++++++++++++++++++++++++
 3 files changed, 345 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/s3c24xx/rx1950_uda1380.c

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 1cdc37bd..7d8235d 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -118,6 +118,14 @@ config SND_S3C24XX_SOC_SIMTEC_HERMES
 	select SND_SOC_TLV320AIC3X
 	select SND_S3C24XX_SOC_SIMTEC
 
+config SND_S3C24XX_SOC_RX1950_UDA1380
+	tristate "Audio support for the HP iPAQ RX1950"
+	depends on SND_S3C24XX_SOC && MACH_RX1950
+	select SND_S3C24XX_SOC_I2S
+	select SND_SOC_UDA1380
+	help
+	  This driver provides audio support for HP iPAQ RX1950 PDA.
+
 config SND_SOC_SMDK_WM9713
 	tristate "SoC AC97 Audio support for SMDK with WM9713"
 	depends on SND_S3C24XX_SOC && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 47ed6d7..dd412a9 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -27,6 +27,7 @@ snd-soc-s3c24xx-uda134x-objs := s3c24xx_uda134x.o
 snd-soc-s3c24xx-simtec-objs := s3c24xx_simtec.o
 snd-soc-s3c24xx-simtec-hermes-objs := s3c24xx_simtec_hermes.o
 snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
+snd-soc-rx1950-uda1380-objs := rx1950_uda1380.o
 snd-soc-smdk64xx-wm8580-objs := smdk64xx_wm8580.o
 snd-soc-smdk-wm9713-objs := smdk_wm9713.o
 snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
@@ -42,6 +43,7 @@ obj-$(CONFIG_SND_S3C24XX_SOC_S3C24XX_UDA134X) += snd-soc-s3c24xx-uda134x.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC) += snd-soc-s3c24xx-simtec.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
+obj-$(CONFIG_SND_S3C24XX_SOC_RX1950_UDA1380) += snd-soc-rx1950-uda1380.o
 obj-$(CONFIG_SND_S3C64XX_SOC_WM8580) += snd-soc-smdk64xx-wm8580.o
 obj-$(CONFIG_SND_SOC_SMDK_WM9713) += snd-soc-smdk-wm9713.o
 obj-$(CONFIG_SND_S3C64XX_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
diff --git a/sound/soc/s3c24xx/rx1950_uda1380.c b/sound/soc/s3c24xx/rx1950_uda1380.c
new file mode 100644
index 0000000..2a16113
--- /dev/null
+++ b/sound/soc/s3c24xx/rx1950_uda1380.c
@@ -0,0 +1,335 @@
+/*
+ * rx1950.c  --  ALSA Soc Audio Layer
+ *
+ * Copyright (c) 2010 Vasily Khoruzhick <anarsoul@gmail.com>
+ *
+ * Based on smdk2440.c and magician.c
+ *
+ * Authors: Graeme Gregory graeme.gregory@wolfsonmicro.com
+ *          Philipp Zabel <philipp.zabel@gmail.com>
+ *          Denis Grigoriev <dgreenday@gmail.com>
+ *          Vasily Khoruzhick <anarsoul@gmail.com>
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
+#include <linux/timer.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/clk.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/uda1380.h>
+#include <sound/jack.h>
+
+#include <plat/regs-iis.h>
+
+#include <mach/regs-clock.h>
+
+#include "s3c-dma.h"
+#include "s3c24xx-i2s.h"
+#include "../codecs/uda1380.h"
+
+static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd);
+static int rx1950_startup(struct snd_pcm_substream *substream);
+static int rx1950_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params);
+static int rx1950_spk_power(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event);
+
+static unsigned int rates[] = {
+	16000,
+	44100,
+	48000,
+	88200,
+};
+
+static struct snd_pcm_hw_constraint_list hw_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list = rates,
+	.mask = 0,
+};
+
+static struct snd_soc_jack hp_jack;
+
+static struct snd_soc_jack_pin hp_jack_pins[] = {
+	{
+		.pin	= "Headphone Jack",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Speaker",
+		.mask	= SND_JACK_HEADPHONE,
+		.invert	= 1,
+	},
+};
+
+static struct snd_soc_jack_gpio hp_jack_gpios[] = {
+	[0] = {
+		.gpio			= S3C2410_GPG(12),
+		.name			= "hp-gpio",
+		.report			= SND_JACK_HEADPHONE,
+		.invert			= 1,
+		.debounce_time		= 200,
+	},
+};
+
+static struct snd_soc_ops rx1950_ops = {
+	.startup	= rx1950_startup,
+	.hw_params	= rx1950_hw_params,
+};
+
+/* s3c24xx digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link rx1950_uda1380_dai[] = {
+	{
+		.name		= "uda1380",
+		.stream_name	= "UDA1380 Duplex",
+		.cpu_dai_name	= "s3c24xx-iis",
+		.codec_dai_name	= "uda1380-hifi",
+		.init		= rx1950_uda1380_init,
+		.platform_name	= "s3c24xx-pcm-audio",
+		.codec_name	= "uda1380-codec.0-001a",
+		.ops		= &rx1950_ops,
+	},
+};
+
+static struct snd_soc_card rx1950_asoc = {
+	.name = "rx1950",
+	.dai_link = rx1950_uda1380_dai,
+	.num_links = ARRAY_SIZE(rx1950_uda1380_dai),
+};
+
+/* rx1950 machine dapm widgets */
+static const struct snd_soc_dapm_widget uda1380_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_SPK("Speaker", rx1950_spk_power),
+};
+
+/* rx1950 machine audio_map */
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* headphone connected to VOUTLHP, VOUTRHP */
+	{"Headphone Jack", NULL, "VOUTLHP"},
+	{"Headphone Jack", NULL, "VOUTRHP"},
+
+	/* ext speaker connected to VOUTL, VOUTR  */
+	{"Speaker", NULL, "VOUTL"},
+	{"Speaker", NULL, "VOUTR"},
+
+	/* mic is connected to VINM */
+	{"VINM", NULL, "Mic Jack"},
+};
+
+static struct platform_device *s3c24xx_snd_device;
+static struct clk *xtal;
+
+static int rx1950_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw.rate_min = hw_rates.list[0];
+	runtime->hw.rate_max = hw_rates.list[hw_rates.count - 1];
+	runtime->hw.rates = SNDRV_PCM_RATE_KNOT;
+
+	return snd_pcm_hw_constraint_list(runtime, 0,
+					SNDRV_PCM_HW_PARAM_RATE,
+					&hw_rates);
+}
+
+static int rx1950_spk_power(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		gpio_set_value(S3C2410_GPA(1), 1);
+	else
+		gpio_set_value(S3C2410_GPA(1), 0);
+
+	return 0;
+}
+
+static int rx1950_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int div;
+	int ret;
+	unsigned int rate = params_rate(params);
+	int clk_source, fs_mode;
+
+	switch (rate) {
+	case 16000:
+	case 48000:
+		clk_source = S3C24XX_CLKSRC_PCLK;
+		fs_mode = S3C2410_IISMOD_384FS;
+		div = s3c24xx_i2s_get_clockrate() / (384 * rate);
+		if (s3c24xx_i2s_get_clockrate() % (384 * rate) > (182 * rate))
+			div++;
+		break;
+	case 44100:
+	case 88200:
+		clk_source = S3C24XX_CLKSRC_MPLL;
+		fs_mode = S3C2410_IISMOD_256FS;
+		div = clk_get_rate(xtal) / (256 * rate);
+		if (clk_get_rate(xtal) % (256 * rate) > (128 * rate))
+			div++;
+		break;
+	default:
+		printk(KERN_ERR "%s: rate %d is not supported\n",
+			__func__, rate);
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
+	/* select clock source */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, clk_source, rate,
+			SND_SOC_CLOCK_OUT);
+	if (ret < 0)
+		return ret;
+
+	/* set MCLK division for sample rate */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK,
+		S3C2410_IISMOD_384FS);
+	if (ret < 0)
+		return ret;
+
+	/* set BCLK division for sample rate */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_BCLK,
+		S3C2410_IISMOD_32FS);
+	if (ret < 0)
+		return ret;
+
+	/* set prescaler division for sample rate */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
+		S3C24XX_PRESCALE(div, div));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int err;
+
+	/* Add rx1950 specific widgets */
+	err = snd_soc_dapm_new_controls(codec, uda1380_dapm_widgets,
+				  ARRAY_SIZE(uda1380_dapm_widgets));
+
+	if (err)
+		return err;
+
+	/* Set up rx1950 specific audio path audio_mapnects */
+	err = snd_soc_dapm_add_routes(codec, audio_map,
+				      ARRAY_SIZE(audio_map));
+
+	if (err)
+		return err;
+
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Speaker");
+
+	snd_soc_dapm_sync(codec);
+
+	snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE,
+		&hp_jack);
+
+	snd_soc_jack_add_pins(&hp_jack, ARRAY_SIZE(hp_jack_pins),
+		hp_jack_pins);
+
+	snd_soc_jack_add_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
+		hp_jack_gpios);
+
+	return 0;
+}
+
+static int __init rx1950_init(void)
+{
+	int ret;
+
+	/* configure some gpios */
+	ret = gpio_request(S3C2410_GPA(1), "speaker-power");
+	if (ret)
+		goto err_gpio;
+
+	ret = gpio_direction_output(S3C2410_GPA(1), 0);
+	if (ret)
+		goto err_gpio_conf;
+
+	s3c24xx_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!s3c24xx_snd_device) {
+		ret = -ENOMEM;
+		goto err_plat_alloc;
+	}
+
+	platform_set_drvdata(s3c24xx_snd_device, &rx1950_asoc);
+	ret = platform_device_add(s3c24xx_snd_device);
+
+	if (ret) {
+		platform_device_put(s3c24xx_snd_device);
+		goto err_plat_add;
+	}
+
+	xtal = clk_get(&s3c24xx_snd_device->dev, "xtal");
+
+	if (IS_ERR(xtal)) {
+		ret = PTR_ERR(xtal);
+		platform_device_unregister(s3c24xx_snd_device);
+		goto err_clk;
+	}
+
+	return 0;
+
+err_clk:
+err_plat_add:
+err_plat_alloc:
+err_gpio_conf:
+	gpio_free(S3C2410_GPA(1));
+
+err_gpio:
+	return ret;
+}
+
+static void __exit rx1950_exit(void)
+{
+	platform_device_unregister(s3c24xx_snd_device);
+	snd_soc_jack_free_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
+		hp_jack_gpios);
+	clk_put(xtal);
+	gpio_free(S3C2410_GPA(1));
+}
+
+module_init(rx1950_init);
+module_exit(rx1950_exit);
+
+/* Module information */
+MODULE_AUTHOR("Vasily Khoruzhick");
+MODULE_DESCRIPTION("ALSA SoC RX1950");
+MODULE_LICENSE("GPL");
-- 
1.7.2
