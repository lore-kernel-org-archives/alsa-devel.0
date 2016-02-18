From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add max9867 codec driver" to the asoc
	tree
Date: Thu, 18 Feb 2016 20:12:13 +0000
Message-ID: <E1aWUvt-0003cJ-SZ@debutante>
References: <1455758929-24202-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D89282606A9
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 21:12:27 +0100 (CET)
In-Reply-To: <1455758929-24202-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add max9867 codec driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 805d132dcbbdbdf8339008f4f964490cf6ff3025 Mon Sep 17 00:00:00 2001
From: anish kumar <yesanishhere@gmail.com>
Date: Wed, 17 Feb 2016 17:28:49 -0800
Subject: [PATCH] ASoC: Add max9867 codec driver

Signed-off-by: anish kumar <yesanishhere@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/max9867.txt          |  17 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   1 +
 sound/soc/codecs/max9867.c                         | 537 +++++++++++++++++++++
 sound/soc/codecs/max9867.h                         |  83 ++++
 5 files changed, 642 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max9867.txt
 create mode 100755 sound/soc/codecs/max9867.c
 create mode 100755 sound/soc/codecs/max9867.h

diff --git a/Documentation/devicetree/bindings/sound/max9867.txt b/Documentation/devicetree/bindings/sound/max9867.txt
new file mode 100644
index 000000000000..394cd4eb17ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max9867.txt
@@ -0,0 +1,17 @@
+max9867 codec
+
+This device supports I2C mode only.
+
+Required properties:
+
+- compatible : "maxim,max9867"
+- reg : The chip select number on the I2C bus
+
+Example:
+
+&i2c {
+	max9867: max9867@0x18 {
+		compatible = "maxim,max9867";
+		reg = <0x18>;
+	};
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ebaaa51823ef..f55a846efe54 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -79,6 +79,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX98090 if I2C
 	select SND_SOC_MAX98095 if I2C
 	select SND_SOC_MAX98357A if GPIOLIB
+	select SND_SOC_MAX9867 if I2C
 	select SND_SOC_MAX98925 if I2C
 	select SND_SOC_MAX98926 if I2C
 	select SND_SOC_MAX9850 if I2C
@@ -517,6 +518,9 @@ config SND_SOC_MAX98095
 config SND_SOC_MAX98357A
        tristate
 
+config SND_SOC_MAX9867
+	tristate
+
 config SND_SOC_MAX98925
        tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 16c014a46ae8..b84fe9d75dfd 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -74,6 +74,7 @@ snd-soc-max98088-objs := max98088.o
 snd-soc-max98090-objs := max98090.o
 snd-soc-max98095-objs := max98095.o
 snd-soc-max98357a-objs := max98357a.o
+snd-soc-max9867-objs := max9867.o
 snd-soc-max98925-objs := max98925.o
 snd-soc-max98926-objs := max98926.o
 snd-soc-max9850-objs := max9850.o
diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
new file mode 100755
index 000000000000..b9d989f25515
--- /dev/null
+++ b/sound/soc/codecs/max9867.c
@@ -0,0 +1,537 @@
+/*
+ * max9867.c -- max9867 ALSA SoC Audio driver
+ *
+ * Copyright 2013-15 Maxim Integrated Products
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include "max9867.h"
+
+static const char *const max9867_spmode[] = {
+	"Stereo Diff", "Mono Diff",
+	"Stereo Cap", "Mono Cap",
+	"Stereo Single", "Mono Single",
+	"Stereo Single Fast", "Mono Single Fast"
+};
+static const char *const max9867_sidetone_text[] = {
+	"None", "Left", "Right", "LeftRight", "LeftRightDiv2",
+};
+static const char *const max9867_filter_text[] = {"IIR", "FIR"};
+
+static SOC_ENUM_SINGLE_DECL(max9867_filter, MAX9867_CODECFLTR, 7,
+	max9867_filter_text);
+static SOC_ENUM_SINGLE_DECL(max9867_spkmode, MAX9867_MODECONFIG, 0,
+	max9867_spmode);
+static SOC_ENUM_SINGLE_DECL(max9867_sidetone, MAX9867_DACGAIN, 6,
+	max9867_sidetone_text);
+static DECLARE_TLV_DB_SCALE(max9860_capture_tlv, -600, 200, 0);
+static DECLARE_TLV_DB_SCALE(max9860_mic_tlv, 2000, 100, 1);
+static DECLARE_TLV_DB_SCALE(max9860_adc_left_tlv, -1200, 100, 1);
+static DECLARE_TLV_DB_SCALE(max9860_adc_right_tlv, -1200, 100, 1);
+static const unsigned int max98088_micboost_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0, 1, TLV_DB_SCALE_ITEM(0, 2000, 0),
+	2, 2, TLV_DB_SCALE_ITEM(3000, 0, 0),
+};
+
+static const struct snd_kcontrol_new max9867_snd_controls[] = {
+	SOC_DOUBLE_R("Master Playback Volume", MAX9867_LEFTVOL,
+				MAX9867_RIGHTVOL, 0, 63, 1),
+	SOC_DOUBLE_R_TLV("Capture Volume", MAX9867_LEFTMICGAIN,
+			MAX9867_RIGHTMICGAIN,
+			0, 15, 1, max9860_capture_tlv),
+	SOC_DOUBLE_R_TLV("Mic Volume", MAX9867_LEFTMICGAIN,
+			MAX9867_RIGHTMICGAIN, 0, 31, 1, max9860_mic_tlv),
+	SOC_DOUBLE_R_TLV("Mic Boost Volume", MAX9867_LEFTMICGAIN,
+			MAX9867_RIGHTMICGAIN, 5, 3, 0, max98088_micboost_tlv),
+	SOC_ENUM("Digital Sidetone Src", max9867_sidetone),
+	SOC_SINGLE("Sidetone Volume", MAX9867_DACGAIN, 0, 31, 1),
+	SOC_SINGLE("DAC Volume", MAX9867_DACLEVEL, 4, 3, 0),
+	SOC_SINGLE("DAC Attenuation", MAX9867_DACLEVEL, 0, 15, 1),
+	SOC_SINGLE_TLV("ADC Left Volume", MAX9867_ADCLEVEL,
+			4, 15, 1, max9860_adc_left_tlv),
+	SOC_SINGLE_TLV("ADC Right Volume", MAX9867_ADCLEVEL,
+			0, 15, 1, max9860_adc_right_tlv),
+	SOC_ENUM("Speaker Mode", max9867_spkmode),
+	SOC_SINGLE("Volume Smoothing Switch", MAX9867_MODECONFIG, 6, 1, 0),
+	SOC_SINGLE("ZCD Switch", MAX9867_MODECONFIG, 5, 1, 0),
+	SOC_ENUM("DSP Filter", max9867_filter),
+};
+
+static const char *const max9867_mux[] = {"None", "Mic", "Line", "Mic_Line"};
+
+static SOC_ENUM_SINGLE_DECL(max9867_mux_enum,
+	MAX9867_INPUTCONFIG, MAX9867_INPUT_SHIFT,
+	max9867_mux);
+
+static const struct snd_kcontrol_new max9867_dapm_mux_controls =
+	SOC_DAPM_ENUM("Route", max9867_mux_enum);
+
+static const struct snd_kcontrol_new max9867_left_dapm_control =
+	SOC_DAPM_SINGLE("Switch", MAX9867_PWRMAN, 6, 1, 0);
+static const struct snd_kcontrol_new max9867_right_dapm_control =
+	SOC_DAPM_SINGLE("Switch", MAX9867_PWRMAN, 5, 1, 0);
+static const struct snd_kcontrol_new max9867_line_dapm_control =
+	SOC_DAPM_SINGLE("Switch", MAX9867_LEFTLINELVL, 6, 1, 1);
+
+static const struct snd_soc_dapm_widget max9867_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("DAI_OUT", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("Left DAC", NULL, MAX9867_PWRMAN, 3, 0),
+	SND_SOC_DAPM_DAC("Right DAC", NULL, MAX9867_PWRMAN, 2, 0),
+	SND_SOC_DAPM_MIXER("Output Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("HPOUT"),
+
+	SND_SOC_DAPM_AIF_IN("DAI_IN", "HiFi Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("Left ADC", "HiFi Capture", MAX9867_PWRMAN, 1, 0),
+	SND_SOC_DAPM_ADC("Right ADC", "HiFi Capture", MAX9867_PWRMAN, 0, 0),
+	SND_SOC_DAPM_MUX("Input Mux", SND_SOC_NOPM, 0, 0,
+		&max9867_dapm_mux_controls),
+
+	SND_SOC_DAPM_MIXER("Input Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SWITCH("Left Line", MAX9867_LEFTLINELVL, 6, 1,
+		&max9867_left_dapm_control),
+	SND_SOC_DAPM_SWITCH("Right Line", MAX9867_RIGTHLINELVL, 6, 1,
+		&max9867_right_dapm_control),
+	SND_SOC_DAPM_SWITCH("Line Mixer", SND_SOC_NOPM, 0, 0,
+		&max9867_line_dapm_control),
+	SND_SOC_DAPM_INPUT("LINE_IN"),
+};
+
+static const struct snd_soc_dapm_route max9867_audio_map[] = {
+	{"Left DAC", NULL, "DAI_OUT"},
+	{"Right DAC", NULL, "DAI_OUT"},
+	{"Output Mixer", NULL, "Left DAC"},
+	{"Output Mixer", NULL, "Right DAC"},
+	{"HPOUT", NULL, "Output Mixer"},
+
+	{"Left ADC", NULL, "DAI_IN"},
+	{"Right ADC", NULL, "DAI_IN"},
+	{"Input Mixer", NULL, "Left ADC"},
+	{"Input Mixer", NULL, "Right ADC"},
+	{"Input Mux", "Line", "Input Mixer"},
+	{"Input Mux", "Mic", "Input Mixer"},
+	{"Input Mux", "Mic_Line", "Input Mixer"},
+	{"Right Line", "Switch", "Input Mux"},
+	{"Left Line", "Switch", "Input Mux"},
+	{"LINE_IN", NULL, "Left Line"},
+	{"LINE_IN", NULL, "Right Line"},
+};
+
+enum rates {
+	pcm_rate_8, pcm_rate_16, pcm_rate_24,
+	pcm_rate_32, pcm_rate_44,
+	pcm_rate_48, max_pcm_rate,
+};
+
+struct ni_div_rates {
+	u32 mclk;
+	u16 ni[max_pcm_rate];
+} ni_div[] = {
+	{11289600, {0x116A, 0x22D4, 0x343F, 0x45A9, 0x6000, 0x687D} },
+	{12000000, {0x1062, 0x20C5, 0x3127, 0x4189, 0x5A51, 0x624E} },
+	{12288000, {0x1000, 0x2000, 0x3000, 0x4000, 0x5833, 0x6000} },
+	{13000000, {0x0F20, 0x1E3F, 0x2D5F, 0x3C7F, 0x535F, 0x5ABE} },
+	{19200000, {0x0A3D, 0x147B, 0x1EB8, 0x28F6, 0x3873, 0x3D71} },
+	{24000000, {0x1062, 0x20C5, 0x1893, 0x4189, 0x5A51, 0x624E} },
+	{26000000, {0x0F20, 0x1E3F, 0x16AF, 0x3C7F, 0x535F, 0x5ABE} },
+	{27000000, {0x0E90, 0x1D21, 0x15D8, 0x3A41, 0x5048, 0x5762} },
+};
+
+static inline int get_ni_value(int mclk, int rate)
+{
+	int i, ret = 0;
+
+	/* find the closest rate index*/
+	for (i = 0; i < ARRAY_SIZE(ni_div); i++) {
+		if (ni_div[i].mclk >= mclk)
+			break;
+	}
+
+	switch (rate) {
+	case 8000:
+		return ni_div[i].ni[pcm_rate_8];
+	case 16000:
+		return ni_div[i].ni[pcm_rate_16];
+	case 32000:
+		return ni_div[i].ni[pcm_rate_32];
+	case 44100:
+		return ni_div[i].ni[pcm_rate_44];
+	case 48000:
+		return ni_div[i].ni[pcm_rate_48];
+	default:
+		pr_err("%s wrong rate %d\n", __func__, rate);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
+	unsigned int ni_h, ni_l, value;
+
+	value = get_ni_value(max9867->sysclk, params_rate(params));
+	if (value < 0)
+		return value;
+
+	ni_h = (0xFF00 & value) >> 8;
+	ni_l = 0x00FF & value;
+	/* set up the ni value */
+	regmap_update_bits(max9867->regmap, MAX9867_AUDIOCLKHIGH,
+		MAX9867_NI_HIGH_MASK, ni_h);
+	regmap_update_bits(max9867->regmap, MAX9867_AUDIOCLKLOW,
+		MAX9867_NI_LOW_MASK, ni_l);
+	if (!max9867->master) {
+		/*
+		 * digital pll locks on to any externally supplied LRCLK signal
+		 * and also enable rapid lock mode.
+		 */
+		regmap_update_bits(max9867->regmap, MAX9867_AUDIOCLKLOW,
+			MAX9867_RAPID_LOCK, MAX9867_RAPID_LOCK);
+		regmap_update_bits(max9867->regmap, MAX9867_AUDIOCLKHIGH,
+			MAX9867_PLL, MAX9867_PLL);
+	} else {
+		unsigned long int bclk_rate, pclk_bclk_ratio;
+		int bclk_value;
+
+		bclk_rate = params_rate(params) * 2 *
+			snd_pcm_format_width(params_format(params));
+		pclk_bclk_ratio = max9867->pclk/bclk_rate;
+		switch (snd_pcm_format_width(params_format(params))) {
+		case 8:
+		case 16:
+			if (pclk_bclk_ratio == 2)
+				bclk_value = MAX9867_IFC1B_PCLK_2;
+			else if (pclk_bclk_ratio == 4)
+				bclk_value = MAX9867_IFC1B_PCLK_4;
+			else if (pclk_bclk_ratio == 8)
+				bclk_value = MAX9867_IFC1B_PCLK_8;
+			else if (pclk_bclk_ratio == 16)
+				bclk_value = MAX9867_IFC1B_PCLK_16;
+			else {
+				dev_err(codec->dev, "unsupported sampling rate\n");
+				return -EINVAL;
+			}
+			break;
+		case 24:
+			bclk_value = MAX9867_IFC1B_24BIT;
+			break;
+		case 32:
+			bclk_value = MAX9867_IFC1B_32BIT;
+			break;
+		default:
+			dev_err(codec->dev, "unsupported sampling rate\n");
+			return -EINVAL;
+		}
+		regmap_update_bits(max9867->regmap, MAX9867_IFC1B,
+			MAX9867_IFC1B_BCLK_MASK, bclk_value);
+	}
+	return 0;
+}
+
+static int max9867_prepare(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
+
+	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
+		MAX9867_SHTDOWN_MASK, MAX9867_SHTDOWN_MASK);
+	return 0;
+}
+
+static int max9867_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
+
+	if (mute)
+		regmap_update_bits(max9867->regmap, MAX9867_DACLEVEL,
+			MAX9867_DAC_MUTE_MASK, MAX9867_DAC_MUTE_MASK);
+	else
+		regmap_update_bits(max9867->regmap, MAX9867_DACLEVEL,
+			MAX9867_DAC_MUTE_MASK, 0);
+	return 0;
+}
+
+static int max9867_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
+	int value = 0;
+
+	/* Set the prescaler based on the master clock frequency*/
+	if (freq >= 10000000 && freq <= 20000000) {
+		value |= MAX9867_PSCLK_10_20;
+		max9867->pclk =  freq;
+	} else if (freq >= 20000000 && freq <= 40000000) {
+		value |= MAX9867_PSCLK_20_40;
+		max9867->pclk =  freq/2;
+	} else if (freq >= 40000000 && freq <= 60000000) {
+		value |= MAX9867_PSCLK_40_60;
+		max9867->pclk =  freq/4;
+	} else {
+		pr_err("bad clock frequency %d", freq);
+		return -EINVAL;
+	}
+	value = value << MAX9867_PSCLK_SHIFT;
+	max9867->sysclk = freq;
+	/* exact integer mode is not supported */
+	value &= ~MAX9867_FREQ_MASK;
+	regmap_update_bits(max9867->regmap, MAX9867_SYSCLK,
+			MAX9867_PSCLK_MASK, value);
+	return 0;
+}
+
+static int max9867_dai_set_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
+	u8 iface1A = 0, iface1B = 0;
+	int ret;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		max9867->master = 1;
+		iface1A |= MAX9867_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		max9867->master = 0;
+		iface1A &= ~MAX9867_MASTER;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* for i2s compatible mode */
+	iface1A |= MAX9867_I2S_DLY;
+	/* SDOUT goes to hiz state after all data is transferred */
+	iface1A |= MAX9867_SDOUT_HIZ;
+
+	/* Clock inversion bits, BCI and WCI */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		iface1A |= MAX9867_WCI_MODE | MAX9867_BCI_MODE;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		iface1A |= MAX9867_BCI_MODE;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		iface1A |= MAX9867_WCI_MODE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_write(max9867->regmap, MAX9867_IFC1A, iface1A);
+	ret = regmap_write(max9867->regmap, MAX9867_IFC1B, iface1B);
+	return 0;
+}
+
+static struct snd_soc_dai_ops max9867_dai_ops = {
+	.set_fmt = max9867_dai_set_fmt,
+	.set_sysclk	= max9867_set_dai_sysclk,
+	.prepare	= max9867_prepare,
+	.digital_mute	= max9867_mute,
+	.hw_params = max9867_dai_hw_params,
+};
+
+#define MAX9867_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+	SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+#define MAX9867_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
+
+static struct snd_soc_dai_driver max9867_dai[] = {
+	{
+	.name = "max9867-aif1",
+	.playback = {
+		.stream_name = "HiFi Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = MAX9867_RATES,
+		.formats = MAX9867_FORMATS,
+	},
+	.capture = {
+		.stream_name = "HiFi Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = MAX9867_RATES,
+		.formats = MAX9867_FORMATS,
+	},
+	.ops = &max9867_dai_ops,
+	}
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int max9867_suspend(struct device *dev)
+{
+	struct max9867_priv *max9867 = dev_get_drvdata(dev);
+
+	/* Drop down to power saving mode when system is suspended */
+	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
+		MAX9867_SHTDOWN_MASK, ~MAX9867_SHTDOWN_MASK);
+	return 0;
+}
+
+static int max9867_resume(struct device *dev)
+{
+	struct max9867_priv *max9867 = dev_get_drvdata(dev);
+
+	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
+		MAX9867_SHTDOWN_MASK, MAX9867_SHTDOWN_MASK);
+	return 0;
+}
+#endif
+
+static int max9867_probe(struct snd_soc_codec *codec)
+{
+	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
+
+	dev_dbg(codec->dev, "max98090_probe\n");
+	max9867->codec = codec;
+	return 0;
+}
+
+static struct snd_soc_codec_driver max9867_codec = {
+	.probe = max9867_probe,
+	.controls = max9867_snd_controls,
+	.num_controls = ARRAY_SIZE(max9867_snd_controls),
+	.dapm_routes = max9867_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(max9867_audio_map),
+	.dapm_widgets = max9867_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(max9867_dapm_widgets),
+};
+
+static bool max9867_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX9867_STATUS:
+	case MAX9867_JACKSTATUS:
+	case MAX9867_AUXHIGH:
+	case MAX9867_AUXLOW:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static struct reg_default max9867_reg[] = {
+	{ 0x04, 0x00 },
+	{ 0x05, 0x00 },
+	{ 0x06, 0x00 },
+	{ 0x07, 0x00 },
+	{ 0x08, 0x00 },
+	{ 0x09, 0x00 },
+	{ 0x0A, 0x00 },
+	{ 0x0B, 0x00 },
+	{ 0x0C, 0x00 },
+	{ 0x0D, 0x00 },
+	{ 0x0E, 0x00 },
+	{ 0x0F, 0x00 },
+	{ 0x10, 0x00 },
+	{ 0x11, 0x00 },
+	{ 0x12, 0x00 },
+	{ 0x13, 0x00 },
+	{ 0x14, 0x00 },
+	{ 0x15, 0x00 },
+	{ 0x16, 0x00 },
+	{ 0x17, 0x00 },
+};
+
+static struct regmap_config max9867_regmap = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= MAX9867_REVISION,
+	.reg_defaults	= max9867_reg,
+	.num_reg_defaults = ARRAY_SIZE(max9867_reg),
+	.volatile_reg	= max9867_volatile_register,
+	.cache_type	= REGCACHE_RBTREE,
+};
+
+static int max9867_i2c_probe(struct i2c_client *i2c,
+		const struct i2c_device_id *id)
+{
+	struct max9867_priv *max9867;
+	int ret = 0, reg;
+
+	max9867 = devm_kzalloc(&i2c->dev,
+			sizeof(*max9867), GFP_KERNEL);
+	if (!max9867)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, max9867);
+	max9867->regmap = devm_regmap_init_i2c(i2c, &max9867_regmap);
+	if (IS_ERR(max9867->regmap)) {
+		ret = PTR_ERR(max9867->regmap);
+		dev_err(&i2c->dev,
+				"Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+	ret = regmap_read(max9867->regmap,
+			MAX9867_REVISION, &reg);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to read: %d\n", ret);
+		return ret;
+	}
+	dev_info(&i2c->dev, "device revision: %x\n", reg);
+	ret = snd_soc_register_codec(&i2c->dev, &max9867_codec,
+			max9867_dai, ARRAY_SIZE(max9867_dai));
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int max9867_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct i2c_device_id max9867_i2c_id[] = {
+	{ "max9867", 0 },
+};
+
+static const struct of_device_id max9867_of_match[] = {
+	{ .compatible = "maxim,max9867", },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, max9867_i2c_id);
+
+static const struct dev_pm_ops max9867_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(max9867_suspend, max9867_resume)
+};
+
+static struct i2c_driver max9867_i2c_driver = {
+	.driver = {
+		.name = "max9867",
+		.of_match_table = of_match_ptr(max9867_of_match),
+		.pm = &max9867_pm_ops,
+	},
+	.probe  = max9867_i2c_probe,
+	.remove = max9867_i2c_remove,
+	.id_table = max9867_i2c_id,
+};
+
+module_i2c_driver(max9867_i2c_driver);
+
+MODULE_AUTHOR("anish kumar <yesanishhere@gmail.com>");
+MODULE_DESCRIPTION("ALSA SoC MAX9867 driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/max9867.h b/sound/soc/codecs/max9867.h
new file mode 100755
index 000000000000..65590b4ad62a
--- /dev/null
+++ b/sound/soc/codecs/max9867.h
@@ -0,0 +1,83 @@
+/*
+ * max9867.h -- MAX9867 ALSA SoC Audio driver
+ *
+ * Copyright 2013-2015 Maxim Integrated Products
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _MAX9867_H
+#define _MAX9867_H
+
+/* MAX9867 register space */
+
+#define MAX9867_STATUS        0x00
+#define MAX9867_JACKSTATUS   0x01
+#define MAX9867_AUXHIGH      0x02
+#define MAX9867_AUXLOW       0x03
+#define MAX9867_INTEN        0x04
+#define MAX9867_SYSCLK       0x05
+#define MAX9867_FREQ_MASK    0xF
+#define MAX9867_PSCLK_SHIFT  0x4
+#define MAX9867_PSCLK_WIDTH  0x2
+#define MAX9867_PSCLK_MASK   (0x03<<MAX9867_PSCLK_SHIFT)
+#define MAX9867_PSCLK_10_20  0x1
+#define MAX9867_PSCLK_20_40  0x2
+#define MAX9867_PSCLK_40_60  0x3
+#define MAX9867_AUDIOCLKHIGH 0x06
+#define MAX9867_NI_HIGH_WIDTH 0x7
+#define MAX9867_NI_HIGH_MASK 0x7F
+#define MAX9867_NI_LOW_MASK 0x7F
+#define MAX9867_NI_LOW_SHIFT 0x1
+#define MAX9867_PLL     (1<<7)
+#define MAX9867_AUDIOCLKLOW  0x07
+#define MAX9867_RAPID_LOCK   0x01
+#define MAX9867_IFC1A        0x08
+#define MAX9867_MASTER       (1<<7)
+#define MAX9867_I2S_DLY      (1<<4)
+#define MAX9867_SDOUT_HIZ    (1<<3)
+#define MAX9867_TDM_MODE     (1<<2)
+#define MAX9867_WCI_MODE     (1<<6)
+#define MAX9867_BCI_MODE     (1<<5)
+#define MAX9867_IFC1B        0x09
+#define MAX9867_IFC1B_BCLK_MASK 7
+#define MAX9867_IFC1B_32BIT  0x01
+#define MAX9867_IFC1B_24BIT  0x02
+#define MAX9867_IFC1B_PCLK_2 4
+#define MAX9867_IFC1B_PCLK_4 5
+#define MAX9867_IFC1B_PCLK_8 6
+#define MAX9867_IFC1B_PCLK_16 7
+#define MAX9867_CODECFLTR    0x0a
+#define MAX9867_DACGAIN      0x0b
+#define MAX9867_DACLEVEL     0x0c
+#define MAX9867_DAC_MUTE_SHIFT 0x6
+#define MAX9867_DAC_MUTE_WIDTH 0x1
+#define MAX9867_DAC_MUTE_MASK (0x1<<MAX9867_DAC_MUTE_SHIFT)
+#define MAX9867_ADCLEVEL     0x0d
+#define MAX9867_LEFTLINELVL  0x0e
+#define MAX9867_RIGTHLINELVL 0x0f
+#define MAX9867_LEFTVOL      0x10
+#define MAX9867_RIGHTVOL     0x11
+#define MAX9867_LEFTMICGAIN  0x12
+#define MAX9867_RIGHTMICGAIN 0x13
+#define MAX9867_INPUTCONFIG  0x14
+#define MAX9867_INPUT_SHIFT  0x6
+#define MAX9867_MICCONFIG    0x15
+#define MAX9867_MODECONFIG   0x16
+#define MAX9867_PWRMAN       0x17
+#define MAX9867_SHTDOWN_MASK (1<<7)
+#define MAX9867_REVISION     0xff
+
+#define MAX9867_CACHEREGNUM 10
+
+/* codec private data */
+struct max9867_priv {
+	struct regmap *regmap;
+	struct snd_soc_codec *codec;
+	unsigned int sysclk;
+	unsigned int pclk;
+	unsigned int master;
+};
+#endif
-- 
2.7.0
