From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 22/25] ASoC: SMDK64XX: Rename for other
	platforms
Date: Tue, 19 Oct 2010 16:08:37 +0900
Message-ID: <1287472117-31115-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 553B910393C
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

We plan to use the same ASoC Machine driver for most of
latest SMDK platforms. So rename the 64XX specific driver
to generic named.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig           |    6 +-
 sound/soc/s3c24xx/Makefile          |    4 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c |  253 -----------------------------------
 sound/soc/s3c24xx/smdk_wm8580.c     |  253 +++++++++++++++++++++++++++++++++++
 4 files changed, 258 insertions(+), 258 deletions(-)
 delete mode 100644 sound/soc/s3c24xx/smdk64xx_wm8580.c
 create mode 100644 sound/soc/s3c24xx/smdk_wm8580.c

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 32f1877..95bdd0d 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -59,13 +59,13 @@ config SND_S3C24XX_SOC_JIVE_WM8750
 	help
 	  Sat Y if you want to add support for SoC audio on the Jive.
 
-config SND_S3C64XX_SOC_WM8580
-	tristate "SoC I2S Audio support for WM8580 on SMDK64XX"
+config SND_SOC_SMDK_WM8580
+	tristate "SoC I2S Audio support for WM8580 on SMDK"
 	depends on SND_S3C24XX_SOC && MACH_SMDK6410
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
 	help
-	  Say Y if you want to add support for SoC audio on the SMDK6410.
+	  Say Y if you want to add support for SoC audio on the SMDKs.
 
 config SND_S3C24XX_SOC_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index dac41ee..7eee57f 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -28,7 +28,7 @@ snd-soc-s3c24xx-simtec-objs := s3c24xx_simtec.o
 snd-soc-s3c24xx-simtec-hermes-objs := s3c24xx_simtec_hermes.o
 snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
 snd-soc-rx1950-uda1380-objs := rx1950_uda1380.o
-snd-soc-smdk64xx-wm8580-objs := smdk64xx_wm8580.o
+snd-soc-smdk-wm8580-objs := smdk_wm8580.o
 snd-soc-smdk-wm9713-objs := smdk_wm9713.o
 snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
 snd-soc-goni-wm8994-objs := goni_wm8994.o
@@ -44,7 +44,7 @@ obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC) += snd-soc-s3c24xx-simtec.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
 obj-$(CONFIG_SND_S3C24XX_SOC_RX1950_UDA1380) += snd-soc-rx1950-uda1380.o
-obj-$(CONFIG_SND_S3C64XX_SOC_WM8580) += snd-soc-smdk64xx-wm8580.o
+obj-$(CONFIG_SND_SOC_SMDK_WM8580) += snd-soc-smdk-wm8580.o
 obj-$(CONFIG_SND_SOC_SMDK_WM9713) += snd-soc-smdk-wm9713.o
 obj-$(CONFIG_SND_S3C64XX_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
 obj-$(CONFIG_SND_SOC_SMDK_SPDIF) += snd-soc-smdk-spdif.o
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
deleted file mode 100644
index 5f51db0..0000000
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ /dev/null
@@ -1,253 +0,0 @@
-/*
- *  smdk64xx_wm8580.c
- *
- *  Copyright (c) 2009 Samsung Electronics Co. Ltd
- *  Author: Jaswinder Singh <jassi.brar@samsung.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-
-#include "../codecs/wm8580.h"
-#include "dma.h"
-#include "i2s.h"
-
-/*
- * Default CFG switch settings to use this driver:
- *
- *   SMDK6410: Set CFG1 1-3 Off, CFG2 1-4 On
- */
-
-/* SMDK64XX has a 12MHZ crystal attached to WM8580 */
-#define SMDK64XX_WM8580_FREQ 12000000
-
-static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	unsigned int pll_out;
-	int bfs, rfs, ret;
-
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_U8:
-	case SNDRV_PCM_FORMAT_S8:
-		bfs = 16;
-		break;
-	case SNDRV_PCM_FORMAT_U16_LE:
-	case SNDRV_PCM_FORMAT_S16_LE:
-		bfs = 32;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* The Fvco for WM8580 PLLs must fall within [90,100]MHz.
-	 * This criterion can't be met if we request PLL output
-	 * as {8000x256, 64000x256, 11025x256}Hz.
-	 * As a wayout, we rather change rfs to a minimum value that
-	 * results in (params_rate(params) * rfs), and itself, acceptable
-	 * to both - the CODEC and the CPU.
-	 */
-	switch (params_rate(params)) {
-	case 16000:
-	case 22050:
-	case 32000:
-	case 44100:
-	case 48000:
-	case 88200:
-	case 96000:
-		rfs = 256;
-		break;
-	case 64000:
-		rfs = 384;
-		break;
-	case 8000:
-	case 11025:
-		rfs = 512;
-		break;
-	default:
-		return -EINVAL;
-	}
-	pll_out = params_rate(params) * rfs;
-
-	/* Set the Codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
-					 | SND_SOC_DAIFMT_NB_NF
-					 | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* Set the AP DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
-					 | SND_SOC_DAIFMT_NB_NF
-					 | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* Set WM8580 to drive MCLK from its PLLA */
-	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_MCLK,
-					WM8580_CLKSRC_PLLA);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 0,
-					SMDK64XX_WM8580_FREQ, pll_out);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8580_CLKSRC_PLLA,
-				     pll_out, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-/*
- * SMDK64XX WM8580 DAI operations.
- */
-static struct snd_soc_ops smdk64xx_ops = {
-	.hw_params = smdk64xx_hw_params,
-};
-
-/* SMDK64xx Playback widgets */
-static const struct snd_soc_dapm_widget wm8580_dapm_widgets_pbk[] = {
-	SND_SOC_DAPM_HP("Front", NULL),
-	SND_SOC_DAPM_HP("Center+Sub", NULL),
-	SND_SOC_DAPM_HP("Rear", NULL),
-};
-
-/* SMDK64xx Capture widgets */
-static const struct snd_soc_dapm_widget wm8580_dapm_widgets_cpt[] = {
-	SND_SOC_DAPM_MIC("MicIn", NULL),
-	SND_SOC_DAPM_LINE("LineIn", NULL),
-};
-
-/* SMDK-PAIFTX connections */
-static const struct snd_soc_dapm_route audio_map_tx[] = {
-	/* MicIn feeds AINL */
-	{"AINL", NULL, "MicIn"},
-
-	/* LineIn feeds AINL/R */
-	{"AINL", NULL, "LineIn"},
-	{"AINR", NULL, "LineIn"},
-};
-
-/* SMDK-PAIFRX connections */
-static const struct snd_soc_dapm_route audio_map_rx[] = {
-	/* Front Left/Right are fed VOUT1L/R */
-	{"Front", NULL, "VOUT1L"},
-	{"Front", NULL, "VOUT1R"},
-
-	/* Center/Sub are fed VOUT2L/R */
-	{"Center+Sub", NULL, "VOUT2L"},
-	{"Center+Sub", NULL, "VOUT2R"},
-
-	/* Rear Left/Right are fed VOUT3L/R */
-	{"Rear", NULL, "VOUT3L"},
-	{"Rear", NULL, "VOUT3R"},
-};
-
-static int smdk64xx_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-
-	/* Add smdk64xx specific Capture widgets */
-	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_cpt,
-				  ARRAY_SIZE(wm8580_dapm_widgets_cpt));
-
-	/* Set up PAIFTX audio path */
-	snd_soc_dapm_add_routes(codec, audio_map_tx, ARRAY_SIZE(audio_map_tx));
-
-	/* Enabling the microphone requires the fitting of a 0R
-	 * resistor to connect the line from the microphone jack.
-	 */
-	snd_soc_dapm_disable_pin(codec, "MicIn");
-
-	/* signal a DAPM event */
-	snd_soc_dapm_sync(codec);
-
-	return 0;
-}
-
-static int smdk64xx_wm8580_init_paifrx(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-
-	/* Add smdk64xx specific Playback widgets */
-	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_pbk,
-				  ARRAY_SIZE(wm8580_dapm_widgets_pbk));
-
-	/* Set up PAIFRX audio path */
-	snd_soc_dapm_add_routes(codec, audio_map_rx, ARRAY_SIZE(audio_map_rx));
-
-	/* signal a DAPM event */
-	snd_soc_dapm_sync(codec);
-
-	return 0;
-}
-
-static struct snd_soc_dai_link smdk64xx_dai[] = {
-{ /* Primary Playback i/f */
-	.name = "WM8580 PAIF RX",
-	.stream_name = "Playback",
-	.cpu_dai_name = "samsung-i2s.2",
-	.codec_dai_name = "wm8580-hifi-playback",
-	.platform_name = "samsung-audio",
-	.codec_name = "wm8580-codec.0-001b",
-	.init = smdk64xx_wm8580_init_paifrx,
-	.ops = &smdk64xx_ops,
-},
-{ /* Primary Capture i/f */
-	.name = "WM8580 PAIF TX",
-	.stream_name = "Capture",
-	.cpu_dai_name = "samsung-i2s.2",
-	.codec_dai_name = "wm8580-hifi-capture",
-	.platform_name = "samsung-audio",
-	.codec_name = "wm8580-codec.0-001b",
-	.init = smdk64xx_wm8580_init_paiftx,
-	.ops = &smdk64xx_ops,
-},
-};
-
-static struct snd_soc_card smdk64xx = {
-	.name = "SMDK64xx 5.1",
-	.dai_link = smdk64xx_dai,
-	.num_links = ARRAY_SIZE(smdk64xx_dai),
-};
-
-static struct platform_device *smdk64xx_snd_device;
-
-static int __init smdk64xx_audio_init(void)
-{
-	int ret;
-
-	smdk64xx_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!smdk64xx_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(smdk64xx_snd_device, &smdk64xx);
-	ret = platform_device_add(smdk64xx_snd_device);
-
-	if (ret)
-		platform_device_put(smdk64xx_snd_device);
-
-	return ret;
-}
-module_init(smdk64xx_audio_init);
-
-MODULE_AUTHOR("Jaswinder Singh, jassi.brar@samsung.com");
-MODULE_DESCRIPTION("ALSA SoC SMDK64XX WM8580");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/smdk_wm8580.c b/sound/soc/s3c24xx/smdk_wm8580.c
new file mode 100644
index 0000000..bbd6c97
--- /dev/null
+++ b/sound/soc/s3c24xx/smdk_wm8580.c
@@ -0,0 +1,253 @@
+/*
+ *  smdk_wm8580.c
+ *
+ *  Copyright (c) 2009 Samsung Electronics Co. Ltd
+ *  Author: Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "../codecs/wm8580.h"
+#include "dma.h"
+#include "i2s.h"
+
+/*
+ * Default CFG switch settings to use this driver:
+ *
+ *   SMDK6410: Set CFG1 1-3 Off, CFG2 1-4 On
+ */
+
+/* SMDK has a 12MHZ crystal attached to WM8580 */
+#define SMDK_WM8580_FREQ 12000000
+
+static int smdk_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	unsigned int pll_out;
+	int bfs, rfs, ret;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_U8:
+	case SNDRV_PCM_FORMAT_S8:
+		bfs = 16;
+		break;
+	case SNDRV_PCM_FORMAT_U16_LE:
+	case SNDRV_PCM_FORMAT_S16_LE:
+		bfs = 32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* The Fvco for WM8580 PLLs must fall within [90,100]MHz.
+	 * This criterion can't be met if we request PLL output
+	 * as {8000x256, 64000x256, 11025x256}Hz.
+	 * As a wayout, we rather change rfs to a minimum value that
+	 * results in (params_rate(params) * rfs), and itself, acceptable
+	 * to both - the CODEC and the CPU.
+	 */
+	switch (params_rate(params)) {
+	case 16000:
+	case 22050:
+	case 32000:
+	case 44100:
+	case 48000:
+	case 88200:
+	case 96000:
+		rfs = 256;
+		break;
+	case 64000:
+		rfs = 384;
+		break;
+	case 8000:
+	case 11025:
+		rfs = 512;
+		break;
+	default:
+		return -EINVAL;
+	}
+	pll_out = params_rate(params) * rfs;
+
+	/* Set the Codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
+					 | SND_SOC_DAIFMT_NB_NF
+					 | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* Set the AP DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
+					 | SND_SOC_DAIFMT_NB_NF
+					 | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* Set WM8580 to drive MCLK from its PLLA */
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_MCLK,
+					WM8580_CLKSRC_PLLA);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 0,
+					SMDK_WM8580_FREQ, pll_out);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8580_CLKSRC_PLLA,
+				     pll_out, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * SMDK WM8580 DAI operations.
+ */
+static struct snd_soc_ops smdk_ops = {
+	.hw_params = smdk_hw_params,
+};
+
+/* SMDK Playback widgets */
+static const struct snd_soc_dapm_widget wm8580_dapm_widgets_pbk[] = {
+	SND_SOC_DAPM_HP("Front", NULL),
+	SND_SOC_DAPM_HP("Center+Sub", NULL),
+	SND_SOC_DAPM_HP("Rear", NULL),
+};
+
+/* SMDK Capture widgets */
+static const struct snd_soc_dapm_widget wm8580_dapm_widgets_cpt[] = {
+	SND_SOC_DAPM_MIC("MicIn", NULL),
+	SND_SOC_DAPM_LINE("LineIn", NULL),
+};
+
+/* SMDK-PAIFTX connections */
+static const struct snd_soc_dapm_route audio_map_tx[] = {
+	/* MicIn feeds AINL */
+	{"AINL", NULL, "MicIn"},
+
+	/* LineIn feeds AINL/R */
+	{"AINL", NULL, "LineIn"},
+	{"AINR", NULL, "LineIn"},
+};
+
+/* SMDK-PAIFRX connections */
+static const struct snd_soc_dapm_route audio_map_rx[] = {
+	/* Front Left/Right are fed VOUT1L/R */
+	{"Front", NULL, "VOUT1L"},
+	{"Front", NULL, "VOUT1R"},
+
+	/* Center/Sub are fed VOUT2L/R */
+	{"Center+Sub", NULL, "VOUT2L"},
+	{"Center+Sub", NULL, "VOUT2R"},
+
+	/* Rear Left/Right are fed VOUT3L/R */
+	{"Rear", NULL, "VOUT3L"},
+	{"Rear", NULL, "VOUT3R"},
+};
+
+static int smdk_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+
+	/* Add smdk specific Capture widgets */
+	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_cpt,
+				  ARRAY_SIZE(wm8580_dapm_widgets_cpt));
+
+	/* Set up PAIFTX audio path */
+	snd_soc_dapm_add_routes(codec, audio_map_tx, ARRAY_SIZE(audio_map_tx));
+
+	/* Enabling the microphone requires the fitting of a 0R
+	 * resistor to connect the line from the microphone jack.
+	 */
+	snd_soc_dapm_disable_pin(codec, "MicIn");
+
+	/* signal a DAPM event */
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static int smdk_wm8580_init_paifrx(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+
+	/* Add smdk specific Playback widgets */
+	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_pbk,
+				  ARRAY_SIZE(wm8580_dapm_widgets_pbk));
+
+	/* Set up PAIFRX audio path */
+	snd_soc_dapm_add_routes(codec, audio_map_rx, ARRAY_SIZE(audio_map_rx));
+
+	/* signal a DAPM event */
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link smdk_dai[] = {
+{ /* Primary Playback i/f */
+	.name = "WM8580 PAIF RX",
+	.stream_name = "Playback",
+	.cpu_dai_name = "samsung-i2s.2",
+	.codec_dai_name = "wm8580-hifi-playback",
+	.platform_name = "samsung-audio",
+	.codec_name = "wm8580-codec.0-001b",
+	.init = smdk_wm8580_init_paifrx,
+	.ops = &smdk_ops,
+},
+{ /* Primary Capture i/f */
+	.name = "WM8580 PAIF TX",
+	.stream_name = "Capture",
+	.cpu_dai_name = "samsung-i2s.2",
+	.codec_dai_name = "wm8580-hifi-capture",
+	.platform_name = "samsung-audio",
+	.codec_name = "wm8580-codec.0-001b",
+	.init = smdk_wm8580_init_paiftx,
+	.ops = &smdk_ops,
+},
+};
+
+static struct snd_soc_card smdk = {
+	.name = "SMDK-I2S",
+	.dai_link = smdk_dai,
+	.num_links = ARRAY_SIZE(smdk_dai),
+};
+
+static struct platform_device *smdk_snd_device;
+
+static int __init smdk_audio_init(void)
+{
+	int ret;
+
+	smdk_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(smdk_snd_device, &smdk);
+	ret = platform_device_add(smdk_snd_device);
+
+	if (ret)
+		platform_device_put(smdk_snd_device);
+
+	return ret;
+}
+module_init(smdk_audio_init);
+
+MODULE_AUTHOR("Jaswinder Singh, jassi.brar@samsung.com");
+MODULE_DESCRIPTION("ALSA SoC SMDK WM8580");
+MODULE_LICENSE("GPL");
-- 
1.6.2.5
