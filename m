From: Anish Kumar <yesanishhere@gmail.com>
Subject: [PATCH] ASoC: Add max98925 codec driver
Date: Mon,  9 Mar 2015 15:50:34 -0700
Message-ID: <1425941434-22720-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id DD0A62614BB
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 23:50:43 +0100 (CET)
Received: by pabli10 with SMTP id li10so76175950pab.2
 for <alsa-devel@alsa-project.org>; Mon, 09 Mar 2015 15:50:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Anish Kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Anish Kumar <yesanishhere@gmail.com>
---
changes in this version:
        - addressed mark brown comments regarding
          probe function.
        - changed the mixer namings
        - added device tree documentation
changes since v1:
	- addressed mark brown comments regarding
	  open coding functions.
	- changed the mixer namings
	- added some dapm widgets
 .../devicetree/bindings/sound/max98925.txt         |  22 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/max98925.c                        | 655 ++++++++++++++++
 sound/soc/codecs/max98925.h                        | 832 +++++++++++++++++++++
 5 files changed, 1515 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98925.txt
 create mode 100644 sound/soc/codecs/max98925.c
 create mode 100644 sound/soc/codecs/max98925.h

diff --git a/Documentation/devicetree/bindings/sound/max98925.txt b/Documentation/devicetree/bindings/sound/max98925.txt
new file mode 100644
index 0000000..27be63e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98925.txt
@@ -0,0 +1,22 @@
+max98925 audio CODEC
+
+This device supports I2C.
+
+Required properties:
+
+  - compatible : "maxim,max98925"
+
+  - vmon-slot-no : slot number used to send voltage information
+
+  - imon-slot-no : slot number used to send current information
+
+  - reg : the I2C address of the device for I2C
+
+Example:
+
+codec: max98925@1a {
+	compatible = "maxim,max98925";
+	vmon-slot-no = <0>;
+	imon-slot-no = <2>;
+	reg = <0x1a>;
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0bddd92..a7f44e3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -68,6 +68,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_LM49453 if I2C
 	select SND_SOC_MAX98088 if I2C
 	select SND_SOC_MAX98090 if I2C
+	select SND_SOC_MAX98925 if I2C
 	select SND_SOC_MAX98095 if I2C
 	select SND_SOC_MAX98357A if GPIOLIB
 	select SND_SOC_MAX9850 if I2C
@@ -455,6 +456,9 @@ config SND_SOC_MAX98088
 config SND_SOC_MAX98090
        tristate
 
+config SND_SOC_MAX98925
+       tristate
+
 config SND_SOC_MAX98095
        tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 7acb6c1..1658d19 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -63,6 +63,7 @@ snd-soc-lm49453-objs := lm49453.o
 snd-soc-max9768-objs := max9768.o
 snd-soc-max98088-objs := max98088.o
 snd-soc-max98090-objs := max98090.o
+snd-soc-max98925-objs := max98925.o
 snd-soc-max98095-objs := max98095.o
 snd-soc-max98357a-objs := max98357a.o
 snd-soc-max9850-objs := max9850.o
@@ -247,6 +248,7 @@ obj-$(CONFIG_SND_SOC_LM49453)   += snd-soc-lm49453.o
 obj-$(CONFIG_SND_SOC_MAX9768)	+= snd-soc-max9768.o
 obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
 obj-$(CONFIG_SND_SOC_MAX98090)	+= snd-soc-max98090.o
+obj-$(CONFIG_SND_SOC_MAX98925)	+= snd-soc-max98925.o
 obj-$(CONFIG_SND_SOC_MAX98095)	+= snd-soc-max98095.o
 obj-$(CONFIG_SND_SOC_MAX98357A)	+= snd-soc-max98357a.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
new file mode 100644
index 0000000..74f4f0b
--- /dev/null
+++ b/sound/soc/codecs/max98925.c
@@ -0,0 +1,655 @@
+/*
+ * max98925.c -- ALSA SoC Stereo MAX98925 driver
+ * Copyright 2013-15 Maxim Integrated Products
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
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
+#include "max98925.h"
+
+static const char *const dai_text[] = {
+	"Left", "Right", "LeftRight", "LeftRightDiv2",
+};
+
+static const char * const max98925_boost_voltage_text[] = {
+	"8.5V", "8.25V", "8.0V", "7.75V", "7.5V", "7.25V", "7.0V", "6.75V",
+	"6.5V", "6.5V", "6.5V", "6.5V", "6.5V", "6.5V",	"6.5V", "6.5V"
+};
+
+static SOC_ENUM_SINGLE_DECL(max98925_boost_voltage,
+	MAX98925_CONFIGURATION, M98925_BST_VOUT_SHIFT,
+	max98925_boost_voltage_text);
+
+static const char *const hpf_text[] = {
+	"Disable", "DC Block", "100Hz",	"200Hz", "400Hz", "800Hz",
+};
+
+static struct reg_default max98925_reg[] = {
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
+};
+
+static const struct soc_enum max98925_dai_enum =
+	SOC_ENUM_SINGLE(MAX98925_GAIN, 5, ARRAY_SIZE(dai_text), dai_text);
+
+static const struct soc_enum max98925_hpf_enum =
+	SOC_ENUM_SINGLE(MAX98925_FILTERS, 0, ARRAY_SIZE(hpf_text), hpf_text);
+
+static const struct snd_kcontrol_new max98925_hpf_sel_mux =
+	SOC_DAPM_ENUM("Rc Filter MUX Mux", max98925_hpf_enum);
+
+static const struct snd_kcontrol_new max98925_dai_sel_mux =
+	SOC_DAPM_ENUM("DAI IN MUX Mux", max98925_dai_enum);
+
+static int max98925_dac_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		regmap_update_bits(max98925->regmap,
+			MAX98925_BLOCK_ENABLE,
+			M98925_BST_EN_MASK |
+			M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK,
+			M98925_BST_EN_MASK |
+			M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_update_bits(max98925->regmap,
+			MAX98925_BLOCK_ENABLE, M98925_BST_EN_MASK |
+			M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK, 0);
+		break;
+	default:
+		return 0;
+	}
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget max98925_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("DAI_OUT", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_MUX("DAI IN MUX", SND_SOC_NOPM, 0, 0,
+				&max98925_dai_sel_mux),
+	SND_SOC_DAPM_MUX("Rc Filter MUX", SND_SOC_NOPM, 0, 0,
+				&max98925_hpf_sel_mux),
+	SND_SOC_DAPM_DAC_E("Amp Enable", NULL, MAX98925_BLOCK_ENABLE,
+			M98925_SPK_EN_SHIFT, 0, max98925_dac_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("Global Enable", MAX98925_GLOBAL_ENABLE,
+			M98925_EN_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("BE_OUT"),
+};
+
+static const struct snd_soc_dapm_route max98925_audio_map[] = {
+	{"DAI IN MUX", "Left", "DAI_OUT"},
+	{"DAI IN MUX", "Right", "DAI_OUT"},
+	{"DAI IN MUX", "LeftRight", "DAI_OUT"},
+	{"DAI IN MUX", "LeftRightDiv2", "DAI_OUT"},
+	{"Rc Filter MUX", "Disable", "DAI IN MUX"},
+	{"Rc Filter MUX", "DC Block", "DAI IN MUX"},
+	{"Rc Filter MUX", "100Hz", "DAI IN MUX"},
+	{"Rc Filter MUX", "200Hz", "DAI IN MUX"},
+	{"Rc Filter MUX", "400Hz", "DAI IN MUX"},
+	{"Rc Filter MUX", "800Hz", "DAI IN MUX"},
+	{"Amp Enable", NULL, "Rc Filter MUX"},
+	{"BE_OUT", NULL, "Amp Enable"},
+	{"BE_OUT", NULL, "Global Enable"},
+};
+
+static bool max98925_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX98925_VBAT_DATA:
+	case MAX98925_VBST_DATA:
+	case MAX98925_LIVE_STATUS0:
+	case MAX98925_LIVE_STATUS1:
+	case MAX98925_LIVE_STATUS2:
+	case MAX98925_STATE0:
+	case MAX98925_STATE1:
+	case MAX98925_STATE2:
+	case MAX98925_FLAG0:
+	case MAX98925_FLAG1:
+	case MAX98925_FLAG2:
+	case MAX98925_REV_VERSION:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool max98925_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX98925_IRQ_CLEAR0:
+	case MAX98925_IRQ_CLEAR1:
+	case MAX98925_IRQ_CLEAR2:
+	case MAX98925_ALC_HOLD_RLS:
+		return false;
+	default:
+		return true;
+	}
+}
+
+DECLARE_TLV_DB_SCALE(max98925_spk_tlv, -600, 100, 0);
+
+static const struct snd_kcontrol_new max98925_snd_controls[] = {
+	SOC_SINGLE_TLV("Speaker Volume", MAX98925_GAIN,
+		M98925_SPK_GAIN_SHIFT, (1<<M98925_SPK_GAIN_WIDTH)-1, 0,
+		max98925_spk_tlv),
+	SOC_SINGLE("Ramp Switch", MAX98925_GAIN_RAMPING,
+				M98925_SPK_RMP_EN_SHIFT, 1, 0),
+	SOC_SINGLE("ZCD Switch", MAX98925_GAIN_RAMPING,
+				M98925_SPK_ZCD_EN_SHIFT, 1, 0),
+	SOC_SINGLE("ALC Switch", MAX98925_THRESHOLD,
+				M98925_ALC_EN_SHIFT, 1, 0),
+	SOC_SINGLE("ALC Threshold", MAX98925_THRESHOLD, M98925_ALC_TH_SHIFT,
+				(1<<M98925_ALC_TH_WIDTH)-1, 0),
+	SOC_ENUM("Boost Output Voltage", max98925_boost_voltage),
+};
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
+static inline int max98925_rate_value(struct snd_soc_codec *codec,
+		int rate, int clock, int *value, int *n, int *m)
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
+	dev_dbg(codec->dev, "%s: sample rate is %d, returning %d\n",
+				__func__, rate_table[i].rate, *value);
+	return ret;
+}
+
+static void max98925_set_sense_data(struct max98925_priv *max98925)
+{
+	/* set VMON slots */
+	regmap_update_bits(max98925->regmap,
+		MAX98925_DOUT_CFG_VMON,
+		M98925_DAI_VMON_EN_MASK, M98925_DAI_VMON_EN_MASK);
+	regmap_update_bits(max98925->regmap,
+		MAX98925_DOUT_CFG_VMON,
+		M98925_DAI_VMON_SLOT_MASK,
+		max98925->v_slot << M98925_DAI_VMON_SLOT_SHIFT);
+	/* set IMON slots */
+	regmap_update_bits(max98925->regmap,
+		MAX98925_DOUT_CFG_IMON,
+		M98925_DAI_IMON_EN_MASK, M98925_DAI_IMON_EN_MASK);
+	regmap_update_bits(max98925->regmap,
+		MAX98925_DOUT_CFG_IMON,
+		M98925_DAI_IMON_SLOT_MASK,
+		max98925->i_slot << M98925_DAI_IMON_SLOT_SHIFT);
+}
+
+static int max98925_dai_set_fmt(struct snd_soc_dai *codec_dai,
+				 unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+	unsigned int invert = 0;
+
+	dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/* set DAI to slave mode */
+		regmap_update_bits(max98925->regmap,
+			MAX98925_DAI_CLK_MODE2,
+			M98925_DAI_MAS_MASK, 0);
+		max98925_set_sense_data(max98925);
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		/*
+		 * set left channel DAI to master mode,
+		 * right channel always slave
+		 */
+		regmap_update_bits(max98925->regmap,
+			MAX98925_DAI_CLK_MODE2,
+			M98925_DAI_MAS_MASK, M98925_DAI_MAS_MASK);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+	default:
+		dev_err(codec->dev, "DAI clock mode unsupported");
+		return -EINVAL;
+	}
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
+	regmap_update_bits(max98925->regmap, MAX98925_FORMAT,
+			M98925_DAI_BCI_MASK | M98925_DAI_BCI_MASK, invert);
+	return 0;
+}
+
+static int max98925_set_clock(struct max98925_priv *max98925,
+		struct snd_pcm_hw_params *params)
+{
+	unsigned int dai_sr = 0, clock, mdll, n, m;
+	struct snd_soc_codec *codec = max98925->codec;
+	int rate = params_rate(params);
+	/* BCLK/LRCLK ratio calculation */
+	int blr_clk_ratio = params_channels(params) * max98925->ch_size;
+
+	switch (blr_clk_ratio) {
+	case 32:
+		regmap_update_bits(max98925->regmap,
+			MAX98925_DAI_CLK_MODE2,
+			M98925_DAI_BSEL_MASK, M98925_DAI_BSEL_32);
+		break;
+	case 48:
+		regmap_update_bits(max98925->regmap,
+			MAX98925_DAI_CLK_MODE2,
+			M98925_DAI_BSEL_MASK, M98925_DAI_BSEL_48);
+		break;
+	case 64:
+		regmap_update_bits(max98925->regmap,
+			MAX98925_DAI_CLK_MODE2,
+			M98925_DAI_BSEL_MASK, M98925_DAI_BSEL_64);
+		break;
+	default:
+		return -EINVAL;
+	}
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
+	if (max98925_rate_value(codec, rate, clock, &dai_sr, &n, &m))
+		return -EINVAL;
+
+	/* set DAI_SR to correct LRCLK frequency */
+	regmap_update_bits(max98925->regmap,
+			MAX98925_DAI_CLK_MODE2,
+			M98925_DAI_SR_MASK, dai_sr << M98925_DAI_SR_SHIFT);
+	/* set DAI m divider */
+	regmap_write(max98925->regmap,
+		MAX98925_DAI_CLK_DIV_M_MSBS, m >> 8);
+	regmap_write(max98925->regmap,
+		MAX98925_DAI_CLK_DIV_M_LSBS, m & 0xFF);
+	/* set DAI n divider */
+	regmap_write(max98925->regmap,
+		MAX98925_DAI_CLK_DIV_N_MSBS, n >> 8);
+	regmap_write(max98925->regmap,
+		MAX98925_DAI_CLK_DIV_N_LSBS, n & 0xFF);
+	/* set MDLL */
+	regmap_update_bits(max98925->regmap, MAX98925_DAI_CLK_MODE1,
+			M98925_MDLL_MULT_MASK, mdll << M98925_MDLL_MULT_SHIFT);
+	return 0;
+}
+
+static int max98925_dai_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+
+	switch (snd_pcm_format_width(params_format(params))) {
+	case 16:
+		regmap_update_bits(max98925->regmap,
+				MAX98925_FORMAT,
+				M98925_DAI_CHANSZ_MASK, M98925_DAI_CHANSZ_16);
+		max98925->ch_size = 16;
+		break;
+	case 24:
+		regmap_update_bits(max98925->regmap,
+				MAX98925_FORMAT,
+				M98925_DAI_CHANSZ_MASK, M98925_DAI_CHANSZ_32);
+		max98925->ch_size = 32;
+		break;
+	case 32:
+		regmap_update_bits(max98925->regmap,
+				MAX98925_FORMAT,
+				M98925_DAI_CHANSZ_MASK, M98925_DAI_CHANSZ_32);
+		max98925->ch_size = 32;
+		break;
+	default:
+		pr_err("%s: format unsupported %d",
+				__func__, params_format(params));
+		return -EINVAL;
+	}
+	dev_dbg(codec->dev, "%s: format supported %d",
+				__func__, params_format(params));
+	return max98925_set_clock(max98925, params);
+}
+
+static int max98925_dai_set_sysclk(struct snd_soc_dai *dai,
+				   int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+
+	switch (clk_id) {
+	case 0:
+		/* use MCLK for Left channel, right channel always BCLK */
+		regmap_update_bits(max98925->regmap,
+				MAX98925_DAI_CLK_MODE1,
+				M98925_DAI_CLK_SOURCE_MASK, 0);
+		break;
+	case 1:
+		/* configure dai clock source to BCLK instead of MCLK */
+		regmap_update_bits(max98925->regmap,
+				MAX98925_DAI_CLK_MODE1,
+				M98925_DAI_CLK_SOURCE_MASK,
+				M98925_DAI_CLK_SOURCE_MASK);
+		break;
+	default:
+		return -EINVAL;
+	}
+	max98925->sysclk = freq;
+	return 0;
+}
+
+#define MAX98925_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_ops max98925_dai_ops = {
+	.set_sysclk = max98925_dai_set_sysclk,
+	.set_fmt = max98925_dai_set_fmt,
+	.hw_params = max98925_dai_hw_params,
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
+static int max98925_probe(struct snd_soc_codec *codec)
+{
+	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
+
+	max98925->codec = codec;
+	codec->control_data = max98925->regmap;
+	regmap_write(max98925->regmap, MAX98925_GLOBAL_ENABLE, 0x00);
+	/* It's not the default but we need to set DAI_DLY */
+	regmap_write(max98925->regmap,
+			MAX98925_FORMAT, M98925_DAI_DLY_MASK);
+	regmap_write(max98925->regmap, MAX98925_TDM_SLOT_SELECT, 0xC8);
+	regmap_write(max98925->regmap, MAX98925_DOUT_HIZ_CFG1, 0xFF);
+	regmap_write(max98925->regmap, MAX98925_DOUT_HIZ_CFG2, 0xFF);
+	regmap_write(max98925->regmap, MAX98925_DOUT_HIZ_CFG3, 0xFF);
+	regmap_write(max98925->regmap, MAX98925_DOUT_HIZ_CFG4, 0xF0);
+	regmap_write(max98925->regmap, MAX98925_FILTERS, 0xD8);
+	regmap_write(max98925->regmap, MAX98925_ALC_CONFIGURATION, 0xF8);
+	regmap_write(max98925->regmap, MAX98925_CONFIGURATION, 0xF0);
+	/* Disable ALC muting */
+	regmap_write(max98925->regmap, MAX98925_BOOST_LIMITER, 0xF8);
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_max98925 = {
+	.probe            = max98925_probe,
+	.controls = max98925_snd_controls,
+	.num_controls = ARRAY_SIZE(max98925_snd_controls),
+	.dapm_routes = max98925_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(max98925_audio_map),
+	.dapm_widgets = max98925_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(max98925_dapm_widgets),
+};
+
+static struct regmap_config max98925_regmap = {
+	.reg_bits         = 8,
+	.val_bits         = 8,
+	.max_register     = MAX98925_REV_VERSION,
+	.reg_defaults     = max98925_reg,
+	.num_reg_defaults = ARRAY_SIZE(max98925_reg),
+	.volatile_reg     = max98925_volatile_register,
+	.readable_reg     = max98925_readable_register,
+	.cache_type       = REGCACHE_RBTREE,
+};
+
+static int max98925_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	int ret, reg;
+	u32 value;
+	struct max98925_priv *max98925;
+
+	max98925 = devm_kzalloc(&i2c->dev,
+			sizeof(*max98925), GFP_KERNEL);
+	if (!max98925)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, max98925);
+	max98925->regmap = devm_regmap_init_i2c(i2c, &max98925_regmap);
+	if (IS_ERR(max98925->regmap)) {
+		ret = PTR_ERR(max98925->regmap);
+		dev_err(&i2c->dev,
+				"Failed to allocate regmap: %d\n", ret);
+		goto err_out;
+	}
+
+	if (!of_property_read_u32(i2c->dev.of_node, "vmon-slot-no", &value)) {
+		if (value > M98925_DAI_VMON_SLOT_1E_1F) {
+			dev_err(&i2c->dev, "vmon slot number is wrong:\n");
+			return -EINVAL;
+		}
+		max98925->v_slot = value;
+	}
+	if (!of_property_read_u32(i2c->dev.of_node, "imon-slot-no", &value)) {
+		if (value > M98925_DAI_IMON_SLOT_1E_1F) {
+			dev_err(&i2c->dev, "imon slot number is wrong:\n");
+			return -EINVAL;
+		}
+		max98925->i_slot = value;
+	}
+	ret = regmap_read(max98925->regmap,
+			MAX98925_REV_VERSION, &reg);
+	if ((ret < 0) ||
+		((reg != MAX98925_VERSION) &&
+		(reg != MAX98925_VERSION1))) {
+		dev_err(&i2c->dev,
+			"device initialization error (%d 0x%02X)\n",
+			ret, reg);
+		goto err_out;
+	}
+	dev_info(&i2c->dev, "device version 0x%02X\n", reg);
+
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98925,
+			max98925_dai, ARRAY_SIZE(max98925_dai));
+	if (ret < 0)
+		dev_err(&i2c->dev,
+				"Failed to register codec: %d\n", ret);
+err_out:
+	return ret;
+}
+
+static int max98925_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct i2c_device_id max98925_i2c_id[] = {
+	{ "max98925", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max98925_i2c_id);
+
+static const struct of_device_id max98925_of_match[] = {
+	{ .compatible = "maxim,max98925", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max98925_of_match);
+
+static struct i2c_driver max98925_i2c_driver = {
+	.driver = {
+		.name = "max98925",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(max98925_of_match),
+		.pm = NULL,
+	},
+	.probe  = max98925_i2c_probe,
+	.remove = max98925_i2c_remove,
+	.id_table = max98925_i2c_id,
+};
+
+module_i2c_driver(max98925_i2c_driver)
+
+MODULE_DESCRIPTION("ALSA SoC MAX98925 driver");
+MODULE_AUTHOR("Ralph Birt <rdbirt@gmail.com>, Anish kumar <anish.kumar@maximintegrated.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/max98925.h b/sound/soc/codecs/max98925.h
new file mode 100644
index 0000000..3783248
--- /dev/null
+++ b/sound/soc/codecs/max98925.h
@@ -0,0 +1,832 @@
+/*
+ * max98925.h -- MAX98925 ALSA SoC Audio driver
+ *
+ * Copyright 2013-2015 Maxim Integrated Products
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _MAX98925_H
+#define _MAX98925_H
+
+#define	MAX98925_VERSION	0x51
+#define	MAX98925_VERSION1	0x80
+#define MAX98925_VBAT_DATA		0x00
+#define MAX98925_VBST_DATA		0x01
+#define MAX98925_LIVE_STATUS0		0x02
+#define MAX98925_LIVE_STATUS1		0x03
+#define MAX98925_LIVE_STATUS2		0x04
+#define MAX98925_STATE0			0x05
+#define MAX98925_STATE1			0x06
+#define MAX98925_STATE2			0x07
+#define MAX98925_FLAG0			0x08
+#define MAX98925_FLAG1			0x09
+#define MAX98925_FLAG2			0x0A
+#define MAX98925_IRQ_ENABLE0		0x0B
+#define MAX98925_IRQ_ENABLE1		0x0C
+#define MAX98925_IRQ_ENABLE2		0x0D
+#define MAX98925_IRQ_CLEAR0		0x0E
+#define MAX98925_IRQ_CLEAR1		0x0F
+#define MAX98925_IRQ_CLEAR2		0x10
+#define MAX98925_MAP0			0x11
+#define MAX98925_MAP1			0x12
+#define MAX98925_MAP2			0x13
+#define MAX98925_MAP3			0x14
+#define MAX98925_MAP4			0x15
+#define MAX98925_MAP5			0x16
+#define MAX98925_MAP6			0x17
+#define MAX98925_MAP7			0x18
+#define MAX98925_MAP8			0x19
+#define MAX98925_DAI_CLK_MODE1		0x1A
+#define MAX98925_DAI_CLK_MODE2		0x1B
+#define MAX98925_DAI_CLK_DIV_M_MSBS	0x1C
+#define MAX98925_DAI_CLK_DIV_M_LSBS	0x1D
+#define MAX98925_DAI_CLK_DIV_N_MSBS	0x1E
+#define MAX98925_DAI_CLK_DIV_N_LSBS	0x1F
+#define MAX98925_FORMAT			0x20
+#define MAX98925_TDM_SLOT_SELECT	0x21
+#define MAX98925_DOUT_CFG_VMON		0x22
+#define MAX98925_DOUT_CFG_IMON		0x23
+#define MAX98925_DOUT_CFG_VBAT		0x24
+#define MAX98925_DOUT_CFG_VBST		0x25
+#define MAX98925_DOUT_CFG_FLAG		0x26
+#define MAX98925_DOUT_HIZ_CFG1		0x27
+#define MAX98925_DOUT_HIZ_CFG2		0x28
+#define MAX98925_DOUT_HIZ_CFG3		0x29
+#define MAX98925_DOUT_HIZ_CFG4		0x2A
+#define MAX98925_DOUT_DRV_STRENGTH	0x2B
+#define MAX98925_FILTERS		0x2C
+#define MAX98925_GAIN			0x2D
+#define MAX98925_GAIN_RAMPING		0x2E
+#define MAX98925_SPK_AMP		0x2F
+#define MAX98925_THRESHOLD		0x30
+#define MAX98925_ALC_ATTACK		0x31
+#define MAX98925_ALC_ATTEN_RLS		0x32
+#define MAX98925_ALC_HOLD_RLS		0x33
+#define MAX98925_ALC_CONFIGURATION	0x34
+#define MAX98925_BOOST_CONVERTER	0x35
+#define MAX98925_BLOCK_ENABLE		0x36
+#define MAX98925_CONFIGURATION		0x37
+#define MAX98925_GLOBAL_ENABLE		0x38
+#define MAX98925_BOOST_LIMITER		0x3A
+#define MAX98925_REV_VERSION		0xFF
+
+#define MAX98925_REG_CNT               (MAX98925_R03A_BOOST_LIMITER+1)
+
+/* MAX98925 Register Bit Fields */
+
+/* MAX98925_R002_LIVE_STATUS0 */
+#define M98925_THERMWARN_STATUS_MASK			(1<<3)
+#define M98925_THERMWARN_STATUS_SHIFT			3
+#define M98925_THERMWARN_STATUS_WIDTH			1
+#define M98925_THERMSHDN_STATUS_MASK			(1<<1)
+#define M98925_THERMSHDN_STATUS_SHIFT			1
+#define M98925_THERMSHDN_STATUS_WIDTH			1
+
+/* MAX98925_R003_LIVE_STATUS1 */
+#define M98925_SPKCURNT_STATUS_MASK			(1<<5)
+#define M98925_SPKCURNT_STATUS_SHIFT			5
+#define M98925_SPKCURNT_STATUS_WIDTH			1
+#define M98925_WATCHFAIL_STATUS_MASK			(1<<4)
+#define M98925_WATCHFAIL_STATUS_SHIFT			4
+#define M98925_WATCHFAIL_STATUS_WIDTH			1
+#define M98925_ALCINFH_STATUS_MASK			(1<<3)
+#define M98925_ALCINFH_STATUS_SHIFT			3
+#define M98925_ALCINFH_STATUS_WIDTH			1
+#define M98925_ALCACT_STATUS_MASK			(1<<2)
+#define M98925_ALCACT_STATUS_SHIFT			2
+#define M98925_ALCACT_STATUS_WIDTH			1
+#define M98925_ALCMUT_STATUS_MASK			(1<<1)
+#define M98925_ALCMUT_STATUS_SHIFT			1
+#define M98925_ALCMUT_STATUS_WIDTH			1
+#define M98925_ACLP_STATUS_MASK				(1<<0)
+#define M98925_ACLP_STATUS_SHIFT			0
+#define M98925_ACLP_STATUS_WIDTH			1
+
+/* MAX98925_R004_LIVE_STATUS2 */
+#define M98925_SLOTOVRN_STATUS_MASK			(1<<6)
+#define M98925_SLOTOVRN_STATUS_SHIFT			6
+#define M98925_SLOTOVRN_STATUS_WIDTH			1
+#define M98925_INVALSLOT_STATUS_MASK			(1<<5)
+#define M98925_INVALSLOT_STATUS_SHIFT			5
+#define M98925_INVALSLOT_STATUS_WIDTH			1
+#define M98925_SLOTCNFLT_STATUS_MASK			(1<<4)
+#define M98925_SLOTCNFLT_STATUS_SHIFT			4
+#define M98925_SLOTCNFLT_STATUS_WIDTH			1
+#define M98925_VBSTOVFL_STATUS_MASK			(1<<3)
+#define M98925_VBSTOVFL_STATUS_SHIFT			3
+#define M98925_VBSTOVFL_STATUS_WIDTH			1
+#define M98925_VBATOVFL_STATUS_MASK			(1<<2)
+#define M98925_VBATOVFL_STATUS_SHIFT			2
+#define M98925_VBATOVFL_STATUS_WIDTH			1
+#define M98925_IMONOVFL_STATUS_MASK			(1<<1)
+#define M98925_IMONOVFL_STATUS_SHIFT			1
+#define M98925_IMONOVFL_STATUS_WIDTH			1
+#define M98925_VMONOVFL_STATUS_MASK			(1<<0)
+#define M98925_VMONOVFL_STATUS_SHIFT			0
+#define M98925_VMONOVFL_STATUS_WIDTH			1
+
+/* MAX98925_R005_STATE0 */
+#define M98925_THERMWARN_END_STATE_MASK			(1<<3)
+#define M98925_THERMWARN_END_STATE_SHIFT		3
+#define M98925_THERMWARN_END_STATE_WIDTH		1
+#define M98925_THERMWARN_BGN_STATE_MASK			(1<<2)
+#define M98925_THERMWARN_BGN_STATE_SHIFT		1
+#define M98925_THERMWARN_BGN_STATE_WIDTH		1
+#define M98925_THERMSHDN_END_STATE_MASK			(1<<1)
+#define M98925_THERMSHDN_END_STATE_SHIFT		1
+#define M98925_THERMSHDN_END_STATE_WIDTH		1
+#define M98925_THERMSHDN_BGN_STATE_MASK			(1<<0)
+#define M98925_THERMSHDN_BGN_STATE_SHIFT		0
+#define M98925_THERMSHDN_BGN_STATE_WIDTH		1
+
+/* MAX98925_R006_STATE1 */
+#define M98925_SPRCURNT_STATE_MASK			(1<<5)
+#define M98925_SPRCURNT_STATE_SHIFT			5
+#define M98925_SPRCURNT_STATE_WIDTH			1
+#define M98925_WATCHFAIL_STATE_MASK			(1<<4)
+#define M98925_WATCHFAIL_STATE_SHIFT			4
+#define M98925_WATCHFAIL_STATE_WIDTH			1
+#define M98925_ALCINFH_STATE_MASK			(1<<3)
+#define M98925_ALCINFH_STATE_SHIFT			3
+#define M98925_ALCINFH_STATE_WIDTH			1
+#define M98925_ALCACT_STATE_MASK			(1<<2)
+#define M98925_ALCACT_STATE_SHIFT			2
+#define M98925_ALCACT_STATE_WIDTH			1
+#define M98925_ALCMUT_STATE_MASK			(1<<1)
+#define M98925_ALCMUT_STATE_SHIFT			1
+#define M98925_ALCMUT_STATE_WIDTH			1
+#define M98925_ALCP_STATE_MASK				(1<<0)
+#define M98925_ALCP_STATE_SHIFT				0
+#define M98925_ALCP_STATE_WIDTH				1
+
+/* MAX98925_R007_STATE2 */
+#define M98925_SLOTOVRN_STATE_MASK			(1<<6)
+#define M98925_SLOTOVRN_STATE_SHIFT			6
+#define M98925_SLOTOVRN_STATE_WIDTH			1
+#define M98925_INVALSLOT_STATE_MASK			(1<<5)
+#define M98925_INVALSLOT_STATE_SHIFT			5
+#define M98925_INVALSLOT_STATE_WIDTH			1
+#define M98925_SLOTCNFLT_STATE_MASK			(1<<4)
+#define M98925_SLOTCNFLT_STATE_SHIFT			4
+#define M98925_SLOTCNFLT_STATE_WIDTH			1
+#define M98925_VBSTOVFL_STATE_MASK			(1<<3)
+#define M98925_VBSTOVFL_STATE_SHIFT			3
+#define M98925_VBSTOVFL_STATE_WIDTH			1
+#define M98925_VBATOVFL_STATE_MASK			(1<<2)
+#define M98925_VBATOVFL_STATE_SHIFT			2
+#define M98925_VBATOVFL_STATE_WIDTH			1
+#define M98925_IMONOVFL_STATE_MASK			(1<<1)
+#define M98925_IMONOVFL_STATE_SHIFT			1
+#define M98925_IMONOVFL_STATE_WIDTH			1
+#define M98925_VMONOVFL_STATE_MASK			(1<<0)
+#define M98925_VMONOVFL_STATE_SHIFT			0
+#define M98925_VMONOVFL_STATE_WIDTH			1
+
+/* MAX98925_R008_FLAG0 */
+#define M98925_THERMWARN_END_FLAG_MASK			(1<<3)
+#define M98925_THERMWARN_END_FLAG_SHIFT			3
+#define M98925_THERMWARN_END_FLAG_WIDTH			1
+#define M98925_THERMWARN_BGN_FLAG_MASK			(1<<2)
+#define M98925_THERMWARN_BGN_FLAG_SHIFT			2
+#define M98925_THERMWARN_BGN_FLAG_WIDTH			1
+#define M98925_THERMSHDN_END_FLAG_MASK			(1<<1)
+#define M98925_THERMSHDN_END_FLAG_SHIFT			1
+#define M98925_THERMSHDN_END_FLAG_WIDTH			1
+#define M98925_THERMSHDN_BGN_FLAG_MASK			(1<<0)
+#define M98925_THERMSHDN_BGN_FLAG_SHIFT			0
+#define M98925_THERMSHDN_BGN_FLAG_WIDTH			1
+
+/* MAX98925_R009_FLAG1 */
+#define M98925_SPKCURNT_FLAG_MASK			(1<<5)
+#define M98925_SPKCURNT_FLAG_SHIFT			5
+#define M98925_SPKCURNT_FLAG_WIDTH			1
+#define M98925_WATCHFAIL_FLAG_MASK			(1<<4)
+#define M98925_WATCHFAIL_FLAG_SHIFT			4
+#define M98925_WATCHFAIL_FLAG_WIDTH			1
+#define M98925_ALCINFH_FLAG_MASK			(1<<3)
+#define M98925_ALCINFH_FLAG_SHIFT			3
+#define M98925_ALCINFH_FLAG_WIDTH			1
+#define M98925_ALCACT_FLAG_MASK				(1<<2)
+#define M98925_ALCACT_FLAG_SHIFT			2
+#define M98925_ALCACT_FLAG_WIDTH			1
+#define M98925_ALCMUT_FLAG_MASK				(1<<1)
+#define M98925_ALCMUT_FLAG_SHIFT			1
+#define M98925_ALCMUT_FLAG_WIDTH			1
+#define M98925_ALCP_FLAG_MASK				(1<<0)
+#define M98925_ALCP_FLAG_SHIFT				0
+#define M98925_ALCP_FLAG_WIDTH				1
+
+/* MAX98925_R00A_FLAG2 */
+#define M98925_SLOTOVRN_FLAG_MASK			(1<<6)
+#define M98925_SLOTOVRN_FLAG_SHIFT			6
+#define M98925_SLOTOVRN_FLAG_WIDTH			1
+#define M98925_INVALSLOT_FLAG_MASK			(1<<5)
+#define M98925_INVALSLOT_FLAG_SHIFT			5
+#define M98925_INVALSLOT_FLAG_WIDTH			1
+#define M98925_SLOTCNFLT_FLAG_MASK			(1<<4)
+#define M98925_SLOTCNFLT_FLAG_SHIFT			4
+#define M98925_SLOTCNFLT_FLAG_WIDTH			1
+#define M98925_VBSTOVFL_FLAG_MASK			(1<<3)
+#define M98925_VBSTOVFL_FLAG_SHIFT			3
+#define M98925_VBSTOVFL_FLAG_WIDTH			1
+#define M98925_VBATOVFL_FLAG_MASK			(1<<2)
+#define M98925_VBATOVFL_FLAG_SHIFT			2
+#define M98925_VBATOVFL_FLAG_WIDTH			1
+#define M98925_IMONOVFL_FLAG_MASK			(1<<1)
+#define M98925_IMONOVFL_FLAG_SHIFT			1
+#define M98925_IMONOVFL_FLAG_WIDTH			1
+#define M98925_VMONOVFL_FLAG_MASK			(1<<0)
+#define M98925_VMONOVFL_FLAG_SHIFT			0
+#define M98925_VMONOVFL_FLAG_WIDTH			1
+
+/* MAX98925_R00B_IRQ_ENABLE0 */
+#define M98925_THERMWARN_END_EN_MASK			(1<<3)
+#define M98925_THERMWARN_END_EN_SHIFT			3
+#define M98925_THERMWARN_END_EN_WIDTH			1
+#define M98925_THERMWARN_BGN_EN_MASK			(1<<2)
+#define M98925_THERMWARN_BGN_EN_SHIFT			2
+#define M98925_THERMWARN_BGN_EN_WIDTH			1
+#define M98925_THERMSHDN_END_EN_MASK			(1<<1)
+#define M98925_THERMSHDN_END_EN_SHIFT			1
+#define M98925_THERMSHDN_END_EN_WIDTH			1
+#define M98925_THERMSHDN_BGN_EN_MASK			(1<<0)
+#define M98925_THERMSHDN_BGN_EN_SHIFT			0
+#define M98925_THERMSHDN_BGN_EN_WIDTH			1
+
+/* MAX98925_R00C_IRQ_ENABLE1 */
+#define M98925_SPKCURNT_EN_MASK				(1<<5)
+#define M98925_SPKCURNT_EN_SHIFT			5
+#define M98925_SPKCURNT_EN_WIDTH			1
+#define M98925_WATCHFAIL_EN_MASK			(1<<4)
+#define M98925_WATCHFAIL_EN_SHIFT			4
+#define M98925_WATCHFAIL_EN_WIDTH			1
+#define M98925_ALCINFH_EN_MASK				(1<<3)
+#define M98925_ALCINFH_EN_SHIFT				3
+#define M98925_ALCINFH_EN_WIDTH				1
+#define M98925_ALCACT_EN_MASK				(1<<2)
+#define M98925_ALCACT_EN_SHIFT				2
+#define M98925_ALCACT_EN_WIDTH				1
+#define M98925_ALCMUT_EN_MASK				(1<<1)
+#define M98925_ALCMUT_EN_SHIFT				1
+#define M98925_ALCMUT_EN_WIDTH				1
+#define M98925_ALCP_EN_MASK					(1<<0)
+#define M98925_ALCP_EN_SHIFT				0
+#define M98925_ALCP_EN_WIDTH				1
+
+/* MAX98925_R00D_IRQ_ENABLE2 */
+#define M98925_SLOTOVRN_EN_MASK					(1<<6)
+#define M98925_SLOTOVRN_EN_SHIFT				6
+#define M98925_SLOTOVRN_EN_WIDTH				1
+#define M98925_INVALSLOT_EN_MASK				(1<<5)
+#define M98925_INVALSLOT_EN_SHIFT				5
+#define M98925_INVALSLOT_EN_WIDTH				1
+#define M98925_SLOTCNFLT_EN_MASK				(1<<4)
+#define M98925_SLOTCNFLT_EN_SHIFT				4
+#define M98925_SLOTCNFLT_EN_WIDTH				1
+#define M98925_VBSTOVFL_EN_MASK					(1<<3)
+#define M98925_VBSTOVFL_EN_SHIFT				3
+#define M98925_VBSTOVFL_EN_WIDTH				1
+#define M98925_VBATOVFL_EN_MASK					(1<<2)
+#define M98925_VBATOVFL_EN_SHIFT				2
+#define M98925_VBATOVFL_EN_WIDTH				1
+#define M98925_IMONOVFL_EN_MASK					(1<<1)
+#define M98925_IMONOVFL_EN_SHIFT				1
+#define M98925_IMONOVFL_EN_WIDTH				1
+#define M98925_VMONOVFL_EN_MASK					(1<<0)
+#define M98925_VMONOVFL_EN_SHIFT				0
+#define M98925_VMONOVFL_EN_WIDTH				1
+
+/* MAX98925_R00E_IRQ_CLEAR0 */
+#define M98925_THERMWARN_END_CLR_MASK			(1<<3)
+#define M98925_THERMWARN_END_CLR_SHIFT			3
+#define M98925_THERMWARN_END_CLR_WIDTH			1
+#define M98925_THERMWARN_BGN_CLR_MASK			(1<<2)
+#define M98925_THERMWARN_BGN_CLR_SHIFT			2
+#define M98925_THERMWARN_BGN_CLR_WIDTH			1
+#define M98925_THERMSHDN_END_CLR_MASK			(1<<1)
+#define M98925_THERMSHDN_END_CLR_SHIFT			1
+#define M98925_THERMSHDN_END_CLR_WIDTH			1
+#define M98925_THERMSHDN_BGN_CLR_MASK			(1<<0)
+#define M98925_THERMSHDN_BGN_CLR_SHIFT			0
+#define M98925_THERMSHDN_BGN_CLR_WIDTH			1
+
+/* MAX98925_R00F_IRQ_CLEAR1 */
+#define M98925_SPKCURNT_CLR_MASK				(1<<5)
+#define M98925_SPKCURNT_CLR_SHIFT				5
+#define M98925_SPKCURNT_CLR_WIDTH				1
+#define M98925_WATCHFAIL_CLR_MASK				(1<<4)
+#define M98925_WATCHFAIL_CLR_SHIFT				4
+#define M98925_WATCHFAIL_CLR_WIDTH				1
+#define M98925_ALCINFH_CLR_MASK					(1<<3)
+#define M98925_ALCINFH_CLR_SHIFT				3
+#define M98925_ALCINFH_CLR_WIDTH				1
+#define M98925_ALCACT_CLR_MASK					(1<<2)
+#define M98925_ALCACT_CLR_SHIFT					2
+#define M98925_ALCACT_CLR_WIDTH					1
+#define M98925_ALCMUT_CLR_MASK					(1<<1)
+#define M98925_ALCMUT_CLR_SHIFT					1
+#define M98925_ALCMUT_CLR_WIDTH					1
+#define M98925_ALCP_CLR_MASK					(1<<0)
+#define M98925_ALCP_CLR_SHIFT					0
+#define M98925_ALCP_CLR_WIDTH					1
+
+/* MAX98925_R010_IRQ_CLEAR2 */
+#define M98925_SLOTOVRN_CLR_MASK				(1<<6)
+#define M98925_SLOTOVRN_CLR_SHIFT				6
+#define M98925_SLOTOVRN_CLR_WIDTH				1
+#define M98925_INVALSLOT_CLR_MASK				(1<<5)
+#define M98925_INVALSLOT_CLR_SHIFT				5
+#define M98925_INVALSLOT_CLR_WIDTH				1
+#define M98925_SLOTCNFLT_CLR_MASK				(1<<4)
+#define M98925_SLOTCNFLT_CLR_SHIFT				4
+#define M98925_SLOTCNFLT_CLR_WIDTH				1
+#define M98925_VBSTOVFL_CLR_MASK				(1<<3)
+#define M98925_VBSTOVFL_CLR_SHIFT				3
+#define M98925_VBSTOVFL_CLR_WIDTH				1
+#define M98925_VBATOVFL_CLR_MASK				(1<<2)
+#define M98925_VBATOVFL_CLR_SHIFT				2
+#define M98925_VBATOVFL_CLR_WIDTH				1
+#define M98925_IMONOVFL_CLR_MASK				(1<<1)
+#define M98925_IMONOVFL_CLR_SHIFT				1
+#define M98925_IMONOVFL_CLR_WIDTH				1
+#define M98925_VMONOVFL_CLR_MASK				(1<<0)
+#define M98925_VMONOVFL_CLR_SHIFT				0
+#define M98925_VMONOVFL_CLR_WIDTH				1
+
+/* MAX98925_R011_MAP0 */
+#define M98925_ER_THERMWARN_EN_MASK				(1<<7)
+#define M98925_ER_THERMWARN_EN_SHIFT			7
+#define M98925_ER_THERMWARN_EN_WIDTH			1
+#define M98925_ER_THERMWARN_MAP_MASK			(0x07<<4)
+#define M98925_ER_THERMWARN_MAP_SHIFT			4
+#define M98925_ER_THERMWARN_MAP_WIDTH			3
+
+/* MAX98925_R012_MAP1 */
+#define M98925_ER_ALCMUT_EN_MASK				(1<<7)
+#define M98925_ER_ALCMUT_EN_SHIFT				7
+#define M98925_ER_ALCMUT_EN_WIDTH				1
+#define M98925_ER_ALCMUT_MAP_MASK				(0x07<<4)
+#define M98925_ER_ALCMUT_MAP_SHIFT				4
+#define M98925_ER_ALCMUT_MAP_WIDTH				3
+#define M98925_ER_ALCP_EN_MASK					(1<<3)
+#define M98925_ER_ALCP_EN_SHIFT					3
+#define M98925_ER_ALCP_EN_WIDTH					1
+#define M98925_ER_ALCP_MAP_MASK					(0x07<<0)
+#define M98925_ER_ALCP_MAP_SHIFT				0
+#define M98925_ER_ALCP_MAP_WIDTH				3
+
+/* MAX98925_R013_MAP2 */
+#define M98925_ER_ALCINFH_EN_MASK				(1<<7)
+#define M98925_ER_ALCINFH_EN_SHIFT				7
+#define M98925_ER_ALCINFH_EN_WIDTH				1
+#define M98925_ER_ALCINFH_MAP_MASK				(0x07<<4)
+#define M98925_ER_ALCINFH_MAP_SHIFT				4
+#define M98925_ER_ALCINFH_MAP_WIDTH				3
+#define M98925_ER_ALCACT_EN_MASK				(1<<3)
+#define M98925_ER_ALCACT_EN_SHIFT				3
+#define M98925_ER_ALCACT_EN_WIDTH				1
+#define M98925_ER_ALCACT_MAP_MASK				(0x07<<0)
+#define M98925_ER_ALCACT_MAP_SHIFT				0
+#define M98925_ER_ALCACT_MAP_WIDTH				3
+
+/* MAX98925_R014_MAP3 */
+#define M98925_ER_SPKCURNT_EN_MASK				(1<<7)
+#define M98925_ER_SPKCURNT_EN_SHIFT				7
+#define M98925_ER_SPKCURNT_EN_WIDTH				1
+#define M98925_ER_SPKCURNT_MAP_MASK				(0x07<<4)
+#define M98925_ER_SPKCURNT_MAP_SHIFT			4
+#define M98925_ER_SPKCURNT_MAP_WIDTH			3
+
+/* MAX98925_R015_MAP4 */
+/* RESERVED */
+
+/* MAX98925_R016_MAP5 */
+#define M98925_ER_IMONOVFL_EN_MASK				(1<<7)
+#define M98925_ER_IMONOVFL_EN_SHIFT				7
+#define M98925_ER_IMONOVFL_EN_WIDTH				1
+#define M98925_ER_IMONOVFL_MAP_MASK				(0x07<<4)
+#define M98925_ER_IMONOVFL_MAP_SHIFT			4
+#define M98925_ER_IMONOVFL_MAP_WIDTH			3
+#define M98925_ER_VMONOVFL_EN_MASK				(1<<3)
+#define M98925_ER_VMONOVFL_EN_SHIFT				3
+#define M98925_ER_VMONOVFL_EN_WIDTH				1
+#define M98925_ER_VMONOVFL_MAP_MASK				(0x07<<0)
+#define M98925_ER_VMONOVFL_MAP_SHIFT			0
+#define M98925_ER_VMONOVFL_MAP_WIDTH			3
+
+/* MAX98925_R017_MAP6 */
+#define M98925_ER_VBSTOVFL_EN_MASK				(1<<7)
+#define M98925_ER_VBSTOVFL_EN_SHIFT				7
+#define M98925_ER_VBSTOVFL_EN_WIDTH				1
+#define M98925_ER_VBSTOVFL_MAP_MASK				(0x07<<4)
+#define M98925_ER_VBSTOVFL_MAP_SHIFT			4
+#define M98925_ER_VBSTOVFL_MAP_WIDTH			3
+#define M98925_ER_VBATOVFL_EN_MASK				(1<<3)
+#define M98925_ER_VBATOVFL_EN_SHIFT				3
+#define M98925_ER_VBATOVFL_EN_WIDTH				1
+#define M98925_ER_VBATOVFL_MAP_MASK				(0x07<<0)
+#define M98925_ER_VBATOVFL_MAP_SHIFT			0
+#define M98925_ER_VBATOVFL_MAP_WIDTH			3
+
+/* MAX98925_R018_MAP7 */
+#define M98925_ER_INVALSLOT_EN_MASK				(1<<7)
+#define M98925_ER_INVALSLOT_EN_SHIFT			7
+#define M98925_ER_INVALSLOT_EN_WIDTH			1
+#define M98925_ER_INVALSLOT_MAP_MASK			(0x07<<4)
+#define M98925_ER_INVALSLOT_MAP_SHIFT			4
+#define M98925_ER_INVALSLOT_MAP_WIDTH			3
+#define M98925_ER_SLOTCNFLT_EN_MASK				(1<<3)
+#define M98925_ER_SLOTCNFLT_EN_SHIFT			3
+#define M98925_ER_SLOTCNFLT_EN_WIDTH			1
+#define M98925_ER_SLOTCNFLT_MAP_MASK			(0x07<<0)
+#define M98925_ER_SLOTCNFLT_MAP_SHIFT			0
+#define M98925_ER_SLOTCNFLT_MAP_WIDTH			3
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
+#define M98925_DAI_SR_MASK			(0x0F<<4)
+#define M98925_DAI_SR_SHIFT			4
+#define M98925_DAI_SR_WIDTH			4
+#define M98925_DAI_MAS_MASK			(1<<3)
+#define M98925_DAI_MAS_SHIFT			3
+#define M98925_DAI_MAS_WIDTH			1
+#define M98925_DAI_BSEL_MASK			(0x07<<0)
+#define M98925_DAI_BSEL_SHIFT			0
+#define M98925_DAI_BSEL_WIDTH			3
+
+#define M98925_DAI_BSEL_32 (0 << M98925_DAI_BSEL_SHIFT)
+#define M98925_DAI_BSEL_48 (1 << M98925_DAI_BSEL_SHIFT)
+#define M98925_DAI_BSEL_64 (2 << M98925_DAI_BSEL_SHIFT)
+#define M98925_DAI_BSEL_256 (6 << M98925_DAI_BSEL_SHIFT)
+
+/* MAX98925_R01C_DAI_CLK_DIV_M_MSBS */
+#define M98925_DAI_M_MSBS_MASK					(0xFF<<0)
+#define M98925_DAI_M_MSBS_SHIFT					0
+#define M98925_DAI_M_MSBS_WIDTH					8
+
+/* MAX98925_R01D_DAI_CLK_DIV_M_LSBS */
+#define M98925_DAI_M_LSBS_MASK					(0xFF<<0)
+#define M98925_DAI_M_LSBS_SHIFT					0
+#define M98925_DAI_M_LSBS_WIDTH					8
+
+/* MAX98925_R01E_DAI_CLK_DIV_N_MSBS */
+#define M98925_DAI_N_MSBS_MASK					(0x7F<<0)
+#define M98925_DAI_N_MSBS_SHIFT					0
+#define M98925_DAI_N_MSBS_WIDTH					7
+
+/* MAX98925_R01F_DAI_CLK_DIV_N_LSBS */
+#define M98925_DAI_N_LSBS_MASK					(0xFF<<0)
+#define M98925_DAI_N_LSBS_SHIFT					0
+#define M98925_DAI_N_LSBS_WIDTH					8
+
+/* MAX98925_R020_FORMAT */
+#define M98925_DAI_CHANSZ_MASK					(0x03<<6)
+#define M98925_DAI_CHANSZ_SHIFT					6
+#define M98925_DAI_CHANSZ_WIDTH					2
+#define M98925_DAI_EXTBCLK_HIZ_MASK				(1<<4)
+#define M98925_DAI_EXTBCLK_HIZ_SHIFT			4
+#define M98925_DAI_EXTBCLK_HIZ_WIDTH			1
+#define M98925_DAI_WCI_MASK						(1<<3)
+#define M98925_DAI_WCI_SHIFT					3
+#define M98925_DAI_WCI_WIDTH					1
+#define M98925_DAI_BCI_MASK						(1<<2)
+#define M98925_DAI_BCI_SHIFT					2
+#define M98925_DAI_BCI_WIDTH					1
+#define M98925_DAI_DLY_MASK						(1<<1)
+#define M98925_DAI_DLY_SHIFT					1
+#define M98925_DAI_DLY_WIDTH					1
+#define M98925_DAI_TDM_MASK						(1<<0)
+#define M98925_DAI_TDM_SHIFT					0
+#define M98925_DAI_TDM_WIDTH					1
+
+#define M98925_DAI_CHANSZ_16 (1 << M98925_DAI_CHANSZ_SHIFT)
+#define M98925_DAI_CHANSZ_24 (2 << M98925_DAI_CHANSZ_SHIFT)
+#define M98925_DAI_CHANSZ_32 (3 << M98925_DAI_CHANSZ_SHIFT)
+
+/* MAX98925_R021_TDM_SLOT_SELECT */
+#define M98925_DAI_DO_EN_MASK					(1<<7)
+#define M98925_DAI_DO_EN_SHIFT					7
+#define M98925_DAI_DO_EN_WIDTH					1
+#define M98925_DAI_DIN_EN_MASK					(1<<6)
+#define M98925_DAI_DIN_EN_SHIFT					6
+#define M98925_DAI_DIN_EN_WIDTH					1
+#define M98925_DAI_INR_SOURCE_MASK				(0x07<<3)
+#define M98925_DAI_INR_SOURCE_SHIFT				3
+#define M98925_DAI_INR_SOURCE_WIDTH				3
+#define M98925_DAI_INL_SOURCE_MASK				(0x07<<0)
+#define M98925_DAI_INL_SOURCE_SHIFT				0
+#define M98925_DAI_INL_SOURCE_WIDTH				3
+
+/* MAX98925_R022_DOUT_CFG_VMON */
+#define M98925_DAI_VMON_EN_MASK					(1<<5)
+#define M98925_DAI_VMON_EN_SHIFT				5
+#define M98925_DAI_VMON_EN_WIDTH				1
+#define M98925_DAI_VMON_SLOT_MASK				(0x1F<<0)
+#define M98925_DAI_VMON_SLOT_SHIFT				0
+#define M98925_DAI_VMON_SLOT_WIDTH				5
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
+#define M98925_DAI_IMON_EN_MASK					(1<<5)
+#define M98925_DAI_IMON_EN_SHIFT				5
+#define M98925_DAI_IMON_EN_WIDTH				1
+#define M98925_DAI_IMON_SLOT_MASK				(0x1F<<0)
+#define M98925_DAI_IMON_SLOT_SHIFT				0
+#define M98925_DAI_IMON_SLOT_WIDTH				5
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
+#define M98925_DAI_VBAT_EN_MASK					(1<<5)
+#define M98925_DAI_VBAT_EN_SHIFT				5
+#define M98925_DAI_VBAT_EN_WIDTH				1
+#define M98925_DAI_VBAT_SLOT_MASK				(0x1F<<0)
+#define M98925_DAI_VBAT_SLOT_SHIFT				0
+#define M98925_DAI_VBAT_SLOT_WIDTH				5
+
+/* MAX98925_R025_DOUT_CFG_VBST */
+#define M98925_DAI_VBST_EN_MASK					(1<<5)
+#define M98925_DAI_VBST_EN_SHIFT				5
+#define M98925_DAI_VBST_EN_WIDTH				1
+#define M98925_DAI_VBST_SLOT_MASK				(0x1F<<0)
+#define M98925_DAI_VBST_SLOT_SHIFT				0
+#define M98925_DAI_VBST_SLOT_WIDTH				5
+
+/* MAX98925_R026_DOUT_CFG_FLAG */
+#define M98925_DAI_FLAG_EN_MASK					(1<<5)
+#define M98925_DAI_FLAG_EN_SHIFT				5
+#define M98925_DAI_FLAG_EN_WIDTH				1
+#define M98925_DAI_FLAG_SLOT_MASK				(0x1F<<0)
+#define M98925_DAI_FLAG_SLOT_SHIFT				0
+#define M98925_DAI_FLAG_SLOT_WIDTH				5
+
+/* MAX98925_R027_DOUT_HIZ_CFG1 */
+#define M98925_DAI_SLOT_HIZ_CFG1_MASK			(0xFF<<0)
+#define M98925_DAI_SLOT_HIZ_CFG1_SHIFT			0
+#define M98925_DAI_SLOT_HIZ_CFG1_WIDTH			8
+
+/* MAX98925_R028_DOUT_HIZ_CFG2 */
+#define M98925_DAI_SLOT_HIZ_CFG2_MASK			(0xFF<<0)
+#define M98925_DAI_SLOT_HIZ_CFG2_SHIFT			0
+#define M98925_DAI_SLOT_HIZ_CFG2_WIDTH			8
+
+/* MAX98925_R029_DOUT_HIZ_CFG3 */
+#define M98925_DAI_SLOT_HIZ_CFG3_MASK			(0xFF<<0)
+#define M98925_DAI_SLOT_HIZ_CFG3_SHIFT			0
+#define M98925_DAI_SLOT_HIZ_CFG3_WIDTH			8
+
+/* MAX98925_R02A_DOUT_HIZ_CFG4 */
+#define M98925_DAI_SLOT_HIZ_CFG4_MASK			(0xFF<<0)
+#define M98925_DAI_SLOT_HIZ_CFG4_SHIFT			0
+#define M98925_DAI_SLOT_HIZ_CFG4_WIDTH			8
+
+/* MAX98925_R02B_DOUT_DRV_STRENGTH */
+#define M98925_DAI_OUT_DRIVE_MASK				(0x03<<0)
+#define M98925_DAI_OUT_DRIVE_SHIFT				0
+#define M98925_DAI_OUT_DRIVE_WIDTH				2
+
+/* MAX98925_R02C_FILTERS */
+#define M98925_ADC_DITHER_EN_MASK				(1<<7)
+#define M98925_ADC_DITHER_EN_SHIFT				7
+#define M98925_ADC_DITHER_EN_WIDTH				1
+#define M98925_IV_DCB_EN_MASK					(1<<6)
+#define M98925_IV_DCB_EN_SHIFT					6
+#define M98925_IV_DCB_EN_WIDTH					1
+#define M98925_DAC_DITHER_EN_MASK				(1<<4)
+#define M98925_DAC_DITHER_EN_SHIFT				4
+#define M98925_DAC_DITHER_EN_WIDTH				1
+#define M98925_DAC_FILTER_MODE_MASK				(1<<3)
+#define M98925_DAC_FILTER_MODE_SHIFT			3
+#define M98925_DAC_FILTER_MODE_WIDTH			1
+#define M98925_DAC_HPF_MASK				(0x07<<0)
+#define M98925_DAC_HPF_SHIFT					0
+#define M98925_DAC_HPF_WIDTH					3
+#define M98925_DAC_HPF_DISABLE		(0 << M98925_DAC_HPF_SHIFT)
+#define M98925_DAC_HPF_DC_BLOCK		(1 << M98925_DAC_HPF_SHIFT)
+#define M98925_DAC_HPF_EN_100		(2 << M98925_DAC_HPF_SHIFT)
+#define M98925_DAC_HPF_EN_200		(3 << M98925_DAC_HPF_SHIFT)
+#define M98925_DAC_HPF_EN_400		(4 << M98925_DAC_HPF_SHIFT)
+#define M98925_DAC_HPF_EN_800		(5 << M98925_DAC_HPF_SHIFT)
+
+/* MAX98925_R02D_GAIN */
+#define M98925_DAC_IN_SEL_MASK					(0x03<<5)
+#define M98925_DAC_IN_SEL_SHIFT					5
+#define M98925_DAC_IN_SEL_WIDTH					2
+#define M98925_SPK_GAIN_MASK					(0x1F<<0)
+#define M98925_SPK_GAIN_SHIFT					0
+#define M98925_SPK_GAIN_WIDTH					5
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
+#define M98925_ALC_EN_MASK			(1<<5)
+#define M98925_ALC_EN_SHIFT			5
+#define M98925_ALC_EN_WIDTH			1
+#define M98925_ALC_TH_MASK			(0x1F<<0)
+#define M98925_ALC_TH_SHIFT			0
+#define M98925_ALC_TH_WIDTH			5
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
+#define M98925_BST_EN_MASK			(1<<7)
+#define M98925_BST_EN_SHIFT			7
+#define M98925_BST_EN_WIDTH			1
+#define M98925_WATCH_EN_MASK		(1<<6)
+#define M98925_WATCH_EN_SHIFT		6
+#define M98925_WATCH_EN_WIDTH		1
+#define M98925_CLKMON_EN_MASK		(1<<5)
+#define M98925_CLKMON_EN_SHIFT		5
+#define M98925_CLKMON_EN_WIDTH		1
+#define M98925_SPK_EN_MASK			(1<<4)
+#define M98925_SPK_EN_SHIFT			4
+#define M98925_SPK_EN_WIDTH			1
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
+#define M98925_THERMWARN_LEVEL_SHIFT			2
+#define M98925_THERMWARN_LEVEL_WIDTH			2
+#define M98925_WATCH_TIME_MASK			(0x03<<0)
+#define M98925_WATCH_TIME_SHIFT			0
+#define M98925_WATCH_TIME_WIDTH			2
+
+/* MAX98925_R038_GLOBAL_ENABLE */
+#define M98925_EN_MASK			(1<<7)
+#define M98925_EN_SHIFT			7
+#define M98925_EN_WIDTH			1
+
+/* MAX98925_R03A_BOOST_LIMITER */
+#define M98925_BST_ILIM_MASK	(0x1F<<3)
+#define M98925_BST_ILIM_SHIFT	3
+#define M98925_BST_ILIM_WIDTH	5
+
+/* MAX98925_R0FF_VERSION */
+#define M98925_REV_ID_MASK	(0xFF<<0)
+#define M98925_REV_ID_SHIFT	0
+#define M98925_REV_ID_WIDTH	8
+
+struct max98925_priv {
+	struct regmap *regmap;
+	struct snd_soc_codec *codec;
+	struct max98925_pdata *pdata;
+	unsigned int sysclk;
+	unsigned int v_slot;
+	unsigned int i_slot;
+	unsigned int spk_gain;
+	unsigned int ch_size;
+};
+#endif
-- 
1.9.3
