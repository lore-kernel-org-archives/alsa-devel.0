From: Zeng Zhaoming <zengzm.kernel@gmail.com>
Subject: [PATCH v2] ASoC: Add FreeScale SGTL5000 codec suppor
Date: Mon, 17 Jan 2011 14:48:54 +0800
Message-ID: <20110117064816.GA2158@ubuntu.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="hQiwHBbRI9kgIhsi"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CAD0103877
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 15:49:20 +0100 (CET)
Received: by pwj4 with SMTP id 4so1070741pwj.38
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 06:49:18 -0800 (PST)
Content-Disposition: inline
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
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, zhaoming.zeng@freescale.com, lrg@slimlogic.co.uk, arnaud.patard@rtp-net.org, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=gb18030
Content-Disposition: inline

v1 url:
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-December/034615.html

Changes since v1:
  - Add DAPM widges as Mark and Arnaud point out.
  - cleanup regulator code
  - new implement dai_ops functions
  - sort configs in Kconfig and Makefile

--hQiwHBbRI9kgIhsi
Content-Type: text/x-diff; charset=gb18030
Content-Disposition: attachment; filename="0001-ASoC-Add-FreeScale-SGTL5000-codec-support.patch"

>From 1704fd5e7cf2540e247aa8a4f69d81ae5e6cbd4e Mon Sep 17 00:00:00 2001
From: Zeng Zhaoming <zengzm.kernel@gmail.com>
Date: Mon, 17 Jan 2011 10:34:42 +0800
Subject: [PATCH] ASoC: Add FreeScale SGTL5000 codec support

add FreeScale SGTL5000 codec support

Signed-off-by: Zeng Zhaoming <zhaoming.zeng@freescale.com>
---
 sound/soc/codecs/Kconfig    |    4 +
 sound/soc/codecs/Makefile   |    1 +
 sound/soc/codecs/sgtl5000.c | 1016 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/sgtl5000.h |  403 +++++++++++++++++
 4 files changed, 1424 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/sgtl5000.c
 create mode 100644 sound/soc/codecs/sgtl5000.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 883a312..19bbb73 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -32,6 +32,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX98088 if I2C
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_PCM3008
+	select SND_SOC_SGTL5000 if I2C
 	select SND_SOC_SPDIF
 	select SND_SOC_SSM2602 if I2C
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
@@ -176,6 +177,9 @@ config SND_SOC_MAX98088
 config SND_SOC_PCM3008
        tristate
 
+config SND_SOC_SGTL5000
+	tristate
+
 config SND_SOC_SPDIF
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 579af9c..78e36cc 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -18,6 +18,7 @@ snd-soc-dmic-objs := dmic.o
 snd-soc-l3-objs := l3.o
 snd-soc-max98088-objs := max98088.o
 snd-soc-pcm3008-objs := pcm3008.o
+snd-soc-sgtl5000-objs := sgtl5000.o
 snd-soc-alc5623-objs := alc5623.o
 snd-soc-spdif-objs := spdif_transciever.o
 snd-soc-ssm2602-objs := ssm2602.o
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
new file mode 100644
index 0000000..9fe474f
--- /dev/null
+++ b/sound/soc/codecs/sgtl5000.c
@@ -0,0 +1,1016 @@
+/*
+ * sgtl5000.c  --  SGTL5000 ALSA SoC Audio driver
+ *
+ * Copyright 2010-2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <sound/core.h>
+#include <sound/tlv.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <mach/hardware.h>
+
+#include "sgtl5000.h"
+
+/* default value of all sgtl5000 registers */
+static const u16 sgtl5000_regs[] =  {
+	/* 0x0	   0x2     0x4 	    0x6     0x8    0xa     0xc     0xe */
+	0xa011, 0x0000, 0x0000, 0x0000, 0x0008, 0x0000, 0x0010, 0x0000,/* 0x */
+	0x0010, 0x0000, 0x0010, 0x0000, 0x0000, 0x0000, 0x323c, 0x0000,/* 1x */
+	0x3c3c, 0x0000, 0x3c3c, 0x0000, 0x555f, 0x0000, 0x0000, 0x0000,/* 2x */
+	0x0000, 0x0000, 0x0000, 0x0000, 0x408c, 0x0000, 0x0008, 0x0000,/* 3x */
+	0x0000, 0x0000, 0x1818, 0x0000, 0x0111, 0x0000, 0x0000, 0x0000,/* 4x */
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0404, 0x0000,/* 5x */
+	0x7060, 0x0000, 0x5000, 0x0000, 0x0000, 0x0000, 0x0017, 0x0000,/* 6x */
+	0x01c0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,/* 7x */
+};
+
+/* regulator supplies for sgtl5000, VDDD is an option external supply */
+enum sgtl5000_regulator_supplies {
+	VDDA,
+	VDDIO,
+	VDDD,
+	SGTL5000_SUPPLY_NUM
+};
+
+
+static const char *supply_names[SGTL5000_SUPPLY_NUM] = {
+	"VDDA",
+	"VDDIO",
+	"VDDD"
+};
+
+/* sgtl5000 private structure in codec */
+struct sgtl5000_priv {
+	int sysclk;	/* sysclk rate */
+	int master;	/* i2s master or not? */
+	int fmt;	/* i2s data format */
+	int lrclk;	/* frame clock rate */
+	int capture_channels;	/* the num of channels for capture. */
+	int small_pop;	/* hw assistant to eliminate pop */
+	struct regulator *supplies[SGTL5000_SUPPLY_NUM]; /* all regulators. */
+};
+
+static int mic_bias_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	/* change mic bias resistor to 4Kohm */
+	snd_soc_write(w->codec, SGTL5000_CHIP_MIC_CTRL, SGTL5000_BIAS_R_4k);
+
+	return 0;
+}
+
+static int dac_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
+			SGTL5000_VAG_POWERUP|SGTL5000_DAC_POWERUP,
+			SGTL5000_VAG_POWERUP|SGTL5000_DAC_POWERUP);
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
+			SGTL5000_DAC_POWERUP, 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * if small_pop is enabled, hp_powerup or lineout_powerup
+ * should be set before vag_powerup be cleared, this introduce
+ * 200~400ms latency
+ */
+static int small_pop_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct sgtl5000_priv *priv = snd_soc_codec_get_drvdata(w->codec);
+	int reg;
+
+	if (!priv->small_pop)
+		return 0;
+
+	reg = snd_soc_read(w->codec, SGTL5000_CHIP_ANA_POWER);
+	if (reg & SGTL5000_VAG_POWERUP) {
+		reg &= ~SGTL5000_VAG_POWERUP;
+		snd_soc_write(w->codec, SGTL5000_CHIP_ANA_POWER, reg);
+		msleep(400);
+	}
+
+	return 0;
+}
+
+static int adc_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
+		SGTL5000_DAC_POWERUP,
+		SGTL5000_DAC_POWERUP);
+
+	return 0;
+}
+
+/* input sources for ADC */
+static const char *adc_mux_text[] = {
+	"MIC_IN", "LINE_IN"
+};
+
+static const struct soc_enum adc_enum =
+SOC_ENUM_SINGLE(SGTL5000_CHIP_ANA_CTRL, 2, 2, adc_mux_text);
+
+static const struct snd_kcontrol_new adc_mux =
+SOC_DAPM_ENUM("Capture Mux", adc_enum);
+
+/* input sources for DAC */
+static const char *dac_mux_text[] = {
+	"DAC", "LINE_IN"
+};
+
+static const struct soc_enum dac_enum =
+SOC_ENUM_SINGLE(SGTL5000_CHIP_ANA_CTRL, 6, 2, dac_mux_text);
+
+static const struct snd_kcontrol_new dac_mux =
+SOC_DAPM_ENUM("Headphone Mux", dac_enum);
+
+static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("LINE_IN"),
+	SND_SOC_DAPM_INPUT("MIC_IN"),
+
+	SND_SOC_DAPM_OUTPUT("HP_OUT"),
+	SND_SOC_DAPM_OUTPUT("LINE_OUT"),
+
+	SND_SOC_DAPM_MICBIAS_E("Mic Bias", SGTL5000_CHIP_MIC_CTRL, 8, 0,
+				mic_bias_event, SND_SOC_DAPM_POST_PMU),
+
+	SND_SOC_DAPM_PGA_E("HP", SGTL5000_CHIP_ANA_POWER, 4, 0, NULL, 0,
+			small_pop_event, SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_PGA_E("LO", SGTL5000_CHIP_ANA_POWER, 0, 0, NULL, 0,
+			small_pop_event, SND_SOC_DAPM_PRE_PMD),
+
+	SND_SOC_DAPM_MUX("Capture Mux", SND_SOC_NOPM, 0, 0, &adc_mux),
+	SND_SOC_DAPM_MUX("Headphone Mux", SND_SOC_NOPM, 0, 0, &dac_mux),
+
+	/* aif for i2s input */
+	SND_SOC_DAPM_AIF_IN("AIFIN", "Playback",
+				0, SGTL5000_CHIP_DIG_POWER,
+				0, 0),
+
+	/* aif for i2s output */
+	SND_SOC_DAPM_AIF_OUT("AIFOUT", "Capture",
+				0, SGTL5000_CHIP_DIG_POWER,
+				1, 0),
+
+	SND_SOC_DAPM_ADC_E("ADC", "Capture", SGTL5000_CHIP_DIG_POWER, 6, 0,
+		adc_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_DAC_E("DAC", "Playback", SGTL5000_CHIP_DIG_POWER, 5, 0,
+		dac_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
+/* routes for sgtl5000 */
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Capture Mux", "LINE_IN", "LINE_IN"},	/* line_in --> adc_mux */
+	{"Capture Mux", "MIC_IN", "MIC_IN"},	/* mic_in --> adc_mux */
+
+	{"ADC", NULL, "Capture Mux"},		/* adc_mux --> adc */
+	{"AIFOUT", NULL, "ADC"},		/* adc --> i2s_out */
+
+	{"DAC", NULL, "AIFIN"},			/* i2s-->dac,skip audio mux */
+	{"Headphone Mux", "DAC", "DAC"},	/* dac --> hp_mux */
+	{"LO", NULL, "DAC"},			/* dac --> line_out */
+
+	{"Headphone Mux", "LINE_IN", "LINE_IN"},/* line_in --> hp_mux */
+	{"HP", NULL, "Headphone Mux"},		/* hp_mux --> hp */
+
+	{"LINE_OUT", NULL, "LO"},
+	{"HP_OUT", NULL, "HP"},
+};
+
+/* custom function to fetch info of PCM playback volume */
+static int dac_info_volsw(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0xfc - 0x3c;
+	return 0;
+}
+
+/* custom function to get of PCM playback volume */
+static int dac_get_volsw(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int reg, l, r;
+
+	reg = snd_soc_read(codec, SGTL5000_CHIP_DAC_VOL);
+	l = (reg & SGTL5000_DAC_VOL_LEFT_MASK) >> SGTL5000_DAC_VOL_LEFT_SHIFT;
+	r = (reg & SGTL5000_DAC_VOL_RIGHT_MASK) >> SGTL5000_DAC_VOL_RIGHT_SHIFT;
+	l = l < 0x3c ? 0x3c : l;
+	l = l > 0xfc ? 0xfc : l;
+	r = r < 0x3c ? 0x3c : r;
+	r = r > 0xfc ? 0xfc : r;
+
+	/* revert it */
+	l = 0xfc - l;
+	r = 0xfc - r;
+
+	ucontrol->value.integer.value[0] = l;
+	ucontrol->value.integer.value[1] = r;
+
+	return 0;
+}
+
+/* custom put function for PCM playback volume */
+static int dac_put_volsw(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int reg, l, r;
+
+	l = ucontrol->value.integer.value[0];
+	r = ucontrol->value.integer.value[1];
+
+	l = l < 0 ? 0 : l;
+	l = l > 0xfc - 0x3c ? 0xfc - 0x3c : l;
+	r = r < 0 ? 0 : r;
+	r = r > 0xfc - 0x3c ? 0xfc - 0x3c : r;
+	l = 0xfc - l;
+	r = 0xfc - r;
+
+	reg = l << SGTL5000_DAC_VOL_LEFT_SHIFT |
+	    r << SGTL5000_DAC_VOL_RIGHT_SHIFT;
+
+	snd_soc_write(codec, SGTL5000_CHIP_DAC_VOL, reg);
+
+	return 0;
+}
+
+/* tlv for mic gain, 0db 20db 30db 40db */
+static const unsigned int mic_gain_tlv[] = {
+	TLV_DB_RANGE_HEAD(4),
+	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+	1, 3, TLV_DB_SCALE_ITEM(2000, 1000, 0),
+};
+
+/* tlv for hp volume, -51.5db to 12.0db, step .5db */
+static const DECLARE_TLV_DB_SCALE(headphone_volume, -5150, 50, 0);
+
+static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
+	SOC_DOUBLE("Capture Volume", SGTL5000_CHIP_ANA_ADC_CTRL, 0, 4, 0xf, 0),
+	SOC_SINGLE("Capture Attenuate Switch (-6db)",
+		SGTL5000_CHIP_ANA_ADC_CTRL,
+		8, 1, 0),
+
+	/* we need SOC_DOUBLE_S8_TLV with invert */
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "PCM Playback Volume",
+		.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+			SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = dac_info_volsw,
+		.get = dac_get_volsw,
+		.put = dac_put_volsw,
+	},
+
+	SOC_DOUBLE_TLV("Headphone Playback Volume",
+			SGTL5000_CHIP_ANA_HP_CTRL,
+			0, 8,
+			0x7f, 1,
+			headphone_volume),
+
+	SOC_SINGLE_TLV("Mic Volume",
+		SGTL5000_CHIP_MIC_CTRL,
+		0, 4, 0, mic_gain_tlv),
+};
+
+/* mutt the codec used by alsa core */
+static int sgtl5000_digital_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+
+	u16 adcdac_ctrl = SGTL5000_DAC_MUTE_LEFT | SGTL5000_DAC_MUTE_RIGHT;
+
+	if (mute)
+		snd_soc_update_bits(codec, SGTL5000_CHIP_ADCDAC_CTRL,
+				adcdac_ctrl, adcdac_ctrl);
+	else
+		snd_soc_update_bits(codec, SGTL5000_CHIP_ADCDAC_CTRL,
+				adcdac_ctrl, 0);
+
+	return 0;
+}
+
+/* set codec format */
+static int sgtl5000_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
+	u16 i2sctl = 0;
+
+	sgtl5000->master = 0;
+	/*
+	 * i2s clock and frame master setting.
+	 * ONLY support:
+	 *  - clock and frame slave,
+	 *  - clock and frame master
+	 */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		i2sctl |= SGTL5000_I2S_MASTER;
+		sgtl5000->master = 1;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBS_CFM:
+		return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* setting i2s data format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		i2sctl |= SGTL5000_I2S_MODE_PCM;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		i2sctl |= SGTL5000_I2S_MODE_PCM;
+		i2sctl |= SGTL5000_I2S_LRALIGN;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		i2sctl |= SGTL5000_I2S_MODE_I2S_LJ;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		i2sctl |= SGTL5000_I2S_MODE_RJ;
+		i2sctl |= SGTL5000_I2S_LRPOL;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		i2sctl |= SGTL5000_I2S_MODE_I2S_LJ;
+		i2sctl |= SGTL5000_I2S_LRALIGN;
+		break;
+	default:
+		return -EINVAL;
+	}
+	sgtl5000->fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+
+	/* Clock inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		i2sctl |= SGTL5000_I2S_SCLK_INV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_write(codec, SGTL5000_CHIP_I2S_CTRL, i2sctl);
+
+	return 0;
+}
+
+/* set codec sysclk */
+static int sgtl5000_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				   int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
+
+	switch (clk_id) {
+	case SGTL5000_SYSCLK:
+		sgtl5000->sysclk = freq;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Set PCM DAI bit size and sample rate.
+ * input: params_rate, params_fmt
+ */
+static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
+	int channels = params_channels(params);
+	int clk_ctl = 0;
+	int pll_ctl = 0;
+	int i2s_ctl;
+	int div2 = 0;
+	int reg;
+	int sys_fs;
+
+	/* sysclk should already set */
+	if (!sgtl5000->sysclk) {
+		dev_err(codec->dev, "%s: set sysclk first!\n", __func__);
+		return -EFAULT;
+	}
+
+	/* power up adc, and set it accroding to stereo or not */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		sgtl5000->capture_channels = channels;
+
+		reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
+		reg |= SGTL5000_ADC_POWERUP;
+
+		if (sgtl5000->capture_channels == 1)
+			reg &= ~SGTL5000_ADC_STEREO;
+		else
+			reg |= SGTL5000_ADC_STEREO;
+
+		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, reg);
+	}
+
+	/* get frame clock rate */
+	sgtl5000->lrclk = params_rate(params);
+
+	/*
+	 * frame clock is divided from sys fs,
+	 * if frame clock lower than 44.1khz, sys fs should set to
+	 * 32khz or 44.1khz.
+	 */
+	switch (sgtl5000->lrclk) {
+	case 8000:
+	case 16000:
+		sys_fs = 32000;
+		break;
+	case 11025:
+	case 22050:
+		sys_fs = 44100;
+		break;
+	default:
+		sys_fs = sgtl5000->lrclk;
+		break;
+	}
+
+	/* get devided factor of frame clock */
+	switch (sys_fs / sgtl5000->lrclk) {
+	case 4:
+		clk_ctl |= SGTL5000_RATE_MODE_DIV_4 << SGTL5000_RATE_MODE_SHIFT;
+		break;
+	case 2:
+		clk_ctl |= SGTL5000_RATE_MODE_DIV_2 << SGTL5000_RATE_MODE_SHIFT;
+		break;
+	default:
+		break;
+	}
+
+	/* set the sys_fs accroding to frame clock */
+	switch (sys_fs) {
+	case 32000:
+		clk_ctl |= SGTL5000_SYS_FS_32k << SGTL5000_SYS_FS_SHIFT;
+		break;
+	case 44100:
+		clk_ctl |= SGTL5000_SYS_FS_44_1k << SGTL5000_SYS_FS_SHIFT;
+		break;
+	case 48000:
+		clk_ctl |= SGTL5000_SYS_FS_48k << SGTL5000_SYS_FS_SHIFT;
+		break;
+	case 96000:
+		clk_ctl |= SGTL5000_SYS_FS_96k << SGTL5000_SYS_FS_SHIFT;
+		break;
+	default:
+		dev_err(codec->dev, "sample rate %d not supported\n",
+			sgtl5000->lrclk);
+		return -EINVAL;
+	}
+
+	/* if codec is slave, just set register to match master parameters */
+	if (!sgtl5000->master) {
+		sys_fs = sgtl5000->lrclk;
+		clk_ctl = SGTL5000_RATE_MODE_DIV_1 << SGTL5000_RATE_MODE_SHIFT;
+		if (sys_fs * 256 == sgtl5000->sysclk)
+			clk_ctl |= SGTL5000_MCLK_FREQ_256FS <<
+				SGTL5000_MCLK_FREQ_SHIFT;
+		else if (sys_fs * 384 == sgtl5000->sysclk && sys_fs != 96000)
+			clk_ctl |= SGTL5000_MCLK_FREQ_384FS <<
+				SGTL5000_MCLK_FREQ_SHIFT;
+		else if (sys_fs * 512 == sgtl5000->sysclk && sys_fs != 96000)
+			clk_ctl |= SGTL5000_MCLK_FREQ_512FS <<
+				SGTL5000_MCLK_FREQ_SHIFT;
+		else {
+			pr_err("%s: PLL not supported in slave mode\n",
+			       __func__);
+			return -EINVAL;
+		}
+	} else
+		/* if codec is master, use PLL to generate sys_fs */
+		clk_ctl |= SGTL5000_MCLK_FREQ_PLL << SGTL5000_MCLK_FREQ_SHIFT;
+
+	if ((clk_ctl & SGTL5000_MCLK_FREQ_MASK) == SGTL5000_MCLK_FREQ_PLL) {
+		u64 out, t;
+		unsigned int in, int_div, frac_div;
+		if (sgtl5000->sysclk > 17000000) {
+			div2 = 1;
+			in = sgtl5000->sysclk / 2;
+		} else {
+			div2 = 0;
+			in = sgtl5000->sysclk;
+		}
+		if (sys_fs == 44100)
+			out = 180633600;
+		else
+			out = 196608000;
+		t = do_div(out, in);
+		int_div = out;
+		t *= 2048;
+		do_div(t, in);
+		frac_div = t;
+		pll_ctl = int_div << SGTL5000_PLL_INT_DIV_SHIFT |
+		    frac_div << SGTL5000_PLL_FRAC_DIV_SHIFT;
+	}
+
+	i2s_ctl = snd_soc_read(codec, SGTL5000_CHIP_I2S_CTRL);
+
+	/* set i2s data format */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		if (sgtl5000->fmt == SND_SOC_DAIFMT_RIGHT_J)
+			return -EINVAL;
+		i2s_ctl |= SGTL5000_I2S_DLEN_16 << SGTL5000_I2S_DLEN_SHIFT;
+		i2s_ctl |= SGTL5000_I2S_SCLKFREQ_32FS <<
+		    SGTL5000_I2S_SCLKFREQ_SHIFT;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		i2s_ctl |= SGTL5000_I2S_DLEN_20 << SGTL5000_I2S_DLEN_SHIFT;
+		i2s_ctl |= SGTL5000_I2S_SCLKFREQ_64FS <<
+		    SGTL5000_I2S_SCLKFREQ_SHIFT;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		i2s_ctl |= SGTL5000_I2S_DLEN_24 << SGTL5000_I2S_DLEN_SHIFT;
+		i2s_ctl |= SGTL5000_I2S_SCLKFREQ_64FS <<
+		    SGTL5000_I2S_SCLKFREQ_SHIFT;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		if (sgtl5000->fmt == SND_SOC_DAIFMT_RIGHT_J)
+			return -EINVAL;
+		i2s_ctl |= SGTL5000_I2S_DLEN_32 << SGTL5000_I2S_DLEN_SHIFT;
+		i2s_ctl |= SGTL5000_I2S_SCLKFREQ_64FS <<
+		    SGTL5000_I2S_SCLKFREQ_SHIFT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(codec->dev, "fs=%d,clk_ctl=%d,pll_ctl=%d,i2s_ctl=%d,div2=%d\n",
+		 sgtl5000->lrclk, clk_ctl, pll_ctl, i2s_ctl, div2);
+
+	if ((clk_ctl & SGTL5000_MCLK_FREQ_MASK) == SGTL5000_MCLK_FREQ_PLL) {
+		snd_soc_write(codec, SGTL5000_CHIP_PLL_CTRL, pll_ctl);
+		if (div2)
+			snd_soc_update_bits(codec,
+				SGTL5000_CHIP_CLK_TOP_CTRL,
+				SGTL5000_INPUT_FREQ_DIV2,
+				SGTL5000_INPUT_FREQ_DIV2);
+		else
+			snd_soc_update_bits(codec,
+				SGTL5000_CHIP_CLK_TOP_CTRL,
+				SGTL5000_INPUT_FREQ_DIV2,
+				0);
+
+		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
+			SGTL5000_PLL_POWERUP | SGTL5000_VCOAMP_POWERUP,
+			SGTL5000_PLL_POWERUP | SGTL5000_VCOAMP_POWERUP);
+	}
+	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL, clk_ctl);
+	snd_soc_write(codec, SGTL5000_CHIP_I2S_CTRL, i2s_ctl);
+
+	return 0;
+}
+
+/*
+ * set dac bias
+ * common state changes:
+ * startup:
+ * off --> standby --> prepare --> on
+ * standby --> prepare --> on
+ *
+ * stop:
+ * on --> prepare --> standby
+ */
+static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
+				   enum snd_soc_bias_level level)
+{
+	codec->bias_level = level;
+	return 0;
+}
+
+#define SGTL5000_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			SNDRV_PCM_FMTBIT_S20_3LE |\
+			SNDRV_PCM_FMTBIT_S24_LE)
+
+struct snd_soc_dai_ops sgtl5000_ops = {
+	.hw_params = sgtl5000_pcm_hw_params,
+	.digital_mute = sgtl5000_digital_mute,
+	.set_fmt = sgtl5000_set_dai_fmt,
+	.set_sysclk = sgtl5000_set_dai_sysclk,
+};
+
+static struct snd_soc_dai_driver sgtl5000_dai = {
+	.name = "sgtl5000",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		/*
+		 * only support 8~48K + 96K,
+		 * TODO modify hw_param to support more
+		 */
+		.rates = SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_96000,
+		.formats = SGTL5000_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_96000,
+		.formats = SGTL5000_FORMATS,
+	},
+	.ops = &sgtl5000_ops,
+	.symmetric_rates = 1,
+};
+
+static int sgtl5000_volatile_register(unsigned int reg)
+{
+	switch (reg) {
+	case SGTL5000_CHIP_ID:
+	case SGTL5000_CHIP_ADCDAC_CTRL:
+	case SGTL5000_CHIP_ANA_STATUS:
+		return 1;
+	}
+
+	return 0;
+}
+
+static int sgtl5000_suspend(struct snd_soc_codec *codec, pm_message_t state)
+{
+	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+static int sgtl5000_restore_reg(struct snd_soc_codec *codec, unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+
+	return snd_soc_write(codec, reg, cache[reg >> 1]);
+}
+
+static int sgtl5000_resume(struct snd_soc_codec *codec)
+{
+	int i;
+
+	/* Restore refs first in same order as in sgtl5000_probe */
+	sgtl5000_restore_reg(codec, SGTL5000_CHIP_LINREG_CTRL);
+	sgtl5000_restore_reg(codec, SGTL5000_CHIP_ANA_POWER);
+	msleep(10);
+	sgtl5000_restore_reg(codec, SGTL5000_CHIP_REF_CTRL);
+	sgtl5000_restore_reg(codec, SGTL5000_CHIP_LINE_OUT_CTRL);
+
+	/* Restore everythine else */
+	for (i = 0; i < ARRAY_SIZE(sgtl5000_regs); i++)
+		sgtl5000_restore_reg(codec, i);
+
+	snd_soc_write(codec, SGTL5000_DAP_CTRL, 0);
+
+	/* Bring the codec back up to standby first to minimise pop/clicks */
+	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	return 0;
+}
+
+static int sgtl5000_probe(struct snd_soc_codec *codec)
+{
+	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
+	u16 reg, ana_pwr, lreg_ctrl;
+	int vag;
+	int ret;
+	int vddd, vdda, vddio;
+	int rev;
+	int i;
+
+	/* setup i2c data ops */
+	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_I2C);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
+
+	/* get and enable all regulators */
+	for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
+		struct regulator *reg;
+		reg = regulator_get(codec->dev, supply_names[i]);
+
+		if (IS_ERR(reg))
+			continue;
+
+		regulator_enable(reg);
+		sgtl5000->supplies[i] = reg;
+	}
+
+	/* vdda and vddio regulator must configed */
+	if (!sgtl5000->supplies[VDDA] || !sgtl5000->supplies[VDDIO]) {
+		dev_err(codec->dev,
+			"Not set vdda or vddio regulator correctly\n");
+		/* FIXME, no such platform regulator configed */
+		return -ENODEV;
+	}
+
+	/* read chip information */
+	reg = snd_soc_read(codec, SGTL5000_CHIP_ID);
+	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
+	    SGTL5000_PARTID_PART_ID) {
+		dev_err(codec->dev,
+			"Device with ID register %x is not a sgtl5000\n", reg);
+		ret = -ENODEV;
+		goto err_out;
+	}
+
+	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
+	dev_info(codec->dev, "sgtl5000 revision %d\n", rev);
+
+	/* reset value */
+	ana_pwr = SGTL5000_DAC_STEREO |
+		SGTL5000_LINREG_SIMPLE_POWERUP |
+		SGTL5000_STARTUP_POWERUP |
+		SGTL5000_ADC_STEREO | SGTL5000_REFTOP_POWERUP;
+	lreg_ctrl = 0;
+
+	vdda  = regulator_get_voltage(sgtl5000->supplies[VDDA]) / 1000;
+	vddio = regulator_get_voltage(sgtl5000->supplies[VDDIO]) / 1000;
+
+	if (regulator_get_voltage(sgtl5000->supplies[VDDD]))
+		vddd = regulator_get_voltage(sgtl5000->supplies[VDDD]) / 1000;
+	else
+		vddd = 0;
+
+	/* workaround for rev 0x11: use vddd linear regulator */
+	if (!vddd || (rev >= 0x11)) {
+		/* set VDDD to 1.2v */
+		lreg_ctrl |= 0x8 << SGTL5000_LINREG_VDDD_SHIFT;
+		/* power internal linear regulator */
+		ana_pwr |= SGTL5000_LINEREG_D_POWERUP;
+	} else {
+		/* turn of startup power */
+		ana_pwr &= ~SGTL5000_STARTUP_POWERUP;
+		ana_pwr &= ~SGTL5000_LINREG_SIMPLE_POWERUP;
+	}
+
+	if (vddio < 3100 && vdda < 3100) {
+		/* Enable VDDC charge pump */
+		ana_pwr |= SGTL5000_VDDC_CHRGPMP_POWERUP;
+	}
+
+	if (vddio >= 3100 && vdda >= 3100) {
+		/* VDDC use VDDIO rail */
+		lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
+		lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
+			    SGTL5000_VDDC_MAN_ASSN_SHIFT;
+	}
+
+	/* If PLL is powered up (such as on power cycle) leave it on. */
+	reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
+	ana_pwr |= reg & (SGTL5000_PLL_POWERUP | SGTL5000_VCOAMP_POWERUP);
+
+	/* set ADC/DAC ref voltage to vdda / 2 */
+	vag = vdda / 2;
+	if (vag <= SGTL5000_ANA_GND_BASE)
+		vag = 0;
+	else if (vag >= SGTL5000_ANA_GND_BASE + SGTL5000_ANA_GND_STP *
+		 (SGTL5000_ANA_GND_MASK >> SGTL5000_ANA_GND_SHIFT))
+		vag = SGTL5000_ANA_GND_MASK >> SGTL5000_ANA_GND_SHIFT;
+	else
+		vag = (vag - SGTL5000_ANA_GND_BASE) / SGTL5000_ANA_GND_STP;
+
+	/* set line out ref voltage to vddio / 2 */
+	vag = vddio / 2;
+	if (vag <= SGTL5000_LINE_OUT_GND_BASE)
+		vag = 0;
+	else if (vag >= SGTL5000_LINE_OUT_GND_BASE + SGTL5000_LINE_OUT_GND_STP *
+		 SGTL5000_LINE_OUT_GND_MAX)
+		vag = SGTL5000_LINE_OUT_GND_MAX;
+	else
+		vag = (vag - SGTL5000_LINE_OUT_GND_BASE) /
+		    SGTL5000_LINE_OUT_GND_STP;
+
+	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL, lreg_ctrl);
+	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, ana_pwr);
+	msleep(10);
+
+	/* For rev 0x11, if vddd linear reg has been enabled, we have
+	   to disable simple reg to get proper VDDD voltage.  */
+	if ((ana_pwr & SGTL5000_LINEREG_D_POWERUP) && (rev >= 0x11)) {
+		ana_pwr &= ~SGTL5000_LINREG_SIMPLE_POWERUP;
+		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, ana_pwr);
+		msleep(10);
+	}
+
+	/* enable small pop, introduce 200~400ms delay in turning on/off */
+	snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
+			vag << SGTL5000_ANA_GND_SHIFT | SGTL5000_SMALL_POP);
+
+	sgtl5000->small_pop = 1;
+
+	snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
+			vag << SGTL5000_LINE_OUT_GND_SHIFT |
+			SGTL5000_LINE_OUT_CURRENT_360u <<
+				SGTL5000_LINE_OUT_CURRENT_SHIFT);
+
+	/* enable short cut detect */
+	snd_soc_write(codec, SGTL5000_CHIP_SHORT_CTRL, 0);
+
+	/*
+	 * set sound switch
+	 * TODO: add sound switch to control and dapm widge.
+	 */
+	snd_soc_write(codec, SGTL5000_CHIP_SSS_CTRL,
+			SGTL5000_DAC_SEL_I2S_IN << SGTL5000_DAC_SEL_SHIFT);
+	snd_soc_write(codec, SGTL5000_CHIP_DIG_POWER, 0);
+
+	snd_soc_write(codec, SGTL5000_CHIP_ADCDAC_CTRL,
+			SGTL5000_DAC_VOL_RAMP_EN |
+			SGTL5000_DAC_MUTE_RIGHT |
+			SGTL5000_DAC_MUTE_LEFT);
+
+	snd_soc_write(codec, SGTL5000_CHIP_PAD_STRENGTH, 0x015f);
+
+	reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_ADC_CTRL);
+	reg &= ~SGTL5000_ADC_VOL_M6DB;
+	reg &= ~(SGTL5000_ADC_VOL_LEFT_MASK | SGTL5000_ADC_VOL_RIGHT_MASK);
+	reg |= (0xf << SGTL5000_ADC_VOL_LEFT_SHIFT)
+	    | (0xf << SGTL5000_ADC_VOL_RIGHT_SHIFT);
+	snd_soc_write(codec, SGTL5000_CHIP_ANA_ADC_CTRL, reg);
+
+	snd_soc_write(codec, SGTL5000_CHIP_ANA_CTRL,
+			SGTL5000_HP_ZCD_EN |
+			SGTL5000_ADC_ZCD_EN);
+
+	snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, 0);
+	snd_soc_write(codec, SGTL5000_CHIP_CLK_TOP_CTRL, 0);
+
+	/*
+	 * disable DAP
+	 * TODO:
+	 * Enable DAP in control and dapm.
+	 */
+	snd_soc_write(codec, SGTL5000_DAP_CTRL, 0);
+
+	/* leading to standby state */
+	ret = sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	if (ret)
+		goto err_out;
+
+	snd_soc_add_controls(codec, sgtl5000_snd_controls,
+			     ARRAY_SIZE(sgtl5000_snd_controls));
+
+	snd_soc_dapm_new_controls(codec, sgtl5000_dapm_widgets,
+				  ARRAY_SIZE(sgtl5000_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_new_widgets(codec);
+
+	return 0;
+
+err_out:
+	for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
+		if (!sgtl5000->supplies[i])
+			continue;
+
+		regulator_disable(sgtl5000->supplies[i]);
+		regulator_put(sgtl5000->supplies[i]);
+	}
+
+	return ret;
+}
+
+static int sgtl5000_remove(struct snd_soc_codec *codec)
+{
+	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
+	int i;
+
+	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	snd_soc_dapm_free(codec);
+
+	for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
+		if (!sgtl5000->supplies[i])
+			continue;
+
+		regulator_disable(sgtl5000->supplies[i]);
+		regulator_put(sgtl5000->supplies[i]);
+	}
+
+	return 0;
+}
+
+struct snd_soc_codec_driver sgtl5000_driver = {
+	.probe = sgtl5000_probe,
+	.remove = sgtl5000_remove,
+	.suspend = sgtl5000_suspend,
+	.resume = sgtl5000_resume,
+	.set_bias_level = sgtl5000_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(sgtl5000_regs),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_step = 2,
+	.reg_cache_default = sgtl5000_regs,
+	.volatile_register = sgtl5000_volatile_register,
+};
+
+static __devinit int sgtl5000_i2c_probe(struct i2c_client *client,
+					const struct i2c_device_id *id)
+{
+	struct sgtl5000_priv *sgtl5000;
+	int ret;
+
+	sgtl5000 = kzalloc(sizeof(struct sgtl5000_priv), GFP_KERNEL);
+	if (!sgtl5000)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, sgtl5000);
+
+	msleep(1);
+
+	ret = snd_soc_register_codec(&client->dev,
+			&sgtl5000_driver, &sgtl5000_dai, 1);
+	if (ret) {
+		dev_err(&client->dev, "Failed to register codec: %d\n", ret);
+		kfree(sgtl5000);
+		return ret;
+	}
+
+	return 0;
+}
+
+static __devexit int sgtl5000_i2c_remove(struct i2c_client *client)
+{
+	struct sgtl5000_priv *sgtl5000 = i2c_get_clientdata(client);
+
+	snd_soc_unregister_codec(&client->dev);
+
+	kfree(sgtl5000);
+	return 0;
+}
+
+static const struct i2c_device_id sgtl5000_id[] = {
+	{"sgtl5000-codec", 0},
+	{},
+};
+
+MODULE_DEVICE_TABLE(i2c, sgtl5000_id);
+
+static struct i2c_driver sgtl5000_i2c_driver = {
+	.driver = {
+		   .name = "sgtl5000-codec",
+		   .owner = THIS_MODULE,
+		   },
+	.probe = sgtl5000_i2c_probe,
+	.remove = __devexit_p(sgtl5000_i2c_remove),
+	.id_table = sgtl5000_id,
+};
+
+static int __init sgtl5000_modinit(void)
+{
+	return i2c_add_driver(&sgtl5000_i2c_driver);
+}
+module_init(sgtl5000_modinit);
+
+static void __exit sgtl5000_exit(void)
+{
+	i2c_del_driver(&sgtl5000_i2c_driver);
+}
+module_exit(sgtl5000_exit);
+
+MODULE_DESCRIPTION("ASoC sgtl5000 driver");
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
new file mode 100644
index 0000000..7f24655
--- /dev/null
+++ b/sound/soc/codecs/sgtl5000.h
@@ -0,0 +1,403 @@
+/*
+ * sgtl5000.h - SGTL5000 audio codec interface
+ *
+ * Copyright 2008-2009 Freescale Semiconductor, Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef _SGTL5000_H
+#define _SGTL5000_H
+
+#include <linux/i2c.h>
+
+/*
+ * Register values.
+ */
+#define SGTL5000_CHIP_ID			0x0000
+#define SGTL5000_CHIP_DIG_POWER			0x0002
+#define SGTL5000_CHIP_CLK_CTRL			0x0004
+#define SGTL5000_CHIP_I2S_CTRL			0x0006
+#define SGTL5000_CHIP_SSS_CTRL			0x000a
+#define SGTL5000_CHIP_ADCDAC_CTRL		0x000e
+#define SGTL5000_CHIP_DAC_VOL			0x0010
+#define SGTL5000_CHIP_PAD_STRENGTH		0x0014
+#define SGTL5000_CHIP_ANA_ADC_CTRL		0x0020
+#define SGTL5000_CHIP_ANA_HP_CTRL		0x0022
+#define SGTL5000_CHIP_ANA_CTRL			0x0024
+#define SGTL5000_CHIP_LINREG_CTRL		0x0026
+#define SGTL5000_CHIP_REF_CTRL			0x0028
+#define SGTL5000_CHIP_MIC_CTRL			0x002a
+#define SGTL5000_CHIP_LINE_OUT_CTRL		0x002c
+#define SGTL5000_CHIP_LINE_OUT_VOL		0x002e
+#define SGTL5000_CHIP_ANA_POWER			0x0030
+#define SGTL5000_CHIP_PLL_CTRL			0x0032
+#define SGTL5000_CHIP_CLK_TOP_CTRL		0x0034
+#define SGTL5000_CHIP_ANA_STATUS		0x0036
+#define SGTL5000_CHIP_SHORT_CTRL		0x003c
+#define SGTL5000_CHIP_ANA_TEST2			0x003a
+#define SGTL5000_DAP_CTRL			0x0100
+#define SGTL5000_DAP_PEQ			0x0102
+#define SGTL5000_DAP_BASS_ENHANCE		0x0104
+#define SGTL5000_DAP_BASS_ENHANCE_CTRL		0x0106
+#define SGTL5000_DAP_AUDIO_EQ			0x0108
+#define SGTL5000_DAP_SURROUND			0x010a
+#define SGTL5000_DAP_FLT_COEF_ACCESS		0x010c
+#define SGTL5000_DAP_COEF_WR_B0_MSB		0x010e
+#define SGTL5000_DAP_COEF_WR_B0_LSB		0x0110
+#define SGTL5000_DAP_EQ_BASS_BAND0		0x0116
+#define SGTL5000_DAP_EQ_BASS_BAND1		0x0118
+#define SGTL5000_DAP_EQ_BASS_BAND2		0x011a
+#define SGTL5000_DAP_EQ_BASS_BAND3		0x011c
+#define SGTL5000_DAP_EQ_BASS_BAND4		0x011e
+#define SGTL5000_DAP_MAIN_CHAN			0x0120
+#define SGTL5000_DAP_MIX_CHAN			0x0122
+#define SGTL5000_DAP_AVC_CTRL			0x0124
+#define SGTL5000_DAP_AVC_THRESHOLD		0x0126
+#define SGTL5000_DAP_AVC_ATTACK			0x0128
+#define SGTL5000_DAP_AVC_DECAY			0x012a
+#define SGTL5000_DAP_COEF_WR_B1_MSB		0x012c
+#define SGTL5000_DAP_COEF_WR_B1_LSB		0x012e
+#define SGTL5000_DAP_COEF_WR_B2_MSB		0x0130
+#define SGTL5000_DAP_COEF_WR_B2_LSB		0x0132
+#define SGTL5000_DAP_COEF_WR_A1_MSB		0x0134
+#define SGTL5000_DAP_COEF_WR_A1_LSB		0x0136
+#define SGTL5000_DAP_COEF_WR_A2_MSB		0x0138
+#define SGTL5000_DAP_COEF_WR_A2_LSB		0x013a
+
+/*
+ * Field Definitions.
+ */
+
+/*
+ * SGTL5000_CHIP_ID
+ */
+#define SGTL5000_PARTID_MASK			0xff00
+#define SGTL5000_PARTID_SHIFT			8
+#define SGTL5000_PARTID_WIDTH			8
+#define SGTL5000_PARTID_PART_ID		0xa0
+#define SGTL5000_REVID_MASK			0x00ff
+#define SGTL5000_REVID_SHIFT			0
+#define SGTL5000_REVID_WIDTH			8
+
+/*
+ * SGTL5000_CHIP_DIG_POWER
+ */
+#define SGTL5000_ADC_EN				0x0040
+#define SGTL5000_DAC_EN				0x0020
+#define SGTL5000_DAP_POWERUP			0x0010
+#define SGTL5000_I2S_OUT_POWERUP		0x0002
+#define SGTL5000_I2S_IN_POWERUP			0x0001
+
+/*
+ * SGTL5000_CHIP_CLK_CTRL
+ */
+#define SGTL5000_RATE_MODE_MASK			0x0030
+#define SGTL5000_RATE_MODE_SHIFT		4
+#define SGTL5000_RATE_MODE_WIDTH		2
+#define SGTL5000_RATE_MODE_DIV_1		0
+#define SGTL5000_RATE_MODE_DIV_2		1
+#define SGTL5000_RATE_MODE_DIV_4		2
+#define SGTL5000_RATE_MODE_DIV_6		3
+#define SGTL5000_SYS_FS_MASK			0x000c
+#define SGTL5000_SYS_FS_SHIFT			2
+#define SGTL5000_SYS_FS_WIDTH			2
+#define SGTL5000_SYS_FS_32k			0x0
+#define SGTL5000_SYS_FS_44_1k			0x1
+#define SGTL5000_SYS_FS_48k			0x2
+#define SGTL5000_SYS_FS_96k			0x3
+#define SGTL5000_MCLK_FREQ_MASK			0x0003
+#define SGTL5000_MCLK_FREQ_SHIFT		0
+#define SGTL5000_MCLK_FREQ_WIDTH		2
+#define SGTL5000_MCLK_FREQ_256FS		0x0
+#define SGTL5000_MCLK_FREQ_384FS		0x1
+#define SGTL5000_MCLK_FREQ_512FS		0x2
+#define SGTL5000_MCLK_FREQ_PLL			0x3
+
+/*
+ * SGTL5000_CHIP_I2S_CTRL
+ */
+#define SGTL5000_I2S_SCLKFREQ_MASK		0x0100
+#define SGTL5000_I2S_SCLKFREQ_SHIFT		8
+#define SGTL5000_I2S_SCLKFREQ_WIDTH		1
+#define SGTL5000_I2S_SCLKFREQ_64FS		0x0
+#define SGTL5000_I2S_SCLKFREQ_32FS		0x1	/* Not for RJ mode */
+#define SGTL5000_I2S_MASTER			0x0080
+#define SGTL5000_I2S_SCLK_INV			0x0040
+#define SGTL5000_I2S_DLEN_MASK			0x0030
+#define SGTL5000_I2S_DLEN_SHIFT			4
+#define SGTL5000_I2S_DLEN_WIDTH			2
+#define SGTL5000_I2S_DLEN_32			0x0
+#define SGTL5000_I2S_DLEN_24			0x1
+#define SGTL5000_I2S_DLEN_20			0x2
+#define SGTL5000_I2S_DLEN_16			0x3
+#define SGTL5000_I2S_MODE_MASK			0x000c
+#define SGTL5000_I2S_MODE_SHIFT			2
+#define SGTL5000_I2S_MODE_WIDTH			2
+#define SGTL5000_I2S_MODE_I2S_LJ		0x0
+#define SGTL5000_I2S_MODE_RJ			0x1
+#define SGTL5000_I2S_MODE_PCM			0x2
+#define SGTL5000_I2S_LRALIGN			0x0002
+#define SGTL5000_I2S_LRPOL			0x0001	/* set for which mode */
+
+/*
+ * SGTL5000_CHIP_SSS_CTRL
+ */
+#define SGTL5000_DAP_MIX_LRSWAP			0x4000
+#define SGTL5000_DAP_LRSWAP			0x2000
+#define SGTL5000_DAC_LRSWAP			0x1000
+#define SGTL5000_I2S_OUT_LRSWAP			0x0400
+#define SGTL5000_DAP_MIX_SEL_MASK		0x0300
+#define SGTL5000_DAP_MIX_SEL_SHIFT		8
+#define SGTL5000_DAP_MIX_SEL_WIDTH		2
+#define SGTL5000_DAP_MIX_SEL_ADC		0x0
+#define SGTL5000_DAP_MIX_SEL_I2S_IN		0x1
+#define SGTL5000_DAP_SEL_MASK			0x00c0
+#define SGTL5000_DAP_SEL_SHIFT			6
+#define SGTL5000_DAP_SEL_WIDTH			2
+#define SGTL5000_DAP_SEL_ADC			0x0
+#define SGTL5000_DAP_SEL_I2S_IN			0x1
+#define SGTL5000_DAC_SEL_MASK			0x0030
+#define SGTL5000_DAC_SEL_SHIFT			4
+#define SGTL5000_DAC_SEL_WIDTH			2
+#define SGTL5000_DAC_SEL_ADC			0x0
+#define SGTL5000_DAC_SEL_I2S_IN			0x1
+#define SGTL5000_DAC_SEL_DAP			0x3
+#define SGTL5000_I2S_OUT_SEL_MASK		0x0003
+#define SGTL5000_I2S_OUT_SEL_SHIFT		0
+#define SGTL5000_I2S_OUT_SEL_WIDTH		2
+#define SGTL5000_I2S_OUT_SEL_ADC		0x0
+#define SGTL5000_I2S_OUT_SEL_I2S_IN		0x1
+#define SGTL5000_I2S_OUT_SEL_DAP		0x3
+
+/*
+ * SGTL5000_CHIP_ADCDAC_CTRL
+ */
+#define SGTL5000_VOL_BUSY_DAC_RIGHT		0x2000
+#define SGTL5000_VOL_BUSY_DAC_LEFT		0x1000
+#define SGTL5000_DAC_VOL_RAMP_EN		0x0200
+#define SGTL5000_DAC_VOL_RAMP_EXPO		0x0100
+#define SGTL5000_DAC_MUTE_RIGHT			0x0008
+#define SGTL5000_DAC_MUTE_LEFT			0x0004
+#define SGTL5000_ADC_HPF_FREEZE			0x0002
+#define SGTL5000_ADC_HPF_BYPASS			0x0001
+
+/*
+ * SGTL5000_CHIP_DAC_VOL
+ */
+#define SGTL5000_DAC_VOL_RIGHT_MASK		0xff00
+#define SGTL5000_DAC_VOL_RIGHT_SHIFT		8
+#define SGTL5000_DAC_VOL_RIGHT_WIDTH		8
+#define SGTL5000_DAC_VOL_LEFT_MASK		0x00ff
+#define SGTL5000_DAC_VOL_LEFT_SHIFT		0
+#define SGTL5000_DAC_VOL_LEFT_WIDTH		8
+
+/*
+ * SGTL5000_CHIP_PAD_STRENGTH
+ */
+#define SGTL5000_PAD_I2S_LRCLK_MASK		0x0300
+#define SGTL5000_PAD_I2S_LRCLK_SHIFT		8
+#define SGTL5000_PAD_I2S_LRCLK_WIDTH		2
+#define SGTL5000_PAD_I2S_SCLK_MASK		0x00c0
+#define SGTL5000_PAD_I2S_SCLK_SHIFT		6
+#define SGTL5000_PAD_I2S_SCLK_WIDTH		2
+#define SGTL5000_PAD_I2S_DOUT_MASK		0x0030
+#define SGTL5000_PAD_I2S_DOUT_SHIFT		4
+#define SGTL5000_PAD_I2S_DOUT_WIDTH		2
+#define SGTL5000_PAD_I2C_SDA_MASK		0x000c
+#define SGTL5000_PAD_I2C_SDA_SHIFT		2
+#define SGTL5000_PAD_I2C_SDA_WIDTH		2
+#define SGTL5000_PAD_I2C_SCL_MASK		0x0003
+#define SGTL5000_PAD_I2C_SCL_SHIFT		0
+#define SGTL5000_PAD_I2C_SCL_WIDTH		2
+
+/*
+ * SGTL5000_CHIP_ANA_ADC_CTRL
+ */
+#define SGTL5000_ADC_VOL_M6DB			0x0100
+#define SGTL5000_ADC_VOL_RIGHT_MASK		0x00f0
+#define SGTL5000_ADC_VOL_RIGHT_SHIFT		4
+#define SGTL5000_ADC_VOL_RIGHT_WIDTH		4
+#define SGTL5000_ADC_VOL_LEFT_MASK		0x000f
+#define SGTL5000_ADC_VOL_LEFT_SHIFT		0
+#define SGTL5000_ADC_VOL_LEFT_WIDTH		4
+
+/*
+ * SGTL5000_CHIP_ANA_HP_CTRL
+ */
+#define SGTL5000_HP_VOL_RIGHT_MASK		0x7f00
+#define SGTL5000_HP_VOL_RIGHT_SHIFT		8
+#define SGTL5000_HP_VOL_RIGHT_WIDTH		7
+#define SGTL5000_HP_VOL_LEFT_MASK		0x007f
+#define SGTL5000_HP_VOL_LEFT_SHIFT		0
+#define SGTL5000_HP_VOL_LEFT_WIDTH		7
+
+/*
+ * SGTL5000_CHIP_ANA_CTRL
+ */
+#define SGTL5000_LINE_OUT_MUTE		0x0100
+#define SGTL5000_HP_SEL_MASK			0x0040
+#define SGTL5000_HP_SEL_SHIFT			6
+#define SGTL5000_HP_SEL_WIDTH			1
+#define SGTL5000_HP_SEL_DAC			0x0
+#define SGTL5000_HP_SEL_LINE_IN			0x1
+#define SGTL5000_HP_ZCD_EN			0x0020
+#define SGTL5000_HP_MUTE			0x0010
+#define SGTL5000_ADC_SEL_MASK			0x0004
+#define SGTL5000_ADC_SEL_SHIFT			2
+#define SGTL5000_ADC_SEL_WIDTH			1
+#define SGTL5000_ADC_SEL_MIC			0x0
+#define SGTL5000_ADC_SEL_LINE_IN		0x1
+#define SGTL5000_ADC_ZCD_EN			0x0002
+#define SGTL5000_ADC_MUTE			0x0001
+
+/*
+ * SGTL5000_CHIP_LINREG_CTRL
+ */
+#define SGTL5000_VDDC_MAN_ASSN_MASK		0x0040
+#define SGTL5000_VDDC_MAN_ASSN_SHIFT		6
+#define SGTL5000_VDDC_MAN_ASSN_WIDTH		1
+#define SGTL5000_VDDC_MAN_ASSN_VDDA		0x0
+#define SGTL5000_VDDC_MAN_ASSN_VDDIO		0x1
+#define SGTL5000_VDDC_ASSN_OVRD			0x0020
+#define SGTL5000_LINREG_VDDD_MASK		0x000f
+#define SGTL5000_LINREG_VDDD_SHIFT		0
+#define SGTL5000_LINREG_VDDD_WIDTH		4
+
+/*
+ * SGTL5000_CHIP_REF_CTRL
+ */
+#define SGTL5000_ANA_GND_MASK			0x01f0
+#define SGTL5000_ANA_GND_SHIFT			4
+#define SGTL5000_ANA_GND_WIDTH			5
+#define SGTL5000_ANA_GND_BASE			800	/* mv */
+#define SGTL5000_ANA_GND_STP			25	/*mv */
+#define SGTL5000_BIAS_CTRL_MASK			0x000e
+#define SGTL5000_BIAS_CTRL_SHIFT		1
+#define SGTL5000_BIAS_CTRL_WIDTH		3
+#define SGTL5000_SMALL_POP			0x0001
+
+/*
+ * SGTL5000_CHIP_MIC_CTRL
+ */
+#define SGTL5000_BIAS_R_MASK			0x0200
+#define SGTL5000_BIAS_R_SHIFT			8
+#define SGTL5000_BIAS_R_WIDTH			2
+#define SGTL5000_BIAS_R_off			0x0
+#define SGTL5000_BIAS_R_2K			0x1
+#define SGTL5000_BIAS_R_4k			0x2
+#define SGTL5000_BIAS_R_8k			0x3
+#define SGTL5000_BIAS_VOLT_MASK			0x0070
+#define SGTL5000_BIAS_VOLT_SHIFT		4
+#define SGTL5000_BIAS_VOLT_WIDTH		3
+#define SGTL5000_MIC_GAIN_MASK			0x0003
+#define SGTL5000_MIC_GAIN_SHIFT			0
+#define SGTL5000_MIC_GAIN_WIDTH			2
+
+/*
+ * SGTL5000_CHIP_LINE_OUT_CTRL
+ */
+#define SGTL5000_LINE_OUT_CURRENT_MASK		0x0f00
+#define SGTL5000_LINE_OUT_CURRENT_SHIFT		8
+#define SGTL5000_LINE_OUT_CURRENT_WIDTH		4
+#define SGTL5000_LINE_OUT_CURRENT_180u		0x0
+#define SGTL5000_LINE_OUT_CURRENT_270u		0x1
+#define SGTL5000_LINE_OUT_CURRENT_360u		0x3
+#define SGTL5000_LINE_OUT_CURRENT_450u		0x7
+#define SGTL5000_LINE_OUT_CURRENT_540u		0xf
+#define SGTL5000_LINE_OUT_GND_MASK		0x003f
+#define SGTL5000_LINE_OUT_GND_SHIFT		0
+#define SGTL5000_LINE_OUT_GND_WIDTH		6
+#define SGTL5000_LINE_OUT_GND_BASE		800	/* mv */
+#define SGTL5000_LINE_OUT_GND_STP		25
+#define SGTL5000_LINE_OUT_GND_MAX		0x23
+
+/*
+ * SGTL5000_CHIP_LINE_OUT_VOL
+ */
+#define SGTL5000_LINE_OUT_VOL_RIGHT_MASK	0x1f00
+#define SGTL5000_LINE_OUT_VOL_RIGHT_SHIFT	8
+#define SGTL5000_LINE_OUT_VOL_RIGHT_WIDTH	5
+#define SGTL5000_LINE_OUT_VOL_LEFT_MASK		0x001f
+#define SGTL5000_LINE_OUT_VOL_LEFT_SHIFT	0
+#define SGTL5000_LINE_OUT_VOL_LEFT_WIDTH	5
+
+/*
+ * SGTL5000_CHIP_ANA_POWER
+ */
+#define SGTL5000_DAC_STEREO			0x4000
+#define SGTL5000_LINREG_SIMPLE_POWERUP		0x2000
+#define SGTL5000_STARTUP_POWERUP		0x1000
+#define SGTL5000_VDDC_CHRGPMP_POWERUP		0x0800
+#define SGTL5000_PLL_POWERUP			0x0400
+#define SGTL5000_LINEREG_D_POWERUP		0x0200
+#define SGTL5000_VCOAMP_POWERUP			0x0100
+#define SGTL5000_VAG_POWERUP			0x0080
+#define SGTL5000_ADC_STEREO			0x0040
+#define SGTL5000_REFTOP_POWERUP			0x0020
+#define SGTL5000_HP_POWERUP			0x0010
+#define SGTL5000_DAC_POWERUP			0x0008
+#define SGTL5000_CAPLESS_HP_POWERUP		0x0004
+#define SGTL5000_ADC_POWERUP			0x0002
+#define SGTL5000_LINE_OUT_POWERUP		0x0001
+
+/*
+ * SGTL5000_CHIP_PLL_CTRL
+ */
+#define SGTL5000_PLL_INT_DIV_MASK		0xf800
+#define SGTL5000_PLL_INT_DIV_SHIFT		11
+#define SGTL5000_PLL_INT_DIV_WIDTH		5
+#define SGTL5000_PLL_FRAC_DIV_MASK		0x0700
+#define SGTL5000_PLL_FRAC_DIV_SHIFT		0
+#define SGTL5000_PLL_FRAC_DIV_WIDTH		11
+
+/*
+ * SGTL5000_CHIP_CLK_TOP_CTRL
+ */
+#define SGTL5000_INT_OSC_EN			0x0800
+#define SGTL5000_INPUT_FREQ_DIV2		0x0008
+
+/*
+ * SGTL5000_CHIP_ANA_STATUS
+ */
+#define SGTL5000_HP_LRSHORT			0x0200
+#define SGTL5000_CAPLESS_SHORT			0x0100
+#define SGTL5000_PLL_LOCKED			0x0010
+
+/*
+ * SGTL5000_CHIP_SHORT_CTRL
+ */
+#define SGTL5000_LVLADJR_MASK			0x7000
+#define SGTL5000_LVLADJR_SHIFT			12
+#define SGTL5000_LVLADJR_WIDTH			3
+#define SGTL5000_LVLADJL_MASK			0x0700
+#define SGTL5000_LVLADJL_SHIFT			8
+#define SGTL5000_LVLADJL_WIDTH			3
+#define SGTL5000_LVLADJC_MASK			0x0070
+#define SGTL5000_LVLADJC_SHIFT			4
+#define SGTL5000_LVLADJC_WIDTH			3
+#define SGTL5000_LR_SHORT_MOD_MASK		0x000c
+#define SGTL5000_LR_SHORT_MOD_SHIFT		2
+#define SGTL5000_LR_SHORT_MOD_WIDTH		2
+#define SGTL5000_CM_SHORT_MOD_MASK		0x0003
+#define SGTL5000_CM_SHORT_MOD_SHIFT		0
+#define SGTL5000_CM_SHORT_MOD_WIDTH		2
+
+/*
+ *SGTL5000_CHIP_ANA_TEST2
+ */
+#define SGTL5000_MONO_DAC			0x1000
+
+/*
+ * SGTL5000_DAP_CTRL
+ */
+#define SGTL5000_DAP_MIX_EN			0x0010
+#define SGTL5000_DAP_EN				0x0001
+
+#define SGTL5000_SYSCLK		0x00
+#define SGTL5000_LRCLK		0x01
+
+#endif
-- 
1.7.0.4


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--hQiwHBbRI9kgIhsi--
