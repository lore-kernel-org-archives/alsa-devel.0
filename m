From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 02/25] ASoC: Samsung: Remove redundant AQUILA
	driver
Date: Tue, 19 Oct 2010 16:05:03 +0900
Message-ID: <1287471903-25452-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id DB6D410387A
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:12:35 +0200 (CEST)
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

AQUILA and GONI are essentially the same h/w w.r.t ASoC.
They only differ by the fact that GONI has stereo speaker-out
whereas AQUILA has mono.

The difference can easily be handled in the same MACHINE driver
by making machine-specific runtime changes.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig         |   17 +--
 sound/soc/s3c24xx/Makefile        |    4 +-
 sound/soc/s3c24xx/aquila_wm8994.c |  295 -------------------------------------
 sound/soc/s3c24xx/goni_wm8994.c   |   19 +++-
 4 files changed, 23 insertions(+), 312 deletions(-)
 delete mode 100644 sound/soc/s3c24xx/aquila_wm8994.c

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 8a6b53c..6efdf65 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -144,22 +144,13 @@ config SND_S3C64XX_SOC_SMARTQ
 	select SND_S3C64XX_SOC_I2S
 	select SND_SOC_WM8750
 
-config SND_S5PC110_SOC_AQUILA_WM8994
-	tristate "SoC I2S Audio support for AQUILA - WM8994"
-	depends on SND_S3C24XX_SOC && MACH_AQUILA
+config SND_SOC_GONI_AQUILA_WM8994
+	tristate "SoC I2S Audio support for AQUILA/GONI - WM8994"
+	depends on SND_S3C24XX_SOC && (MACH_GONI || MACH_AQUILA)
 	select SND_S3C64XX_SOC_I2S_V4
 	select SND_SOC_WM8994
 	help
-	  Say Y if you want to add support for SoC audio on aquila
-	  with the WM8994.
-
-config SND_S5PV210_SOC_GONI_WM8994
-	tristate "SoC I2S Audio support for GONI - WM8994"
-	depends on SND_S3C24XX_SOC && MACH_GONI
-	select SND_S3C64XX_SOC_I2S_V4
-	select SND_SOC_WM8994
-	help
-	  Say Y if you want to add support for SoC audio on goni
+	  Say Y if you want to add support for SoC audio on goni or aquila
 	  with the WM8994.
 
 config SND_SOC_SMDK_SPDIF
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index ee8f41d..4e232f1 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -33,7 +33,6 @@ snd-soc-rx1950-uda1380-objs := rx1950_uda1380.o
 snd-soc-smdk64xx-wm8580-objs := smdk64xx_wm8580.o
 snd-soc-smdk-wm9713-objs := smdk_wm9713.o
 snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
-snd-soc-aquila-wm8994-objs := aquila_wm8994.o
 snd-soc-goni-wm8994-objs := goni_wm8994.o
 snd-soc-smdk-spdif-objs := smdk_spdif.o
 
@@ -50,6 +49,5 @@ obj-$(CONFIG_SND_S3C24XX_SOC_RX1950_UDA1380) += snd-soc-rx1950-uda1380.o
 obj-$(CONFIG_SND_S3C64XX_SOC_WM8580) += snd-soc-smdk64xx-wm8580.o
 obj-$(CONFIG_SND_SOC_SMDK_WM9713) += snd-soc-smdk-wm9713.o
 obj-$(CONFIG_SND_S3C64XX_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
-obj-$(CONFIG_SND_S5PC110_SOC_AQUILA_WM8994) += snd-soc-aquila-wm8994.o
-obj-$(CONFIG_SND_S5PV210_SOC_GONI_WM8994) += snd-soc-goni-wm8994.o
 obj-$(CONFIG_SND_SOC_SMDK_SPDIF) += snd-soc-smdk-spdif.o
+obj-$(CONFIG_SND_SOC_GONI_AQUILA_WM8994) += snd-soc-goni-wm8994.o
diff --git a/sound/soc/s3c24xx/aquila_wm8994.c b/sound/soc/s3c24xx/aquila_wm8994.c
deleted file mode 100644
index 235d197..0000000
--- a/sound/soc/s3c24xx/aquila_wm8994.c
+++ /dev/null
@@ -1,295 +0,0 @@
-/*
- * aquila_wm8994.c
- *
- * Copyright (C) 2010 Samsung Electronics Co.Ltd
- * Author: Chanwoo Choi <cw00.choi@samsung.com>
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
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-#include <sound/jack.h>
-#include <asm/mach-types.h>
-#include <mach/gpio.h>
-#include <mach/regs-clock.h>
-
-#include <linux/mfd/wm8994/core.h>
-#include <linux/mfd/wm8994/registers.h>
-#include "../codecs/wm8994.h"
-#include "s3c-dma.h"
-#include "s3c64xx-i2s.h"
-
-static struct snd_soc_card aquila;
-static struct platform_device *aquila_snd_device;
-
-/* 3.5 pie jack */
-static struct snd_soc_jack jack;
-
-/* 3.5 pie jack detection DAPM pins */
-static struct snd_soc_jack_pin jack_pins[] = {
-	{
-		.pin = "Headset Mic",
-		.mask = SND_JACK_MICROPHONE,
-	}, {
-		.pin = "Headset Stereophone",
-		.mask = SND_JACK_HEADPHONE | SND_JACK_MECHANICAL |
-			SND_JACK_AVOUT,
-	},
-};
-
-/* 3.5 pie jack detection gpios */
-static struct snd_soc_jack_gpio jack_gpios[] = {
-	{
-		.gpio = S5PV210_GPH0(6),
-		.name = "DET_3.5",
-		.report = SND_JACK_HEADSET | SND_JACK_MECHANICAL |
-			SND_JACK_AVOUT,
-		.debounce_time = 200,
-	},
-};
-
-static const struct snd_soc_dapm_widget aquila_dapm_widgets[] = {
-	SND_SOC_DAPM_SPK("Ext Spk", NULL),
-	SND_SOC_DAPM_SPK("Ext Rcv", NULL),
-	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_MIC("Main Mic", NULL),
-	SND_SOC_DAPM_MIC("2nd Mic", NULL),
-	SND_SOC_DAPM_LINE("Radio In", NULL),
-};
-
-static const struct snd_soc_dapm_route aquila_dapm_routes[] = {
-	{"Ext Spk", NULL, "SPKOUTLP"},
-	{"Ext Spk", NULL, "SPKOUTLN"},
-
-	{"Ext Rcv", NULL, "HPOUT2N"},
-	{"Ext Rcv", NULL, "HPOUT2P"},
-
-	{"Headset Stereophone", NULL, "HPOUT1L"},
-	{"Headset Stereophone", NULL, "HPOUT1R"},
-
-	{"IN1RN", NULL, "Headset Mic"},
-	{"IN1RP", NULL, "Headset Mic"},
-
-	{"IN1RN", NULL, "2nd Mic"},
-	{"IN1RP", NULL, "2nd Mic"},
-
-	{"IN1LN", NULL, "Main Mic"},
-	{"IN1LP", NULL, "Main Mic"},
-
-	{"IN2LN", NULL, "Radio In"},
-	{"IN2RN", NULL, "Radio In"},
-};
-
-static int aquila_wm8994_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	int ret;
-
-	/* add aquila specific widgets */
-	snd_soc_dapm_new_controls(codec, aquila_dapm_widgets,
-			ARRAY_SIZE(aquila_dapm_widgets));
-
-	/* set up aquila specific audio routes */
-	snd_soc_dapm_add_routes(codec, aquila_dapm_routes,
-			ARRAY_SIZE(aquila_dapm_routes));
-
-	/* set endpoints to not connected */
-	snd_soc_dapm_nc_pin(codec, "IN2LP:VXRN");
-	snd_soc_dapm_nc_pin(codec, "IN2RP:VXRP");
-	snd_soc_dapm_nc_pin(codec, "LINEOUT1N");
-	snd_soc_dapm_nc_pin(codec, "LINEOUT1P");
-	snd_soc_dapm_nc_pin(codec, "LINEOUT2N");
-	snd_soc_dapm_nc_pin(codec, "LINEOUT2P");
-	snd_soc_dapm_nc_pin(codec, "SPKOUTRN");
-	snd_soc_dapm_nc_pin(codec, "SPKOUTRP");
-
-	snd_soc_dapm_sync(codec);
-
-	/* Headset jack detection */
-	ret = snd_soc_jack_new(&aquila, "Headset Jack",
-			SND_JACK_HEADSET | SND_JACK_MECHANICAL | SND_JACK_AVOUT,
-			&jack);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_jack_add_pins(&jack, ARRAY_SIZE(jack_pins), jack_pins);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_jack_add_gpios(&jack, ARRAY_SIZE(jack_gpios), jack_gpios);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int aquila_hifi_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	unsigned int pll_out = 24000000;
-	int ret = 0;
-
-	/* set the cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set the cpu system clock */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CLKSRC_PCLK,
-			0, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set the codec FLL */
-	ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL1, 0, pll_out,
-			params_rate(params) * 256);
-	if (ret < 0)
-		return ret;
-
-	/* set the codec system clock */
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8994_SYSCLK_FLL1,
-			params_rate(params) * 256, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static struct snd_soc_ops aquila_hifi_ops = {
-	.hw_params = aquila_hifi_hw_params,
-};
-
-static int aquila_voice_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	unsigned int pll_out = 24000000;
-	int ret = 0;
-
-	if (params_rate(params) != 8000)
-		return -EINVAL;
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_LEFT_J |
-			SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set the codec FLL */
-	ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL2, 0, pll_out,
-			params_rate(params) * 256);
-	if (ret < 0)
-		return ret;
-
-	/* set the codec system clock */
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8994_SYSCLK_FLL2,
-			params_rate(params) * 256, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static struct snd_soc_dai_driver voice_dai = {
-	.name = "aquila-voice-dai",
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-};
-
-static struct snd_soc_ops aquila_voice_ops = {
-	.hw_params = aquila_voice_hw_params,
-};
-
-static struct snd_soc_dai_link aquila_dai[] = {
-{
-	.name = "WM8994",
-	.stream_name = "WM8994 HiFi",
-	.cpu_dai_name = "s3c64xx-i2s-v4",
-	.codec_dai_name = "wm8994-hifi",
-	.platform_name = "s3c24xx-pcm-audio",
-	.codec_name = "wm8994-codec.0-0x1a",
-	.init = aquila_wm8994_init,
-	.ops = &aquila_hifi_ops,
-}, {
-	.name = "WM8994 Voice",
-	.stream_name = "Voice",
-	.cpu_dai_name = "aquila-voice-dai",
-	.codec_dai_name = "wm8994-voice",
-	.platform_name = "s3c24xx-pcm-audio",
-	.codec_name = "wm8994-codec.0-0x1a",
-	.ops = &aquila_voice_ops,
-},
-};
-
-static struct snd_soc_card aquila = {
-	.name = "aquila",
-	.dai_link = aquila_dai,
-	.num_links = ARRAY_SIZE(aquila_dai),
-};
-
-static int __init aquila_init(void)
-{
-	int ret;
-
-	if (!machine_is_aquila())
-		return -ENODEV;
-
-	aquila_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!aquila_snd_device)
-		return -ENOMEM;
-
-	/* register voice DAI here */
-	ret = snd_soc_register_dai(&aquila_snd_device->dev, &voice_dai);
-	if (ret)
-		return ret;
-
-	platform_set_drvdata(aquila_snd_device, &aquila);
-	ret = platform_device_add(aquila_snd_device);
-
-	if (ret)
-		platform_device_put(aquila_snd_device);
-
-	return ret;
-}
-
-static void __exit aquila_exit(void)
-{
-	platform_device_unregister(aquila_snd_device);
-}
-
-module_init(aquila_init);
-module_exit(aquila_exit);
-
-/* Module information */
-MODULE_DESCRIPTION("ALSA SoC WM8994 Aquila(S5PC110)");
-MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/goni_wm8994.c b/sound/soc/s3c24xx/goni_wm8994.c
index 694f702..ef22f14 100644
--- a/sound/soc/s3c24xx/goni_wm8994.c
+++ b/sound/soc/s3c24xx/goni_wm8994.c
@@ -28,6 +28,14 @@
 #include "s3c-dma.h"
 #include "s3c64xx-i2s.h"
 
+#define MACHINE_NAME	0
+#define CPU_VOICE_DAI	1
+
+static const char *aquila_str[] = {
+	[MACHINE_NAME] = "aquila",
+	[CPU_VOICE_DAI] = "aquila-voice-dai",
+};
+
 static struct snd_soc_card goni;
 static struct platform_device *goni_snd_device;
 
@@ -115,6 +123,11 @@ static int goni_wm8994_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(codec, "LINEOUT2N");
 	snd_soc_dapm_nc_pin(codec, "LINEOUT2P");
 
+	if (machine_is_aquila()) {
+		snd_soc_dapm_nc_pin(codec, "SPKOUTRN");
+		snd_soc_dapm_nc_pin(codec, "SPKOUTRP");
+	}
+
 	snd_soc_dapm_sync(codec);
 
 	/* Headset jack detection */
@@ -263,7 +276,11 @@ static int __init goni_init(void)
 {
 	int ret;
 
-	if (!machine_is_goni())
+	if (machine_is_aquila()) {
+		voice_dai.name = aquila_str[CPU_VOICE_DAI];
+		goni_dai[1].cpu_dai_name = aquila_str[CPU_VOICE_DAI];
+		goni.name = aquila_str[MACHINE_NAME];
+	} else if (!machine_is_goni())
 		return -ENODEV;
 
 	goni_snd_device = platform_device_alloc("soc-audio", -1);
-- 
1.6.2.5
