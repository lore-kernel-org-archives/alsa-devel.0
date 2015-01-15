From: Anish Kumar <yesanishhere@gmail.com>
Subject: [PATCH] [ALSA] ASoC: Add max98925 codec driver
Date: Thu, 15 Jan 2015 13:17:13 -0800
Message-ID: <1421356633-30617-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 6334C260867
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 22:17:28 +0100 (CET)
Received: by mail-pd0-f179.google.com with SMTP id v10so338217pde.10
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 13:17:27 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Anish Kumar <anish.kumar@maximintegrated.com>, nitin.mittal@maximintegrated.com
List-Id: alsa-devel@alsa-project.org

From: Anish Kumar <anish.kumar@maximintegrated.com>

This patch adds the max98925 codec driver.

Signed-off-by: Anish Kumar <anish.kumar@maximintegrated.com>
---
 sound/soc/codecs/max98925.c | 954 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/max98925.h | 842 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 1796 insertions(+)
 create mode 100644 sound/soc/codecs/max98925.c
 create mode 100644 sound/soc/codecs/max98925.h

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
new file mode 100644
index 0000000..ab78064
--- /dev/null
+++ b/sound/soc/codecs/max98925.c
@@ -0,0 +1,954 @@
+/*
+ * max98925.c -- ALSA SoC Stereo MAX98925 driver
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
+#include <linux/slab.h>
+#include <linux/cdev.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include <sound/max98925.h>
+#include "max98925.h"
+
+static struct reg_default max98925_reg[] = {
+	{ 0x00, 0x00 }, /* Battery Voltage Data */
+	{ 0x01, 0x00 }, /* Boost Voltage Data */
+	{ 0x02, 0x00 }, /* Live Status0 */
+	{ 0x03, 0x00 }, /* Live Status1 */
+	{ 0x04, 0x00 }, /* Live Status2 */
+	{ 0x05, 0x00 }, /* State0 */
+	{ 0x06, 0x00 }, /* State1 */
+	{ 0x07, 0x00 }, /* State2 */
+	{ 0x08, 0x00 }, /* Flag0 */
+	{ 0x09, 0x00 }, /* Flag1 */
+	{ 0x0A, 0x00 }, /* Flag2 */
+	{ 0x0B, 0x00 }, /* IRQ Enable0 */
+	{ 0x0C, 0x00 }, /* IRQ Enable1 */
+	{ 0x0D, 0x00 }, /* IRQ Enable2 */
+	{ 0x0E, 0x00 }, /* IRQ Clear0 */
+	{ 0x0F, 0x00 }, /* IRQ Clear1 */
+	{ 0x10, 0x00 }, /* IRQ Clear2 */
+	{ 0x11, 0xC0 }, /* Map0 */
+	{ 0x12, 0x00 }, /* Map1 */
+	{ 0x13, 0x00 }, /* Map2 */
+	{ 0x14, 0xF0 }, /* Map3 */
+	{ 0x15, 0x00 }, /* Map4 */
+	{ 0x16, 0xAB }, /* Map5 */
+	{ 0x17, 0x89 }, /* Map6 */
+	{ 0x18, 0x00 }, /* Map7 */
+	{ 0x19, 0x00 }, /* Map8 */
+	{ 0x1A, 0x06 }, /* DAI Clock Mode 1 */
+	{ 0x1B, 0xC0 }, /* DAI Clock Mode 2 */
+	{ 0x1C, 0x00 }, /* DAI Clock Divider Denominator MSBs */
+	{ 0x1D, 0x00 }, /* DAI Clock Divider Denominator LSBs */
+	{ 0x1E, 0xF0 }, /* DAI Clock Divider Numerator MSBs */
+	{ 0x1F, 0x00 }, /* DAI Clock Divider Numerator LSBs */
+	{ 0x20, 0x50 }, /* Format */
+	{ 0x21, 0x00 }, /* TDM Slot Select */
+	{ 0x22, 0x00 }, /* DOUT Configuration VMON */
+	{ 0x23, 0x00 }, /* DOUT Configuration IMON */
+	{ 0x24, 0x00 }, /* DOUT Configuration VBAT */
+	{ 0x25, 0x00 }, /* DOUT Configuration VBST */
+	{ 0x26, 0x00 }, /* DOUT Configuration FLAG */
+	{ 0x27, 0xFF }, /* DOUT HiZ Configuration 1 */
+	{ 0x28, 0xFF }, /* DOUT HiZ Configuration 2 */
+	{ 0x29, 0xFF }, /* DOUT HiZ Configuration 3 */
+	{ 0x2A, 0xFF }, /* DOUT HiZ Configuration 4 */
+	{ 0x2B, 0x02 }, /* DOUT Drive Strength */
+	{ 0x2C, 0x90 }, /* Filters */
+	{ 0x2D, 0x00 }, /* Gain */
+	{ 0x2E, 0x02 }, /* Gain Ramping */
+	{ 0x2F, 0x00 }, /* Speaker Amplifier */
+	{ 0x30, 0x0A }, /* Threshold */
+	{ 0x31, 0x00 }, /* ALC Attack */
+	{ 0x32, 0x80 }, /* ALC Atten and Release */
+	{ 0x33, 0x00 }, /* ALC Infinite Hold Release */
+	{ 0x34, 0x92 }, /* ALC Configuration */
+	{ 0x35, 0x01 }, /* Boost Converter */
+	{ 0x36, 0x00 }, /* Block Enable */
+	{ 0x37, 0x00 }, /* Configuration */
+	{ 0x38, 0x00 }, /* Global Enable */
+	{ 0x3A, 0x00 }, /* Boost Limiter */
+	{ 0xFF, 0x50 }, /* Revision ID */
+};
+
+static bool max98925_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX98925_R000_VBAT_DATA:
+	case MAX98925_R001_VBST_DATA:
+	case MAX98925_R002_LIVE_STATUS0:
+	case MAX98925_R003_LIVE_STATUS1:
+	case MAX98925_R004_LIVE_STATUS2:
+	case MAX98925_R005_STATE0:
+	case MAX98925_R006_STATE1:
+	case MAX98925_R007_STATE2:
+	case MAX98925_R008_FLAG0:
+	case MAX98925_R009_FLAG1:
+	case MAX98925_R00A_FLAG2:
+	case MAX98925_R0FF_VERSION:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool max98925_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX98925_R00E_IRQ_CLEAR0:
+	case MAX98925_R00F_IRQ_CLEAR1:
+	case MAX98925_R010_IRQ_CLEAR2:
+	case MAX98925_R033_ALC_HOLD_RLS:
+		return false;
+	default:
+		return true;
+	}
+};
+
+static const unsigned int max98925_spk_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	1, 31, TLV_DB_SCALE_ITEM(-600, 100, 0),
+};
+
+static int max98925_spk_gain_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = max98925->spk_gain;
+	pr_debug("%s: spk_gain setting returned %d\n", __func__,
+				(int) ucontrol->value.integer.value[0]);
+	return 0;
+}
+
+static int max98925_spk_gain_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	unsigned int sel = ucontrol->value.integer.value[0];
+
+	if (sel < ((1 << M98925_SPK_GAIN_WIDTH) - 1)) {
+		regmap_update_bits(max98925->regmapL, MAX98925_R02D_GAIN,
+			M98925_SPK_GAIN_MASK, sel << M98925_SPK_GAIN_SHIFT);
+		regmap_update_bits(max98925->regmapR, MAX98925_R02D_GAIN,
+			M98925_SPK_GAIN_MASK, sel << M98925_SPK_GAIN_SHIFT);
+
+		max98925->spk_gain = sel;
+
+		pr_debug("%s: spk_gain set to %d\n", __func__, sel);
+	} else {
+		pr_debug("%s: valid speaker gain settings: %d to %d\n",
+			__func__, 0,
+			((1 << M98925_SPK_GAIN_WIDTH) - 1));
+	}
+	return 0;
+}
+
+static int max98925_reg_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol, unsigned int reg,
+		unsigned int mask, unsigned int shift)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	int data;
+
+	regmap_read(max98925->regmapL, reg, &data);
+	ucontrol->value.integer.value[0] =
+		(data & mask) >> shift;
+	return 0;
+}
+
+static int max98925_reg_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol, unsigned int reg,
+		unsigned int mask, unsigned int shift)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	unsigned int sel = ucontrol->value.integer.value[0];
+
+	regmap_update_bits(max98925->regmapL, reg, mask, sel << shift);
+	regmap_update_bits(max98925->regmapR, reg, mask, sel << shift);
+
+	pr_debug("%s: register 0x%02X, value 0x%02X\n", __func__, reg, sel);
+	return 0;
+}
+
+static int max98925_spk_ramp_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	return max98925_reg_get(kcontrol, ucontrol, MAX98925_R02E_GAIN_RAMPING,
+			M98925_SPK_RMP_EN_MASK, M98925_SPK_RMP_EN_SHIFT);
+}
+
+static int max98925_spk_ramp_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	return max98925_reg_put(kcontrol, ucontrol, MAX98925_R02E_GAIN_RAMPING,
+			M98925_SPK_RMP_EN_MASK, M98925_SPK_RMP_EN_SHIFT);
+}
+
+static int max98925_spk_zcd_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	return max98925_reg_get(kcontrol, ucontrol, MAX98925_R02E_GAIN_RAMPING,
+			M98925_SPK_ZCD_EN_MASK, M98925_SPK_ZCD_EN_SHIFT);
+}
+
+static int max98925_spk_zcd_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	return max98925_reg_put(kcontrol, ucontrol, MAX98925_R02E_GAIN_RAMPING,
+			M98925_SPK_ZCD_EN_MASK, M98925_SPK_ZCD_EN_SHIFT);
+}
+
+static int max98925_alc_en_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	return max98925_reg_get(kcontrol, ucontrol, MAX98925_R030_THRESHOLD,
+			M98925_ALC_EN_MASK, M98925_ALC_EN_SHIFT);
+}
+
+static int max98925_alc_en_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	return max98925_reg_put(kcontrol, ucontrol, MAX98925_R030_THRESHOLD,
+			M98925_ALC_EN_MASK, M98925_ALC_EN_SHIFT);
+}
+
+static int max98925_alc_threshold_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	return max98925_reg_get(kcontrol, ucontrol, MAX98925_R030_THRESHOLD,
+			M98925_ALC_TH_MASK, M98925_ALC_TH_SHIFT);
+}
+
+static int max98925_alc_threshold_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	return max98925_reg_put(kcontrol, ucontrol, MAX98925_R030_THRESHOLD,
+			M98925_ALC_TH_MASK, M98925_ALC_TH_SHIFT);
+}
+
+static const char * const max98925_boost_voltage_text[] = {"8.5V", "8.25V",
+		"8.0V", "7.75V", "7.5V", "7.25V", "7.0V", "6.75V",
+		"6.5V", "6.5V", "6.5V", "6.5V", "6.5V", "6.5V",
+		"6.5V", "6.5V"};
+
+static const struct soc_enum max98925_boost_voltage_enum =
+	SOC_ENUM_SINGLE(MAX98925_R037_CONFIGURATION, M98925_BST_VOUT_SHIFT, 15,
+			max98925_boost_voltage_text);
+
+static int max98925_boost_voltage_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	return max98925_reg_get(kcontrol, ucontrol, MAX98925_R037_CONFIGURATION,
+			M98925_BST_VOUT_MASK, M98925_BST_VOUT_SHIFT);
+}
+
+static int max98925_boost_voltage_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	return max98925_reg_put(kcontrol, ucontrol, MAX98925_R037_CONFIGURATION,
+			M98925_BST_VOUT_MASK, M98925_BST_VOUT_SHIFT);
+}
+
+static const struct snd_kcontrol_new max98925_snd_controls[] = {
+
+	SOC_SINGLE_EXT_TLV("Speaker Gain", MAX98925_R02D_GAIN,
+		M98925_SPK_GAIN_SHIFT, (1<<M98925_SPK_GAIN_WIDTH)-1, 0,
+		max98925_spk_gain_get, max98925_spk_gain_put, max98925_spk_tlv),
+
+	SOC_SINGLE_EXT("Speaker Ramp", 0, 0, 1, 0,
+		max98925_spk_ramp_get, max98925_spk_ramp_put),
+
+	SOC_SINGLE_EXT("Speaker ZCD", 0, 0, 1, 0,
+		max98925_spk_zcd_get, max98925_spk_zcd_put),
+
+	SOC_SINGLE_EXT("ALC Enable", 0, 0, 1, 0,
+		max98925_alc_en_get, max98925_alc_en_put),
+
+	SOC_SINGLE_EXT("ALC Threshold", 0, 0, (1<<M98925_ALC_TH_WIDTH)-1, 0,
+		max98925_alc_threshold_get, max98925_alc_threshold_put),
+
+	SOC_ENUM_EXT("Boost Output Voltage", max98925_boost_voltage_enum,
+		max98925_boost_voltage_get, max98925_boost_voltage_put),
+};
+
+static int max98925_add_widgets(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	ret = snd_soc_add_codec_controls(codec, max98925_snd_controls,
+		ARRAY_SIZE(max98925_snd_controls));
+	return 0;
+}
+
+/* codec sample rate and n/m dividers parameter table */
+static const struct {
+	int rate;
+	int  sr;
+	int divisors[3][2];
+} rate_table[] = {
+	{
+		.rate = 8000,
+		.sr = 0,
+		.divisors = { {1, 375}, {5, 1764}, {1, 384} }
+	},
+	{
+		.rate = 11025,
+		.sr = 1,
+		.divisors = { {147, 40000}, {1, 256}, {147, 40960} }
+	},
+	{
+		.rate = 12000,
+		.sr = 2,
+		.divisors = { {1, 250}, {5, 1176}, {1, 256} }
+	},
+	{
+		.rate = 16000,
+		.sr = 3,
+		.divisors = { {2, 375}, {5, 882}, {1, 192} }
+	},
+	{
+		.rate = 22050,
+		.sr = 4,
+		.divisors = { {147, 20000}, {1, 128}, {147, 20480} }
+	},
+	{
+		.rate = 24000,
+		.sr = 5,
+		.divisors = { {1, 125}, {5, 588}, {1, 128} }
+	},
+	{
+		.rate = 32000,
+		.sr = 6,
+		.divisors = { {4, 375}, {5, 441}, {1, 96} }
+	},
+	{
+		.rate = 44100,
+		.sr = 7,
+		.divisors = { {147, 10000}, {1, 64}, {147, 10240} }
+	},
+	{
+		.rate = 48000,
+		.sr = 8,
+		.divisors = { {2, 125}, {5, 294}, {1, 64} }
+	},
+};
+
+static inline int max98925_rate_value(int rate,
+		int clock, int *value, int *n, int *m)
+{
+	int ret = -EINVAL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rate_table); i++) {
+		if (rate_table[i].rate >= rate) {
+			*value = rate_table[i].sr;
+			*n = rate_table[i].divisors[clock][0];
+			*m = rate_table[i].divisors[clock][1];
+			ret = 0;
+			break;
+		}
+	}
+	pr_debug("%s: sample rate is %d, returning %d\n",
+				__func__, rate_table[i].rate, *value);
+	return ret;
+}
+
+static int max98925_set_tdm_slot(struct snd_soc_dai *codec_dai,
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
+{
+	pr_info("%s: tx_mask 0x%X, rx_mask 0x%X, slots %d, slot width %d\n",
+			__func__, tx_mask, rx_mask, slots, slot_width);
+	return 0;
+}
+
+static void max98925_set_sense_data(struct max98925_priv *max98925)
+{
+	/*
+	 * 1. set VMON slots
+	 */
+	regmap_update_bits(max98925->regmapL, MAX98925_R022_DOUT_CFG_VMON,
+			M98925_DAI_VMON_EN_MASK, M98925_DAI_VMON_EN_MASK);
+	regmap_update_bits(max98925->regmapL, MAX98925_R022_DOUT_CFG_VMON,
+			M98925_DAI_VMON_SLOT_MASK, M98925_DAI_VMON_SLOT_00_01);
+	/*
+	 * 2. set IMON slots
+	 */
+	regmap_update_bits(max98925->regmapL, MAX98925_R023_DOUT_CFG_IMON,
+			M98925_DAI_IMON_EN_MASK, M98925_DAI_IMON_EN_MASK);
+	regmap_update_bits(max98925->regmapL, MAX98925_R023_DOUT_CFG_IMON,
+			M98925_DAI_IMON_SLOT_MASK, M98925_DAI_IMON_SLOT_02_03);
+}
+
+static void max98925_set_slave(struct max98925_priv *max98925)
+{
+	/*
+	 * 1. use BCLK instead of MCLK
+	 */
+	regmap_update_bits(max98925->regmapL, MAX98925_R01A_DAI_CLK_MODE1,
+			M98925_DAI_CLK_SOURCE_MASK, M98925_DAI_CLK_SOURCE_MASK);
+	regmap_update_bits(max98925->regmapR, MAX98925_R01A_DAI_CLK_MODE1,
+			M98925_DAI_CLK_SOURCE_MASK, M98925_DAI_CLK_SOURCE_MASK);
+	/*
+	 * 2. set DAI to slave mode
+	 */
+	regmap_update_bits(max98925->regmapL, MAX98925_R01B_DAI_CLK_MODE2,
+			M98925_DAI_MAS_MASK, 0);
+	regmap_update_bits(max98925->regmapR, MAX98925_R01B_DAI_CLK_MODE2,
+			M98925_DAI_MAS_MASK, 0);
+	/*
+	 * 3. set BLCKs to LRCLKs to 64
+	 */
+	regmap_update_bits(max98925->regmapL, MAX98925_R01B_DAI_CLK_MODE2,
+			M98925_DAI_BSEL_MASK, M98925_DAI_BSEL_64);
+	regmap_update_bits(max98925->regmapR, MAX98925_R01B_DAI_CLK_MODE2,
+			M98925_DAI_BSEL_MASK, M98925_DAI_BSEL_64);
+
+	max98925_set_sense_data(max98925);
+}
+
+static void max98925_set_master(struct max98925_priv *max98925)
+{
+	/*
+	 * 1. use MCLK for Left channel, right channel always BCLK
+	 */
+	regmap_update_bits(max98925->regmapL, MAX98925_R01A_DAI_CLK_MODE1,
+			M98925_DAI_CLK_SOURCE_MASK, 0);
+	regmap_update_bits(max98925->regmapR, MAX98925_R01A_DAI_CLK_MODE1,
+			M98925_DAI_CLK_SOURCE_MASK, M98925_DAI_CLK_SOURCE_MASK);
+	/*
+	 * 2. set left channel DAI to master mode, right channel always slave
+	 */
+	regmap_update_bits(max98925->regmapL, MAX98925_R01B_DAI_CLK_MODE2,
+			M98925_DAI_MAS_MASK, M98925_DAI_MAS_MASK);
+	regmap_update_bits(max98925->regmapR, MAX98925_R01B_DAI_CLK_MODE2,
+			M98925_DAI_MAS_MASK, 0);
+}
+
+static int max98925_dai_set_fmt(struct snd_soc_dai *codec_dai,
+				 unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	struct max98925_cdata *cdata;
+	unsigned int invert = 0;
+
+	pr_debug("%s: fmt 0x%08X\n", __func__, fmt);
+	cdata = &max98925->dai[0];
+	cdata->fmt = fmt;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		max98925_set_slave(max98925);
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		max98925_set_master(max98925);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+	default:
+		dev_err(codec->dev, "DAI clock mode unsupported");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+	default:
+		dev_err(codec->dev, "DAI format unsupported, fmt:0x%x", fmt);
+		return -EINVAL;
+	}
+	pr_debug("DAI format supported, fmt:0x%x", fmt);
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		invert = M98925_DAI_WCI_MASK;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		invert = M98925_DAI_BCI_MASK;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		invert = M98925_DAI_BCI_MASK | M98925_DAI_WCI_MASK;
+		break;
+	default:
+		dev_err(codec->dev, "DAI invert mode unsupported");
+		return -EINVAL;
+	}
+
+	regmap_update_bits(max98925->regmapL, MAX98925_R020_FORMAT,
+			M98925_DAI_BCI_MASK | M98925_DAI_BCI_MASK, invert);
+	regmap_update_bits(max98925->regmapR, MAX98925_R020_FORMAT,
+			M98925_DAI_BCI_MASK | M98925_DAI_BCI_MASK, invert);
+	return 0;
+}
+
+static int max98925_set_bias_level(struct snd_soc_codec *codec,
+				   enum snd_soc_bias_level level)
+{
+	codec->dapm.bias_level = level;
+	return 0;
+}
+
+static int max98925_set_clock(struct max98925_priv *max98925, unsigned int rate)
+{
+	unsigned int dai_sr = 0;
+	unsigned int clock;
+	unsigned int mdll;
+	unsigned int n;
+	unsigned int m;
+
+	switch (max98925->sysclk) {
+	case 6000000:
+		clock = 0;
+		mdll  = M98925_MDLL_MULT_MCLKx16;
+		break;
+	case 11289600:
+		clock = 1;
+		mdll  = M98925_MDLL_MULT_MCLKx8;
+		break;
+	case 12000000:
+		clock = 0;
+		mdll  = M98925_MDLL_MULT_MCLKx8;
+		break;
+	case 12288000:
+		clock = 2;
+		mdll  = M98925_MDLL_MULT_MCLKx8;
+		break;
+	default:
+		dev_info(max98925->codec->dev, "unsupported sysclk %d\n",
+					max98925->sysclk);
+		return -EINVAL;
+	}
+
+	if (max98925_rate_value(rate, clock, &dai_sr, &n, &m))
+		return -EINVAL;
+
+	/*
+	 * 1. set DAI_SR to correct LRCLK frequency
+	 */
+	regmap_update_bits(max98925->regmapL, MAX98925_R01B_DAI_CLK_MODE2,
+			M98925_DAI_SR_MASK, dai_sr << M98925_DAI_SR_SHIFT);
+	regmap_update_bits(max98925->regmapR, MAX98925_R01B_DAI_CLK_MODE2,
+			M98925_DAI_SR_MASK, dai_sr << M98925_DAI_SR_SHIFT);
+	/*
+	 * 2. set DAI m divider
+	 */
+	regmap_write(max98925->regmapL, MAX98925_R01C_DAI_CLK_DIV_M_MSBS,
+			m >> 8);
+	regmap_write(max98925->regmapL, MAX98925_R01D_DAI_CLK_DIV_M_LSBS,
+			m & 0xFF);
+	/*
+	 * 3. set DAI n divider
+	 */
+	regmap_write(max98925->regmapL, MAX98925_R01E_DAI_CLK_DIV_N_MSBS,
+			n >> 8);
+	regmap_write(max98925->regmapL, MAX98925_R01F_DAI_CLK_DIV_N_LSBS,
+			n & 0xFF);
+	/*
+	 * 4. set MDLL
+	 */
+	regmap_update_bits(max98925->regmapL, MAX98925_R01A_DAI_CLK_MODE1,
+			M98925_MDLL_MULT_MASK, mdll << M98925_MDLL_MULT_SHIFT);
+	regmap_update_bits(max98925->regmapR, MAX98925_R01A_DAI_CLK_MODE1,
+			M98925_MDLL_MULT_MASK, mdll << M98925_MDLL_MULT_SHIFT);
+
+	return 0;
+}
+
+static int max98925_dai_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	struct max98925_cdata *cdata;
+	unsigned int rate;
+
+	cdata = &max98925->dai[0];
+	rate = params_rate(params);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		regmap_update_bits(max98925->regmapL, MAX98925_R020_FORMAT,
+				M98925_DAI_CHANSZ_MASK, M98925_DAI_CHANSZ_16);
+		regmap_update_bits(max98925->regmapR, MAX98925_R020_FORMAT,
+				M98925_DAI_CHANSZ_MASK, M98925_DAI_CHANSZ_16);
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		regmap_update_bits(max98925->regmapL, MAX98925_R020_FORMAT,
+				M98925_DAI_CHANSZ_MASK, M98925_DAI_CHANSZ_32);
+		regmap_update_bits(max98925->regmapR, MAX98925_R020_FORMAT,
+				M98925_DAI_CHANSZ_MASK, M98925_DAI_CHANSZ_32);
+		pr_debug("%s: (really set to 32 bits)\n", __func__);
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		regmap_update_bits(max98925->regmapL, MAX98925_R020_FORMAT,
+				M98925_DAI_CHANSZ_MASK, M98925_DAI_CHANSZ_32);
+		regmap_update_bits(max98925->regmapR, MAX98925_R020_FORMAT,
+				M98925_DAI_CHANSZ_MASK, M98925_DAI_CHANSZ_32);
+		break;
+	default:
+		pr_err("%s: format unsupported %d",
+				__func__, params_format(params));
+		return -EINVAL;
+	}
+	pr_debug("%s: format supported %d", __func__, params_format(params));
+	return max98925_set_clock(max98925, rate);
+}
+
+static int max98925_dai_set_sysclk(struct snd_soc_dai *dai,
+				   int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+
+	pr_debug("%s: clk_id %d, freq %d, dir %d\n",
+				__func__, clk_id, freq, dir);
+	max98925->sysclk = freq;
+	return 0;
+}
+
+static int max98925_dai_digital_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+	struct max98925_priv *max98925 =
+				snd_soc_codec_get_drvdata(codec_dai->codec);
+
+	pr_debug("%s: mute %d\n", __func__, mute);
+	if (mute) {
+		regmap_update_bits(max98925->regmapL, MAX98925_R02D_GAIN,
+			M98925_SPK_GAIN_MASK, 0x00);
+		regmap_update_bits(max98925->regmapR, MAX98925_R02D_GAIN,
+			M98925_SPK_GAIN_MASK, 0x00);
+
+		regmap_update_bits(max98925->regmapL,
+			MAX98925_R038_GLOBAL_ENABLE, M98925_EN_MASK, 0x0);
+		regmap_update_bits(max98925->regmapR,
+			MAX98925_R038_GLOBAL_ENABLE, M98925_EN_MASK, 0x0);
+	} else	{
+		regmap_update_bits(max98925->regmapL, MAX98925_R02D_GAIN,
+			M98925_SPK_GAIN_MASK, max98925->spk_gain);
+		regmap_update_bits(max98925->regmapR, MAX98925_R02D_GAIN,
+			M98925_SPK_GAIN_MASK, max98925->spk_gain);
+
+		regmap_update_bits(max98925->regmapL,
+			MAX98925_R036_BLOCK_ENABLE,
+			M98925_BST_EN_MASK | M98925_SPK_EN_MASK |
+			M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK,
+			M98925_BST_EN_MASK | M98925_SPK_EN_MASK |
+			M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK);
+		regmap_update_bits(max98925->regmapR,
+			MAX98925_R036_BLOCK_ENABLE,
+			M98925_BST_EN_MASK | M98925_SPK_EN_MASK |
+			M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK,
+			M98925_BST_EN_MASK | M98925_SPK_EN_MASK |
+			M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK);
+
+		regmap_write(max98925->regmapL, MAX98925_R038_GLOBAL_ENABLE,
+			M98925_EN_MASK);
+		regmap_write(max98925->regmapR, MAX98925_R038_GLOBAL_ENABLE,
+			M98925_EN_MASK);
+	}
+	return 0;
+}
+
+#define MAX98925_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_ops max98925_dai_ops = {
+	.set_sysclk = max98925_dai_set_sysclk,
+	.set_fmt = max98925_dai_set_fmt,
+	.set_tdm_slot = max98925_set_tdm_slot,
+	.hw_params = max98925_dai_hw_params,
+	.digital_mute = max98925_dai_digital_mute,
+};
+
+static struct snd_soc_dai_driver max98925_dai[] = {
+	{
+		.name = "max98925-aif1",
+		.playback = {
+			.stream_name = "HiFi Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = MAX98925_FORMATS,
+		},
+		.capture = {
+			.stream_name = "HiFi Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = MAX98925_FORMATS,
+		},
+		.ops = &max98925_dai_ops,
+	}
+};
+
+static void max98925_handle_pdata(struct snd_soc_codec *codec)
+{
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	struct max98925_pdata *pdata = max98925->pdata;
+
+	if (!pdata) {
+		dev_dbg(codec->dev, "No platform data\n");
+		return;
+	}
+}
+
+static int max98925_probe(struct snd_soc_codec *codec)
+{
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	struct max98925_cdata *cdata;
+	int ret = 0;
+	int reg = 0;
+
+	dev_info(codec->dev, "build number %s\n", MAX98925_REVISION);
+
+	max98925->codec = codec;
+	codec->control_data = max98925->regmapL;
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
+
+	max98925->sysclk = (unsigned)-1;
+	max98925->spk_gain = 0x14;
+
+	cdata = &max98925->dai[0];
+	cdata->rate = (unsigned)-1;
+	cdata->fmt  = (unsigned)-1;
+
+	reg = 0;
+	ret = regmap_read(max98925->regmapL, MAX98925_R0FF_VERSION, &reg);
+	if ((ret < 0) ||
+		((reg != MAX98925_VERSION) && (reg != MAX98925_VERSION1))) {
+		dev_err(codec->dev,
+			"L device initialization error (%d 0x%02X)\n",
+			ret,
+			reg);
+		goto err_access;
+	}
+	dev_info(codec->dev, "L device version 0x%02X\n", reg);
+
+	if (max98925->regmapR != NULL) {
+		reg = 0;
+		ret = regmap_read(max98925->regmapR,
+				MAX98925_R0FF_VERSION, &reg);
+		if ((ret < 0) || ((reg != MAX98925_VERSION)
+				&& (reg != MAX98925_VERSION1))) {
+			dev_err(codec->dev,
+				"R device initialization error (%d 0x%02X)\n",
+				ret, reg);
+			goto err_access;
+		}
+		dev_info(codec->dev, "R device version 0x%02X\n", reg);
+	}
+	regmap_write(max98925->regmapL, MAX98925_R038_GLOBAL_ENABLE, 0x00);
+	regmap_write(max98925->regmapR, MAX98925_R038_GLOBAL_ENABLE, 0x00);
+
+	/* It's not the default but we need to set DAI_DLY */
+	regmap_write(max98925->regmapL,
+				MAX98925_R020_FORMAT, M98925_DAI_DLY_MASK);
+	regmap_write(max98925->regmapR,
+				MAX98925_R020_FORMAT, M98925_DAI_DLY_MASK);
+
+	regmap_write(max98925->regmapL,
+				MAX98925_R021_TDM_SLOT_SELECT, 0xC8);
+	regmap_write(max98925->regmapR,
+				MAX98925_R021_TDM_SLOT_SELECT, 0xC8);
+
+	regmap_write(max98925->regmapL,
+				MAX98925_R027_DOUT_HIZ_CFG1, 0xFF);
+	regmap_write(max98925->regmapL,
+				MAX98925_R028_DOUT_HIZ_CFG2, 0xFF);
+	regmap_write(max98925->regmapL,
+				MAX98925_R029_DOUT_HIZ_CFG3, 0xFF);
+	regmap_write(max98925->regmapL,
+				MAX98925_R02A_DOUT_HIZ_CFG4, 0xF0);
+	regmap_write(max98925->regmapR,
+				MAX98925_R027_DOUT_HIZ_CFG1, 0xFF);
+	regmap_write(max98925->regmapR,
+				MAX98925_R028_DOUT_HIZ_CFG2, 0xFF);
+	regmap_write(max98925->regmapR,
+				MAX98925_R029_DOUT_HIZ_CFG3, 0xFF);
+	regmap_write(max98925->regmapR,
+				MAX98925_R02A_DOUT_HIZ_CFG4, 0x0F);
+
+	regmap_write(max98925->regmapL,
+				MAX98925_R02C_FILTERS, 0xD8);
+	regmap_write(max98925->regmapR,
+				MAX98925_R02C_FILTERS, 0xD8);
+
+	regmap_write(max98925->regmapL,
+				MAX98925_R034_ALC_CONFIGURATION, 0xF8);
+	regmap_write(max98925->regmapR,
+				MAX98925_R034_ALC_CONFIGURATION, 0xF8);
+
+	regmap_write(max98925->regmapL,
+				MAX98925_R037_CONFIGURATION, 0xF0);
+	regmap_write(max98925->regmapR,
+				MAX98925_R037_CONFIGURATION, 0xF0);
+
+	/* Disable ALC muting */
+	regmap_write(max98925->regmapL,
+				MAX98925_R03A_BOOST_LIMITER, 0xF8);
+	regmap_write(max98925->regmapR,
+				MAX98925_R03A_BOOST_LIMITER, 0xF8);
+
+	regmap_update_bits(max98925->regmapL, MAX98925_R02D_GAIN,
+			M98925_DAC_IN_SEL_MASK, M98925_DAC_IN_SEL_LEFT_DAI);
+	regmap_update_bits(max98925->regmapR, MAX98925_R02D_GAIN,
+			M98925_DAC_IN_SEL_MASK, M98925_DAC_IN_SEL_RIGHT_DAI);
+
+	max98925_handle_pdata(codec);
+	max98925_add_widgets(codec);
+err_access:
+	return ret;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_max98925 = {
+	.probe            = max98925_probe,
+	.set_bias_level   = max98925_set_bias_level,
+};
+
+static const struct regmap_config max98925_regmap = {
+	.reg_bits         = 8,
+	.val_bits         = 8,
+	.max_register     = MAX98925_R0FF_VERSION,
+	.reg_defaults     = max98925_reg,
+	.num_reg_defaults = ARRAY_SIZE(max98925_reg),
+	.volatile_reg     = max98925_volatile_register,
+	.readable_reg     = max98925_readable_register,
+	.cache_type       = REGCACHE_RBTREE,
+};
+
+/* There should be a second MAX98925 on the board */
+static struct i2c_board_info max98925_i2c_second[] = {
+	{
+		I2C_BOARD_INFO("max98925R", 0x32),
+	}
+};
+
+struct i2c_client *add_second_device(int busnum)
+{
+	struct i2c_client *i2c = NULL;
+	struct i2c_adapter *adapter;
+
+	adapter = i2c_get_adapter(busnum);
+	if (adapter != NULL)
+		i2c = i2c_new_device(adapter, max98925_i2c_second);
+
+	return i2c;
+}
+
+static int max98925_i2c_probe(struct i2c_client *i2c_l,
+			     const struct i2c_device_id *id)
+{
+	struct max98925_priv *max98925;
+	struct i2c_client *i2c_r;
+	int ret;
+
+	pr_info("%s: enter, device '%s'\n", __func__, id->name);
+	if (strcmp(id->name, "max98925R") == 0)
+		return 0;
+
+	max98925 = kzalloc(sizeof(struct max98925_priv), GFP_KERNEL);
+	if (max98925 == NULL)
+		return -ENOMEM;
+
+	max98925->devtype = id->driver_data;
+	i2c_set_clientdata(i2c_l, max98925);
+	max98925->control_data = i2c_l;
+	max98925->pdata = i2c_l->dev.platform_data;
+
+	max98925->regmapL = regmap_init_i2c(i2c_l, &max98925_regmap);
+	if (IS_ERR(max98925->regmapL)) {
+		ret = PTR_ERR(max98925->regmapL);
+		dev_err(&i2c_l->dev, "Failed to allocate regmapL: %d\n", ret);
+		goto err_out;
+	}
+
+	/* Check for second MAX98925 */
+	i2c_r = add_second_device(2);
+
+	if (IS_ERR(i2c_r)) {
+		dev_err(&i2c_l->dev, "second MAX98925 not found\n");
+		ret = -ENODEV;
+		goto err_out;
+	} else {
+		max98925->regmapR = regmap_init_i2c(i2c_r, &max98925_regmap);
+		if (IS_ERR(max98925->regmapR)) {
+			ret = PTR_ERR(max98925->regmapR);
+			dev_err(&i2c_r->dev,
+				"Failed to allocate regmapR: %d\n", ret);
+			goto err_out;
+		}
+	}
+	ret = snd_soc_register_codec(&i2c_l->dev, &soc_codec_dev_max98925,
+			max98925_dai, ARRAY_SIZE(max98925_dai));
+err_out:
+	if (ret < 0) {
+		if (max98925->regmapL)
+			regmap_exit(max98925->regmapL);
+		if (max98925->regmapR)
+			regmap_exit(max98925->regmapR);
+		kfree(max98925);
+	}
+	return ret;
+}
+
+static int max98925_i2c_remove(struct i2c_client *client)
+{
+	struct max98925_priv *max98925 = dev_get_drvdata(&client->dev);
+
+	snd_soc_unregister_codec(&client->dev);
+	if (max98925->regmapL)
+		regmap_exit(max98925->regmapL);
+	if (max98925->regmapR)
+		regmap_exit(max98925->regmapL);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static const struct i2c_device_id max98925_i2c_id[] = {
+	{ "max98925", MAX98925 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max98925_i2c_id);
+
+static struct i2c_driver max98925_i2c_driver = {
+	.driver = {
+		.name = "max98925",
+		.owner = THIS_MODULE,
+		.pm = NULL,
+	},
+	.probe  = max98925_i2c_probe,
+	.remove = max98925_i2c_remove,
+	.id_table = max98925_i2c_id,
+};
+
+module_i2c_driver(max98925_i2c_driver);
+
+MODULE_DESCRIPTION("ALSA SoC MAX98925 Stereo driver");
+MODULE_AUTHOR("Ralph Birt <rdbirt@gmail.com>, Anish kumar <anish.kumar@maximintegrated.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/max98925.h b/sound/soc/codecs/max98925.h
new file mode 100644
index 0000000..9d89d34
--- /dev/null
+++ b/sound/soc/codecs/max98925.h
@@ -0,0 +1,842 @@
+/*
+ * max98925.h -- MAX98925 ALSA SoC Audio driver
+ *
+ * Copyright 2011-2012 Maxim Integrated Products
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _MAX98925_H
+#define _MAX98925_H
+
+/* Maximum number of MAX98925 devices in the system this driver can support */
+#define MAX_NUM_MAX98925        2
+#define	MAX98925_VERSION	0x51
+#define	MAX98925_VERSION1	0x80
+
+#define MAX98925_REVISION                 "0.00.0332"
+
+#define MAX98925_R000_VBAT_DATA			0x00
+#define MAX98925_R001_VBST_DATA			0x01
+#define MAX98925_R002_LIVE_STATUS0		0x02
+#define MAX98925_R003_LIVE_STATUS1		0x03
+#define MAX98925_R004_LIVE_STATUS2		0x04
+#define MAX98925_R005_STATE0			0x05
+#define MAX98925_R006_STATE1			0x06
+#define MAX98925_R007_STATE2			0x07
+#define MAX98925_R008_FLAG0			0x08
+#define MAX98925_R009_FLAG1			0x09
+#define MAX98925_R00A_FLAG2			0x0A
+#define MAX98925_R00B_IRQ_ENABLE0		0x0B
+#define MAX98925_R00C_IRQ_ENABLE1		0x0C
+#define MAX98925_R00D_IRQ_ENABLE2		0x0D
+#define MAX98925_R00E_IRQ_CLEAR0		0x0E
+#define MAX98925_R00F_IRQ_CLEAR1		0x0F
+#define MAX98925_R010_IRQ_CLEAR2		0x10
+#define MAX98925_R011_MAP0			0x11
+#define MAX98925_R012_MAP1			0x12
+#define MAX98925_R013_MAP2			0x13
+#define MAX98925_R014_MAP3			0x14
+#define MAX98925_R015_MAP4			0x15
+#define MAX98925_R016_MAP5			0x16
+#define MAX98925_R017_MAP6			0x17
+#define MAX98925_R018_MAP7			0x18
+#define MAX98925_R019_MAP8			0x19
+#define MAX98925_R01A_DAI_CLK_MODE1		0x1A
+#define MAX98925_R01B_DAI_CLK_MODE2		0x1B
+#define MAX98925_R01C_DAI_CLK_DIV_M_MSBS	0x1C
+#define MAX98925_R01D_DAI_CLK_DIV_M_LSBS	0x1D
+#define MAX98925_R01E_DAI_CLK_DIV_N_MSBS	0x1E
+#define MAX98925_R01F_DAI_CLK_DIV_N_LSBS	0x1F
+#define MAX98925_R020_FORMAT			0x20
+#define MAX98925_R021_TDM_SLOT_SELECT		0x21
+#define MAX98925_R022_DOUT_CFG_VMON		0x22
+#define MAX98925_R023_DOUT_CFG_IMON		0x23
+#define MAX98925_R024_DOUT_CFG_VBAT		0x24
+#define MAX98925_R025_DOUT_CFG_VBST		0x25
+#define MAX98925_R026_DOUT_CFG_FLAG		0x26
+#define MAX98925_R027_DOUT_HIZ_CFG1		0x27
+#define MAX98925_R028_DOUT_HIZ_CFG2		0x28
+#define MAX98925_R029_DOUT_HIZ_CFG3		0x29
+#define MAX98925_R02A_DOUT_HIZ_CFG4		0x2A
+#define MAX98925_R02B_DOUT_DRV_STRENGTH		0x2B
+#define MAX98925_R02C_FILTERS			0x2C
+#define MAX98925_R02D_GAIN			0x2D
+#define MAX98925_R02E_GAIN_RAMPING		0x2E
+#define MAX98925_R02F_SPK_AMP			0x2F
+#define MAX98925_R030_THRESHOLD			0x30
+#define MAX98925_R031_ALC_ATTACK		0x31
+#define MAX98925_R032_ALC_ATTEN_RLS		0x32
+#define MAX98925_R033_ALC_HOLD_RLS		0x33
+#define MAX98925_R034_ALC_CONFIGURATION		0x34
+#define MAX98925_R035_BOOST_CONVERTER		0x35
+#define MAX98925_R036_BLOCK_ENABLE		0x36
+#define MAX98925_R037_CONFIGURATION		0x37
+#define MAX98925_R038_GLOBAL_ENABLE		0x38
+#define MAX98925_R03A_BOOST_LIMITER		0x3A
+#define MAX98925_R0FF_VERSION			0xFF
+
+#define MAX98925_REG_CNT               (MAX98925_R03A_BOOST_LIMITER+1)
+
+/* MAX98925 Register Bit Fields */
+
+/* MAX98925_R002_LIVE_STATUS0 */
+#define M98925_THERMWARN_STATUS_MASK		(1<<3)
+#define M98925_THERMWARN_STATUS_SHIFT		3
+#define M98925_THERMWARN_STATUS_WIDTH		1
+#define M98925_THERMSHDN_STATUS_MASK		(1<<1)
+#define M98925_THERMSHDN_STATUS_SHIFT		1
+#define M98925_THERMSHDN_STATUS_WIDTH		1
+
+/* MAX98925_R003_LIVE_STATUS1 */
+#define M98925_SPKCURNT_STATUS_MASK			(1<<5)
+#define M98925_SPKCURNT_STATUS_SHIFT		5
+#define M98925_SPKCURNT_STATUS_WIDTH		1
+#define M98925_WATCHFAIL_STATUS_MASK		(1<<4)
+#define M98925_WATCHFAIL_STATUS_SHIFT		4
+#define M98925_WATCHFAIL_STATUS_WIDTH		1
+#define M98925_ALCINFH_STATUS_MASK		(1<<3)
+#define M98925_ALCINFH_STATUS_SHIFT		3
+#define M98925_ALCINFH_STATUS_WIDTH		1
+#define M98925_ALCACT_STATUS_MASK		(1<<2)
+#define M98925_ALCACT_STATUS_SHIFT		2
+#define M98925_ALCACT_STATUS_WIDTH		1
+#define M98925_ALCMUT_STATUS_MASK		(1<<1)
+#define M98925_ALCMUT_STATUS_SHIFT		1
+#define M98925_ALCMUT_STATUS_WIDTH		1
+#define M98925_ACLP_STATUS_MASK			(1<<0)
+#define M98925_ACLP_STATUS_SHIFT		0
+#define M98925_ACLP_STATUS_WIDTH		1
+
+/* MAX98925_R004_LIVE_STATUS2 */
+#define M98925_SLOTOVRN_STATUS_MASK		(1<<6)
+#define M98925_SLOTOVRN_STATUS_SHIFT		6
+#define M98925_SLOTOVRN_STATUS_WIDTH		1
+#define M98925_INVALSLOT_STATUS_MASK		(1<<5)
+#define M98925_INVALSLOT_STATUS_SHIFT		5
+#define M98925_INVALSLOT_STATUS_WIDTH		1
+#define M98925_SLOTCNFLT_STATUS_MASK		(1<<4)
+#define M98925_SLOTCNFLT_STATUS_SHIFT		4
+#define M98925_SLOTCNFLT_STATUS_WIDTH		1
+#define M98925_VBSTOVFL_STATUS_MASK		(1<<3)
+#define M98925_VBSTOVFL_STATUS_SHIFT		3
+#define M98925_VBSTOVFL_STATUS_WIDTH		1
+#define M98925_VBATOVFL_STATUS_MASK		(1<<2)
+#define M98925_VBATOVFL_STATUS_SHIFT		2
+#define M98925_VBATOVFL_STATUS_WIDTH		1
+#define M98925_IMONOVFL_STATUS_MASK		(1<<1)
+#define M98925_IMONOVFL_STATUS_SHIFT		1
+#define M98925_IMONOVFL_STATUS_WIDTH		1
+#define M98925_VMONOVFL_STATUS_MASK		(1<<0)
+#define M98925_VMONOVFL_STATUS_SHIFT		0
+#define M98925_VMONOVFL_STATUS_WIDTH		1
+
+/* MAX98925_R005_STATE0 */
+#define M98925_THERMWARN_END_STATE_MASK		(1<<3)
+#define M98925_THERMWARN_END_STATE_SHIFT	3
+#define M98925_THERMWARN_END_STATE_WIDTH	1
+#define M98925_THERMWARN_BGN_STATE_MASK		(1<<2)
+#define M98925_THERMWARN_BGN_STATE_SHIFT	1
+#define M98925_THERMWARN_BGN_STATE_WIDTH	1
+#define M98925_THERMSHDN_END_STATE_MASK		(1<<1)
+#define M98925_THERMSHDN_END_STATE_SHIFT	1
+#define M98925_THERMSHDN_END_STATE_WIDTH	1
+#define M98925_THERMSHDN_BGN_STATE_MASK		(1<<0)
+#define M98925_THERMSHDN_BGN_STATE_SHIFT	0
+#define M98925_THERMSHDN_BGN_STATE_WIDTH	1
+
+/* MAX98925_R006_STATE1 */
+#define M98925_SPRCURNT_STATE_MASK		(1<<5)
+#define M98925_SPRCURNT_STATE_SHIFT		5
+#define M98925_SPRCURNT_STATE_WIDTH		1
+#define M98925_WATCHFAIL_STATE_MASK		(1<<4)
+#define M98925_WATCHFAIL_STATE_SHIFT		4
+#define M98925_WATCHFAIL_STATE_WIDTH		1
+#define M98925_ALCINFH_STATE_MASK		(1<<3)
+#define M98925_ALCINFH_STATE_SHIFT		3
+#define M98925_ALCINFH_STATE_WIDTH		1
+#define M98925_ALCACT_STATE_MASK		(1<<2)
+#define M98925_ALCACT_STATE_SHIFT		2
+#define M98925_ALCACT_STATE_WIDTH		1
+#define M98925_ALCMUT_STATE_MASK		(1<<1)
+#define M98925_ALCMUT_STATE_SHIFT		1
+#define M98925_ALCMUT_STATE_WIDTH		1
+#define M98925_ALCP_STATE_MASK			(1<<0)
+#define M98925_ALCP_STATE_SHIFT			0
+#define M98925_ALCP_STATE_WIDTH			1
+
+/* MAX98925_R007_STATE2 */
+#define M98925_SLOTOVRN_STATE_MASK		(1<<6)
+#define M98925_SLOTOVRN_STATE_SHIFT		6
+#define M98925_SLOTOVRN_STATE_WIDTH		1
+#define M98925_INVALSLOT_STATE_MASK		(1<<5)
+#define M98925_INVALSLOT_STATE_SHIFT		5
+#define M98925_INVALSLOT_STATE_WIDTH		1
+#define M98925_SLOTCNFLT_STATE_MASK		(1<<4)
+#define M98925_SLOTCNFLT_STATE_SHIFT		4
+#define M98925_SLOTCNFLT_STATE_WIDTH		1
+#define M98925_VBSTOVFL_STATE_MASK		(1<<3)
+#define M98925_VBSTOVFL_STATE_SHIFT		3
+#define M98925_VBSTOVFL_STATE_WIDTH		1
+#define M98925_VBATOVFL_STATE_MASK		(1<<2)
+#define M98925_VBATOVFL_STATE_SHIFT		2
+#define M98925_VBATOVFL_STATE_WIDTH		1
+#define M98925_IMONOVFL_STATE_MASK		(1<<1)
+#define M98925_IMONOVFL_STATE_SHIFT		1
+#define M98925_IMONOVFL_STATE_WIDTH		1
+#define M98925_VMONOVFL_STATE_MASK		(1<<0)
+#define M98925_VMONOVFL_STATE_SHIFT		0
+#define M98925_VMONOVFL_STATE_WIDTH		1
+
+/* MAX98925_R008_FLAG0 */
+#define M98925_THERMWARN_END_FLAG_MASK		(1<<3)
+#define M98925_THERMWARN_END_FLAG_SHIFT		3
+#define M98925_THERMWARN_END_FLAG_WIDTH		1
+#define M98925_THERMWARN_BGN_FLAG_MASK		(1<<2)
+#define M98925_THERMWARN_BGN_FLAG_SHIFT		2
+#define M98925_THERMWARN_BGN_FLAG_WIDTH		1
+#define M98925_THERMSHDN_END_FLAG_MASK		(1<<1)
+#define M98925_THERMSHDN_END_FLAG_SHIFT		1
+#define M98925_THERMSHDN_END_FLAG_WIDTH		1
+#define M98925_THERMSHDN_BGN_FLAG_MASK		(1<<0)
+#define M98925_THERMSHDN_BGN_FLAG_SHIFT		0
+#define M98925_THERMSHDN_BGN_FLAG_WIDTH		1
+
+/* MAX98925_R009_FLAG1 */
+#define M98925_SPKCURNT_FLAG_MASK		(1<<5)
+#define M98925_SPKCURNT_FLAG_SHIFT		5
+#define M98925_SPKCURNT_FLAG_WIDTH		1
+#define M98925_WATCHFAIL_FLAG_MASK		(1<<4)
+#define M98925_WATCHFAIL_FLAG_SHIFT		4
+#define M98925_WATCHFAIL_FLAG_WIDTH		1
+#define M98925_ALCINFH_FLAG_MASK		(1<<3)
+#define M98925_ALCINFH_FLAG_SHIFT		3
+#define M98925_ALCINFH_FLAG_WIDTH		1
+#define M98925_ALCACT_FLAG_MASK			(1<<2)
+#define M98925_ALCACT_FLAG_SHIFT		2
+#define M98925_ALCACT_FLAG_WIDTH		1
+#define M98925_ALCMUT_FLAG_MASK			(1<<1)
+#define M98925_ALCMUT_FLAG_SHIFT		1
+#define M98925_ALCMUT_FLAG_WIDTH		1
+#define M98925_ALCP_FLAG_MASK			(1<<0)
+#define M98925_ALCP_FLAG_SHIFT			0
+#define M98925_ALCP_FLAG_WIDTH			1
+
+/* MAX98925_R00A_FLAG2 */
+#define M98925_SLOTOVRN_FLAG_MASK		(1<<6)
+#define M98925_SLOTOVRN_FLAG_SHIFT		6
+#define M98925_SLOTOVRN_FLAG_WIDTH		1
+#define M98925_INVALSLOT_FLAG_MASK		(1<<5)
+#define M98925_INVALSLOT_FLAG_SHIFT		5
+#define M98925_INVALSLOT_FLAG_WIDTH		1
+#define M98925_SLOTCNFLT_FLAG_MASK		(1<<4)
+#define M98925_SLOTCNFLT_FLAG_SHIFT		4
+#define M98925_SLOTCNFLT_FLAG_WIDTH		1
+#define M98925_VBSTOVFL_FLAG_MASK		(1<<3)
+#define M98925_VBSTOVFL_FLAG_SHIFT		3
+#define M98925_VBSTOVFL_FLAG_WIDTH		1
+#define M98925_VBATOVFL_FLAG_MASK		(1<<2)
+#define M98925_VBATOVFL_FLAG_SHIFT		2
+#define M98925_VBATOVFL_FLAG_WIDTH		1
+#define M98925_IMONOVFL_FLAG_MASK		(1<<1)
+#define M98925_IMONOVFL_FLAG_SHIFT		1
+#define M98925_IMONOVFL_FLAG_WIDTH		1
+#define M98925_VMONOVFL_FLAG_MASK		(1<<0)
+#define M98925_VMONOVFL_FLAG_SHIFT		0
+#define M98925_VMONOVFL_FLAG_WIDTH		1
+
+/* MAX98925_R00B_IRQ_ENABLE0 */
+#define M98925_THERMWARN_END_EN_MASK		(1<<3)
+#define M98925_THERMWARN_END_EN_SHIFT		3
+#define M98925_THERMWARN_END_EN_WIDTH		1
+#define M98925_THERMWARN_BGN_EN_MASK		(1<<2)
+#define M98925_THERMWARN_BGN_EN_SHIFT		2
+#define M98925_THERMWARN_BGN_EN_WIDTH		1
+#define M98925_THERMSHDN_END_EN_MASK		(1<<1)
+#define M98925_THERMSHDN_END_EN_SHIFT		1
+#define M98925_THERMSHDN_END_EN_WIDTH		1
+#define M98925_THERMSHDN_BGN_EN_MASK		(1<<0)
+#define M98925_THERMSHDN_BGN_EN_SHIFT		0
+#define M98925_THERMSHDN_BGN_EN_WIDTH		1
+
+/* MAX98925_R00C_IRQ_ENABLE1 */
+#define M98925_SPKCURNT_EN_MASK			(1<<5)
+#define M98925_SPKCURNT_EN_SHIFT		5
+#define M98925_SPKCURNT_EN_WIDTH		1
+#define M98925_WATCHFAIL_EN_MASK		(1<<4)
+#define M98925_WATCHFAIL_EN_SHIFT		4
+#define M98925_WATCHFAIL_EN_WIDTH		1
+#define M98925_ALCINFH_EN_MASK			(1<<3)
+#define M98925_ALCINFH_EN_SHIFT			3
+#define M98925_ALCINFH_EN_WIDTH			1
+#define M98925_ALCACT_EN_MASK			(1<<2)
+#define M98925_ALCACT_EN_SHIFT			2
+#define M98925_ALCACT_EN_WIDTH			1
+#define M98925_ALCMUT_EN_MASK			(1<<1)
+#define M98925_ALCMUT_EN_SHIFT			1
+#define M98925_ALCMUT_EN_WIDTH			1
+#define M98925_ALCP_EN_MASK			(1<<0)
+#define M98925_ALCP_EN_SHIFT			0
+#define M98925_ALCP_EN_WIDTH			1
+
+/* MAX98925_R00D_IRQ_ENABLE2 */
+#define M98925_SLOTOVRN_EN_MASK			(1<<6)
+#define M98925_SLOTOVRN_EN_SHIFT		6
+#define M98925_SLOTOVRN_EN_WIDTH		1
+#define M98925_INVALSLOT_EN_MASK		(1<<5)
+#define M98925_INVALSLOT_EN_SHIFT		5
+#define M98925_INVALSLOT_EN_WIDTH		1
+#define M98925_SLOTCNFLT_EN_MASK		(1<<4)
+#define M98925_SLOTCNFLT_EN_SHIFT		4
+#define M98925_SLOTCNFLT_EN_WIDTH		1
+#define M98925_VBSTOVFL_EN_MASK			(1<<3)
+#define M98925_VBSTOVFL_EN_SHIFT		3
+#define M98925_VBSTOVFL_EN_WIDTH		1
+#define M98925_VBATOVFL_EN_MASK			(1<<2)
+#define M98925_VBATOVFL_EN_SHIFT		2
+#define M98925_VBATOVFL_EN_WIDTH		1
+#define M98925_IMONOVFL_EN_MASK			(1<<1)
+#define M98925_IMONOVFL_EN_SHIFT		1
+#define M98925_IMONOVFL_EN_WIDTH		1
+#define M98925_VMONOVFL_EN_MASK			(1<<0)
+#define M98925_VMONOVFL_EN_SHIFT		0
+#define M98925_VMONOVFL_EN_WIDTH		1
+
+/* MAX98925_R00E_IRQ_CLEAR0 */
+#define M98925_THERMWARN_END_CLR_MASK		(1<<3)
+#define M98925_THERMWARN_END_CLR_SHIFT		3
+#define M98925_THERMWARN_END_CLR_WIDTH		1
+#define M98925_THERMWARN_BGN_CLR_MASK		(1<<2)
+#define M98925_THERMWARN_BGN_CLR_SHIFT		2
+#define M98925_THERMWARN_BGN_CLR_WIDTH		1
+#define M98925_THERMSHDN_END_CLR_MASK		(1<<1)
+#define M98925_THERMSHDN_END_CLR_SHIFT		1
+#define M98925_THERMSHDN_END_CLR_WIDTH		1
+#define M98925_THERMSHDN_BGN_CLR_MASK		(1<<0)
+#define M98925_THERMSHDN_BGN_CLR_SHIFT		0
+#define M98925_THERMSHDN_BGN_CLR_WIDTH		1
+
+/* MAX98925_R00F_IRQ_CLEAR1 */
+#define M98925_SPKCURNT_CLR_MASK		(1<<5)
+#define M98925_SPKCURNT_CLR_SHIFT		5
+#define M98925_SPKCURNT_CLR_WIDTH		1
+#define M98925_WATCHFAIL_CLR_MASK		(1<<4)
+#define M98925_WATCHFAIL_CLR_SHIFT		4
+#define M98925_WATCHFAIL_CLR_WIDTH		1
+#define M98925_ALCINFH_CLR_MASK			(1<<3)
+#define M98925_ALCINFH_CLR_SHIFT		3
+#define M98925_ALCINFH_CLR_WIDTH		1
+#define M98925_ALCACT_CLR_MASK			(1<<2)
+#define M98925_ALCACT_CLR_SHIFT			2
+#define M98925_ALCACT_CLR_WIDTH			1
+#define M98925_ALCMUT_CLR_MASK			(1<<1)
+#define M98925_ALCMUT_CLR_SHIFT			1
+#define M98925_ALCMUT_CLR_WIDTH			1
+#define M98925_ALCP_CLR_MASK			(1<<0)
+#define M98925_ALCP_CLR_SHIFT			0
+#define M98925_ALCP_CLR_WIDTH			1
+
+/* MAX98925_R010_IRQ_CLEAR2 */
+#define M98925_SLOTOVRN_CLR_MASK		(1<<6)
+#define M98925_SLOTOVRN_CLR_SHIFT		6
+#define M98925_SLOTOVRN_CLR_WIDTH		1
+#define M98925_INVALSLOT_CLR_MASK		(1<<5)
+#define M98925_INVALSLOT_CLR_SHIFT		5
+#define M98925_INVALSLOT_CLR_WIDTH		1
+#define M98925_SLOTCNFLT_CLR_MASK		(1<<4)
+#define M98925_SLOTCNFLT_CLR_SHIFT		4
+#define M98925_SLOTCNFLT_CLR_WIDTH		1
+#define M98925_VBSTOVFL_CLR_MASK		(1<<3)
+#define M98925_VBSTOVFL_CLR_SHIFT		3
+#define M98925_VBSTOVFL_CLR_WIDTH		1
+#define M98925_VBATOVFL_CLR_MASK		(1<<2)
+#define M98925_VBATOVFL_CLR_SHIFT		2
+#define M98925_VBATOVFL_CLR_WIDTH		1
+#define M98925_IMONOVFL_CLR_MASK		(1<<1)
+#define M98925_IMONOVFL_CLR_SHIFT		1
+#define M98925_IMONOVFL_CLR_WIDTH		1
+#define M98925_VMONOVFL_CLR_MASK		(1<<0)
+#define M98925_VMONOVFL_CLR_SHIFT		0
+#define M98925_VMONOVFL_CLR_WIDTH		1
+
+/* MAX98925_R011_MAP0 */
+#define M98925_ER_THERMWARN_EN_MASK		(1<<7)
+#define M98925_ER_THERMWARN_EN_SHIFT		7
+#define M98925_ER_THERMWARN_EN_WIDTH		1
+#define M98925_ER_THERMWARN_MAP_MASK		(0x07<<4)
+#define M98925_ER_THERMWARN_MAP_SHIFT		4
+#define M98925_ER_THERMWARN_MAP_WIDTH		3
+
+/* MAX98925_R012_MAP1 */
+#define M98925_ER_ALCMUT_EN_MASK		(1<<7)
+#define M98925_ER_ALCMUT_EN_SHIFT		7
+#define M98925_ER_ALCMUT_EN_WIDTH		1
+#define M98925_ER_ALCMUT_MAP_MASK		(0x07<<4)
+#define M98925_ER_ALCMUT_MAP_SHIFT		4
+#define M98925_ER_ALCMUT_MAP_WIDTH		3
+#define M98925_ER_ALCP_EN_MASK			(1<<3)
+#define M98925_ER_ALCP_EN_SHIFT			3
+#define M98925_ER_ALCP_EN_WIDTH			1
+#define M98925_ER_ALCP_MAP_MASK			(0x07<<0)
+#define M98925_ER_ALCP_MAP_SHIFT		0
+#define M98925_ER_ALCP_MAP_WIDTH		3
+
+/* MAX98925_R013_MAP2 */
+#define M98925_ER_ALCINFH_EN_MASK		(1<<7)
+#define M98925_ER_ALCINFH_EN_SHIFT		7
+#define M98925_ER_ALCINFH_EN_WIDTH		1
+#define M98925_ER_ALCINFH_MAP_MASK		(0x07<<4)
+#define M98925_ER_ALCINFH_MAP_SHIFT		4
+#define M98925_ER_ALCINFH_MAP_WIDTH		3
+#define M98925_ER_ALCACT_EN_MASK		(1<<3)
+#define M98925_ER_ALCACT_EN_SHIFT		3
+#define M98925_ER_ALCACT_EN_WIDTH		1
+#define M98925_ER_ALCACT_MAP_MASK		(0x07<<0)
+#define M98925_ER_ALCACT_MAP_SHIFT		0
+#define M98925_ER_ALCACT_MAP_WIDTH		3
+
+/* MAX98925_R014_MAP3 */
+#define M98925_ER_SPKCURNT_EN_MASK		(1<<7)
+#define M98925_ER_SPKCURNT_EN_SHIFT		7
+#define M98925_ER_SPKCURNT_EN_WIDTH		1
+#define M98925_ER_SPKCURNT_MAP_MASK		(0x07<<4)
+#define M98925_ER_SPKCURNT_MAP_SHIFT		4
+#define M98925_ER_SPKCURNT_MAP_WIDTH		3
+
+/* MAX98925_R015_MAP4 */
+/* RESERVED */
+
+/* MAX98925_R016_MAP5 */
+#define M98925_ER_IMONOVFL_EN_MASK	(1<<7)
+#define M98925_ER_IMONOVFL_EN_SHIFT	7
+#define M98925_ER_IMONOVFL_EN_WIDTH	1
+#define M98925_ER_IMONOVFL_MAP_MASK	(0x07<<4)
+#define M98925_ER_IMONOVFL_MAP_SHIFT	4
+#define M98925_ER_IMONOVFL_MAP_WIDTH	3
+#define M98925_ER_VMONOVFL_EN_MASK	(1<<3)
+#define M98925_ER_VMONOVFL_EN_SHIFT	3
+#define M98925_ER_VMONOVFL_EN_WIDTH	1
+#define M98925_ER_VMONOVFL_MAP_MASK	(0x07<<0)
+#define M98925_ER_VMONOVFL_MAP_SHIFT	0
+#define M98925_ER_VMONOVFL_MAP_WIDTH	3
+
+/* MAX98925_R017_MAP6 */
+#define M98925_ER_VBSTOVFL_EN_MASK	(1<<7)
+#define M98925_ER_VBSTOVFL_EN_SHIFT	7
+#define M98925_ER_VBSTOVFL_EN_WIDTH	1
+#define M98925_ER_VBSTOVFL_MAP_MASK	(0x07<<4)
+#define M98925_ER_VBSTOVFL_MAP_SHIFT	4
+#define M98925_ER_VBSTOVFL_MAP_WIDTH	3
+#define M98925_ER_VBATOVFL_EN_MASK	(1<<3)
+#define M98925_ER_VBATOVFL_EN_SHIFT	3
+#define M98925_ER_VBATOVFL_EN_WIDTH	1
+#define M98925_ER_VBATOVFL_MAP_MASK	(0x07<<0)
+#define M98925_ER_VBATOVFL_MAP_SHIFT	0
+#define M98925_ER_VBATOVFL_MAP_WIDTH	3
+
+/* MAX98925_R018_MAP7 */
+#define M98925_ER_INVALSLOT_EN_MASK	(1<<7)
+#define M98925_ER_INVALSLOT_EN_SHIFT	7
+#define M98925_ER_INVALSLOT_EN_WIDTH	1
+#define M98925_ER_INVALSLOT_MAP_MASK	(0x07<<4)
+#define M98925_ER_INVALSLOT_MAP_SHIFT	4
+#define M98925_ER_INVALSLOT_MAP_WIDTH	3
+#define M98925_ER_SLOTCNFLT_EN_MASK	(1<<3)
+#define M98925_ER_SLOTCNFLT_EN_SHIFT	3
+#define M98925_ER_SLOTCNFLT_EN_WIDTH	1
+#define M98925_ER_SLOTCNFLT_MAP_MASK	(0x07<<0)
+#define M98925_ER_SLOTCNFLT_MAP_SHIFT	0
+#define M98925_ER_SLOTCNFLT_MAP_WIDTH	3
+
+/* MAX98925_R019_MAP8 */
+#define M98925_ER_SLOTOVRN_EN_MASK	(1<<3)
+#define M98925_ER_SLOTOVRN_EN_SHIFT	3
+#define M98925_ER_SLOTOVRN_EN_WIDTH	1
+#define M98925_ER_SLOTOVRN_MAP_MASK	(0x07<<0)
+#define M98925_ER_SLOTOVRN_MAP_SHIFT	0
+#define M98925_ER_SLOTOVRN_MAP_WIDTH	3
+
+/* MAX98925_R01A_DAI_CLK_MODE1 */
+#define M98925_DAI_CLK_SOURCE_MASK	(1<<6)
+#define M98925_DAI_CLK_SOURCE_SHIFT	6
+#define M98925_DAI_CLK_SOURCE_WIDTH	1
+#define M98925_MDLL_MULT_MASK		(0x0F<<0)
+#define M98925_MDLL_MULT_SHIFT		0
+#define M98925_MDLL_MULT_WIDTH		4
+
+#define M98925_MDLL_MULT_MCLKx8		6
+#define M98925_MDLL_MULT_MCLKx16	8
+
+/* MAX98925_R01B_DAI_CLK_MODE2 */
+#define M98925_DAI_SR_MASK		(0x0F<<4)
+#define M98925_DAI_SR_SHIFT		4
+#define M98925_DAI_SR_WIDTH		4
+#define M98925_DAI_MAS_MASK		(1<<3)
+#define M98925_DAI_MAS_SHIFT		3
+#define M98925_DAI_MAS_WIDTH		1
+#define M98925_DAI_BSEL_MASK		(0x07<<0)
+#define M98925_DAI_BSEL_SHIFT		0
+#define M98925_DAI_BSEL_WIDTH		3
+
+#define M98925_DAI_BSEL_32 (0 << M98925_DAI_BSEL_SHIFT)
+#define M98925_DAI_BSEL_48 (1 << M98925_DAI_BSEL_SHIFT)
+#define M98925_DAI_BSEL_64 (2 << M98925_DAI_BSEL_SHIFT)
+#define M98925_DAI_BSEL_256 (6 << M98925_DAI_BSEL_SHIFT)
+
+/* MAX98925_R01C_DAI_CLK_DIV_M_MSBS */
+#define M98925_DAI_M_MSBS_MASK		(0xFF<<0)
+#define M98925_DAI_M_MSBS_SHIFT		0
+#define M98925_DAI_M_MSBS_WIDTH		8
+
+/* MAX98925_R01D_DAI_CLK_DIV_M_LSBS */
+#define M98925_DAI_M_LSBS_MASK		(0xFF<<0)
+#define M98925_DAI_M_LSBS_SHIFT		0
+#define M98925_DAI_M_LSBS_WIDTH		8
+
+/* MAX98925_R01E_DAI_CLK_DIV_N_MSBS */
+#define M98925_DAI_N_MSBS_MASK		(0x7F<<0)
+#define M98925_DAI_N_MSBS_SHIFT		0
+#define M98925_DAI_N_MSBS_WIDTH		7
+
+/* MAX98925_R01F_DAI_CLK_DIV_N_LSBS */
+#define M98925_DAI_N_LSBS_MASK		(0xFF<<0)
+#define M98925_DAI_N_LSBS_SHIFT		0
+#define M98925_DAI_N_LSBS_WIDTH		8
+
+/* MAX98925_R020_FORMAT */
+#define M98925_DAI_CHANSZ_MASK		(0x03<<6)
+#define M98925_DAI_CHANSZ_SHIFT		6
+#define M98925_DAI_CHANSZ_WIDTH		2
+#define M98925_DAI_EXTBCLK_HIZ_MASK		(1<<4)
+#define M98925_DAI_EXTBCLK_HIZ_SHIFT  4
+#define M98925_DAI_EXTBCLK_HIZ_WIDTH  1
+#define M98925_DAI_WCI_MASK			(1<<3)
+#define M98925_DAI_WCI_SHIFT		3
+#define M98925_DAI_WCI_WIDTH		1
+#define M98925_DAI_BCI_MASK			(1<<2)
+#define M98925_DAI_BCI_SHIFT		2
+#define M98925_DAI_BCI_WIDTH		1
+#define M98925_DAI_DLY_MASK			(1<<1)
+#define M98925_DAI_DLY_SHIFT		1
+#define M98925_DAI_DLY_WIDTH		1
+#define M98925_DAI_TDM_MASK			(1<<0)
+#define M98925_DAI_TDM_SHIFT		0
+#define M98925_DAI_TDM_WIDTH					1
+
+#define M98925_DAI_CHANSZ_16 (1 << M98925_DAI_CHANSZ_SHIFT)
+#define M98925_DAI_CHANSZ_24 (2 << M98925_DAI_CHANSZ_SHIFT)
+#define M98925_DAI_CHANSZ_32 (3 << M98925_DAI_CHANSZ_SHIFT)
+
+/* MAX98925_R021_TDM_SLOT_SELECT */
+#define M98925_DAI_DO_EN_MASK			(1<<7)
+#define M98925_DAI_DO_EN_SHIFT			7
+#define M98925_DAI_DO_EN_WIDTH			1
+#define M98925_DAI_DIN_EN_MASK			(1<<6)
+#define M98925_DAI_DIN_EN_SHIFT			6
+#define M98925_DAI_DIN_EN_WIDTH			1
+#define M98925_DAI_INR_SOURCE_MASK		(0x07<<3)
+#define M98925_DAI_INR_SOURCE_SHIFT		3
+#define M98925_DAI_INR_SOURCE_WIDTH		3
+#define M98925_DAI_INL_SOURCE_MASK		(0x07<<0)
+#define M98925_DAI_INL_SOURCE_SHIFT		0
+#define M98925_DAI_INL_SOURCE_WIDTH		3
+
+/* MAX98925_R022_DOUT_CFG_VMON */
+#define M98925_DAI_VMON_EN_MASK			(1<<5)
+#define M98925_DAI_VMON_EN_SHIFT		5
+#define M98925_DAI_VMON_EN_WIDTH		1
+#define M98925_DAI_VMON_SLOT_MASK		(0x1F<<0)
+#define M98925_DAI_VMON_SLOT_SHIFT		0
+#define M98925_DAI_VMON_SLOT_WIDTH		5
+
+#define M98925_DAI_VMON_SLOT_00_01 (0 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_01_02 (1 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_02_03 (2 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_03_04 (3 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_04_05 (4 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_05_06 (5 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_06_07 (6 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_07_08 (7 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_08_09 (8 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_09_0A (9 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_0A_0B (10 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_0B_0C (11 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_0C_0D (12 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_0D_0E (13 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_0E_0F (14 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_0F_10 (15 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_10_11 (16 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_11_12 (17 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_12_13 (18 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_13_14 (19 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_14_15 (20 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_15_16 (21 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_16_17 (22 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_17_18 (23 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_18_19 (24 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_19_1A (25 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_1A_1B (26 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_1B_1C (27 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_1C_1D (28 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_1D_1E (29 << M98925_DAI_VMON_SLOT_SHIFT)
+#define M98925_DAI_VMON_SLOT_1E_1F (30 << M98925_DAI_VMON_SLOT_SHIFT)
+
+/* MAX98925_R023_DOUT_CFG_IMON */
+#define M98925_DAI_IMON_EN_MASK		(1<<5)
+#define M98925_DAI_IMON_EN_SHIFT	5
+#define M98925_DAI_IMON_EN_WIDTH	1
+#define M98925_DAI_IMON_SLOT_MASK	(0x1F<<0)
+#define M98925_DAI_IMON_SLOT_SHIFT	0
+#define M98925_DAI_IMON_SLOT_WIDTH	5
+
+#define M98925_DAI_IMON_SLOT_00_01 (0 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_01_02 (1 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_02_03 (2 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_03_04 (3 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_04_05 (4 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_05_06 (5 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_06_07 (6 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_07_08 (7 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_08_09 (8 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_09_0A (9 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_0A_0B (10 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_0B_0C (11 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_0C_0D (12 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_0D_0E (13 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_0E_0F (14 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_0F_10 (15 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_10_11 (16 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_11_12 (17 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_12_13 (18 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_13_14 (19 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_14_15 (20 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_15_16 (21 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_16_17 (22 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_17_18 (23 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_18_19 (24 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_19_1A (25 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_1A_1B (26 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_1B_1C (27 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_1C_1D (28 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_1D_1E (29 << M98925_DAI_IMON_SLOT_SHIFT)
+#define M98925_DAI_IMON_SLOT_1E_1F (30 << M98925_DAI_IMON_SLOT_SHIFT)
+
+/* MAX98925_R024_DOUT_CFG_VBAT */
+#define M98925_DAI_VBAT_EN_MASK		(1<<5)
+#define M98925_DAI_VBAT_EN_SHIFT	5
+#define M98925_DAI_VBAT_EN_WIDTH	1
+#define M98925_DAI_VBAT_SLOT_MASK	(0x1F<<0)
+#define M98925_DAI_VBAT_SLOT_SHIFT	0
+#define M98925_DAI_VBAT_SLOT_WIDTH	5
+
+/* MAX98925_R025_DOUT_CFG_VBST */
+#define M98925_DAI_VBST_EN_MASK		(1<<5)
+#define M98925_DAI_VBST_EN_SHIFT	5
+#define M98925_DAI_VBST_EN_WIDTH	1
+#define M98925_DAI_VBST_SLOT_MASK	(0x1F<<0)
+#define M98925_DAI_VBST_SLOT_SHIFT	0
+#define M98925_DAI_VBST_SLOT_WIDTH	5
+
+/* MAX98925_R026_DOUT_CFG_FLAG */
+#define M98925_DAI_FLAG_EN_MASK		(1<<5)
+#define M98925_DAI_FLAG_EN_SHIFT	5
+#define M98925_DAI_FLAG_EN_WIDTH	1
+#define M98925_DAI_FLAG_SLOT_MASK	(0x1F<<0)
+#define M98925_DAI_FLAG_SLOT_SHIFT	0
+#define M98925_DAI_FLAG_SLOT_WIDTH	5
+
+/* MAX98925_R027_DOUT_HIZ_CFG1 */
+#define M98925_DAI_SLOT_HIZ_CFG1_MASK	(0xFF<<0)
+#define M98925_DAI_SLOT_HIZ_CFG1_SHIFT	0
+#define M98925_DAI_SLOT_HIZ_CFG1_WIDTH	8
+
+/* MAX98925_R028_DOUT_HIZ_CFG2 */
+#define M98925_DAI_SLOT_HIZ_CFG2_MASK	(0xFF<<0)
+#define M98925_DAI_SLOT_HIZ_CFG2_SHIFT	0
+#define M98925_DAI_SLOT_HIZ_CFG2_WIDTH	8
+
+/* MAX98925_R029_DOUT_HIZ_CFG3 */
+#define M98925_DAI_SLOT_HIZ_CFG3_MASK	(0xFF<<0)
+#define M98925_DAI_SLOT_HIZ_CFG3_SHIFT	0
+#define M98925_DAI_SLOT_HIZ_CFG3_WIDTH	8
+
+/* MAX98925_R02A_DOUT_HIZ_CFG4 */
+#define M98925_DAI_SLOT_HIZ_CFG4_MASK	(0xFF<<0)
+#define M98925_DAI_SLOT_HIZ_CFG4_SHIFT	0
+#define M98925_DAI_SLOT_HIZ_CFG4_WIDTH	8
+
+/* MAX98925_R02B_DOUT_DRV_STRENGTH */
+#define M98925_DAI_OUT_DRIVE_MASK	(0x03<<0)
+#define M98925_DAI_OUT_DRIVE_SHIFT	0
+#define M98925_DAI_OUT_DRIVE_WIDTH	2
+
+/* MAX98925_R02C_FILTERS */
+#define M98925_ADC_DITHER_EN_MASK	(1<<7)
+#define M98925_ADC_DITHER_EN_SHIFT	7
+#define M98925_ADC_DITHER_EN_WIDTH	1
+#define M98925_IV_DCB_EN_MASK		(1<<6)
+#define M98925_IV_DCB_EN_SHIFT		6
+#define M98925_IV_DCB_EN_WIDTH		1
+#define M98925_DAC_DITHER_EN_MASK	(1<<4)
+#define M98925_DAC_DITHER_EN_SHIFT	4
+#define M98925_DAC_DITHER_EN_WIDTH	1
+#define M98925_DAC_FILTER_MODE_MASK	(1<<3)
+#define M98925_DAC_FILTER_MODE_SHIFT	3
+#define M98925_DAC_FILTER_MODE_WIDTH	1
+#define M98925_DAC_HPF_MASK		(0x07<<0)
+#define M98925_DAC_HPF_SHIFT		0
+#define M98925_DAC_HPF_WIDTH		3
+
+/* MAX98925_R02D_GAIN */
+#define M98925_DAC_IN_SEL_MASK		(0x03<<5)
+#define M98925_DAC_IN_SEL_SHIFT		5
+#define M98925_DAC_IN_SEL_WIDTH		2
+#define M98925_SPK_GAIN_MASK		(0x1F<<0)
+#define M98925_SPK_GAIN_SHIFT		0
+#define M98925_SPK_GAIN_WIDTH		5
+
+#define M98925_DAC_IN_SEL_LEFT_DAI (0 << M98925_DAC_IN_SEL_SHIFT)
+#define M98925_DAC_IN_SEL_RIGHT_DAI (1 << M98925_DAC_IN_SEL_SHIFT)
+#define M98925_DAC_IN_SEL_SUMMED_DAI (2 << M98925_DAC_IN_SEL_SHIFT)
+#define M98925_DAC_IN_SEL_DIV2_SUMMED_DAI (3 << M98925_DAC_IN_SEL_SHIFT)
+
+/* MAX98925_R02E_GAIN_RAMPING */
+#define M98925_SPK_RMP_EN_MASK		(1<<1)
+#define M98925_SPK_RMP_EN_SHIFT		1
+#define M98925_SPK_RMP_EN_WIDTH		1
+#define M98925_SPK_ZCD_EN_MASK		(1<<0)
+#define M98925_SPK_ZCD_EN_SHIFT		0
+#define M98925_SPK_ZCD_EN_WIDTH		1
+
+/* MAX98925_R02F_SPK_AMP */
+#define M98925_SPK_MODE_MASK		(1<<0)
+#define M98925_SPK_MODE_SHIFT		0
+#define M98925_SPK_MODE_WIDTH		1
+
+/* MAX98925_R030_THRESHOLD */
+#define M98925_ALC_EN_MASK		(1<<5)
+#define M98925_ALC_EN_SHIFT		5
+#define M98925_ALC_EN_WIDTH		1
+#define M98925_ALC_TH_MASK		(0x1F<<0)
+#define M98925_ALC_TH_SHIFT		0
+#define M98925_ALC_TH_WIDTH		5
+
+/* MAX98925_R031_ALC_ATTACK */
+#define M98925_ALC_ATK_STEP_MASK	(0x0F<<4)
+#define M98925_ALC_ATK_STEP_SHIFT	4
+#define M98925_ALC_ATK_STEP_WIDTH	4
+#define M98925_ALC_ATK_RATE_MASK	(0x7<<0)
+#define M98925_ALC_ATK_RATE_SHIFT	0
+#define M98925_ALC_ATK_RATE_WIDTH	3
+
+/* MAX98925_R032_ALC_ATTEN_RLS */
+#define M98925_ALC_MAX_ATTEN_MASK	(0x0F<<4)
+#define M98925_ALC_MAX_ATTEN_SHIFT	4
+#define M98925_ALC_MAX_ATTEN_WIDTH	4
+#define M98925_ALC_RLS_RATE_MASK	(0x7<<0)
+#define M98925_ALC_RLS_RATE_SHIFT	0
+#define M98925_ALC_RLS_RATE_WIDTH	3
+
+/* MAX98925_R033_ALC_HOLD_RLS */
+#define M98925_ALC_RLS_TGR_MASK		(1<<0)
+#define M98925_ALC_RLS_TGR_SHIFT	0
+#define M98925_ALC_RLS_TGR_WIDTH	1
+
+/* MAX98925_R034_ALC_CONFIGURATION */
+#define M98925_ALC_MUTE_EN_MASK		(1<<7)
+#define M98925_ALC_MUTE_EN_SHIFT	7
+#define M98925_ALC_MUTE_EN_WIDTH	1
+#define M98925_ALC_MUTE_DLY_MASK	(0x07<<4)
+#define M98925_ALC_MUTE_DLY_SHIFT	4
+#define M98925_ALC_MUTE_DLY_WIDTH	3
+#define M98925_ALC_RLS_DBT_MASK		(0x07<<0)
+#define M98925_ALC_RLS_DBT_SHIFT	0
+#define M98925_ALC_RLS_DBT_WIDTH	3
+
+/* MAX98925_R035_BOOST_CONVERTER */
+#define M98925_BST_SYNC_MASK		(1<<7)
+#define M98925_BST_SYNC_SHIFT		7
+#define M98925_BST_SYNC_WIDTH		1
+#define M98925_BST_PHASE_MASK		(0x03<<4)
+#define M98925_BST_PHASE_SHIFT		4
+#define M98925_BST_PHASE_WIDTH		2
+#define M98925_BST_SKIP_MODE_MASK	(0x03<<0)
+#define M98925_BST_SKIP_MODE_SHIFT	0
+#define M98925_BST_SKIP_MODE_WIDTH	2
+
+/* MAX98925_R036_BLOCK_ENABLE */
+#define M98925_BST_EN_MASK		(1<<7)
+#define M98925_BST_EN_SHIFT		7
+#define M98925_BST_EN_WIDTH		1
+#define M98925_WATCH_EN_MASK		(1<<6)
+#define M98925_WATCH_EN_SHIFT		6
+#define M98925_WATCH_EN_WIDTH		1
+#define M98925_CLKMON_EN_MASK		(1<<5)
+#define M98925_CLKMON_EN_SHIFT		5
+#define M98925_CLKMON_EN_WIDTH		1
+#define M98925_SPK_EN_MASK		(1<<4)
+#define M98925_SPK_EN_SHIFT		4
+#define M98925_SPK_EN_WIDTH		1
+#define M98925_ADC_VBST_EN_MASK		(1<<3)
+#define M98925_ADC_VBST_EN_SHIFT	3
+#define M98925_ADC_VBST_EN_WIDTH	1
+#define M98925_ADC_VBAT_EN_MASK		(1<<2)
+#define M98925_ADC_VBAT_EN_SHIFT	2
+#define M98925_ADC_VBAT_EN_WIDTH	1
+#define M98925_ADC_IMON_EN_MASK		(1<<1)
+#define M98925_ADC_IMON_EN_SHIFT	1
+#define M98925_ADC_IMON_EN_WIDTH	1
+#define M98925_ADC_VMON_EN_MASK		(1<<0)
+#define M98925_ADC_VMON_EN_SHIFT	0
+#define M98925_ADC_VMON_EN_WIDTH	1
+
+/* MAX98925_R037_CONFIGURATION */
+#define M98925_BST_VOUT_MASK		(0x0F<<4)
+#define M98925_BST_VOUT_SHIFT		4
+#define M98925_BST_VOUT_WIDTH		4
+#define M98925_THERMWARN_LEVEL_MASK	(0x03<<2)
+#define M98925_THERMWARN_LEVEL_SHIFT	2
+#define M98925_THERMWARN_LEVEL_WIDTH	2
+#define M98925_WATCH_TIME_MASK		(0x03<<0)
+#define M98925_WATCH_TIME_SHIFT		0
+#define M98925_WATCH_TIME_WIDTH		2
+
+/* MAX98925_R038_GLOBAL_ENABLE */
+#define M98925_EN_MASK			(1<<7)
+#define M98925_EN_SHIFT			7
+#define M98925_EN_WIDTH			1
+
+/* MAX98925_R03A_BOOST_LIMITER */
+#define M98925_BST_ILIM_MASK		(0x1F<<3)
+#define M98925_BST_ILIM_SHIFT		3
+#define M98925_BST_ILIM_WIDTH		5
+
+/* MAX98925_R0FF_VERSION */
+#define M98925_REV_ID_MASK		(0xFF<<0)
+#define M98925_REV_ID_SHIFT		0
+#define M98925_REV_ID_WIDTH		8
+
+enum max98925_type {
+	MAX98925,
+};
+
+struct max98925_cdata {
+	unsigned int rate;
+	unsigned int fmt;
+};
+
+struct max98925_priv {
+	struct regmap *regmapL;
+	struct regmap *regmapR;
+	struct snd_soc_codec *codec;
+	enum max98925_type devtype;
+	void *control_data;
+	struct max98925_pdata *pdata;
+	unsigned int spk_gain;
+	unsigned int sysclk;
+	unsigned int iv_status;
+	struct max98925_cdata dai[1];
+};
+
+#endif
-- 
1.9.3
