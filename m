From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] ASoC: Add HP iPAQ H1940 support
Date: Sun, 12 Sep 2010 13:55:09 +0300
Message-ID: <1284288909-5961-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E8337246B9
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Sep 2010 12:57:07 +0200 (CEST)
Received: by eye27 with SMTP id 27so1381131eye.38
	for <alsa-devel@alsa-project.org>; Sun, 12 Sep 2010 03:57:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel <alsa-devel@alsa-project.org>, Ben Dooks <ben-linux@fluff.org>, Arnaud Patard (Rt
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch depends on gpiolib support for h1940 latch access,
here's link to patch in ml archive:

http://www.spinics.net/lists/arm-kernel/msg98042.html

I hope Ben will find some time to merge it into his tree
before 2.6.37 merge window :)

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Tested-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---
 sound/soc/s3c24xx/Kconfig         |    8 +
 sound/soc/s3c24xx/Makefile        |    2 +
 sound/soc/s3c24xx/h1940_uda1380.c |  296 +++++++++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/s3c24xx/h1940_uda1380.c

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 7d8235d..6b50509 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -118,6 +118,14 @@ config SND_S3C24XX_SOC_SIMTEC_HERMES
 	select SND_SOC_TLV320AIC3X
 	select SND_S3C24XX_SOC_SIMTEC
 
+config SND_S3C24XX_SOC_H1940_UDA1380
+	tristate "Audio support for the HP iPAQ H1940"
+	depends on SND_S3C24XX_SOC && ARCH_H1940
+	select SND_S3C24XX_SOC_I2S
+	select SND_SOC_UDA1380
+	help
+	  This driver provides audio support for HP iPAQ h1940 PDA.
+
 config SND_S3C24XX_SOC_RX1950_UDA1380
 	tristate "Audio support for the HP iPAQ RX1950"
 	depends on SND_S3C24XX_SOC && MACH_RX1950
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index dd412a9..33a7c68 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -28,6 +28,7 @@ snd-soc-s3c24xx-simtec-objs := s3c24xx_simtec.o
 snd-soc-s3c24xx-simtec-hermes-objs := s3c24xx_simtec_hermes.o
 snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
 snd-soc-rx1950-uda1380-objs := rx1950_uda1380.o
+snd-soc-h1940-uda1380-objs := h1940_uda1380.o
 snd-soc-smdk64xx-wm8580-objs := smdk64xx_wm8580.o
 snd-soc-smdk-wm9713-objs := smdk_wm9713.o
 snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
@@ -44,6 +45,7 @@ obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC) += snd-soc-s3c24xx-simtec.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
 obj-$(CONFIG_SND_S3C24XX_SOC_RX1950_UDA1380) += snd-soc-rx1950-uda1380.o
+obj-$(CONFIG_SND_S3C24XX_SOC_H1940_UDA1380) += snd-soc-h1940-uda1380.o
 obj-$(CONFIG_SND_S3C64XX_SOC_WM8580) += snd-soc-smdk64xx-wm8580.o
 obj-$(CONFIG_SND_SOC_SMDK_WM9713) += snd-soc-smdk-wm9713.o
 obj-$(CONFIG_SND_S3C64XX_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
diff --git a/sound/soc/s3c24xx/h1940_uda1380.c b/sound/soc/s3c24xx/h1940_uda1380.c
new file mode 100644
index 0000000..77550fa
--- /dev/null
+++ b/sound/soc/s3c24xx/h1940_uda1380.c
@@ -0,0 +1,296 @@
+/*
+ * h1940-uda1380.c  --  ALSA Soc Audio Layer
+ *
+ * Copyright (c) 2010 Arnaud Patard <arnaud.patard@rtp-net.org>
+ * Copyright (c) 2010 Vasily Khoruzhick <anarsoul@gmail.com>
+ *
+ * Based on version from Arnaud Patard <arnaud.patard@rtp-net.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/uda1380.h>
+#include <sound/jack.h>
+
+#include <plat/regs-iis.h>
+
+#include <mach/h1940-latch.h>
+
+#include <asm/mach-types.h>
+
+#include "s3c-dma.h"
+#include "s3c24xx-i2s.h"
+#include "../codecs/uda1380.h"
+
+static unsigned int rates[] = {
+	11025,
+	22050,
+	44100,
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
+	{
+		.gpio			= S3C2410_GPG(4),
+		.name			= "hp-gpio",
+		.report			= SND_JACK_HEADPHONE,
+		.invert			= 1,
+		.debounce_time		= 200,
+	},
+};
+
+static int h1940_startup(struct snd_pcm_substream *substream)
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
+static int h1940_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int div;
+	int ret;
+	unsigned int rate = params_rate(params);
+
+	switch (rate) {
+	case 11025:
+	case 22050:
+	case 44100:
+		div = s3c24xx_i2s_get_clockrate() / (384 * rate);
+		if (s3c24xx_i2s_get_clockrate() % (384 * rate) > (192 * rate))
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
+	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C24XX_CLKSRC_PCLK, rate,
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
+static struct snd_soc_ops h1940_ops = {
+	.startup	= h1940_startup,
+	.hw_params	= h1940_hw_params,
+};
+
+static int h1940_spk_power(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		gpio_set_value(H1940_LATCH_AUDIO_POWER, 1);
+	else
+		gpio_set_value(H1940_LATCH_AUDIO_POWER, 0);
+
+	return 0;
+}
+
+/* h1940 machine dapm widgets */
+static const struct snd_soc_dapm_widget uda1380_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_SPK("Speaker", h1940_spk_power),
+};
+
+/* h1940 machine audio_map */
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
+
+static int h1940_uda1380_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int err;
+
+	/* Add h1940 specific widgets */
+	err = snd_soc_dapm_new_controls(codec, uda1380_dapm_widgets,
+				  ARRAY_SIZE(uda1380_dapm_widgets));
+	if (err)
+		return err;
+
+	/* Set up h1940 specific audio path audio_mapnects */
+	err = snd_soc_dapm_add_routes(codec, audio_map,
+				      ARRAY_SIZE(audio_map));
+	if (err)
+		return err;
+
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Speaker");
+	snd_soc_dapm_enable_pin(codec, "Mic Jack");
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
+/* s3c24xx digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link h1940_uda1380_dai[] = {
+	{
+		.name		= "uda1380",
+		.stream_name	= "UDA1380 Duplex",
+		.cpu_dai_name	= "s3c24xx-iis",
+		.codec_dai_name	= "uda1380-hifi",
+		.init		= h1940_uda1380_init,
+		.platform_name	= "s3c24xx-pcm-audio",
+		.codec_name	= "uda1380-codec.0-001a",
+		.ops		= &h1940_ops,
+	},
+};
+
+static struct snd_soc_card h1940_asoc = {
+	.name = "h1940",
+	.dai_link = h1940_uda1380_dai,
+	.num_links = ARRAY_SIZE(h1940_uda1380_dai),
+};
+
+static int __init h1940_init(void)
+{
+	int ret;
+
+	if (!machine_is_h1940())
+		return -ENODEV;
+
+	/* configure some gpios */
+	ret = gpio_request(H1940_LATCH_AUDIO_POWER, "speaker-power");
+	if (ret)
+		goto err_out;
+
+	ret = gpio_direction_output(H1940_LATCH_AUDIO_POWER, 0);
+	if (ret)
+		goto err_gpio;
+
+	s3c24xx_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!s3c24xx_snd_device) {
+		ret = -ENOMEM;
+		goto err_gpio;
+	}
+
+	platform_set_drvdata(s3c24xx_snd_device, &h1940_asoc);
+	ret = platform_device_add(s3c24xx_snd_device);
+
+	if (ret)
+		goto err_plat;
+
+	return 0;
+
+err_plat:
+	platform_device_put(s3c24xx_snd_device);
+err_gpio:
+	gpio_free(H1940_LATCH_AUDIO_POWER);
+
+err_out:
+	return ret;
+}
+
+static void __exit h1940_exit(void)
+{
+	platform_device_unregister(s3c24xx_snd_device);
+	snd_soc_jack_free_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
+		hp_jack_gpios);
+	gpio_free(H1940_LATCH_AUDIO_POWER);
+}
+
+module_init(h1940_init);
+module_exit(h1940_exit);
+
+/* Module information */
+MODULE_AUTHOR("Arnaud Patard, Vasily Khoruzhick");
+MODULE_DESCRIPTION("ALSA SoC H1940");
+MODULE_LICENSE("GPL");
-- 
1.7.2.2
