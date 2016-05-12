From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH 2/2] ASoC: wm8985: add support for WM8758
Date: Thu, 12 May 2016 17:54:37 +0200
Message-ID: <1463068477-18421-3-git-send-email-petr@barix.com>
References: <1463068477-18421-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 68A1C260483
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 17:55:31 +0200 (CEST)
Received: by mail-wm0-f41.google.com with SMTP id e201so264419428wme.0
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 08:55:31 -0700 (PDT)
In-Reply-To: <1463068477-18421-1-git-send-email-petr@barix.com>
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
Cc: Petr Kulhavy <petr@barix.com>, alsa-devel@alsa-project.org, plamen@barix.com
List-Id: alsa-devel@alsa-project.org

The WM8758 chip is almost identical to WM8985 with the difference that it
doesn't feature the AUX input. This patch adds the WM8758 support into the
WM8985 driver.

The chip selection is done by the I2C name. The SPI probe supports only
the WM8985.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
 sound/soc/codecs/Kconfig  |   2 +-
 sound/soc/codecs/wm8985.c | 281 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 277 insertions(+), 6 deletions(-)

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
index 42696e709580..5cd40025f64c 100644
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
 
+struct wm8xxx_chip {
+	struct snd_soc_dai_driver *dai;
+	struct snd_soc_codec_driver *codec_dev;
+};
+
 static const struct reg_default wm8985_reg_defaults[] = {
 	{ 1,  0x0000 },     /* R1  - Power management 1 */
 	{ 2,  0x0000 },     /* R2  - Power management 2 */
@@ -283,6 +291,103 @@ static const char *depth_3d_text[] = {
 static const SOC_ENUM_SINGLE_DECL(depth_3d, WM8985_3D_CONTROL, 0,
 				  depth_3d_text);
 
+static const struct snd_kcontrol_new wm8758_snd_controls[] = {
+	SOC_SINGLE("Digital Loopback Switch", WM8985_COMPANDING_CONTROL,
+		0, 1, 0),
+
+	SOC_ENUM("ALC Capture Function", alc_sel),
+	SOC_SINGLE_TLV("ALC Capture Max Volume", WM8985_ALC_CONTROL_1,
+		3, 7, 0, alc_max_tlv),
+	SOC_SINGLE_TLV("ALC Capture Min Volume", WM8985_ALC_CONTROL_1,
+		0, 7, 0, alc_min_tlv),
+	SOC_SINGLE_TLV("ALC Capture Target Volume", WM8985_ALC_CONTROL_2,
+		0, 15, 0, alc_tar_tlv),
+	SOC_SINGLE("ALC Capture Attack", WM8985_ALC_CONTROL_3, 0, 10, 0),
+	SOC_SINGLE("ALC Capture Hold", WM8985_ALC_CONTROL_2, 4, 10, 0),
+	SOC_SINGLE("ALC Capture Decay", WM8985_ALC_CONTROL_3, 4, 10, 0),
+	SOC_ENUM("ALC Mode", alc_mode),
+	SOC_SINGLE("ALC Capture NG Switch", WM8985_NOISE_GATE,
+		3, 1, 0),
+	SOC_SINGLE("ALC Capture NG Threshold", WM8985_NOISE_GATE,
+		0, 7, 1),
+
+	SOC_DOUBLE_R_TLV("Capture Volume", WM8985_LEFT_ADC_DIGITAL_VOL,
+		WM8985_RIGHT_ADC_DIGITAL_VOL, 0, 255, 0, adc_tlv),
+	SOC_DOUBLE_R("Capture PGA ZC Switch", WM8985_LEFT_INP_PGA_GAIN_CTRL,
+		WM8985_RIGHT_INP_PGA_GAIN_CTRL, 7, 1, 0),
+	SOC_DOUBLE_R_TLV("Capture PGA Volume", WM8985_LEFT_INP_PGA_GAIN_CTRL,
+		WM8985_RIGHT_INP_PGA_GAIN_CTRL, 0, 63, 0, pga_vol_tlv),
+
+	SOC_DOUBLE_R_TLV("Capture PGA Boost Volume",
+		WM8985_LEFT_ADC_BOOST_CTRL, WM8985_RIGHT_ADC_BOOST_CTRL,
+		8, 1, 0, pga_boost_tlv),
+
+	SOC_DOUBLE("ADC Inversion Switch", WM8985_ADC_CONTROL, 0, 1, 1, 0),
+	SOC_SINGLE("ADC 128x Oversampling Switch", WM8985_ADC_CONTROL,
+		   8, 1, 0),
+
+	SOC_DOUBLE_R_TLV("Playback Volume", WM8985_LEFT_DAC_DIGITAL_VOL,
+		WM8985_RIGHT_DAC_DIGITAL_VOL, 0, 255, 0, dac_tlv),
+
+	SOC_SINGLE("DAC Playback Limiter Switch", WM8985_DAC_LIMITER_1,
+		   8, 1, 0),
+	SOC_SINGLE("DAC Playback Limiter Decay", WM8985_DAC_LIMITER_1,
+		   4, 10, 0),
+	SOC_SINGLE("DAC Playback Limiter Attack", WM8985_DAC_LIMITER_1,
+		   0, 11, 0),
+	SOC_SINGLE_TLV("DAC Playback Limiter Threshold", WM8985_DAC_LIMITER_2,
+		4, 7, 1, lim_thresh_tlv),
+	SOC_SINGLE_TLV("DAC Playback Limiter Boost Volume",
+		WM8985_DAC_LIMITER_2, 0, 12, 0, lim_boost_tlv),
+	SOC_DOUBLE("DAC Inversion Switch", WM8985_DAC_CONTROL, 0, 1, 1, 0),
+	SOC_SINGLE("DAC Auto Mute Switch", WM8985_DAC_CONTROL, 2, 1, 0),
+	SOC_SINGLE("DAC 128x Oversampling Switch", WM8985_DAC_CONTROL,
+		   3, 1, 0),
+
+	SOC_DOUBLE_R_TLV("Headphone Playback Volume",
+		WM8985_LOUT1_HP_VOLUME_CTRL,
+		WM8985_ROUT1_HP_VOLUME_CTRL, 0, 63, 0, out_tlv),
+	SOC_DOUBLE_R("Headphone Playback ZC Switch",
+		WM8985_LOUT1_HP_VOLUME_CTRL,
+		WM8985_ROUT1_HP_VOLUME_CTRL, 7, 1, 0),
+	SOC_DOUBLE_R("Headphone Switch", WM8985_LOUT1_HP_VOLUME_CTRL,
+		WM8985_ROUT1_HP_VOLUME_CTRL, 6, 1, 1),
+
+	SOC_DOUBLE_R_TLV("Speaker Playback Volume",
+		WM8985_LOUT2_SPK_VOLUME_CTRL,
+		WM8985_ROUT2_SPK_VOLUME_CTRL, 0, 63, 0, out_tlv),
+	SOC_DOUBLE_R("Speaker Playback ZC Switch",
+		WM8985_LOUT2_SPK_VOLUME_CTRL,
+		WM8985_ROUT2_SPK_VOLUME_CTRL, 7, 1, 0),
+	SOC_DOUBLE_R("Speaker Switch", WM8985_LOUT2_SPK_VOLUME_CTRL,
+		WM8985_ROUT2_SPK_VOLUME_CTRL, 6, 1, 1),
+
+	SOC_SINGLE("High Pass Filter Switch", WM8985_ADC_CONTROL, 8, 1, 0),
+	SOC_ENUM("High Pass Filter Mode", filter_mode),
+	SOC_SINGLE("High Pass Filter Cutoff", WM8985_ADC_CONTROL, 4, 7, 0),
+
+	SOC_DOUBLE_R_TLV("Input PGA Bypass Volume",
+		WM8985_LEFT_MIXER_CTRL, WM8985_RIGHT_MIXER_CTRL, 2, 7, 0,
+		bypass_tlv),
+
+	SOC_ENUM_EXT("Equalizer Function", eqmode, eqmode_get, eqmode_put),
+	SOC_ENUM("EQ1 Cutoff", eq1_cutoff),
+	SOC_SINGLE_TLV("EQ1 Volume", WM8985_EQ1_LOW_SHELF,  0, 24, 1, eq_tlv),
+	SOC_ENUM("EQ2 Bandwidth", eq2_bw),
+	SOC_ENUM("EQ2 Cutoff", eq2_cutoff),
+	SOC_SINGLE_TLV("EQ2 Volume", WM8985_EQ2_PEAK_1, 0, 24, 1, eq_tlv),
+	SOC_ENUM("EQ3 Bandwidth", eq3_bw),
+	SOC_ENUM("EQ3 Cutoff", eq3_cutoff),
+	SOC_SINGLE_TLV("EQ3 Volume", WM8985_EQ3_PEAK_2, 0, 24, 1, eq_tlv),
+	SOC_ENUM("EQ4 Bandwidth", eq4_bw),
+	SOC_ENUM("EQ4 Cutoff", eq4_cutoff),
+	SOC_SINGLE_TLV("EQ4 Volume", WM8985_EQ4_PEAK_3, 0, 24, 1, eq_tlv),
+	SOC_ENUM("EQ5 Cutoff", eq5_cutoff),
+	SOC_SINGLE_TLV("EQ5 Volume", WM8985_EQ5_HIGH_SHELF, 0, 24, 1, eq_tlv),
+
+	SOC_ENUM("3D Depth", depth_3d),
+};
+
 static const struct snd_kcontrol_new wm8985_snd_controls[] = {
 	SOC_SINGLE("Digital Loopback Switch", WM8985_COMPANDING_CONTROL,
 		0, 1, 0),
@@ -389,6 +494,16 @@ static const struct snd_kcontrol_new right_out_mixer[] = {
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
@@ -401,6 +516,16 @@ static const struct snd_kcontrol_new right_input_mixer[] = {
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
@@ -415,6 +540,65 @@ static const struct snd_kcontrol_new right_boost_mixer[] = {
 		0, 7, 0, boost_tlv)
 };
 
+static const struct snd_soc_dapm_widget wm8758_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("Left DAC", "Left Playback",
+		WM8985_POWER_MANAGEMENT_3, 0, 0),
+	SND_SOC_DAPM_DAC("Right DAC", "Right Playback",
+		WM8985_POWER_MANAGEMENT_3, 1, 0),
+	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", WM8985_POWER_MANAGEMENT_2,
+		0, 0),
+	SND_SOC_DAPM_ADC("Right ADC", "Right Capture",
+		WM8985_POWER_MANAGEMENT_2, 1, 0),
+
+	SND_SOC_DAPM_MIXER("Left Output Mixer", WM8985_POWER_MANAGEMENT_3,
+		2, 0, wm8758_left_out_mixer,
+		ARRAY_SIZE(wm8758_left_out_mixer)),
+	SND_SOC_DAPM_MIXER("Right Output Mixer", WM8985_POWER_MANAGEMENT_3,
+		3, 0, wm8758_right_out_mixer,
+		ARRAY_SIZE(wm8758_right_out_mixer)),
+
+	SND_SOC_DAPM_MIXER("Left Input Mixer", WM8985_POWER_MANAGEMENT_2,
+		2, 0, left_input_mixer, ARRAY_SIZE(left_input_mixer)),
+	SND_SOC_DAPM_MIXER("Right Input Mixer", WM8985_POWER_MANAGEMENT_2,
+		3, 0, right_input_mixer, ARRAY_SIZE(right_input_mixer)),
+
+	SND_SOC_DAPM_MIXER("Left Boost Mixer", WM8985_POWER_MANAGEMENT_2,
+		4, 0, wm8758_left_boost_mixer,
+		ARRAY_SIZE(wm8758_left_boost_mixer)),
+	SND_SOC_DAPM_MIXER("Right Boost Mixer", WM8985_POWER_MANAGEMENT_2,
+		5, 0, wm8758_right_boost_mixer,
+		ARRAY_SIZE(wm8758_right_boost_mixer)),
+
+	SND_SOC_DAPM_PGA("Left Capture PGA", WM8985_LEFT_INP_PGA_GAIN_CTRL,
+		6, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("Right Capture PGA", WM8985_RIGHT_INP_PGA_GAIN_CTRL,
+		6, 1, NULL, 0),
+
+	SND_SOC_DAPM_PGA("Left Headphone Out", WM8985_POWER_MANAGEMENT_2,
+		7, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Right Headphone Out", WM8985_POWER_MANAGEMENT_2,
+		8, 0, NULL, 0),
+
+	SND_SOC_DAPM_PGA("Left Speaker Out", WM8985_POWER_MANAGEMENT_3,
+		5, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Right Speaker Out", WM8985_POWER_MANAGEMENT_3,
+		6, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("Mic Bias", WM8985_POWER_MANAGEMENT_1, 4, 0,
+			    NULL, 0),
+
+	SND_SOC_DAPM_INPUT("LIN"),
+	SND_SOC_DAPM_INPUT("LIP"),
+	SND_SOC_DAPM_INPUT("RIN"),
+	SND_SOC_DAPM_INPUT("RIP"),
+	SND_SOC_DAPM_INPUT("L2"),
+	SND_SOC_DAPM_INPUT("R2"),
+	SND_SOC_DAPM_OUTPUT("HPL"),
+	SND_SOC_DAPM_OUTPUT("HPR"),
+	SND_SOC_DAPM_OUTPUT("SPKL"),
+	SND_SOC_DAPM_OUTPUT("SPKR")
+};
+
 static const struct snd_soc_dapm_widget wm8985_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", WM8985_POWER_MANAGEMENT_3,
 		0, 0),
@@ -517,6 +701,47 @@ static const struct snd_soc_dapm_route wm8985_dapm_routes[] = {
 	{ "Left Input Mixer", "MicP Switch", "LIP" },
 };
 
+static const struct snd_soc_dapm_route wm8758_dapm_routes[] = {
+	{ "Right Output Mixer", "PCM Switch", "Right DAC" },
+	{ "Right Output Mixer", "Line Switch", "Right Boost Mixer" },
+
+	{ "Left Output Mixer", "PCM Switch", "Left DAC" },
+	{ "Left Output Mixer", "Line Switch", "Left Boost Mixer" },
+
+	{ "Right Headphone Out", NULL, "Right Output Mixer" },
+	{ "HPR", NULL, "Right Headphone Out" },
+
+	{ "Left Headphone Out", NULL, "Left Output Mixer" },
+	{ "HPL", NULL, "Left Headphone Out" },
+
+	{ "Right Speaker Out", NULL, "Right Output Mixer" },
+	{ "SPKR", NULL, "Right Speaker Out" },
+
+	{ "Left Speaker Out", NULL, "Left Output Mixer" },
+	{ "SPKL", NULL, "Left Speaker Out" },
+
+	{ "Right ADC", NULL, "Right Boost Mixer" },
+
+	{ "Right Boost Mixer", NULL, "Right Capture PGA" },
+	{ "Right Boost Mixer", "R2 Volume", "R2" },
+
+	{ "Left ADC", NULL, "Left Boost Mixer" },
+
+	{ "Left Boost Mixer", NULL, "Left Capture PGA" },
+	{ "Left Boost Mixer", "L2 Volume", "L2" },
+
+	{ "Right Capture PGA", NULL, "Right Input Mixer" },
+	{ "Left Capture PGA", NULL, "Left Input Mixer" },
+
+	{ "Right Input Mixer", "R2 Switch", "R2" },
+	{ "Right Input Mixer", "MicN Switch", "RIN" },
+	{ "Right Input Mixer", "MicP Switch", "RIP" },
+
+	{ "Left Input Mixer", "L2 Switch", "L2" },
+	{ "Left Input Mixer", "MicN Switch", "LIN" },
+	{ "Left Input Mixer", "MicP Switch", "LIP" },
+};
+
 static int eqmode_get(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
@@ -1043,6 +1268,39 @@ static struct snd_soc_dai_driver wm8985_dai = {
 	.symmetric_rates = 1
 };
 
+static struct snd_soc_dai_driver wm8758_dai = {
+	.name = "wm8758-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = WM8985_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = WM8985_FORMATS,
+	},
+	.ops = &wm8985_dai_ops,
+	.symmetric_rates = 1
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_wm8758 = {
+	.probe = wm8985_probe,
+	.set_bias_level = wm8985_set_bias_level,
+	.suspend_bias_off = true,
+
+	.controls = wm8758_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8758_snd_controls),
+	.dapm_widgets = wm8758_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8758_dapm_widgets),
+	.dapm_routes = wm8758_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8758_dapm_routes),
+};
+
 static struct snd_soc_codec_driver soc_codec_dev_wm8985 = {
 	.probe = wm8985_probe,
 	.set_bias_level = wm8985_set_bias_level,
@@ -1068,6 +1326,17 @@ static const struct regmap_config wm8985_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(wm8985_reg_defaults),
 };
 
+static const struct wm8xxx_chip wm8985_chip = {
+	.dai		= &wm8985_dai,
+	.codec_dev	= &soc_codec_dev_wm8985,
+};
+
+static const struct wm8xxx_chip wm8758_chip = {
+	.dai		= &wm8758_dai,
+	.codec_dev	= &soc_codec_dev_wm8758,
+};
+
+
 #if defined(CONFIG_SPI_MASTER)
 static int wm8985_spi_probe(struct spi_device *spi)
 {
@@ -1113,6 +1382,7 @@ static int wm8985_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8985_priv *wm8985;
+	struct wm8xxx_chip *chip = (void *) id->driver_data;
 	int ret;
 
 	wm8985 = devm_kzalloc(&i2c->dev, sizeof *wm8985, GFP_KERNEL);
@@ -1130,7 +1400,7 @@ static int wm8985_i2c_probe(struct i2c_client *i2c,
 	}
 
 	ret = snd_soc_register_codec(&i2c->dev,
-				     &soc_codec_dev_wm8985, &wm8985_dai, 1);
+				     chip->codec_dev, chip->dai, 1);
 	return ret;
 }
 
@@ -1141,7 +1411,8 @@ static int wm8985_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id wm8985_i2c_id[] = {
-	{ "wm8985", 0 },
+	{ "wm8985", (kernel_ulong_t) &wm8985_chip },
+	{ "wm8758", (kernel_ulong_t) &wm8758_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wm8985_i2c_id);
@@ -1189,6 +1460,6 @@ static void __exit wm8985_exit(void)
 }
 module_exit(wm8985_exit);
 
-MODULE_DESCRIPTION("ASoC WM8985 driver");
+MODULE_DESCRIPTION("ASoC WM8985 / WM8758 driver");
 MODULE_AUTHOR("Dimitris Papastamos <dp@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
-- 
1.9.1
