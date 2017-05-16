From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH v2 1/2] ASoC: add es8316 codec driver
Date: Tue, 16 May 2017 14:20:34 -0600
Message-ID: <20170516202035.27590-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id EA7E2267530
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 22:20:44 +0200 (CEST)
Received: by mail-ua0-f173.google.com with SMTP id j17so107051974uag.3
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 13:20:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux@endlessm.com, pierre-louis.bossart@linux.intel.com, yangxiaohua@everest-semi.com
List-Id: alsa-devel@alsa-project.org

Add a codec driver for the Everest ES8316, based on code provided by
David Yang from Everest Semi.

I limited the functionality to items where the vendor code was clear,
and things that can be tested on the Weibu F3C (Intel Cherry Trail).
As a result the initial implementation only supports running in slave
mode at single speed (up to 48kHz sample rate) using I2S. HPD is not
supported.

Signed-off-by: David Yang <yangxiaohua@everest-semi.com>
[drake@endlessm.com: significant cleanups and simplifications,
                     remove dead/unclear code]
Signed-off-by: Daniel Drake <drake@endlessm.com>
---

Notes:
    v2:
     - Add sign-off from David Yang
     - Only support whole number rates calculated with mclk ratios

 sound/soc/codecs/Kconfig  |   4 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/es8316.c | 646 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/es8316.h | 122 +++++++++
 4 files changed, 774 insertions(+)
 create mode 100644 sound/soc/codecs/es8316.c
 create mode 100644 sound/soc/codecs/es8316.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 883ed4c8a551..c6286e5ba511 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -72,6 +72,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA9055 if I2C
 	select SND_SOC_DIO2125
 	select SND_SOC_DMIC
+	select SND_SOC_ES8316 if I2C
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
 	select SND_SOC_ES7134
@@ -543,6 +544,9 @@ config SND_SOC_HDMI_CODEC
 config SND_SOC_ES7134
        tristate "Everest Semi ES7134 CODEC"
 
+config SND_SOC_ES8316
+	tristate "Everest Semi ES8316 CODEC"
+
 config SND_SOC_ES8328
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 28a63fdaf982..e878306ce46e 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -65,6 +65,7 @@ snd-soc-da732x-objs := da732x.o
 snd-soc-da9055-objs := da9055.o
 snd-soc-dmic-objs := dmic.o
 snd-soc-es7134-objs := es7134.o
+snd-soc-es8316-objs := es8316.o
 snd-soc-es8328-objs := es8328.o
 snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
@@ -300,6 +301,7 @@ obj-$(CONFIG_SND_SOC_DA732X)	+= snd-soc-da732x.o
 obj-$(CONFIG_SND_SOC_DA9055)	+= snd-soc-da9055.o
 obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_ES7134)	+= snd-soc-es7134.o
+obj-$(CONFIG_SND_SOC_ES8316)    += snd-soc-es8316.o
 obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
new file mode 100644
index 000000000000..35fe32070285
--- /dev/null
+++ b/sound/soc/codecs/es8316.c
@@ -0,0 +1,646 @@
+/*
+ * es8316.c -- es8316 ALSA SoC audio driver
+ * Copyright Everest Semiconductor Co.,Ltd
+ *
+ * Authors: David Yang <yangxiaohua@everest-semi.com>,
+ *          Daniel Drake <drake@endlessm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+#include "es8316.h"
+
+/* In slave mode at single speed, the codec is documented as accepting 5
+ * MCLK/LRCK ratios, but we also add ratio 400, which is commonly used on
+ * Intel Cherry Trail platforms (19.2MHz MCLK, 48kHz LRCK).
+ */
+#define NR_SUPPORTED_MCLK_LRCK_RATIOS 6
+static const unsigned int supported_mclk_lrck_ratios[] = {
+	256, 384, 400, 512, 768, 1024
+};
+
+struct es8316_priv {
+	unsigned int sysclk;
+	unsigned int allowed_rates[NR_SUPPORTED_MCLK_LRCK_RATIOS];
+	struct snd_pcm_hw_constraint_list sysclk_constraints;
+};
+
+/*
+ * ES8316 controls
+ */
+static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -9600, 50, 1);
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -9600, 50, 1);
+static const DECLARE_TLV_DB_SCALE(hpmixer_gain_tlv, -1200, 150, 0);
+static const DECLARE_TLV_DB_SCALE(mic_bst_tlv, 0, 1200, 0);
+
+static unsigned int linin_pga_tlv[] = {
+	TLV_DB_RANGE_HEAD(12),
+	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+	1, 1, TLV_DB_SCALE_ITEM(300, 0, 0),
+	2, 2, TLV_DB_SCALE_ITEM(600, 0, 0),
+	3, 3, TLV_DB_SCALE_ITEM(900, 0, 0),
+	4, 4, TLV_DB_SCALE_ITEM(1200, 0, 0),
+	5, 5, TLV_DB_SCALE_ITEM(1500, 0, 0),
+	6, 6, TLV_DB_SCALE_ITEM(1800, 0, 0),
+	7, 7, TLV_DB_SCALE_ITEM(2100, 0, 0),
+	8, 8, TLV_DB_SCALE_ITEM(2400, 0, 0),
+};
+static unsigned int hpout_vol_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0, 3, TLV_DB_SCALE_ITEM(-4800, 1200, 0),
+};
+static const char * const alc_func_txt[] = { "Off", "On" };
+static const struct soc_enum alc_func =
+	SOC_ENUM_SINGLE(ES8316_ADC_ALC1, 6, 2, alc_func_txt);
+
+static const char * const ng_type_txt[] =
+	{ "Constant PGA Gain", "Mute ADC Output"};
+static const struct soc_enum ng_type =
+	SOC_ENUM_SINGLE(ES8316_ADC_ALC6, 6, 2, ng_type_txt);
+
+static const char * const adcpol_txt[] = { "Normal", "Invert" };
+static const struct soc_enum adcpol =
+	SOC_ENUM_SINGLE(ES8316_ADC_MUTE, 1, 2, adcpol_txt);
+static const char *const dacpol_txt[] =
+	{ "Normal", "R Invert", "L Invert", "L + R Invert" };
+static const struct soc_enum dacpol =
+	SOC_ENUM_SINGLE(ES8316_DAC_SET1, 0, 4, dacpol_txt);
+
+static const struct snd_kcontrol_new es8316_snd_controls[] = {
+	SOC_DOUBLE_TLV("HP Playback Volume", ES8316_CPHP_ICAL_VOL,
+		       4, 0, 0, 1, hpout_vol_tlv),
+	SOC_DOUBLE_TLV("HPMixer Gain", ES8316_HPMIX_VOL,
+		       0, 4, 7, 0, hpmixer_gain_tlv),
+
+	SOC_DOUBLE_R_TLV("DAC Playback Volume", ES8316_DAC_VOLL,
+			 ES8316_DAC_VOLR, 0, 0xC0, 1, dac_vol_tlv),
+
+	SOC_SINGLE("Enable DAC Soft Ramp", ES8316_DAC_SET1, 4, 1, 1),
+	SOC_SINGLE("DAC Soft Ramp Rate", ES8316_DAC_SET1, 2, 4, 0),
+
+	SOC_ENUM("Playback Polarity", dacpol),
+	SOC_SINGLE("DAC Notch Filter", ES8316_DAC_SET2, 6, 1, 0),
+	SOC_SINGLE("DAC Double Fs Mode", ES8316_DAC_SET2, 7, 1, 0),
+	SOC_SINGLE("DAC Volume Control-LeR", ES8316_DAC_SET2, 2, 1, 0),
+	SOC_SINGLE("DAC Stereo Enhancement", ES8316_DAC_SET3, 0, 7, 0),
+
+	/* +20dB D2SE PGA Control */
+	SOC_SINGLE_TLV("MIC Boost", ES8316_ADC_D2SEPGA,
+		       0, 1, 0, mic_bst_tlv),
+
+	/* 0-+24dB Lineinput PGA Control */
+	SOC_SINGLE_TLV("Input PGA", ES8316_ADC_PGAGAIN,
+		       4, 8, 0, linin_pga_tlv),
+
+	SOC_SINGLE_TLV("ADC Capture Volume", ES8316_ADC_VOLUME,
+		       0, 0xc0, 1, adc_vol_tlv),
+	SOC_SINGLE("ADC Soft Ramp", ES8316_ADC_MUTE, 4, 1, 0),
+	SOC_ENUM("Capture Polarity", adcpol),
+	SOC_SINGLE("ADC Double FS Mode", ES8316_ADC_DMIC, 4, 1, 0),
+
+	SOC_SINGLE("ALC Capture Target Volume",
+		   ES8316_ADC_ALC3, 4, 10, 0),
+	SOC_SINGLE("ALC Capture Max PGA", ES8316_ADC_ALC1, 0, 28, 0),
+	SOC_SINGLE("ALC Capture Min PGA", ES8316_ADC_ALC2, 0, 28, 0),
+	SOC_ENUM("ALC Capture Function", alc_func),
+	SOC_SINGLE("ALC Capture Hold Time", ES8316_ADC_ALC3, 0, 10, 0),
+	SOC_SINGLE("ALC Capture Decay Time", ES8316_ADC_ALC4, 4, 10, 0),
+	SOC_SINGLE("ALC Capture Attack Time", ES8316_ADC_ALC4, 0, 10, 0),
+	SOC_SINGLE("ALC Capture NG Threshold", ES8316_ADC_ALC6, 0, 31, 0),
+	SOC_ENUM("ALC Capture NG Type", ng_type),
+	SOC_SINGLE("ALC Capture NG Switch", ES8316_ADC_ALC6, 5, 1, 0),
+};
+
+/* Analog Input Mux */
+static const char * const es8316_analog_in_txt[] = {
+		"lin1-rin1",
+		"lin2-rin2",
+		"lin1-rin1 with 20db Boost",
+		"lin2-rin2 with 20db Boost"
+};
+static const unsigned int es8316_analog_in_values[] = { 0, 1, 2, 3 };
+static const struct soc_enum es8316_analog_input_enum =
+	SOC_VALUE_ENUM_SINGLE(ES8316_ADC_PDN_LINSEL, 4, 3,
+			      ARRAY_SIZE(es8316_analog_in_txt),
+			      es8316_analog_in_txt,
+			      es8316_analog_in_values);
+static const struct snd_kcontrol_new es8316_analog_in_mux_controls =
+	SOC_DAPM_ENUM("Route", es8316_analog_input_enum);
+
+static const char * const es8316_dmic_txt[] = {
+		"dmic disable",
+		"dmic data at high level",
+		"dmic data at low level",
+};
+static const unsigned int es8316_dmic_values[] = { 0, 1, 2 };
+static const struct soc_enum es8316_dmic_src_enum =
+	SOC_VALUE_ENUM_SINGLE(ES8316_ADC_DMIC, 0, 3,
+			      ARRAY_SIZE(es8316_dmic_txt),
+			      es8316_dmic_txt,
+			      es8316_dmic_values);
+static const struct snd_kcontrol_new es8316_dmic_src_controls =
+	SOC_DAPM_ENUM("Route", es8316_dmic_src_enum);
+
+/* hp mixer mux */
+static const char * const es8316_hpmux_texts[] = {
+	"lin1-rin1",
+	"lin2-rin2",
+	"lin-rin with Boost",
+	"lin-rin with Boost and PGA"
+};
+
+static const unsigned int es8316_hpmux_values[] = { 0, 1, 2, 3 };
+
+static SOC_ENUM_SINGLE_DECL(es8316_left_hpmux_enum, ES8316_HPMIX_SEL,
+	4, es8316_hpmux_texts);
+
+static const struct snd_kcontrol_new es8316_left_hpmux_controls =
+	SOC_DAPM_ENUM("Route", es8316_left_hpmux_enum);
+
+static SOC_ENUM_SINGLE_DECL(es8316_right_hpmux_enum, ES8316_HPMIX_SEL,
+	0, es8316_hpmux_texts);
+
+static const struct snd_kcontrol_new es8316_right_hpmux_controls =
+	SOC_DAPM_ENUM("Route", es8316_right_hpmux_enum);
+
+/* headphone Output Mixer */
+static const struct snd_kcontrol_new es8316_out_left_mix[] = {
+	SOC_DAPM_SINGLE("LLIN Switch", ES8316_HPMIX_SWITCH, 6, 1, 0),
+	SOC_DAPM_SINGLE("Left DAC Switch", ES8316_HPMIX_SWITCH, 7, 1, 0),
+};
+static const struct snd_kcontrol_new es8316_out_right_mix[] = {
+	SOC_DAPM_SINGLE("RLIN Switch", ES8316_HPMIX_SWITCH, 2, 1, 0),
+	SOC_DAPM_SINGLE("Right DAC Switch", ES8316_HPMIX_SWITCH, 3, 1, 0),
+};
+
+/* DAC data source mux */
+static const char * const es8316_dacsrc_texts[] = {
+	"LDATA TO LDAC, RDATA TO RDAC",
+	"LDATA TO LDAC, LDATA TO RDAC",
+	"RDATA TO LDAC, RDATA TO RDAC",
+	"RDATA TO LDAC, LDATA TO RDAC",
+};
+
+static const unsigned int es8316_dacsrc_values[] = { 0, 1, 2, 3 };
+
+static SOC_ENUM_SINGLE_DECL(es8316_dacsrc_mux_enum, ES8316_DAC_SET1,
+	6, es8316_dacsrc_texts);
+
+static const struct snd_kcontrol_new es8316_dacsrc_mux_controls =
+	SOC_DAPM_ENUM("Route", es8316_dacsrc_mux_enum);
+
+static const struct snd_soc_dapm_widget es8316_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("DMIC"),
+	SND_SOC_DAPM_INPUT("MIC1"),
+	SND_SOC_DAPM_INPUT("MIC2"),
+	SND_SOC_DAPM_MICBIAS("micbias", SND_SOC_NOPM, 0, 0),
+
+	/* Input Mux */
+	SND_SOC_DAPM_MUX("Differential Mux", SND_SOC_NOPM, 0, 0,
+			 &es8316_analog_in_mux_controls),
+
+	SND_SOC_DAPM_PGA("Line input PGA", ES8316_ADC_PDN_LINSEL,
+			 7, 1, NULL, 0),
+	SND_SOC_DAPM_ADC("Mono ADC", NULL, ES8316_ADC_PDN_LINSEL, 6, 1),
+	SND_SOC_DAPM_MUX("Digital Mic Mux", SND_SOC_NOPM, 0, 0,
+			 &es8316_dmic_src_controls),
+
+	/* Digital Interface */
+	SND_SOC_DAPM_AIF_OUT("I2S OUT", "I2S1 Capture",  1,
+			     ES8316_SERDATA_ADC, 6, 1),
+	SND_SOC_DAPM_AIF_IN("I2S IN", "I2S1 Playback", 0,
+			    SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_MUX("DAC SRC Mux", SND_SOC_NOPM, 0, 0,
+			 &es8316_dacsrc_mux_controls),
+
+	SND_SOC_DAPM_DAC("Right DAC", NULL, SND_SOC_NOPM, 0, 1),
+	SND_SOC_DAPM_DAC("Left DAC", NULL, SND_SOC_NOPM, 4, 1),
+
+	/* Headphone Output Side */
+	SND_SOC_DAPM_MUX("Left Hp mux", SND_SOC_NOPM, 0, 0,
+			 &es8316_left_hpmux_controls),
+	SND_SOC_DAPM_MUX("Right Hp mux", SND_SOC_NOPM, 0, 0,
+			 &es8316_right_hpmux_controls),
+	SND_SOC_DAPM_MIXER("Left Hp mixer", SND_SOC_NOPM,
+			   4, 1, &es8316_out_left_mix[0],
+			   ARRAY_SIZE(es8316_out_left_mix)),
+	SND_SOC_DAPM_MIXER("Right Hp mixer", SND_SOC_NOPM,
+			   0, 1, &es8316_out_right_mix[0],
+			   ARRAY_SIZE(es8316_out_right_mix)),
+
+	/* Output charge pump */
+	SND_SOC_DAPM_PGA("HPCP L", SND_SOC_NOPM, 6, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("HPCP R", SND_SOC_NOPM, 2, 0, NULL, 0),
+
+	/* Output Driver */
+	SND_SOC_DAPM_PGA("HPVOL L", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("HPVOL R", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("HPOL"),
+	SND_SOC_DAPM_OUTPUT("HPOR"),
+};
+
+static const struct snd_soc_dapm_route es8316_dapm_routes[] = {
+	/* Recording */
+	{"MIC1", NULL, "micbias"},
+	{"MIC2", NULL, "micbias"},
+
+	{"Differential Mux", "lin1-rin1", "MIC1"},
+	{"Differential Mux", "lin2-rin2", "MIC2"},
+	{"Line input PGA", NULL, "Differential Mux"},
+
+	{"Mono ADC", NULL, "Line input PGA"},
+
+	{"Digital Mic Mux", "dmic disable", "Mono ADC"},
+
+	{"I2S OUT", NULL, "Digital Mic Mux"},
+
+	/* Playback */
+	{"DAC SRC Mux", "LDATA TO LDAC, RDATA TO RDAC", "I2S IN"},
+
+	{"Left DAC", NULL, "DAC SRC Mux"},
+	{"Right DAC", NULL, "DAC SRC Mux"},
+
+	{"Left Hp mux", "lin-rin with Boost and PGA", "Line input PGA"},
+	{"Right Hp mux", "lin-rin with Boost and PGA", "Line input PGA"},
+
+	{"Left Hp mixer", "LLIN Switch", "Left Hp mux"},
+	{"Left Hp mixer", "Left DAC Switch", "Left DAC"},
+
+	{"Right Hp mixer", "RLIN Switch", "Right Hp mux"},
+	{"Right Hp mixer", "Right DAC Switch", "Right DAC"},
+
+	{"HPCP L", NULL, "Left Hp mixer"},
+	{"HPCP R", NULL, "Right Hp mixer"},
+
+	{"HPVOL L", NULL, "HPCP L"},
+	{"HPVOL R", NULL, "HPCP R"},
+
+	{"HPOL", NULL, "HPVOL L"},
+	{"HPOR", NULL, "HPVOL R"},
+};
+
+static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct es8316_priv *es8316 = snd_soc_codec_get_drvdata(codec);
+	int i;
+	int count = 0;
+
+	es8316->sysclk = freq;
+
+	if (freq == 0)
+		return 0;
+
+	/* Limit supported sample rates to ones that can be autodetected
+	 * by the codec running in slave mode.
+	 */
+	for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
+		const unsigned int ratio = supported_mclk_lrck_ratios[i];
+
+		if (freq % ratio == 0)
+			es8316->allowed_rates[count++] = freq / ratio;
+	}
+
+	es8316->sysclk_constraints.list = es8316->allowed_rates;
+	es8316->sysclk_constraints.count = count;
+
+	return 0;
+}
+
+static int es8316_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			      unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u8 serdata1 = 0;
+	u8 serdata2 = 0;
+	u8 mask;
+
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS) {
+		dev_err(codec->dev, "Codec driver only supports slave mode\n");
+		return -EINVAL;
+	}
+
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_I2S) {
+		dev_err(codec->dev, "Codec driver only supports I2S format\n");
+		return -EINVAL;
+	}
+
+	/* Clock inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		serdata1 |= ES8316_SERDATA1_BCLK_INV;
+		serdata2 |= ES8316_SERDATA2_ADCLRP;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		serdata1 |= ES8316_SERDATA1_BCLK_INV;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		serdata2 |= ES8316_SERDATA2_ADCLRP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mask = ES8316_SERDATA1_MASTER | ES8316_SERDATA1_BCLK_INV;
+	snd_soc_update_bits(codec, ES8316_SERDATA1, mask, serdata1);
+
+	mask = ES8316_SERDATA2_FMT_MASK | ES8316_SERDATA2_ADCLRP;
+	snd_soc_update_bits(codec, ES8316_SERDATA_ADC, mask, serdata2);
+	snd_soc_update_bits(codec, ES8316_SERDATA_DAC, mask, serdata2);
+
+	return 0;
+}
+
+static int es8316_pcm_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct es8316_priv *es8316 = snd_soc_codec_get_drvdata(codec);
+
+	if (es8316->sysclk == 0) {
+		dev_err(codec->dev, "No sysclk provided\n");
+		return -EINVAL;
+	}
+
+	/* The set of sample rates that can be supported depends on the
+	 * MCLK supplied to the CODEC.
+	 */
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   &es8316->sysclk_constraints);
+
+	return 0;
+}
+
+static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct es8316_priv *es8316 = snd_soc_codec_get_drvdata(codec);
+	u8 wordlen = 0;
+
+	if (!es8316->sysclk) {
+		dev_err(codec->dev, "No MCLK configured\n");
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		wordlen = ES8316_SERDATA2_LEN_16;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		wordlen = ES8316_SERDATA2_LEN_20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		wordlen = ES8316_SERDATA2_LEN_24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		wordlen = ES8316_SERDATA2_LEN_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, ES8316_SERDATA_DAC,
+			    ES8316_SERDATA2_LEN_MASK, wordlen);
+	snd_soc_update_bits(codec, ES8316_SERDATA_ADC,
+			    ES8316_SERDATA2_LEN_MASK, wordlen);
+	return 0;
+}
+
+static int es8316_mute(struct snd_soc_dai *dai, int mute)
+{
+	snd_soc_update_bits(dai->codec, ES8316_DAC_SET1, 0x20,
+			    mute ? 0x20 : 0);
+	return 0;
+}
+
+static int es8316_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		snd_soc_write(codec, ES8316_RESET, 0xC0);
+		snd_soc_write(codec, ES8316_CPHP_OUTEN, 0x66);
+		snd_soc_write(codec, ES8316_DAC_PDN, 0x00);
+		snd_soc_write(codec, ES8316_CPHP_LDOCTL, 0x30);
+		snd_soc_write(codec, ES8316_CPHP_PDN2, 0x10);
+		snd_soc_write(codec, ES8316_CPHP_PDN1, 0x03);
+		snd_soc_write(codec, ES8316_HPMIX_PDN, 0x00);
+		snd_soc_update_bits(codec, ES8316_ADC_PDN_LINSEL, 0xc0, 0x00);
+		snd_soc_write(codec, ES8316_SYS_PDN, 0x00);
+		snd_soc_write(codec, ES8316_SYS_LP1, 0x04);
+		snd_soc_write(codec, ES8316_SYS_LP2, 0x0c);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		break;
+	case SND_SOC_BIAS_OFF:
+		snd_soc_write(codec, ES8316_CPHP_OUTEN, 0x00);
+		snd_soc_write(codec, ES8316_DAC_PDN, 0x11);
+		snd_soc_write(codec, ES8316_CPHP_LDOCTL, 0x03);
+		snd_soc_write(codec, ES8316_CPHP_PDN2, 0x22);
+		snd_soc_write(codec, ES8316_CPHP_PDN1, 0x06);
+		snd_soc_write(codec, ES8316_HPMIX_PDN, 0x33);
+		snd_soc_update_bits(codec, ES8316_ADC_PDN_LINSEL, 0xc0, 0xc0);
+		snd_soc_write(codec, ES8316_SYS_PDN, 0x3f);
+		snd_soc_write(codec, ES8316_SYS_LP1, 0x3f);
+		snd_soc_write(codec, ES8316_SYS_LP2, 0x1f);
+		snd_soc_write(codec, ES8316_RESET, 0x00);
+		break;
+	}
+
+	return 0;
+}
+
+#define ES8316_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE)
+
+static struct snd_soc_dai_ops es8316_ops = {
+	.startup = es8316_pcm_startup,
+	.hw_params = es8316_pcm_hw_params,
+	.set_fmt = es8316_set_dai_fmt,
+	.set_sysclk = es8316_set_dai_sysclk,
+	.digital_mute = es8316_mute,
+};
+
+static struct snd_soc_dai_driver es8316_dai = {
+	.name = "ES8316 HiFi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = ES8316_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = ES8316_FORMATS,
+	},
+	.ops = &es8316_ops,
+	.symmetric_rates = 1,
+};
+
+static int es8316_probe(struct snd_soc_codec *codec)
+{
+	snd_soc_write(codec, ES8316_RESET, 0x3f);
+	usleep_range(5000, 5500);
+	snd_soc_write(codec, ES8316_RESET, 0x00);
+	snd_soc_write(codec, ES8316_SYS_VMIDSEL, 0xFF);
+	msleep(30);
+
+	snd_soc_write(codec, ES8316_CLKMGR_CLKSEL, 0x08);
+	snd_soc_write(codec, ES8316_CLKMGR_ADCOSR, 0x32);
+	snd_soc_write(codec, ES8316_CLKMGR_ADCDIV1, 0x11);
+	snd_soc_write(codec, ES8316_CLKMGR_ADCDIV2, 0x00);
+	snd_soc_write(codec, ES8316_CLKMGR_DACDIV1, 0x11);
+	snd_soc_write(codec, ES8316_CLKMGR_DACDIV2, 0x00);
+	snd_soc_write(codec, ES8316_CLKMGR_CPDIV, 0x00);
+	snd_soc_write(codec, ES8316_SERDATA1, 0x04);
+	snd_soc_write(codec, ES8316_CLKMGR_CLKSW, 0x7f);
+	snd_soc_write(codec, ES8316_CAL_TYPE, 0x0F);
+	snd_soc_write(codec, ES8316_CAL_HPLIV, 0x90);
+	snd_soc_write(codec, ES8316_CAL_HPRIV, 0x90);
+	snd_soc_write(codec, ES8316_ADC_VOLUME, 0x00);
+	snd_soc_write(codec, ES8316_ADC_D2SEPGA, 0x00);
+	snd_soc_write(codec, ES8316_ADC_DMIC, 0x08);
+	snd_soc_write(codec, ES8316_DAC_SET2, 0x00);
+	snd_soc_write(codec, ES8316_DAC_SET3, 0x00);
+	snd_soc_write(codec, ES8316_DAC_VOLL, 0x02);
+	snd_soc_write(codec, ES8316_DAC_VOLR, 0x02);
+	snd_soc_write(codec, ES8316_SERDATA_ADC, 0x00);
+	snd_soc_write(codec, ES8316_SERDATA_DAC, 0x00);
+	snd_soc_write(codec, ES8316_SYS_VMIDLOW, 0x11);
+	snd_soc_write(codec, ES8316_SYS_VSEL, 0xfc);
+	snd_soc_write(codec, ES8316_SYS_REF, 0x28);
+	snd_soc_write(codec, ES8316_HPMIX_SEL, 0x00);
+	snd_soc_write(codec, ES8316_HPMIX_SWITCH, 0x88);
+	snd_soc_write(codec, ES8316_HPMIX_VOL, 0x88);
+	snd_soc_write(codec, ES8316_CPHP_ICAL_VOL, 0x00);
+	snd_soc_write(codec, ES8316_GPIO_SEL, 0x00);
+	snd_soc_write(codec, ES8316_GPIO_DEBUNCE_INT, 0x02);
+	snd_soc_write(codec, ES8316_TESTMODE, 0xa0);
+	snd_soc_write(codec, ES8316_TEST1, 0x00);
+	snd_soc_write(codec, ES8316_TEST2, 0x04);
+	snd_soc_write(codec, ES8316_RESET, 0xc0);
+	msleep(50);
+	snd_soc_write(codec, ES8316_ADC_PGAGAIN, 0x60);
+	snd_soc_write(codec, ES8316_ADC_D2SEPGA, 0x01);
+
+	/* ADC DS mode, HPF enable */
+	snd_soc_write(codec, ES8316_ADC_DMIC, 0x08);
+	snd_soc_write(codec, ES8316_ADC_ALC1, 0xcd);
+	snd_soc_write(codec, ES8316_ADC_ALC2, 0x08);
+	snd_soc_write(codec, ES8316_ADC_ALC3, 0xa0);
+	snd_soc_write(codec, ES8316_ADC_ALC4, 0x05);
+	snd_soc_write(codec, ES8316_ADC_ALC5, 0x06);
+	snd_soc_write(codec, ES8316_ADC_ALC6, 0x61);
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_es8316 = {
+	.probe		= es8316_probe,
+	.set_bias_level	= es8316_set_bias_level,
+	.idle_bias_off	= true,
+
+	.component_driver = {
+		.controls		= es8316_snd_controls,
+		.num_controls		= ARRAY_SIZE(es8316_snd_controls),
+		.dapm_widgets		= es8316_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(es8316_dapm_widgets),
+		.dapm_routes		= es8316_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(es8316_dapm_routes),
+	},
+};
+
+static const struct regmap_config es8316_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x53,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int es8316_i2c_probe(struct i2c_client *i2c_client,
+			    const struct i2c_device_id *id)
+{
+	struct es8316_priv *es8316;
+	struct regmap *regmap;
+
+	es8316 = devm_kzalloc(&i2c_client->dev, sizeof(struct es8316_priv),
+			      GFP_KERNEL);
+	if (es8316 == NULL)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c_client, es8316);
+
+	regmap = devm_regmap_init_i2c(i2c_client, &es8316_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return snd_soc_register_codec(&i2c_client->dev, &soc_codec_dev_es8316,
+				      &es8316_dai, 1);
+}
+
+static int es8316_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct i2c_device_id es8316_i2c_id[] = {
+	{"ESSX8316", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, es8316_i2c_id);
+
+static const struct of_device_id es8316_of_match[] = {
+	{ .compatible = "everest,es8316", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, es8316_of_match);
+
+static const struct acpi_device_id es8316_acpi_match[] = {
+	{"ESSX8316", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, es8316_acpi_match);
+
+static struct i2c_driver es8316_i2c_driver = {
+	.driver = {
+		.name			= "es8316",
+		.acpi_match_table	= ACPI_PTR(es8316_acpi_match),
+		.of_match_table		= of_match_ptr(es8316_of_match),
+	},
+	.probe		= es8316_i2c_probe,
+	.remove		= es8316_i2c_remove,
+	.id_table	= es8316_i2c_id,
+};
+module_i2c_driver(es8316_i2c_driver);
+
+MODULE_DESCRIPTION("Everest Semi ES8316 ALSA SoC Codec Driver");
+MODULE_AUTHOR("David Yang <yangxiaohua@everest-semi.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/es8316.h b/sound/soc/codecs/es8316.h
new file mode 100644
index 000000000000..702bebc69ca8
--- /dev/null
+++ b/sound/soc/codecs/es8316.h
@@ -0,0 +1,122 @@
+/*
+ * Copyright Everest Semiconductor Co.,Ltd
+ *
+ * Author: David Yang <yangxiaohua@everest-semi.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef _ES8316_H
+#define _ES8316_H
+
+/*
+ * ES8316 register space
+ */
+
+/* Reset Control */
+#define ES8316_RESET		0x00
+
+/* Clock Management */
+#define ES8316_CLKMGR_CLKSW	0x01
+#define ES8316_CLKMGR_CLKSEL	0x02
+#define ES8316_CLKMGR_ADCOSR	0x03
+#define ES8316_CLKMGR_ADCDIV1	0x04
+#define ES8316_CLKMGR_ADCDIV2	0x05
+#define ES8316_CLKMGR_DACDIV1	0x06
+#define ES8316_CLKMGR_DACDIV2	0x07
+#define ES8316_CLKMGR_CPDIV	0x08
+
+/* Serial Data Port Control */
+#define ES8316_SERDATA1		0x09
+#define ES8316_SERDATA_ADC	0x0a
+#define ES8316_SERDATA_DAC	0x0b
+
+/* System Control */
+#define ES8316_SYS_VMIDSEL	0x0c
+#define ES8316_SYS_PDN		0x0d
+#define ES8316_SYS_LP1		0x0e
+#define ES8316_SYS_LP2		0x0f
+#define ES8316_SYS_VMIDLOW	0x10
+#define ES8316_SYS_VSEL		0x11
+#define ES8316_SYS_REF		0x12
+
+/* Headphone Mixer */
+#define ES8316_HPMIX_SEL	0x13
+#define ES8316_HPMIX_SWITCH	0x14
+#define ES8316_HPMIX_PDN	0x15
+#define ES8316_HPMIX_VOL	0x16
+
+/* Charge Pump Headphone driver */
+#define ES8316_CPHP_OUTEN	0x17
+#define ES8316_CPHP_ICAL_VOL	0x18
+#define ES8316_CPHP_PDN1	0x19
+#define ES8316_CPHP_PDN2	0x1a
+#define ES8316_CPHP_LDOCTL	0x1b
+
+/* Calibration */
+#define ES8316_CAL_TYPE		0x1c
+#define ES8316_CAL_SET		0x1d
+#define ES8316_CAL_HPLIV	0x1e
+#define ES8316_CAL_HPRIV	0x1f
+#define ES8316_CAL_HPLMV	0x20
+#define ES8316_CAL_HPRMV	0x21
+
+/* ADC Control */
+#define ES8316_ADC_PDN_LINSEL	0x22
+#define ES8316_ADC_PGAGAIN	0x23
+#define ES8316_ADC_D2SEPGA	0x24
+#define ES8316_ADC_DMIC		0x25
+#define ES8316_ADC_MUTE		0x26
+#define ES8316_ADC_VOLUME	0x27
+#define ES8316_ADC_ALC1		0x29
+#define ES8316_ADC_ALC2		0x2a
+#define ES8316_ADC_ALC3		0x2b
+#define ES8316_ADC_ALC4		0x2c
+#define ES8316_ADC_ALC5		0x2d
+#define ES8316_ADC_ALC6		0x2e
+
+/* DAC Control */
+#define ES8316_DAC_PDN		0x2f
+#define ES8316_DAC_SET1		0x30
+#define ES8316_DAC_SET2		0x31
+#define ES8316_DAC_SET3		0x32
+#define ES8316_DAC_VOLL		0x33
+#define ES8316_DAC_VOLR		0x34
+
+/* GPIO */
+#define ES8316_GPIO_SEL		0x4d
+#define ES8316_GPIO_DEBUNCE_INT 0x4e
+#define ES8316_GPIO_FLAG	0x4f
+
+/* Test mode */
+#define ES8316_TESTMODE		0x50
+#define ES8316_TEST1		0x51
+#define ES8316_TEST2		0x52
+#define ES8316_TEST3		0x53
+
+/*
+ * Field definitions
+ */
+
+/* ES8316_SERDATA1 */
+#define ES8316_SERDATA1_MASTER		0x80
+#define ES8316_SERDATA1_BCLK_INV	0x20
+
+/* ES8316_SERDATA_ADC and _DAC */
+#define ES8316_SERDATA2_FMT_MASK	0x3
+#define ES8316_SERDATA2_FMT_I2S		0x00
+#define ES8316_SERDATA2_FMT_LEFTJ	0x01
+#define ES8316_SERDATA2_FMT_RIGHTJ	0x02
+#define ES8316_SERDATA2_FMT_PCM		0x03
+#define ES8316_SERDATA2_ADCLRP		0x20
+#define ES8316_SERDATA2_LEN_MASK	0x1c
+#define ES8316_SERDATA2_LEN_24		0x00
+#define ES8316_SERDATA2_LEN_20		0x04
+#define ES8316_SERDATA2_LEN_18		0x08
+#define ES8316_SERDATA2_LEN_16		0x0c
+#define ES8316_SERDATA2_LEN_32		0x10
+
+#endif
-- 
2.11.0
