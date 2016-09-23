From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH v2] ASoC: tlv320aic31xx: add explicit support for tlv320dac31xx
Date: Fri, 23 Sep 2016 14:52:52 +0300
Message-ID: <1474631572-30586-1-git-send-email-nikita.yoush@cogentembedded.com>
References: <306354bf-ab8d-bd34-ee48-59bea808fa4d@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <306354bf-ab8d-bd34-ee48-59bea808fa4d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bastien Nocera <hadess@hadess.net>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>
List-Id: alsa-devel@alsa-project.org

tlv320dac31xx is a subset of tlv320aic31xx:
- it does not have MIC inputs and ADC, thus capture is not supported,
- it has analog inputs AIN1/AIN2 that can be mixed into output.

Although tlv320dac31xx does work with tlv320aic31xx driver, this setup
does register non-existent widgets and non-existent capture stream.
Thus userspace lists non-existent objects in user interfaces, an can
access these, causing operations with device registers that are
declared as "reserved" in tlv320dac31xx datasheet.

This patch fixes this situation by separating controls/widgets/routes
into common, aic31xx-specific, and dac31xx-specific parts. Only parts
that match actual hardware (as declared in "compatible" device tree
property) are registered.

Changes from v1:
- update device tree binding documentation,
- rebased on top of "ASoC: codec duplicated callback function goes to
  component on tlv320aic31xx" commit.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |   9 +-
 sound/soc/codecs/tlv320aic31xx.c                   | 212 +++++++++++++++------
 sound/soc/codecs/tlv320aic31xx.h                   |   2 +
 3 files changed, 164 insertions(+), 59 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
index eff12be..9340d2d 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
@@ -11,6 +11,7 @@ Required properties:
     "ti,tlv320aic3110" - TLV320AIC3110 (stereo speaker amp, no MiniDSP)
     "ti,tlv320aic3120" - TLV320AIC3120 (mono speaker amp, MiniDSP)
     "ti,tlv320aic3111" - TLV320AIC3111 (stereo speaker amp, MiniDSP)
+    "ti,tlv320dac3100" - TLV320DAC3100 (no ADC, mono speaker amp, no MiniDSP)
 
 - reg - <int> -  I2C slave address
 - HPVDD-supply, SPRVDD-supply, SPLVDD-supply, AVDD-supply, IOVDD-supply,
@@ -37,9 +38,11 @@ CODEC output pins:
   * MICBIAS
 
 CODEC input pins:
-  * MIC1LP
-  * MIC1RP
-  * MIC1LM
+  * MIC1LP, devices with ADC
+  * MIC1RP, devices with ADC
+  * MIC1LM, devices with ADC
+  * AIN1, devices without ADC
+  * AIN2, devices without ADC
 
 The pins can be used in referring sound node's audio-routing property.
 
diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index e46fb47..725173b 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -273,10 +273,20 @@ static const DECLARE_TLV_DB_SCALE(sp_vol_tlv, -6350, 50, 0);
 /*
  * controls to be exported to the user space
  */
-static const struct snd_kcontrol_new aic31xx_snd_controls[] = {
+static const struct snd_kcontrol_new common31xx_snd_controls[] = {
 	SOC_DOUBLE_R_S_TLV("DAC Playback Volume", AIC31XX_LDACVOL,
 			   AIC31XX_RDACVOL, 0, -127, 48, 7, 0, dac_vol_tlv),
 
+	SOC_DOUBLE_R("HP Driver Playback Switch", AIC31XX_HPLGAIN,
+		     AIC31XX_HPRGAIN, 2, 1, 0),
+	SOC_DOUBLE_R_TLV("HP Driver Playback Volume", AIC31XX_HPLGAIN,
+			 AIC31XX_HPRGAIN, 3, 0x09, 0, hp_drv_tlv),
+
+	SOC_DOUBLE_R_TLV("HP Analog Playback Volume", AIC31XX_LANALOGHPL,
+			 AIC31XX_RANALOGHPR, 0, 0x7F, 1, hp_vol_tlv),
+};
+
+static const struct snd_kcontrol_new aic31xx_snd_controls[] = {
 	SOC_SINGLE_TLV("ADC Fine Capture Volume", AIC31XX_ADCFGA, 4, 4, 1,
 		       adc_fgain_tlv),
 
@@ -286,14 +296,6 @@ static const struct snd_kcontrol_new aic31xx_snd_controls[] = {
 
 	SOC_SINGLE_TLV("Mic PGA Capture Volume", AIC31XX_MICPGA, 0,
 		       119, 0, mic_pga_tlv),
-
-	SOC_DOUBLE_R("HP Driver Playback Switch", AIC31XX_HPLGAIN,
-		     AIC31XX_HPRGAIN, 2, 1, 0),
-	SOC_DOUBLE_R_TLV("HP Driver Playback Volume", AIC31XX_HPLGAIN,
-			 AIC31XX_HPRGAIN, 3, 0x09, 0, hp_drv_tlv),
-
-	SOC_DOUBLE_R_TLV("HP Analog Playback Volume", AIC31XX_LANALOGHPL,
-			 AIC31XX_RANALOGHPR, 0, 0x7F, 1, hp_vol_tlv),
 };
 
 static const struct snd_kcontrol_new aic311x_snd_controls[] = {
@@ -397,17 +399,28 @@ static int aic31xx_dapm_power_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static const struct snd_kcontrol_new left_output_switches[] = {
+static const struct snd_kcontrol_new aic31xx_left_output_switches[] = {
 	SOC_DAPM_SINGLE("From Left DAC", AIC31XX_DACMIXERROUTE, 6, 1, 0),
 	SOC_DAPM_SINGLE("From MIC1LP", AIC31XX_DACMIXERROUTE, 5, 1, 0),
 	SOC_DAPM_SINGLE("From MIC1RP", AIC31XX_DACMIXERROUTE, 4, 1, 0),
 };
 
-static const struct snd_kcontrol_new right_output_switches[] = {
+static const struct snd_kcontrol_new aic31xx_right_output_switches[] = {
 	SOC_DAPM_SINGLE("From Right DAC", AIC31XX_DACMIXERROUTE, 2, 1, 0),
 	SOC_DAPM_SINGLE("From MIC1RP", AIC31XX_DACMIXERROUTE, 1, 1, 0),
 };
 
+static const struct snd_kcontrol_new dac31xx_left_output_switches[] = {
+	SOC_DAPM_SINGLE("From Left DAC", AIC31XX_DACMIXERROUTE, 6, 1, 0),
+	SOC_DAPM_SINGLE("From AIN1", AIC31XX_DACMIXERROUTE, 5, 1, 0),
+	SOC_DAPM_SINGLE("From AIN2", AIC31XX_DACMIXERROUTE, 4, 1, 0),
+};
+
+static const struct snd_kcontrol_new dac31xx_right_output_switches[] = {
+	SOC_DAPM_SINGLE("From Right DAC", AIC31XX_DACMIXERROUTE, 2, 1, 0),
+	SOC_DAPM_SINGLE("From AIN2", AIC31XX_DACMIXERROUTE, 1, 1, 0),
+};
+
 static const struct snd_kcontrol_new p_term_mic1lp =
 	SOC_DAPM_ENUM("MIC1LP P-Terminal", mic1lp_p_enum);
 
@@ -457,7 +470,7 @@ static int mic_bias_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static const struct snd_soc_dapm_widget aic31xx_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget common31xx_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("DAC IN", "DAC Playback", 0, SND_SOC_NOPM, 0, 0),
 
 	SND_SOC_DAPM_MUX("DAC Left Input",
@@ -473,14 +486,7 @@ static const struct snd_soc_dapm_widget aic31xx_dapm_widgets[] = {
 			   AIC31XX_DACSETUP, 6, 0, aic31xx_dapm_power_event,
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
-	/* Output Mixers */
-	SND_SOC_DAPM_MIXER("Output Left", SND_SOC_NOPM, 0, 0,
-			   left_output_switches,
-			   ARRAY_SIZE(left_output_switches)),
-	SND_SOC_DAPM_MIXER("Output Right", SND_SOC_NOPM, 0, 0,
-			   right_output_switches,
-			   ARRAY_SIZE(right_output_switches)),
-
+	/* HP */
 	SND_SOC_DAPM_SWITCH("HP Left", SND_SOC_NOPM, 0, 0,
 			    &aic31xx_dapm_hpl_switch),
 	SND_SOC_DAPM_SWITCH("HP Right", SND_SOC_NOPM, 0, 0,
@@ -494,10 +500,34 @@ static const struct snd_soc_dapm_widget aic31xx_dapm_widgets[] = {
 			       NULL, 0, aic31xx_dapm_power_event,
 			       SND_SOC_DAPM_POST_PMD | SND_SOC_DAPM_POST_PMU),
 
-	/* ADC */
-	SND_SOC_DAPM_ADC_E("ADC", "Capture", AIC31XX_ADCSETUP, 7, 0,
-			   aic31xx_dapm_power_event, SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
+	/* Mic Bias */
+	SND_SOC_DAPM_SUPPLY("MICBIAS", SND_SOC_NOPM, 0, 0, mic_bias_event,
+			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+
+	/* Outputs */
+	SND_SOC_DAPM_OUTPUT("HPL"),
+	SND_SOC_DAPM_OUTPUT("HPR"),
+};
+
+static const struct snd_soc_dapm_widget dac31xx_dapm_widgets[] = {
+	/* Inputs */
+	SND_SOC_DAPM_INPUT("AIN1"),
+	SND_SOC_DAPM_INPUT("AIN2"),
+
+	/* Output Mixers */
+	SND_SOC_DAPM_MIXER("Output Left", SND_SOC_NOPM, 0, 0,
+			   dac31xx_left_output_switches,
+			   ARRAY_SIZE(dac31xx_left_output_switches)),
+	SND_SOC_DAPM_MIXER("Output Right", SND_SOC_NOPM, 0, 0,
+			   dac31xx_right_output_switches,
+			   ARRAY_SIZE(dac31xx_right_output_switches)),
+};
+
+static const struct snd_soc_dapm_widget aic31xx_dapm_widgets[] = {
+	/* Inputs */
+	SND_SOC_DAPM_INPUT("MIC1LP"),
+	SND_SOC_DAPM_INPUT("MIC1RP"),
+	SND_SOC_DAPM_INPUT("MIC1LM"),
 
 	/* Input Selection to MIC_PGA */
 	SND_SOC_DAPM_MUX("MIC1LP P-Terminal", SND_SOC_NOPM, 0, 0,
@@ -507,24 +537,25 @@ static const struct snd_soc_dapm_widget aic31xx_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("MIC1LM P-Terminal", SND_SOC_NOPM, 0, 0,
 			 &p_term_mic1lm),
 
+	/* ADC */
+	SND_SOC_DAPM_ADC_E("ADC", "Capture", AIC31XX_ADCSETUP, 7, 0,
+			   aic31xx_dapm_power_event, SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_POST_PMD),
+
 	SND_SOC_DAPM_MUX("MIC1LM M-Terminal", SND_SOC_NOPM, 0, 0,
 			 &m_term_mic1lm),
+
 	/* Enabling & Disabling MIC Gain Ctl */
 	SND_SOC_DAPM_PGA("MIC_GAIN_CTL", AIC31XX_MICPGA,
 			 7, 1, NULL, 0),
 
-	/* Mic Bias */
-	SND_SOC_DAPM_SUPPLY("MICBIAS", SND_SOC_NOPM, 0, 0, mic_bias_event,
-			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-
-	/* Outputs */
-	SND_SOC_DAPM_OUTPUT("HPL"),
-	SND_SOC_DAPM_OUTPUT("HPR"),
-
-	/* Inputs */
-	SND_SOC_DAPM_INPUT("MIC1LP"),
-	SND_SOC_DAPM_INPUT("MIC1RP"),
-	SND_SOC_DAPM_INPUT("MIC1LM"),
+	/* Output Mixers */
+	SND_SOC_DAPM_MIXER("Output Left", SND_SOC_NOPM, 0, 0,
+			   aic31xx_left_output_switches,
+			   ARRAY_SIZE(aic31xx_left_output_switches)),
+	SND_SOC_DAPM_MIXER("Output Right", SND_SOC_NOPM, 0, 0,
+			   aic31xx_right_output_switches,
+			   ARRAY_SIZE(aic31xx_right_output_switches)),
 };
 
 static const struct snd_soc_dapm_widget aic311x_dapm_widgets[] = {
@@ -554,7 +585,7 @@ static const struct snd_soc_dapm_widget aic310x_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route
-aic31xx_audio_map[] = {
+common31xx_audio_map[] = {
 	/* DAC Input Routing */
 	{"DAC Left Input", "Left Data", "DAC IN"},
 	{"DAC Left Input", "Right Data", "DAC IN"},
@@ -565,6 +596,31 @@ aic31xx_audio_map[] = {
 	{"DAC Left", NULL, "DAC Left Input"},
 	{"DAC Right", NULL, "DAC Right Input"},
 
+	/* HPL path */
+	{"HP Left", "Switch", "Output Left"},
+	{"HPL Driver", NULL, "HP Left"},
+	{"HPL", NULL, "HPL Driver"},
+
+	/* HPR path */
+	{"HP Right", "Switch", "Output Right"},
+	{"HPR Driver", NULL, "HP Right"},
+	{"HPR", NULL, "HPR Driver"},
+};
+
+static const struct snd_soc_dapm_route
+dac31xx_audio_map[] = {
+	/* Left Output */
+	{"Output Left", "From Left DAC", "DAC Left"},
+	{"Output Left", "From AIN1", "AIN1"},
+	{"Output Left", "From AIN2", "AIN2"},
+
+	/* Right Output */
+	{"Output Right", "From Right DAC", "DAC Right"},
+	{"Output Right", "From AIN2", "AIN2"},
+};
+
+static const struct snd_soc_dapm_route
+aic31xx_audio_map[] = {
 	/* Mic input */
 	{"MIC1LP P-Terminal", "FFR 10 Ohm", "MIC1LP"},
 	{"MIC1LP P-Terminal", "FFR 20 Ohm", "MIC1LP"},
@@ -595,16 +651,6 @@ aic31xx_audio_map[] = {
 	/* Right Output */
 	{"Output Right", "From Right DAC", "DAC Right"},
 	{"Output Right", "From MIC1RP", "MIC1RP"},
-
-	/* HPL path */
-	{"HP Left", "Switch", "Output Left"},
-	{"HPL Driver", NULL, "HP Left"},
-	{"HPL", NULL, "HPL Driver"},
-
-	/* HPR path */
-	{"HP Right", "Switch", "Output Right"},
-	{"HPR Driver", NULL, "HP Right"},
-	{"HPR", NULL, "HPR Driver"},
 };
 
 static const struct snd_soc_dapm_route
@@ -633,6 +679,13 @@ static int aic31xx_add_controls(struct snd_soc_codec *codec)
 	int ret = 0;
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 
+	if (!(aic31xx->pdata.codec_type & DAC31XX_BIT))
+		ret = snd_soc_add_codec_controls(
+			codec, aic31xx_snd_controls,
+			ARRAY_SIZE(aic31xx_snd_controls));
+	if (ret)
+		return ret;
+
 	if (aic31xx->pdata.codec_type & AIC31XX_STEREO_CLASS_D_BIT)
 		ret = snd_soc_add_codec_controls(
 			codec, aic311x_snd_controls,
@@ -651,6 +704,30 @@ static int aic31xx_add_widgets(struct snd_soc_codec *codec)
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
+	if (aic31xx->pdata.codec_type & DAC31XX_BIT) {
+		ret = snd_soc_dapm_new_controls(
+			dapm, dac31xx_dapm_widgets,
+			ARRAY_SIZE(dac31xx_dapm_widgets));
+		if (ret)
+			return ret;
+
+		ret = snd_soc_dapm_add_routes(dapm, dac31xx_audio_map,
+					      ARRAY_SIZE(dac31xx_audio_map));
+		if (ret)
+			return ret;
+	} else {
+		ret = snd_soc_dapm_new_controls(
+			dapm, aic31xx_dapm_widgets,
+			ARRAY_SIZE(aic31xx_dapm_widgets));
+		if (ret)
+			return ret;
+
+		ret = snd_soc_dapm_add_routes(dapm, aic31xx_audio_map,
+					      ARRAY_SIZE(aic31xx_audio_map));
+		if (ret)
+			return ret;
+	}
+
 	if (aic31xx->pdata.codec_type & AIC31XX_STEREO_CLASS_D_BIT) {
 		ret = snd_soc_dapm_new_controls(
 			dapm, aic311x_dapm_widgets,
@@ -1115,12 +1192,12 @@ static struct snd_soc_codec_driver soc_codec_driver_aic31xx = {
 	.suspend_bias_off	= true,
 
 	.component_driver = {
-		.controls		= aic31xx_snd_controls,
-		.num_controls		= ARRAY_SIZE(aic31xx_snd_controls),
-		.dapm_widgets		= aic31xx_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(aic31xx_dapm_widgets),
-		.dapm_routes		= aic31xx_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(aic31xx_audio_map),
+		.controls		= common31xx_snd_controls,
+		.num_controls		= ARRAY_SIZE(common31xx_snd_controls),
+		.dapm_widgets		= common31xx_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(common31xx_dapm_widgets),
+		.dapm_routes		= common31xx_audio_map,
+		.num_dapm_routes	= ARRAY_SIZE(common31xx_audio_map),
 	},
 };
 
@@ -1131,6 +1208,21 @@ static const struct snd_soc_dai_ops aic31xx_dai_ops = {
 	.digital_mute	= aic31xx_dac_mute,
 };
 
+static struct snd_soc_dai_driver dac31xx_dai_driver[] = {
+	{
+		.name = "tlv32dac31xx-hifi",
+		.playback = {
+			.stream_name	 = "Playback",
+			.channels_min	 = 1,
+			.channels_max	 = 2,
+			.rates		 = AIC31XX_RATES,
+			.formats	 = AIC31XX_FORMATS,
+		},
+		.ops = &aic31xx_dai_ops,
+		.symmetric_rates = 1,
+	}
+};
+
 static struct snd_soc_dai_driver aic31xx_dai_driver[] = {
 	{
 		.name = "tlv320aic31xx-hifi",
@@ -1261,9 +1353,16 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
 
-	return snd_soc_register_codec(&i2c->dev, &soc_codec_driver_aic31xx,
-				     aic31xx_dai_driver,
-				     ARRAY_SIZE(aic31xx_dai_driver));
+	if (aic31xx->pdata.codec_type & DAC31XX_BIT)
+		return snd_soc_register_codec(&i2c->dev,
+				&soc_codec_driver_aic31xx,
+				dac31xx_dai_driver,
+				ARRAY_SIZE(dac31xx_dai_driver));
+	else
+		return snd_soc_register_codec(&i2c->dev,
+				&soc_codec_driver_aic31xx,
+				aic31xx_dai_driver,
+				ARRAY_SIZE(aic31xx_dai_driver));
 }
 
 static int aic31xx_i2c_remove(struct i2c_client *i2c)
@@ -1279,6 +1378,7 @@ static const struct i2c_device_id aic31xx_i2c_id[] = {
 	{ "tlv320aic3110", AIC3110 },
 	{ "tlv320aic3120", AIC3120 },
 	{ "tlv320aic3111", AIC3111 },
+	{ "tlv320dac3100", DAC3100 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, aic31xx_i2c_id);
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index ac9b146..5acd5b6 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -24,12 +24,14 @@
 
 #define AIC31XX_STEREO_CLASS_D_BIT	0x1
 #define AIC31XX_MINIDSP_BIT		0x2
+#define DAC31XX_BIT			0x4
 
 enum aic31xx_type {
 	AIC3100	= 0,
 	AIC3110 = AIC31XX_STEREO_CLASS_D_BIT,
 	AIC3120 = AIC31XX_MINIDSP_BIT,
 	AIC3111 = (AIC31XX_STEREO_CLASS_D_BIT | AIC31XX_MINIDSP_BIT),
+	DAC3100 = DAC31XX_BIT,
 };
 
 struct aic31xx_pdata {
-- 
2.1.4
