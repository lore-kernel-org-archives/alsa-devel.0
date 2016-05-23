From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH v3 2/2] ASoC: wm8985: add support for WM8758
Date: Mon, 23 May 2016 16:11:25 +0200
Message-ID: <1464012685-1142-3-git-send-email-petr@barix.com>
References: <1464012685-1142-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id D7A112664CB
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 16:11:35 +0200 (CEST)
Received: by mail-wm0-f54.google.com with SMTP id z87so50147309wmh.0
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 07:11:35 -0700 (PDT)
In-Reply-To: <1464012685-1142-1-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
Cc: Petr Kulhavy <petr@barix.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, plamen@barix.com
List-Id: alsa-devel@alsa-project.org

The WM8758 chip is almost identical to WM8985 with the difference that it
doesn't feature the AUX input. This patch adds the WM8758 support into the
WM8985 driver.

The chip selection is done by the I2C name. The SPI probe supports only
the WM8985.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
v1: initial
v2: use chip type enum instead of chip structure
    do not copy the complete controls, widget, routes but only the differences and 
    add widgets dynamically using add_widgets()
v3: merge the wm8985_xxx_snd_controls into wm8985_common_snd_controls and wm8985_specific_snd_controls
    in order to reduce the number of structures
    use the static initialization in snd_soc_codec_driver for the common part

 sound/soc/codecs/Kconfig  |   2 +-
 sound/soc/codecs/wm8985.c | 160 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 123 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 649e92a252ae..5947e0c94d02 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -933,7 +933,7 @@ config SND_SOC_WM8983
 	tristate
 
 config SND_SOC_WM8985
-	tristate
+	tristate "Wolfson Microelectronics WM8985 and WM8758 codec driver"
 
 config SND_SOC_WM8988
 	tristate
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 42696e709580..232f4b2418d7 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -1,10 +1,13 @@
 /*
- * wm8985.c  --  WM8985 ALSA SoC Audio driver
+ * wm8985.c  --  WM8985 / WM8758 ALSA SoC Audio driver
  *
  * Copyright 2010 Wolfson Microelectronics plc
- *
  * Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
  *
+ * WM8758 support:
+ * Copyright: 2016 Barix AG
+ * Author: Petr Kulhavy <petr@barix.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -40,6 +43,11 @@ static const char *wm8985_supply_names[WM8985_NUM_SUPPLIES] = {
 	"AVDD2"
 };
 
+enum wm8985_type {
+	WM8985,
+	WM8758,
+};
+
 static const struct reg_default wm8985_reg_defaults[] = {
 	{ 1,  0x0000 },     /* R1  - Power management 1 */
 	{ 2,  0x0000 },     /* R2  - Power management 2 */
@@ -181,6 +189,7 @@ static const int volume_update_regs[] = {
 struct wm8985_priv {
 	struct regmap *regmap;
 	struct regulator_bulk_data supplies[WM8985_NUM_SUPPLIES];
+	enum wm8985_type dev_type;
 	unsigned int pllout;	/* input rate to the MCLKDIV divider */
 };
 
@@ -283,7 +292,7 @@ static const char *depth_3d_text[] = {
 static const SOC_ENUM_SINGLE_DECL(depth_3d, WM8985_3D_CONTROL, 0,
 				  depth_3d_text);
 
-static const struct snd_kcontrol_new wm8985_snd_controls[] = {
+static const struct snd_kcontrol_new wm8985_common_snd_controls[] = {
 	SOC_SINGLE("Digital Loopback Switch", WM8985_COMPANDING_CONTROL,
 		0, 1, 0),
 
@@ -317,6 +326,10 @@ static const struct snd_kcontrol_new wm8985_snd_controls[] = {
 	SOC_DOUBLE("ADC Inversion Switch", WM8985_ADC_CONTROL, 0, 1, 1, 0),
 	SOC_SINGLE("ADC 128x Oversampling Switch", WM8985_ADC_CONTROL, 8, 1, 0),
 
+	SOC_SINGLE("High Pass Filter Switch", WM8985_ADC_CONTROL, 8, 1, 0),
+	SOC_ENUM("High Pass Filter Mode", filter_mode),
+	SOC_SINGLE("High Pass Filter Cutoff", WM8985_ADC_CONTROL, 4, 7, 0),
+
 	SOC_DOUBLE_R_TLV("Playback Volume", WM8985_LEFT_DAC_DIGITAL_VOL,
 		WM8985_RIGHT_DAC_DIGITAL_VOL, 0, 255, 0, dac_tlv),
 
@@ -344,15 +357,6 @@ static const struct snd_kcontrol_new wm8985_snd_controls[] = {
 		WM8985_ROUT2_SPK_VOLUME_CTRL, 7, 1, 0),
 	SOC_DOUBLE_R("Speaker Switch", WM8985_LOUT2_SPK_VOLUME_CTRL,
 		WM8985_ROUT2_SPK_VOLUME_CTRL, 6, 1, 1),
-
-	SOC_SINGLE("High Pass Filter Switch", WM8985_ADC_CONTROL, 8, 1, 0),
-	SOC_ENUM("High Pass Filter Mode", filter_mode),
-	SOC_SINGLE("High Pass Filter Cutoff", WM8985_ADC_CONTROL, 4, 7, 0),
-
-	SOC_DOUBLE_R_TLV("Aux Bypass Volume",
-		WM8985_LEFT_MIXER_CTRL, WM8985_RIGHT_MIXER_CTRL, 6, 7, 0,
-		aux_tlv),
-
 	SOC_DOUBLE_R_TLV("Input PGA Bypass Volume",
 		WM8985_LEFT_MIXER_CTRL, WM8985_RIGHT_MIXER_CTRL, 2, 7, 0,
 		bypass_tlv),
@@ -373,6 +377,12 @@ static const struct snd_kcontrol_new wm8985_snd_controls[] = {
 	SOC_SINGLE_TLV("EQ5 Volume", WM8985_EQ5_HIGH_SHELF, 0, 24, 1, eq_tlv),
 
 	SOC_ENUM("3D Depth", depth_3d),
+};
+
+static const struct snd_kcontrol_new wm8985_specific_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("Aux Bypass Volume",
+		WM8985_LEFT_MIXER_CTRL, WM8985_RIGHT_MIXER_CTRL, 6, 7, 0,
+		aux_tlv),
 
 	SOC_ENUM("Speaker Mode", speaker_mode)
 };
@@ -389,6 +399,16 @@ static const struct snd_kcontrol_new right_out_mixer[] = {
 	SOC_DAPM_SINGLE("PCM Switch", WM8985_RIGHT_MIXER_CTRL, 0, 1, 0),
 };
 
+static const struct snd_kcontrol_new wm8758_left_out_mixer[] = {
+	SOC_DAPM_SINGLE("Line Switch", WM8985_LEFT_MIXER_CTRL, 1, 1, 0),
+	SOC_DAPM_SINGLE("PCM Switch", WM8985_LEFT_MIXER_CTRL, 0, 1, 0),
+};
+
+static const struct snd_kcontrol_new wm8758_right_out_mixer[] = {
+	SOC_DAPM_SINGLE("Line Switch", WM8985_RIGHT_MIXER_CTRL, 1, 1, 0),
+	SOC_DAPM_SINGLE("PCM Switch", WM8985_RIGHT_MIXER_CTRL, 0, 1, 0),
+};
+
 static const struct snd_kcontrol_new left_input_mixer[] = {
 	SOC_DAPM_SINGLE("L2 Switch", WM8985_INPUT_CTRL, 2, 1, 0),
 	SOC_DAPM_SINGLE("MicN Switch", WM8985_INPUT_CTRL, 1, 1, 0),
@@ -401,6 +421,16 @@ static const struct snd_kcontrol_new right_input_mixer[] = {
 	SOC_DAPM_SINGLE("MicP Switch", WM8985_INPUT_CTRL, 4, 1, 0),
 };
 
+static const struct snd_kcontrol_new wm8758_left_boost_mixer[] = {
+	SOC_DAPM_SINGLE_TLV("L2 Volume", WM8985_LEFT_ADC_BOOST_CTRL,
+		4, 7, 0, boost_tlv),
+};
+
+static const struct snd_kcontrol_new wm8758_right_boost_mixer[] = {
+	SOC_DAPM_SINGLE_TLV("R2 Volume", WM8985_RIGHT_ADC_BOOST_CTRL,
+		4, 7, 0, boost_tlv),
+};
+
 static const struct snd_kcontrol_new left_boost_mixer[] = {
 	SOC_DAPM_SINGLE_TLV("L2 Volume", WM8985_LEFT_ADC_BOOST_CTRL,
 		4, 7, 0, boost_tlv),
@@ -415,7 +445,7 @@ static const struct snd_kcontrol_new right_boost_mixer[] = {
 		0, 7, 0, boost_tlv)
 };
 
-static const struct snd_soc_dapm_widget wm8985_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget wm8985_common_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", WM8985_POWER_MANAGEMENT_3,
 		0, 0),
 	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", WM8985_POWER_MANAGEMENT_3,
@@ -425,21 +455,11 @@ static const struct snd_soc_dapm_widget wm8985_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", WM8985_POWER_MANAGEMENT_2,
 		1, 0),
 
-	SND_SOC_DAPM_MIXER("Left Output Mixer", WM8985_POWER_MANAGEMENT_3,
-		2, 0, left_out_mixer, ARRAY_SIZE(left_out_mixer)),
-	SND_SOC_DAPM_MIXER("Right Output Mixer", WM8985_POWER_MANAGEMENT_3,
-		3, 0, right_out_mixer, ARRAY_SIZE(right_out_mixer)),
-
 	SND_SOC_DAPM_MIXER("Left Input Mixer", WM8985_POWER_MANAGEMENT_2,
 		2, 0, left_input_mixer, ARRAY_SIZE(left_input_mixer)),
 	SND_SOC_DAPM_MIXER("Right Input Mixer", WM8985_POWER_MANAGEMENT_2,
 		3, 0, right_input_mixer, ARRAY_SIZE(right_input_mixer)),
 
-	SND_SOC_DAPM_MIXER("Left Boost Mixer", WM8985_POWER_MANAGEMENT_2,
-		4, 0, left_boost_mixer, ARRAY_SIZE(left_boost_mixer)),
-	SND_SOC_DAPM_MIXER("Right Boost Mixer", WM8985_POWER_MANAGEMENT_2,
-		5, 0, right_boost_mixer, ARRAY_SIZE(right_boost_mixer)),
-
 	SND_SOC_DAPM_PGA("Left Capture PGA", WM8985_LEFT_INP_PGA_GAIN_CTRL,
 		6, 1, NULL, 0),
 	SND_SOC_DAPM_PGA("Right Capture PGA", WM8985_RIGHT_INP_PGA_GAIN_CTRL,
@@ -462,8 +482,6 @@ static const struct snd_soc_dapm_widget wm8985_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("LIP"),
 	SND_SOC_DAPM_INPUT("RIN"),
 	SND_SOC_DAPM_INPUT("RIP"),
-	SND_SOC_DAPM_INPUT("AUXL"),
-	SND_SOC_DAPM_INPUT("AUXR"),
 	SND_SOC_DAPM_INPUT("L2"),
 	SND_SOC_DAPM_INPUT("R2"),
 	SND_SOC_DAPM_OUTPUT("HPL"),
@@ -472,13 +490,42 @@ static const struct snd_soc_dapm_widget wm8985_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("SPKR")
 };
 
-static const struct snd_soc_dapm_route wm8985_dapm_routes[] = {
+static const struct snd_soc_dapm_widget wm8985_dapm_widgets[] = {
+	SND_SOC_DAPM_MIXER("Left Output Mixer", WM8985_POWER_MANAGEMENT_3,
+		2, 0, left_out_mixer, ARRAY_SIZE(left_out_mixer)),
+	SND_SOC_DAPM_MIXER("Right Output Mixer", WM8985_POWER_MANAGEMENT_3,
+		3, 0, right_out_mixer, ARRAY_SIZE(right_out_mixer)),
+
+	SND_SOC_DAPM_MIXER("Left Boost Mixer", WM8985_POWER_MANAGEMENT_2,
+		4, 0, left_boost_mixer, ARRAY_SIZE(left_boost_mixer)),
+	SND_SOC_DAPM_MIXER("Right Boost Mixer", WM8985_POWER_MANAGEMENT_2,
+		5, 0, right_boost_mixer, ARRAY_SIZE(right_boost_mixer)),
+
+	SND_SOC_DAPM_INPUT("AUXL"),
+	SND_SOC_DAPM_INPUT("AUXR"),
+};
+
+static const struct snd_soc_dapm_widget wm8758_dapm_widgets[] = {
+	SND_SOC_DAPM_MIXER("Left Output Mixer", WM8985_POWER_MANAGEMENT_3,
+		2, 0, wm8758_left_out_mixer,
+		ARRAY_SIZE(wm8758_left_out_mixer)),
+	SND_SOC_DAPM_MIXER("Right Output Mixer", WM8985_POWER_MANAGEMENT_3,
+		3, 0, wm8758_right_out_mixer,
+		ARRAY_SIZE(wm8758_right_out_mixer)),
+
+	SND_SOC_DAPM_MIXER("Left Boost Mixer", WM8985_POWER_MANAGEMENT_2,
+		4, 0, wm8758_left_boost_mixer,
+		ARRAY_SIZE(wm8758_left_boost_mixer)),
+	SND_SOC_DAPM_MIXER("Right Boost Mixer", WM8985_POWER_MANAGEMENT_2,
+		5, 0, wm8758_right_boost_mixer,
+		ARRAY_SIZE(wm8758_right_boost_mixer)),
+};
+
+static const struct snd_soc_dapm_route wm8985_common_dapm_routes[] = {
 	{ "Right Output Mixer", "PCM Switch", "Right DAC" },
-	{ "Right Output Mixer", "Aux Switch", "AUXR" },
 	{ "Right Output Mixer", "Line Switch", "Right Boost Mixer" },
 
 	{ "Left Output Mixer", "PCM Switch", "Left DAC" },
-	{ "Left Output Mixer", "Aux Switch", "AUXL" },
 	{ "Left Output Mixer", "Line Switch", "Left Boost Mixer" },
 
 	{ "Right Headphone Out", NULL, "Right Output Mixer" },
@@ -495,13 +542,11 @@ static const struct snd_soc_dapm_route wm8985_dapm_routes[] = {
 
 	{ "Right ADC", NULL, "Right Boost Mixer" },
 
-	{ "Right Boost Mixer", "AUXR Volume", "AUXR" },
 	{ "Right Boost Mixer", NULL, "Right Capture PGA" },
 	{ "Right Boost Mixer", "R2 Volume", "R2" },
 
 	{ "Left ADC", NULL, "Left Boost Mixer" },
 
-	{ "Left Boost Mixer", "AUXL Volume", "AUXL" },
 	{ "Left Boost Mixer", NULL, "Left Capture PGA" },
 	{ "Left Boost Mixer", "L2 Volume", "L2" },
 
@@ -516,6 +561,38 @@ static const struct snd_soc_dapm_route wm8985_dapm_routes[] = {
 	{ "Left Input Mixer", "MicN Switch", "LIN" },
 	{ "Left Input Mixer", "MicP Switch", "LIP" },
 };
+static const struct snd_soc_dapm_route wm8985_aux_dapm_routes[] = {
+	{ "Right Output Mixer", "Aux Switch", "AUXR" },
+	{ "Left Output Mixer", "Aux Switch", "AUXL" },
+
+	{ "Right Boost Mixer", "AUXR Volume", "AUXR" },
+	{ "Left Boost Mixer", "AUXL Volume", "AUXL" },
+};
+
+static int wm8985_add_widgets(struct snd_soc_codec *codec)
+{
+	struct wm8985_priv *wm8985 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+
+	switch (wm8985->dev_type) {
+	case WM8758:
+		snd_soc_dapm_new_controls(dapm, wm8758_dapm_widgets,
+					  ARRAY_SIZE(wm8758_dapm_widgets));
+		break;
+
+	case WM8985:
+		snd_soc_add_codec_controls(codec, wm8985_specific_snd_controls,
+			ARRAY_SIZE(wm8985_specific_snd_controls));
+
+		snd_soc_dapm_new_controls(dapm, wm8985_dapm_widgets,
+			ARRAY_SIZE(wm8985_dapm_widgets));
+		snd_soc_dapm_add_routes(dapm, wm8985_aux_dapm_routes,
+			ARRAY_SIZE(wm8985_aux_dapm_routes));
+		break;
+	}
+
+	return 0;
+}
 
 static int eqmode_get(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
@@ -1005,6 +1082,8 @@ static int wm8985_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8985_BIAS_CTRL, WM8985_BIASCUT,
 			    WM8985_BIASCUT);
 
+	wm8985_add_widgets(codec);
+
 	return 0;
 
 err_reg_enable:
@@ -1048,12 +1127,12 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8985 = {
 	.set_bias_level = wm8985_set_bias_level,
 	.suspend_bias_off = true,
 
-	.controls = wm8985_snd_controls,
-	.num_controls = ARRAY_SIZE(wm8985_snd_controls),
-	.dapm_widgets = wm8985_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(wm8985_dapm_widgets),
-	.dapm_routes = wm8985_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(wm8985_dapm_routes),
+	.controls = wm8985_common_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8985_common_snd_controls),
+	.dapm_widgets = wm8985_common_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8985_common_dapm_widgets),
+	.dapm_routes = wm8985_common_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8985_common_dapm_routes),
 };
 
 static const struct regmap_config wm8985_regmap = {
@@ -1080,6 +1159,8 @@ static int wm8985_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, wm8985);
 
+	wm8985->dev_type = WM8985;
+
 	wm8985->regmap = devm_regmap_init_spi(spi, &wm8985_regmap);
 	if (IS_ERR(wm8985->regmap)) {
 		ret = PTR_ERR(wm8985->regmap);
@@ -1121,6 +1202,8 @@ static int wm8985_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8985);
 
+	wm8985->dev_type = id->driver_data;
+
 	wm8985->regmap = devm_regmap_init_i2c(i2c, &wm8985_regmap);
 	if (IS_ERR(wm8985->regmap)) {
 		ret = PTR_ERR(wm8985->regmap);
@@ -1141,7 +1224,8 @@ static int wm8985_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id wm8985_i2c_id[] = {
-	{ "wm8985", 0 },
+	{ "wm8985", WM8985 },
+	{ "wm8758", WM8758 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wm8985_i2c_id);
@@ -1189,6 +1273,6 @@ static void __exit wm8985_exit(void)
 }
 module_exit(wm8985_exit);
 
-MODULE_DESCRIPTION("ASoC WM8985 driver");
+MODULE_DESCRIPTION("ASoC WM8985 / WM8758 driver");
 MODULE_AUTHOR("Dimitris Papastamos <dp@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
-- 
1.9.1
