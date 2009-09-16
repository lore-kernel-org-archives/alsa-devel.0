From: Jassi <jassi.brar@samsung.com>
Subject: [PATCH] S3C64XX I2S: Added machine driver for WM8580
Date: Wed, 16 Sep 2009 19:02:42 +0900
Message-ID: <1253095362-571-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E4E62445F
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 12:09:36 +0200 (CEST)
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
Cc: kgene.kim@samsung.com, Jassi <jassi.brar@samsung.com>, jsgood.yang@samsung.com, broonie@opensource.wolfsonmicro.com, ilho215.lee@samsung.com, thomas.ab@samsung.com, ki0351.kim@samsung.com, ben@trinity.fluff.org
List-Id: alsa-devel@alsa-project.org

New machine driver for WM8580 I2S i/f on SMDK64XX.
By default SoC-Slave is set and WM8580 is configured to use it's
PLLA to generate clocks from a 12MHz crystal attached to WM8580.
I2S controller-0 is set as default, set S3C64XX_I2S_CNTRLR to 2
inorder to use I2S_v4 controller of S3C6410.

Signed-off-by: Jassi <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig           |    8 +
 sound/soc/s3c24xx/Makefile          |    2 +
 sound/soc/s3c24xx/smdk64xx_wm8580.c |  288 +++++++++++++++++++++++++++++++++++
 3 files changed, 298 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/s3c24xx/smdk64xx_wm8580.c

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 923428f..769697e 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -56,6 +56,14 @@ config SND_S3C24XX_SOC_JIVE_WM8750
 	help
 	  Sat Y if you want to add support for SoC audio on the Jive.
 
+config SND_S3C64XX_SOC_WM8580
+	tristate "SoC I2S Audio support for WM8580 on SMDK64XX"
+	depends on SND_S3C24XX_SOC && (MACH_SMDK6400 || MACH_SMDK6410)
+	select SND_SOC_WM8580
+	select SND_S3C64XX_SOC_I2S
+	help
+	  Sat Y if you want to add support for SoC audio on the SMDK64XX.
+
 config SND_S3C24XX_SOC_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
 	depends on SND_S3C24XX_SOC && MACH_SMDK2443
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 99f5a7d..7790406 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -23,6 +23,7 @@ snd-soc-s3c24xx-uda134x-objs := s3c24xx_uda134x.o
 snd-soc-s3c24xx-simtec-objs := s3c24xx_simtec.o
 snd-soc-s3c24xx-simtec-hermes-objs := s3c24xx_simtec_hermes.o
 snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
+snd-soc-smdk64xx-wm8580-objs := smdk64xx_wm8580.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -33,4 +34,5 @@ obj-$(CONFIG_SND_S3C24XX_SOC_S3C24XX_UDA134X) += snd-soc-s3c24xx-uda134x.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC) += snd-soc-s3c24xx-simtec.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
+obj-$(CONFIG_SND_S3C64XX_SOC_WM8580) += snd-soc-smdk64xx-wm8580.o
 
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
new file mode 100644
index 0000000..6489e52
--- /dev/null
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -0,0 +1,288 @@
+/*
+ *  smdk64xx_wm8580.c
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
+#include "s3c24xx-pcm.h"
+#include "s3c64xx-i2s.h"
+
+#define S3C64XX_I2S_CNTRLR 0
+
+/* SMDK64XX has a 12MHZ crystal attached to WM8580 */
+#define SMDK64XX_WM8580_FREQ (12000000)
+
+static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	unsigned int pll_out;
+	int bfs, rfs, ret;
+
+	switch (params_rate(params)) {
+	case 8000:
+		pll_out = 8192000 / 4; break;
+	case 11025:
+		pll_out = 11289600 / 4; break;
+	case 16000:
+		pll_out = 8192000 / 2; break;
+	case 22050:
+		pll_out = 11289600 / 2; break;
+	case 32000:
+		pll_out = 8192000; break;
+	case 44100:
+		pll_out = 11289600; break;
+	case 48000:
+		pll_out = 12288000; break;
+	case 64000:
+		pll_out = 24576000; break;
+	case 88200:
+		pll_out = 11289600 * 2; break;
+	case 96000:
+		pll_out = 12288000 * 2; break;
+	default:
+		return -EINVAL;
+	}
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
+	/* We block CODCLK from MCLK of WM8580 */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CODCLKSRC_EXT,
+					0, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* We use PCLK for basic ops in SoC-Slave mode */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CLKSRC_PCLK,
+					0, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* Set WM8580 to drive MCLK from it's PLLA */
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_MCLK,
+					WM8580_CLKSRC_PLLA);
+	if (ret < 0)
+		return ret;
+
+	/* Explicitly set WM8580-ADC/DAC to source from MCLK */
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_ADC_CLKSEL,
+					WM8580_CLKSRC_MCLK);
+	if (ret < 0)
+		return ret;
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_DAC_CLKSEL,
+					WM8580_CLKSRC_MCLK);
+	if (ret < 0)
+		return ret;
+
+	/* Don't output to the disconnected pin */
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_CLKOUTSRC,
+					WM8580_CLKSRC_NONE);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_pll(codec_dai, WM8580_PLLA,
+					SMDK64XX_WM8580_FREQ, pll_out);
+	if (ret < 0)
+		return ret;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_U8:
+	case SNDRV_PCM_FORMAT_S8:
+		bfs = 16;
+		rfs = 256;
+		break;
+	case SNDRV_PCM_FORMAT_U16_LE:
+	case SNDRV_PCM_FORMAT_S16_LE:
+		bfs = 32;
+		rfs = 256;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_BCLK, bfs);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_RCLK, rfs);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int smdk64xx_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+
+	/* disable the PLL */
+	return snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 0, 0);
+}
+
+/*
+ * SMDK64XX WM8580 DAI operations.
+ */
+static struct snd_soc_ops smdk64xx_ops = {
+	.hw_params = smdk64xx_hw_params,
+	.hw_free = smdk64xx_hw_free,
+};
+
+/* SMDK64xx Playback widgets */
+static const struct snd_soc_dapm_widget wm8580_dapm_widgets_pbk[] = {
+	SND_SOC_DAPM_HP("Front-L/R", NULL),
+	SND_SOC_DAPM_HP("Center/Sub", NULL),
+	SND_SOC_DAPM_HP("Rear-L/R", NULL),
+};
+
+/* SMDK64xx Capture widgets */
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
+	{"Front-L/R", NULL, "VOUT1L"},
+	{"Front-L/R", NULL, "VOUT1R"},
+
+	/* Center/Sub are fed VOUT2L/R */
+	{"Center/Sub", NULL, "VOUT2L"},
+	{"Center/Sub", NULL, "VOUT2R"},
+
+	/* Rear Left/Right are fed VOUT3L/R */
+	{"Rear-L/R", NULL, "VOUT3L"},
+	{"Rear-L/R", NULL, "VOUT3R"},
+};
+
+static int smdk64xx_wm8580_init_paiftx(struct snd_soc_codec *codec)
+{
+	/* Add smdk64xx specific Capture widgets */
+	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_cpt,
+				  ARRAY_SIZE(wm8580_dapm_widgets_cpt));
+
+	/* Set up PAIFTX audio path */
+	snd_soc_dapm_add_routes(codec, audio_map_tx, ARRAY_SIZE(audio_map_tx));
+
+	/* LineIn enabled by default */
+	snd_soc_dapm_disable_pin(codec, "MicIn");
+	snd_soc_dapm_enable_pin(codec, "LineIn");
+
+	/* signal a DAPM event */
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static int smdk64xx_wm8580_init_paifrx(struct snd_soc_codec *codec)
+{
+	/* Add smdk64xx specific Playback widgets */
+	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_pbk,
+				  ARRAY_SIZE(wm8580_dapm_widgets_pbk));
+
+	/* Set up PAIFRX audio path */
+	snd_soc_dapm_add_routes(codec, audio_map_rx, ARRAY_SIZE(audio_map_rx));
+
+	/* Stereo enabled by default */
+	snd_soc_dapm_enable_pin(codec, "Front-L/R");
+	snd_soc_dapm_disable_pin(codec, "Center/Sub");
+	snd_soc_dapm_disable_pin(codec, "Rear-L/R");
+
+	/* signal a DAPM event */
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link smdk64xx_dai[] = {
+{ /* Primary Playback i/f */
+	.name = "WM8580 PAIF RX",
+	.stream_name = "Playback",
+	.cpu_dai = &s3c64xx_i2s_dai[S3C64XX_I2S_CNTRLR],
+	.codec_dai = &wm8580_dai[WM8580_DAI_PAIFRX],
+	.init = smdk64xx_wm8580_init_paifrx,
+	.ops = &smdk64xx_ops,
+},
+{ /* Primary Capture i/f */
+	.name = "WM8580 PAIF TX",
+	.stream_name = "Capture",
+	.cpu_dai = &s3c64xx_i2s_dai[S3C64XX_I2S_CNTRLR],
+	.codec_dai = &wm8580_dai[WM8580_DAI_PAIFTX],
+	.init = smdk64xx_wm8580_init_paiftx,
+	.ops = &smdk64xx_ops,
+},
+};
+
+static struct snd_soc_card smdk64xx = {
+	.name = "smdk64xx",
+	.platform = &s3c24xx_soc_platform,
+	.dai_link = smdk64xx_dai,
+	.num_links = ARRAY_SIZE(smdk64xx_dai),
+};
+
+static struct snd_soc_device smdk64xx_snd_devdata = {
+	.card = &smdk64xx,
+	.codec_dev = &soc_codec_dev_wm8580,
+};
+
+static struct platform_device *smdk64xx_snd_device;
+
+static int __init smdk64xx_audio_init(void)
+{
+	int ret;
+
+	smdk64xx_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk64xx_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(smdk64xx_snd_device, &smdk64xx_snd_devdata);
+	smdk64xx_snd_devdata.dev = &smdk64xx_snd_device->dev;
+	ret = platform_device_add(smdk64xx_snd_device);
+
+	if (ret)
+		platform_device_put(smdk64xx_snd_device);
+
+	return ret;
+}
+module_init(smdk64xx_audio_init);
+
+static void __exit smdk64xx_audio_exit(void)
+{
+	platform_device_unregister(smdk64xx_snd_device);
+}
+module_exit(smdk64xx_audio_exit);
+
+/* Module information */
+MODULE_DESCRIPTION("ALSA SoC SMDK64XX WM8580");
+MODULE_LICENSE("GPL");
-- 
1.6.2.5
