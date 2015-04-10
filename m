From: Chih-Chiang Chang <ccchang12@nuvoton.com>
Subject: [PATCH] ASoC: Add support for NAU8825 codec to ASoC
Date: Fri, 10 Apr 2015 15:21:42 +0800
Message-ID: <55277A06.3060206@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, lgirdwood@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The NAU88L25 is an ultra-low power high performance audio codec designe=
d
for smartphone, tablet PC, and other portable devices by Nuvoton, now
add linux driver support for it.

Signed-off-by: Chih-Chiang Chang <ccchang12@nuvoton.com>
---
 include/sound/nau8825_plat.h |  22 ++
 sound/soc/codecs/Kconfig     |   5 +
 sound/soc/codecs/Makefile    |   2 +
 sound/soc/codecs/nau8825.c   | 593 +++++++++++++++++++++++++++++++++++=
++++++++
 sound/soc/codecs/nau8825.h   | 150 +++++++++++
 5 files changed, 772 insertions(+)
 create mode 100644 include/sound/nau8825_plat.h
 create mode 100644 sound/soc/codecs/nau8825.c
 create mode 100644 sound/soc/codecs/nau8825.h

diff --git a/include/sound/nau8825_plat.h b/include/sound/nau8825_plat.=
h
new file mode 100644
index 0000000..87afcd3
--- /dev/null
+++ b/include/sound/nau8825_plat.h
@@ -0,0 +1,22 @@
+/*
+ * linux/sound/snd_nau8825.h -- Platform data for NAU8825
+ *
+ * Copyright 2015 Nuvoton Technology Corp.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_NAU8825_H
+#define __LINUX_SND_NAU8825_H
+
+struct nau8825_platform_data {
+	unsigned int audio_mclk1;
+	unsigned int gpio_irq;
+	int naudint_irq;
+	int headset_detect;
+	int button_press_detect;
+};
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0bddd92..8807c57 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -75,6 +75,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_MC13783 if MFD_MC13XXX
 	select SND_SOC_ML26124 if I2C
+	select SND_SOC_NAU8825 if I2C
 	select SND_SOC_HDMI_CODEC
 	select SND_SOC_PCM1681 if I2C
 	select SND_SOC_PCM1792A if SPI_MASTER
@@ -464,6 +465,10 @@ config SND_SOC_MAX98357A
 config SND_SOC_MAX9850
 	tristate
=20
+config SND_SOC_NAU8825
+	tristate "Nuvoton NAU8825 CODEC"
+	depends on I2C
+
 config SND_SOC_PCM1681
 	tristate "Texas Instruments PCM1681 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 7acb6c1..acf594e 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -68,6 +68,7 @@ snd-soc-max98357a-objs :=3D max98357a.o
 snd-soc-max9850-objs :=3D max9850.o
 snd-soc-mc13783-objs :=3D mc13783.o
 snd-soc-ml26124-objs :=3D ml26124.o
+snd-soc-nau8825-objs :=3D nau8825.o
 snd-soc-hdmi-codec-objs :=3D hdmi.o
 snd-soc-pcm1681-objs :=3D pcm1681.o
 snd-soc-pcm1792a-codec-objs :=3D pcm1792a.o
@@ -252,6 +253,7 @@ obj-$(CONFIG_SND_SOC_MAX98357A)	+=3D snd-soc-max983=
57a.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+=3D snd-soc-max9850.o
 obj-$(CONFIG_SND_SOC_MC13783)	+=3D snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+=3D snd-soc-ml26124.o
+obj-$(CONFIG_SND_SOC_NAU8825)	+=3D snd-soc-nau8825.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC) +=3D snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+=3D snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM1792A)	+=3D snd-soc-pcm1792a-codec.o
diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
new file mode 100644
index 0000000..a8c8f59
--- /dev/null
+++ b/sound/soc/codecs/nau8825.c
@@ -0,0 +1,593 @@
+/*
+ * linux/sound/soc/codecs/nau8825.c
+ *
+ * Copyright 2015 Nuvoton Technology Corp.
+ * Author: Meng-Huang Kuo <mhkuo@nuvoton.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <linux/acpi.h>
+#include <asm/div64.h>
+#include <sound/jack.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <linux/delay.h>
+#include "nau8825.h"
+
+static int nau8825_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai);
+static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai,
+				unsigned int fmt);
+static int nau8825_set_bias_level(struct snd_soc_codec *codec,
+				enum snd_soc_bias_level level);
+static int nau8825_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+				unsigned int freq, int dir);
+static const DECLARE_TLV_DB_SCALE(out_hp_vol_tlv, -5400, 100, 0);
+static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, 2400, 50, 1);
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -12800, 50, 0);
+
+static const struct snd_kcontrol_new nau8825_snd_controls[] =3D {
+
+	SOC_SINGLE_TLV("MIC Volume", NAU8825_ADC_DGAIN_CTRL,
+				NAU8825_ADC_DGAIN_SFT,
+				NAU8825_ADC_VOL_RSCL_RANGE, 0, adc_vol_tlv),
+	SOC_DOUBLE_TLV("HP Volume", NAU8825_HSVOL_CTRL,
+				NAU8825_L_HSVOL_SFT, NAU8825_R_HSVOL_SFT,
+				NAU8825_VOL_RSCL_RANGE, 1, out_hp_vol_tlv),
+	SOC_DOUBLE("HP Playback Switch", NAU8825_HSVOL_CTRL, NAU8825_L_MUTE,
+				NAU8825_R_MUTE, 1, 1),
+	SOC_SINGLE("HP Class OP", NAU8825_CLASS_G_CTRL, NAU8825_CLASS_G_SHIFT=
,
+				 1, 0),
+	SOC_SINGLE("DAC Right", NAU8825_DAC_CTRL, NAU8825_DAC_R_SFT, 1, 0),
+	SOC_SINGLE("DAC Left", NAU8825_DAC_CTRL, NAU8825_DAC_L_SFT, 1, 0),
+	SOC_SINGLE("DAC Right Clock", NAU8825_DAC_CTRL, NAU8825_DAC_CLK_R_SFT=
,
+				1, 0),
+	SOC_SINGLE("DAC Left Clock", NAU8825_DAC_CTRL, NAU8825_DAC_CLK_L_SFT,
+				1, 0),
+};
+
+static const struct snd_kcontrol_new nau8825_hpo_mix[] =3D {
+	SOC_DAPM_SINGLE("HP L Switch", NAU8825_HSVOL_CTRL,
+	NAU8825_L_MUTE_SFT, 1, 1),
+	SOC_DAPM_SINGLE("HP R Switch", NAU8825_HSVOL_CTRL,
+	NAU8825_R_MUTE_SFT, 1, 1),
+};
+
+static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] =3D {
+
+	SND_SOC_DAPM_INPUT("Mic Jack"),
+	SND_SOC_DAPM_MICBIAS("MIC BIAS", NAU8825_BOOST, NAU8825_G_BIAS_SFT, 0=
),
+	SND_SOC_DAPM_SUPPLY("micbias", SND_SOC_NOPM, 0, 0,
+				NULL, SND_SOC_DAPM_PRE_PMU
+				| SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("vmid", SND_SOC_NOPM, 0, 0, NULL,
+				SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	/* ADCs */
+	SND_SOC_DAPM_ADC("ADC L", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC R", NULL, SND_SOC_NOPM, 0, 0),
+	/* ADC IF1  */
+	SND_SOC_DAPM_PGA("IF1 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	/* Audio Interface */
+	SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0)=
,
+	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0)=
,
+	/* DACs */
+	SND_SOC_DAPM_DAC_E("DAC L1", NULL, NAU8825_DAC_CTRL,
+				NAU8825_DAC_L_SFT, 0, NULL,
+				SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_DAC_E("DAC R1", NULL, NAU8825_DAC_CTRL,
+				NAU8825_DAC_R_SFT, 0, NULL,
+				SND_SOC_DAPM_PRE_PMD),
+	/* SPO/HPO/LOUT/Mono Mixer */
+	SND_SOC_DAPM_MIXER("HPO MIX", SND_SOC_NOPM, 0, 0, nau8825_hpo_mix,
+				ARRAY_SIZE(nau8825_hpo_mix)),
+	SND_SOC_DAPM_PGA_S("HP amp", 1, NAU8825_CLASS_G_CTRL,
+				NAU8825_CLASS_G_SHIFT, 0, NULL, 0),
+	/* Output Lines */
+	SND_SOC_DAPM_OUTPUT("HPOL"),
+	SND_SOC_DAPM_OUTPUT("HPOR"),
+};
+
+static const struct snd_soc_dapm_route nau8825_dapm_routes[] =3D {
+
+	{"ADC L", NULL, "Mic Jack"},
+	{"ADC R", NULL, "Mic Jack"},
+	{"AIF1TX", NULL, "ADC L"},
+	{"AIF1TX", NULL, "ADC R"},
+	{"DAC L1", NULL, "AIF1RX"},
+	{"DAC R1", NULL, "AIF1RX"},
+	{"HPO MIX", "HP L Switch", "DAC L1"},
+	{"HPO MIX", "HP R Switch", "DAC R1"},
+	{"HP amp", NULL, "HPO MIX"},
+	{"HPOL", NULL, "HP amp"},
+	{"HPOR", NULL, "HP amp"},
+};
+
+static int nau8825_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *tmp)
+{
+	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
+	struct snd_soc_codec *codec =3D rtd->codec;
+	unsigned int val_len =3D 0;
+
+	switch (params_width(params)) {
+	case 16:
+		break;
+	case 20:
+		val_len |=3D NAU8825_I2S_DL_20;
+		break;
+	case 24:
+		val_len |=3D NAU8825_I2S_DL_24;
+		break;
+	case 32:
+		val_len |=3D NAU8825_I2S_DL_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+	snd_soc_update_bits(codec, NAU8825_I2S_PCM_CTRL_1,
+				NAU8825_I2S_DL_MASK, val_len);
+	return 0;
+}
+
+static int nau8825_dac_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+	struct snd_soc_codec *codec =3D codec_dai->codec;
+
+	if (mute)
+		snd_soc_update_bits(codec, NAU8825_DAC_MUTE_CTRL,
+				NAU8825_SOFT_MUTE_MASK, NAU8825_SOFT_MUTE_EN);
+	else
+		snd_soc_update_bits(codec, NAU8825_DAC_MUTE_CTRL,
+				NAU8825_SOFT_MUTE_MASK, NAU8825_SOFT_MUTE_DIS);
+	return 0;
+}
+
+static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned=
 int fmt)
+{
+	struct snd_soc_codec *codec =3D codec_dai->codec;
+	unsigned int reg_val =3D 0;
+
+	dev_dbg(codec->dev, " %s ###nau8825_set_dai_fmt %x\n", __func__, fmt)=
;
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		reg_val |=3D NAU8825_I2S_BP_INV;
+		break;
+	default:
+		dev_alert(codec->dev, "Invalid DAI interface format\n");
+		return -EINVAL;
+	}
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		reg_val |=3D NAU8825_I2S_DF_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		reg_val |=3D NAU8825_I2S_DF_LEFT;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		reg_val |=3D NAU8825_I2S_DF_RIGHT;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		reg_val |=3D NAU8825_I2S_DF_PCM_A;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		reg_val |=3D NAU8825_I2S_DF_PCM_B;
+		reg_val |=3D NAU8825_I2S_PCMB_EN;
+		break;
+	default:
+		dev_alert(codec->dev, "Invalid DAI I2S/PCM format\n");
+		return -EINVAL;
+	}
+	snd_soc_update_bits(codec, NAU8825_I2S_PCM_CTRL_1,
+				NAU8825_I2S_DL_MASK | NAU8825_I2S_DF_MASK
+				| NAU8825_I2S_BP_MASK | NAU8825_I2S_PCMB_MASK,
+				reg_val);
+	return 0;
+}
+
+static void config_fll_clk_12m(struct snd_soc_codec *codec)
+{
+	snd_soc_update_bits(codec, NAU8825_CLK_DIVIDER, 0x000F, 0x0003);
+	snd_soc_update_bits(codec, NAU8825_FL_1, 0x007F, 0x0001);
+	snd_soc_write(codec, NAU8825_FL_2, 0xC49B);
+	snd_soc_update_bits(codec, NAU8825_FL_3, 0x03FF, 0x0020);
+	snd_soc_update_bits(codec, NAU8825_FL_4, 0x0C00, 0x0800);
+	snd_soc_update_bits(codec, NAU8825_FL_5, 0x2000, 0x0000);
+	snd_soc_update_bits(codec, NAU8825_FL_6, 0x4000, 0x4000);
+}
+
+void set_sys_clk(struct snd_soc_codec *codec, int sys_clk)
+{
+	pr_debug("%s :: sys_clk=3D%x\n", __func__, sys_clk);
+	switch (sys_clk) {
+	case NAU8825_INTERNALCLOCK:
+		snd_soc_write(codec, NAU8825_CLK_DIVIDER, 0x0853);
+		snd_soc_write(codec, NAU8825_FL_6, 0xE000);
+		snd_soc_write(codec, NAU8825_CLK_DIVIDER, 0x8853);
+		break;
+	case NAU8825_MCLK:
+	default:
+		snd_soc_write(codec, NAU8825_CLK_DIVIDER, 0x0853);
+		snd_soc_write(codec, NAU8825_FL_6, 0x6000);
+		snd_soc_write(codec, NAU8825_CLK_DIVIDER, 0x8853);
+		break;
+	}
+}
+
+static int nau8825_dai_set_sysclk(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec =3D dai->codec;
+
+	switch (clk_id) {
+	case NAU8825_MCLK:
+		config_fll_clk_12m(codec);
+		set_sys_clk(codec, clk_id);
+		break;
+	case NAU8825_INTERNALCLOCK:
+		set_sys_clk(codec, clk_id);
+		break;
+	default:
+		dev_err(codec->dev, "Wrong clock src\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int nau8825_set_bias_level(struct snd_soc_codec *codec,
+				enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		/* All power is driven by DAPM system*/
+		dev_dbg(codec->dev, "###nau8825_set_bias_level BIAS_ON\n");
+		snd_soc_update_bits(codec, NAU8825_BIAS_ADJ,
+			NAU8825_VMID_MASK, NAU8825_VMID_EN);
+		snd_soc_update_bits(codec, NAU8825_BOOST,
+				NAU8825_G_BIAS_MASK, NAU8825_G_BIAS_EN);
+		break;
+	case SND_SOC_BIAS_OFF:
+		dev_dbg(codec->dev, "###nau8825_set_bias_level OFF\n");
+		set_sys_clk(codec, NAU8825_INTERNALCLOCK);
+		snd_soc_update_bits(codec, NAU8825_BIAS_ADJ, NAU8825_VMID_MASK,
+				NAU8825_VMID_DIS);
+		snd_soc_update_bits(codec, NAU8825_BOOST,
+				NAU8825_G_BIAS_MASK, NAU8825_G_BIAS_DIS);
+		break;
+	default:
+		break;
+	}
+	codec->dapm.bias_level =3D level;
+	dev_dbg(codec->dev, "## nau8825_set_bias_level %d\n", level);
+	return 0;
+}
+
+static int nau8825_codec_suspend(struct snd_soc_codec *codec)
+{
+	nau8825_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static int nau8825_resume(struct snd_soc_codec *codec)
+{
+	nau8825_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	return 0;
+}
+
+static const struct reg_default nau8825_reg[] =3D {
+	/* software reset */
+	{0x0000, 0x0001},
+	{0x0000, 0x0002},
+	/* enable clock source */
+	{0x0001, 0x07FF},
+	/* enable VMID and Bias */
+	{0x0076, 0x3140},
+	/* setup clock divider */
+	{0x0003, 0x0050},
+	/* jack detection configuration */
+	{0x000D, 0x00E0},
+	{0x000F, 0x0801},
+	{0x0012, 0x0010},
+	/* keypad detection configuration */
+	{0x0013, 0x0280},
+	{0x0014, 0x7310},
+	{0x0015, 0x050E},
+	{0x0016, 0x1B2A},
+	/* audio format configuration */
+	{0x001A, 0x0800},
+	{0x001C, 0x000E},
+	{0x001D, 0x0010},
+	/* sampling rate control */
+	{0x002B, 0x0012},
+	/* DAC sampling rate control */
+	{0x002C, 0x0082},
+	/* ADC and DAC mixer control */
+	{0x0030, 0x00D2},
+	{0x0033, 0x00CF},
+	{0x0034, 0x02CF},
+	/* DAC class-G control */
+	{0x006A, 0x1003},
+	{0x0050, 0x2007},
+	/* ADC PGA control */
+	{0x0072, 0x0260},
+	/* DAC power down enabled */
+	{0x0080, 0x03A0},
+	/* enable DAC clock */
+	{0x0073, 0x336C},
+	/* enable MIC Bias */
+	{0x0074, 0x5502},
+	/* powerup output driver */
+	{0x007F, 0x473C},
+	{0x007F, 0x473F},
+	/* DAC power down disabled */
+	{0x0080, 0x00A0},
+	/* adjust MIC Bias */
+	{0x0066, 0x2060},
+	{0x0066, 0x2060},
+	{0x0066, 0x0060},
+};
+
+static int nau8825_codec_probe(struct snd_soc_codec *codec)
+{
+	int i;
+	struct nau8825_priv *nau8825;
+
+	nau8825 =3D snd_soc_codec_get_drvdata(codec);
+	nau8825->codec =3D codec;
+	/*writing initial register values to the codec*/
+	for (i =3D 0; i < ARRAY_SIZE(nau8825_reg); i++)
+		snd_soc_write(codec, nau8825_reg[i].reg, nau8825_reg[i].def);
+	return 0;
+}
+
+static int nau8825_codec_remove(struct snd_soc_codec *codec)
+{
+	struct nau8825_priv *nau8825 =3D snd_soc_codec_get_drvdata(codec);
+
+	regmap_write(nau8825->regmap, NAU8825_RESET, 0);
+	regmap_write(nau8825->regmap, NAU8825_RESET, 1);
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_driver_nau8825 =3D {
+	.probe =3D nau8825_codec_probe,
+	.remove	=3D nau8825_codec_remove,
+	.suspend =3D nau8825_codec_suspend,
+	.resume	=3D nau8825_resume,
+	.set_bias_level	=3D nau8825_set_bias_level,
+	.controls =3D nau8825_snd_controls,
+	.num_controls =3D ARRAY_SIZE(nau8825_snd_controls),
+	.dapm_widgets =3D nau8825_dapm_widgets,
+	.num_dapm_widgets =3D ARRAY_SIZE(nau8825_dapm_widgets),
+	.dapm_routes =3D nau8825_dapm_routes,
+	.num_dapm_routes =3D ARRAY_SIZE(nau8825_dapm_routes),
+};
+
+static bool nau8825_readable_register(struct device *dev, unsigned int=
 reg)
+{
+	switch (reg) {
+	case NAU8825_RESET:
+	case NAU8825_ENA_CTRL:
+	case NAU8825_CLK_EN:
+	case NAU8825_CLK_DIVIDER:
+	case NAU8825_FL_1:
+	case NAU8825_FL_2:
+	case NAU8825_FL_3:
+	case NAU8825_FL_4:
+	case NAU8825_FL_5:
+	case NAU8825_FL_6:
+	case NAU8825_HEADSET_CTRL:
+	case NAU8825_JACK_DET_CTRL:
+	case NAU8825_IRQ_SETTING_1:
+	case NAU8825_IRQ_STATUS:
+	case NAU8825_IRQ_CLEAR:
+	case NAU8825_IRQ_SETTING:
+	case NAU8825_SAR_ADC:
+	case NAU8825_VDET_COEFFICIENT:
+	case NAU8825_VDET_THRESHOLD_1:
+	case NAU8825_VDET_THRESHOLD_2:
+	case NAU8825_GPIO2_CTRL:
+	case NAU8825_I2S_PCM_CTRL_1:
+	case NAU8825_I2S_PCM_CTRL_2:
+	case NAU8825_ADC_RATE:
+	case NAU8825_DAC_CTRL1:
+	case NAU8825_DAC_CTRL2:
+	case NAU8825_ADC_DGAIN_CTRL:
+	case NAU8825_DAC_MUTE_CTRL:
+	case NAU8825_HSVOL_CTRL:
+	case NAU8825_DACL_CTRL:
+	case NAU8825_DACR_CTRL:
+	case NAU8825_SAR_ADC_OUTPUT:
+	case NAU8825_ANALOG_CTRL2:
+	case NAU8825_ANALOG_ADC_1:
+	case NAU8825_ANALOG_ADC_2:
+	case NAU8825_DAC_CTRL:
+	case NAU8825_MIC_BIAS:
+	case NAU8825_BOOST:
+	case NAU8825_CLASS_G_CTRL:
+	case NAU8825_BIAS_ADJ:
+	case NAU8825_POWER_UP_CTRL:
+	case NAU8825_CHARGE_BUMP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool nau8825_volatile_register(struct device *dev, unsigned int=
 reg)
+{
+	switch (reg) {
+	case NAU8825_RESET:
+	case NAU8825_ENA_CTRL:
+	case NAU8825_CLK_EN:
+	case NAU8825_CLK_DIVIDER:
+	case NAU8825_FL_1:
+	case NAU8825_FL_2:
+	case NAU8825_FL_3:
+	case NAU8825_FL_4:
+	case NAU8825_FL_5:
+	case NAU8825_FL_6:
+	case NAU8825_HEADSET_CTRL:
+	case NAU8825_JACK_DET_CTRL:
+	case NAU8825_IRQ_SETTING_1:
+	case NAU8825_IRQ_STATUS:
+	case NAU8825_IRQ_CLEAR:
+	case NAU8825_IRQ_SETTING:
+	case NAU8825_SAR_ADC:
+	case NAU8825_VDET_COEFFICIENT:
+	case NAU8825_VDET_THRESHOLD_1:
+	case NAU8825_VDET_THRESHOLD_2:
+	case NAU8825_GPIO2_CTRL:
+	case NAU8825_I2S_PCM_CTRL_1:
+	case NAU8825_I2S_PCM_CTRL_2:
+	case NAU8825_ADC_RATE:
+	case NAU8825_DAC_CTRL1:
+	case NAU8825_DAC_CTRL2:
+	case NAU8825_ADC_DGAIN_CTRL:
+	case NAU8825_DAC_MUTE_CTRL:
+	case NAU8825_HSVOL_CTRL:
+	case NAU8825_DACL_CTRL:
+	case NAU8825_DACR_CTRL:
+	case NAU8825_SAR_ADC_OUTPUT:
+	case NAU8825_ANALOG_CTRL2:
+	case NAU8825_ANALOG_ADC_1:
+	case NAU8825_ANALOG_ADC_2:
+	case NAU8825_DAC_CTRL:
+	case NAU8825_MIC_BIAS:
+	case NAU8825_BOOST:
+	case NAU8825_CLASS_G_CTRL:
+	case NAU8825_BIAS_ADJ:
+	case NAU8825_POWER_UP_CTRL:
+	case NAU8825_CHARGE_BUMP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config nau8825_regmap =3D {
+	.reg_bits =3D 16,
+	.val_bits =3D 16,
+	.use_single_rw =3D true,
+	.max_register =3D NAU8825_MAX_REGISTER,
+	.volatile_reg =3D nau8825_volatile_register,
+	.readable_reg =3D nau8825_readable_register,
+	.cache_type =3D REGCACHE_RBTREE,
+	.reg_defaults =3D nau8825_reg,
+	.num_reg_defaults =3D ARRAY_SIZE(nau8825_reg),
+};
+
+static struct snd_soc_dai_ops nau8825_dai_ops =3D {
+	.hw_params	=3D nau8825_hw_params,
+	.set_sysclk	=3D nau8825_dai_set_sysclk,
+	.set_fmt	=3D nau8825_set_dai_fmt,
+	.digital_mute	=3D nau8825_dac_mute,
+};
+
+static struct snd_soc_dai_driver nau8825_dai_driver[] =3D {
+	{
+		.name =3D "nau8825-aif1",
+			.playback =3D {
+				.stream_name	 =3D "AIF1 Playback",
+				.channels_min	 =3D 1,
+				.channels_max	 =3D 2,
+				.rates		 =3D NAU8825_RATES,
+				.formats	 =3D NAU8825_FORMATS,
+			},
+			.capture =3D {
+				.stream_name	 =3D "AIF1 Capture",
+				.channels_min	 =3D 1,
+				.channels_max	 =3D 2,
+				.rates		 =3D NAU8825_RATES,
+				.formats	 =3D NAU8825_FORMATS,
+			},
+		.ops =3D &nau8825_dai_ops,
+	}
+};
+
+
+static int nau8825_i2c_probe(struct i2c_client *i2c,
+				 const struct i2c_device_id *i2c_id)
+{
+	struct nau8825_platform_data *pdata =3D dev_get_platdata(&i2c->dev);
+	struct nau8825_priv *nau8825;
+	int ret;
+
+	nau8825 =3D devm_kzalloc(&i2c->dev, sizeof(struct nau8825_priv),
+		GFP_KERNEL);
+	if (nau8825 =3D=3D NULL)
+		return -ENOMEM;
+	nau8825->i2c =3D i2c;
+	i2c_set_clientdata(i2c, nau8825);
+	if (pdata)
+		nau8825->pdata =3D *pdata;
+	nau8825->regmap =3D devm_regmap_init_i2c(i2c, &nau8825_regmap);
+	if (IS_ERR(nau8825->regmap)) {
+		ret =3D PTR_ERR(nau8825->regmap);
+		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
+		goto err_enable;
+	}
+	ret =3D snd_soc_register_codec(&i2c->dev, &soc_codec_driver_nau8825,
+				nau8825_dai_driver,
+				ARRAY_SIZE(nau8825_dai_driver));
+err_enable:
+	return ret;
+}
+
+static int nau8825_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
+	return 0;
+}
+
+static const struct i2c_device_id nau8825_i2c_id[] =3D {
+	{"nau8825", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, nau8825_i2c_id);
+
+static const struct acpi_device_id nau8825_acpi_match[] =3D {
+	{ "10508825", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, nau8825_acpi_match);
+
+static struct i2c_driver nau8825_i2c_driver =3D {
+	.driver =3D {
+		.name	=3D "nau8825",
+		.owner	=3D THIS_MODULE,
+		.acpi_match_table =3D ACPI_PTR(nau8825_acpi_match),
+	},
+	.probe		=3D nau8825_i2c_probe,
+	.remove		=3D (nau8825_i2c_remove),
+	.id_table	=3D nau8825_i2c_id,
+};
+module_i2c_driver(nau8825_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC NAU8825 codec driver");
+MODULE_AUTHOR("Nuvoton");
+MODULE_LICENSE("GPL v2");
+
+
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
new file mode 100644
index 0000000..b16d4d1
--- /dev/null
+++ b/sound/soc/codecs/nau8825.h
@@ -0,0 +1,150 @@
+/*
+ * linux/sound/soc/codecs/nau8825.h
+ *
+ * Copyright 2015 Nuvoton Technology Corp.
+ * Author: Meng-Huang Kuo <mhkuo@nuvoton.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _NAU8825_H
+#define _NAU8825_H
+
+#include <sound/nau8825_plat.h>
+
+#define NAU8825_RESET					0x00
+#define NAU8825_ENA_CTRL				0x01
+#define NAU8825_CLK_EN					0x02
+#define NAU8825_CLK_DIVIDER				0x03
+#define NAU8825_FL_1					0x04
+#define NAU8825_FL_2					0x05
+#define NAU8825_FL_3					0x06
+#define NAU8825_FL_4					0x07
+#define NAU8825_FL_5					0x08
+#define NAU8825_FL_6					0x09
+#define NAU8825_HEADSET_CTRL			0x0C
+#define NAU8825_JACK_DET_CTRL			0x0D
+#define NAU8825_IRQ_SETTING_1			0x0F
+#define NAU8825_IRQ_STATUS				0x10
+#define NAU8825_IRQ_CLEAR				0x11
+#define NAU8825_IRQ_SETTING				0x12
+#define NAU8825_SAR_ADC					0x13
+#define NAU8825_VDET_COEFFICIENT		0x14
+#define NAU8825_VDET_THRESHOLD_1		0x15
+#define NAU8825_VDET_THRESHOLD_2		0x16
+#define NAU8825_GPIO2_CTRL				0x1A
+#define NAU8825_I2S_PCM_CTRL_1			0x1C
+#define NAU8825_I2S_PCM_CTRL_2			0x1D
+#define NAU8825_ADC_RATE				0x2B
+#define NAU8825_DAC_CTRL1				0x2C
+#define NAU8825_DAC_CTRL2				0x2D
+#define NAU8825_ADC_DGAIN_CTRL			0x30
+#define NAU8825_DAC_MUTE_CTRL			0x31
+#define NAU8825_HSVOL_CTRL				0x32
+#define NAU8825_DACL_CTRL				0x33
+#define NAU8825_DACR_CTRL				0x34
+#define NAU8825_CLASS_G_CTRL			0x50
+#define NAU8825_SAR_ADC_OUTPUT			0x59
+#define NAU8825_BIAS_ADJ				0x66
+#define NAU8825_ANALOG_CTRL2			0x6A
+#define NAU8825_ANALOG_ADC_1			0x71
+#define NAU8825_ANALOG_ADC_2			0x72
+#define NAU8825_DAC_CTRL				0x73
+#define NAU8825_MIC_BIAS				0x74
+#define NAU8825_BOOST					0x76
+#define NAU8825_POWER_UP_CTRL			0x7F
+#define NAU8825_CHARGE_BUMP				0x80
+#define NAU8825_MAX_REGISTER			0xFF
+
+/* reg. NAU8825_I2S_PCM_CTRL_1 (0x1C) */
+#define NAU8825_I2S_BP_MASK			(0x1 << 7)
+#define NAU8825_I2S_BP_INV			(0x1 << 7)
+#define NAU8825_I2S_PCMB_MASK		(0x1 << 6)
+#define NAU8825_I2S_PCMB_EN			(0x1 << 6)
+#define NAU8825_I2S_DL_MASK			(0x3 << 2)
+#define NAU8825_I2S_DF_MASK				0x3
+#define NAU8825_I2S_DF_RIGHT			0x0
+#define NAU8825_I2S_DF_LEFT				0x1
+#define NAU8825_I2S_DF_I2S				0x2
+#define NAU8825_I2S_DF_PCM_A			0x3
+#define NAU8825_I2S_DF_PCM_B			0x3
+
+/* reg. NAU8825_I2S_PCM_CTRL_2 (0x1D) */
+#define NAU8825_I2S_MS_MASK			(0x1 << 3)
+
+/* reg. NAU8825_ADC_DGAIN_CTRL (0x30) */
+#define NAU8825_ADC_DGAIN_SFT			0
+
+/* reg. NAU8825_DAC_MUTE_CTRL (0x31) */
+#define NAU8825_SOFT_MUTE_MASK		(0x1 << 13)
+#define NAU8825_SOFT_MUTE_EN		(0x1 << 13)
+#define NAU8825_SOFT_MUTE_DIS		(0x0 << 13)
+
+/* reg. NAU8825_HSVOL_CTRL (0x32) */
+#define NAU8825_R_MUTE				(0x1 << 15)
+#define NAU8825_R_MUTE_SFT				15
+#define NAU8825_L_MUTE				(0x1 << 14)
+#define NAU8825_L_MUTE_SFT				14
+#define NAU8825_L_HSVOL_SFT				6
+#define NAU8825_R_HSVOL_SFT				0
+
+/* reg. NAU8825_CLASS_G_CTRL (0x50) */
+#define NAU8825_CLASS_G_RIGHT_SHIFT		2
+#define NAU8825_CLASS_G_LEFT_SHIFT		1
+#define NAU8825_CLASS_G_SHIFT			0
+
+/* reg. NAU8825_BIAS_ADJ_2 (0x66) */
+#define NAU8825_VMID_MASK			(0x1 << 6)
+#define NAU8825_VMID_EN				(0x1 << 6)
+#define NAU8825_VMID_DIS			(0x0 << 6)
+
+/* reg. NAU8825_DAC_CTRL (0x73) */
+#define NAU8825_DAC_R_SFT				13
+#define NAU8825_DAC_L_SFT				12
+#define NAU8825_DAC_CLK_R_SFT			9
+#define NAU8825_DAC_CLK_L_SFT			8
+
+/* reg. NAU8825_BOOST (0x76) */
+#define NAU8825_G_BIAS_MASK			(0x1 << 12)
+#define NAU8825_G_BIAS_SFT				12
+#define NAU8825_G_BIAS_EN			(0x1 << 12)
+#define NAU8825_G_BIAS_DIS			(0x0 << 12)
+
+/* Volume Rescale */
+#define NAU8825_VOL_RSCL_RANGE			0x36
+#define NAU8825_ADC_VOL_RSCL_RANGE		0x256
+
+/* Data format */
+#define NAU8825_I2S_DL_16			(0x0 << 2)
+#define NAU8825_I2S_DL_20			(0x1 << 2)
+#define NAU8825_I2S_DL_24			(0x2 << 2)
+#define NAU8825_I2S_DL_32			(0x3 << 2)
+
+enum {
+	NAU8825_INTERNALCLOCK =3D 0,
+	NAU8825_MCLK,
+};
+
+#define NAU8825_RATES	SNDRV_PCM_RATE_8000_192000
+#define NAU8825_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S2=
0_3LE \
+			 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+struct nau8825_priv {
+	struct snd_soc_codec *codec;
+	struct nau8825_platform_data pdata;
+	struct regmap *regmap;
+	struct i2c_client *i2c;
+	struct snd_soc_jack *hp_jack;
+	struct snd_soc_jack *mic_jack;
+	struct delayed_work delayed_work;
+
+	struct workqueue_struct *workqueue;
+	struct mutex mutex;
+	unsigned int irq;
+	bool jd_status;
+	bool bp_status;
+	int	jack_type;
+};
+#endif	/* _NAU8825_H */
--=20
1.9.3


---
Avast =E9=98=B2=E6=AF=92=E8=BB=9F=E9=AB=94=E5=B7=B2=E6=AA=A2=E6=9F=A5=E6=
=AD=A4=E5=B0=81=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E7=9A=84=E7=97=85=E6=
=AF=92=E3=80=82
http://www.avast.com
