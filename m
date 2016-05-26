From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH v5] ASoC: wm8985: add support for WM8758
Date: Thu, 26 May 2016 22:19:16 +0200
Message-ID: <1464293956-4950-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 19E24266525
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2016 22:19:27 +0200 (CEST)
Received: by mail-wm0-f42.google.com with SMTP id z87so112833098wmh.0
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2016 13:19:27 -0700 (PDT)
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

From: Petr Kulhavy <petr@barix.com>

The WM8758 chip is almost identical to WM8985 with the difference that it
doesn't feature the AUX input. This patch adds the WM8758 support into the
WM8985 driver.

The chip selection is done by the I2C name. The SPI probe supports only
the WM8985.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
v1: initial
v2: use chip type enum instead of chip structure
    do not copy the complete controls, widget, routes but only the differences and 
    add widgets dynamically using add_widgets()
v3: merge the wm8985_xxx_snd_controls into wm8985_common_snd_controls and wm8985_specific_snd_controls
    in order to reduce the number of structures
    use the static initialization in snd_soc_codec_driver for the common part
v4: avoid duplicating left/right_out_mixer and left/right_boost_mixer by moving the aux controls 
    at the end and providing shorter size for wm8758
    do not move the high pass filter controls
v5: reapplied to git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git branch topics/wm8985

 sound/soc/codecs/Kconfig  |   2 +-
 sound/soc/codecs/wm8985.c | 143 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 109 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b3afae9..5c635f7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -944,7 +944,7 @@ config SND_SOC_WM8983
 	tristate
 
 config SND_SOC_WM8985
-	tristate
+	tristate "Wolfson Microelectronics WM8985 and WM8758 codec driver"
 
 config SND_SOC_WM8988
 	tristate
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 6ac76fe..7347abf 100644
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
 	unsigned int sysclk;
 	unsigned int bclk;
 };
@@ -289,7 +298,7 @@ static const char *depth_3d_text[] = {
 };
 static SOC_ENUM_SINGLE_DECL(depth_3d, WM8985_3D_CONTROL, 0, depth_3d_text);
 
-static const struct snd_kcontrol_new wm8985_snd_controls[] = {
+static const struct snd_kcontrol_new wm8985_common_snd_controls[] = {
 	SOC_SINGLE("Digital Loopback Switch", WM8985_COMPANDING_CONTROL,
 		0, 1, 0),
 
@@ -355,10 +364,6 @@ static const struct snd_kcontrol_new wm8985_snd_controls[] = {
 	SOC_ENUM("High Pass Filter Mode", filter_mode),
 	SOC_SINGLE("High Pass Filter Cutoff", WM8985_ADC_CONTROL, 4, 7, 0),
 
-	SOC_DOUBLE_R_TLV("Aux Bypass Volume",
-		WM8985_LEFT_MIXER_CTRL, WM8985_RIGHT_MIXER_CTRL, 6, 7, 0,
-		aux_tlv),
-
 	SOC_DOUBLE_R_TLV("Input PGA Bypass Volume",
 		WM8985_LEFT_MIXER_CTRL, WM8985_RIGHT_MIXER_CTRL, 2, 7, 0,
 		bypass_tlv),
@@ -379,20 +384,30 @@ static const struct snd_kcontrol_new wm8985_snd_controls[] = {
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
 
 static const struct snd_kcontrol_new left_out_mixer[] = {
 	SOC_DAPM_SINGLE("Line Switch", WM8985_LEFT_MIXER_CTRL, 1, 1, 0),
-	SOC_DAPM_SINGLE("Aux Switch", WM8985_LEFT_MIXER_CTRL, 5, 1, 0),
 	SOC_DAPM_SINGLE("PCM Switch", WM8985_LEFT_MIXER_CTRL, 0, 1, 0),
+
+	/* --- WM8985 only --- */
+	SOC_DAPM_SINGLE("Aux Switch", WM8985_LEFT_MIXER_CTRL, 5, 1, 0),
 };
 
 static const struct snd_kcontrol_new right_out_mixer[] = {
 	SOC_DAPM_SINGLE("Line Switch", WM8985_RIGHT_MIXER_CTRL, 1, 1, 0),
-	SOC_DAPM_SINGLE("Aux Switch", WM8985_RIGHT_MIXER_CTRL, 5, 1, 0),
 	SOC_DAPM_SINGLE("PCM Switch", WM8985_RIGHT_MIXER_CTRL, 0, 1, 0),
+
+	/* --- WM8985 only --- */
+	SOC_DAPM_SINGLE("Aux Switch", WM8985_RIGHT_MIXER_CTRL, 5, 1, 0),
 };
 
 static const struct snd_kcontrol_new left_input_mixer[] = {
@@ -410,6 +425,8 @@ static const struct snd_kcontrol_new right_input_mixer[] = {
 static const struct snd_kcontrol_new left_boost_mixer[] = {
 	SOC_DAPM_SINGLE_TLV("L2 Volume", WM8985_LEFT_ADC_BOOST_CTRL,
 		4, 7, 0, boost_tlv),
+
+	/* --- WM8985 only --- */
 	SOC_DAPM_SINGLE_TLV("AUXL Volume", WM8985_LEFT_ADC_BOOST_CTRL,
 		0, 7, 0, boost_tlv)
 };
@@ -417,11 +434,13 @@ static const struct snd_kcontrol_new left_boost_mixer[] = {
 static const struct snd_kcontrol_new right_boost_mixer[] = {
 	SOC_DAPM_SINGLE_TLV("R2 Volume", WM8985_RIGHT_ADC_BOOST_CTRL,
 		4, 7, 0, boost_tlv),
+
+	/* --- WM8985 only --- */
 	SOC_DAPM_SINGLE_TLV("AUXR Volume", WM8985_RIGHT_ADC_BOOST_CTRL,
 		0, 7, 0, boost_tlv)
 };
 
-static const struct snd_soc_dapm_widget wm8985_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget wm8985_common_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", WM8985_POWER_MANAGEMENT_3,
 		0, 0),
 	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", WM8985_POWER_MANAGEMENT_3,
@@ -431,21 +450,11 @@ static const struct snd_soc_dapm_widget wm8985_dapm_widgets[] = {
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
@@ -468,8 +477,6 @@ static const struct snd_soc_dapm_widget wm8985_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("LIP"),
 	SND_SOC_DAPM_INPUT("RIN"),
 	SND_SOC_DAPM_INPUT("RIP"),
-	SND_SOC_DAPM_INPUT("AUXL"),
-	SND_SOC_DAPM_INPUT("AUXR"),
 	SND_SOC_DAPM_INPUT("L2"),
 	SND_SOC_DAPM_INPUT("R2"),
 	SND_SOC_DAPM_OUTPUT("HPL"),
@@ -478,13 +485,42 @@ static const struct snd_soc_dapm_widget wm8985_dapm_widgets[] = {
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
+		2, 0, left_out_mixer,
+		ARRAY_SIZE(left_out_mixer) - 1),
+	SND_SOC_DAPM_MIXER("Right Output Mixer", WM8985_POWER_MANAGEMENT_3,
+		3, 0, right_out_mixer,
+		ARRAY_SIZE(right_out_mixer) - 1),
+
+	SND_SOC_DAPM_MIXER("Left Boost Mixer", WM8985_POWER_MANAGEMENT_2,
+		4, 0, left_boost_mixer,
+		ARRAY_SIZE(left_boost_mixer) - 1),
+	SND_SOC_DAPM_MIXER("Right Boost Mixer", WM8985_POWER_MANAGEMENT_2,
+		5, 0, right_boost_mixer,
+		ARRAY_SIZE(right_boost_mixer) - 1),
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
@@ -501,13 +537,11 @@ static const struct snd_soc_dapm_route wm8985_dapm_routes[] = {
 
 	{ "Right ADC", NULL, "Right Boost Mixer" },
 
-	{ "Right Boost Mixer", "AUXR Volume", "AUXR" },
 	{ "Right Boost Mixer", NULL, "Right Capture PGA" },
 	{ "Right Boost Mixer", "R2 Volume", "R2" },
 
 	{ "Left ADC", NULL, "Left Boost Mixer" },
 
-	{ "Left Boost Mixer", "AUXL Volume", "AUXL" },
 	{ "Left Boost Mixer", NULL, "Left Capture PGA" },
 	{ "Left Boost Mixer", "L2 Volume", "L2" },
 
@@ -522,6 +556,38 @@ static const struct snd_soc_dapm_route wm8985_dapm_routes[] = {
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
@@ -999,6 +1065,8 @@ static int wm8985_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8985_BIAS_CTRL, WM8985_BIASCUT,
 			    WM8985_BIASCUT);
 
+	wm8985_add_widgets(codec);
+
 	return 0;
 
 err_reg_enable:
@@ -1042,12 +1110,12 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8985 = {
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
@@ -1074,6 +1142,8 @@ static int wm8985_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, wm8985);
 
+	wm8985->dev_type = WM8985;
+
 	wm8985->regmap = devm_regmap_init_spi(spi, &wm8985_regmap);
 	if (IS_ERR(wm8985->regmap)) {
 		ret = PTR_ERR(wm8985->regmap);
@@ -1115,6 +1185,8 @@ static int wm8985_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8985);
 
+	wm8985->dev_type = id->driver_data;
+
 	wm8985->regmap = devm_regmap_init_i2c(i2c, &wm8985_regmap);
 	if (IS_ERR(wm8985->regmap)) {
 		ret = PTR_ERR(wm8985->regmap);
@@ -1135,7 +1207,8 @@ static int wm8985_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id wm8985_i2c_id[] = {
-	{ "wm8985", 0 },
+	{ "wm8985", WM8985 },
+	{ "wm8758", WM8758 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wm8985_i2c_id);
@@ -1183,6 +1256,6 @@ static void __exit wm8985_exit(void)
 }
 module_exit(wm8985_exit);
 
-MODULE_DESCRIPTION("ASoC WM8985 driver");
+MODULE_DESCRIPTION("ASoC WM8985 / WM8758 driver");
 MODULE_AUTHOR("Dimitris Papastamos <dp@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
-- 
2.5.0
