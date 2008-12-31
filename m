From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: TWL4030: DAPM based capture
	implementation
Date: Wed, 31 Dec 2008 10:08:38 +0200
Message-ID: <1230710918-2741-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1230710918-2741-1-git-send-email-peter.ujfalusi@nokia.com>
	<1230710918-2741-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A61351037EB
	for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2008 09:08:50 +0100 (CET)
In-Reply-To: <1230710918-2741-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

This patch adds DAPM implementaion for the capture path
on twlx030.

TWL has two physical ADC and two digital microphone (stereo) connections.
The CPU interface has four microphone channels.
For simplicity the microphone channel paths are named as:
TX1 (Left/Right) - when using i2s mode, only the TX1 data is valid
TX2 (Left/Right)

Input routing (simplified version):
There is two levels of mux settings for TWL in input path:
Analog input mux:
 ADCL <- {Off, Main mic, Headset mic, AUXL, Carkit mic}
 ADCR <- {Off, Sub mic, AUXR}

Analog/Digital mux:
TX1 Analog mode:
 TX1L <- ADCL
 TX1R <- ADCR
TX1 Digital mode:
 TX1L <- Digimic0 (Left)
 TX1R <- Digimic0 (Right)

TX2 Analog mode:
 TX2L <- ADCL
 TX2R <- ADCR
TX2 Digital mode:
 TX2L <- Digimic1 (Left)
 TX2R <- Digimic1 (Right)

The patch provides the following user controls for the capture path:
Mux settings:
"TX1 Capture Route": {Analog, Digimic0}
"TX2 Capture Route": {Analog, Digimic1}
"Analog Left Capture Route":  {Off, Main Mic, Headset Mic, AUXL, Carkit Mic}
"Analog Right Capture Route": {Off, Sub Mic, AUXR}

Volume/Gain controls:
"TX1 Digital Capture Volume": Stereo gain control for TX1 path
"TX2 Digital Capture Volume": Stereo gain control for TX2 path
"Analog Capture Volume":      Stereo gain control for the analog path only

Important things for the board files:
Microphone bias:
"Mic Bias 1":       Bias for Main mic or for digimic0 (analog or digital path)
"Mic Bias 2":       Bias for Sub mic or for digimic1 (analog or digital path)
"Headset Mic Bias": Bias for Headset mic

When the routing configured correctly only the needed components will be
powered/enabled.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |  347 ++++++++++++++++++++++----------------------
 sound/soc/codecs/twl4030.h |    7 +
 2 files changed, 182 insertions(+), 172 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 2c279cd..31e44e3 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -298,6 +298,55 @@ static const struct soc_enum twl4030_handsfreer_enum =
 static const struct snd_kcontrol_new twl4030_dapm_handsfreer_control =
 SOC_DAPM_ENUM("Route", twl4030_handsfreer_enum);
 
+/* Left analog microphone selection */
+static const char *twl4030_analoglmic_texts[] =
+		{"Off", "Main mic", "Headset mic", "Invalid", "AUXL",
+		 "Invalid", "Invalid", "Invalid", "Carkit mic"};
+
+static const struct soc_enum twl4030_analoglmic_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_ANAMICL, 0,
+			ARRAY_SIZE(twl4030_analoglmic_texts),
+			twl4030_analoglmic_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_analoglmic_control =
+SOC_DAPM_ENUM("Route", twl4030_analoglmic_enum);
+
+/* Right analog microphone selection */
+static const char *twl4030_analogrmic_texts[] =
+		{"Off", "Sub mic", "Invalid", "Invalid", "AUXR"};
+
+static const struct soc_enum twl4030_analogrmic_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_ANAMICR, 0,
+			ARRAY_SIZE(twl4030_analogrmic_texts),
+			twl4030_analogrmic_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_analogrmic_control =
+SOC_DAPM_ENUM("Route", twl4030_analogrmic_enum);
+
+/* TX1 L/R Analog/Digital microphone selection */
+static const char *twl4030_micpathtx1_texts[] =
+		{"Analog", "Digimic0"};
+
+static const struct soc_enum twl4030_micpathtx1_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_ADCMICSEL, 0,
+			ARRAY_SIZE(twl4030_micpathtx1_texts),
+			twl4030_micpathtx1_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_micpathtx1_control =
+SOC_DAPM_ENUM("Route", twl4030_micpathtx1_enum);
+
+/* TX2 L/R Analog/Digital microphone selection */
+static const char *twl4030_micpathtx2_texts[] =
+		{"Analog", "Digimic1"};
+
+static const struct soc_enum twl4030_micpathtx2_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_ADCMICSEL, 2,
+			ARRAY_SIZE(twl4030_micpathtx2_texts),
+			twl4030_micpathtx2_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_micpathtx2_control =
+SOC_DAPM_ENUM("Route", twl4030_micpathtx2_enum);
+
 /*
  * This function filters out the non valid mux settings, named as "Invalid"
  * in the enum texts.
@@ -320,6 +369,36 @@ static int twl4030_enum_event(struct snd_soc_dapm_widget *w,
 	return ret;
 }
 
+static int micpath_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct soc_enum *e = (struct soc_enum *)w->kcontrols->private_value;
+	unsigned char adcmicsel, micbias_ctl;
+
+	adcmicsel = twl4030_read_reg_cache(w->codec, TWL4030_REG_ADCMICSEL);
+	micbias_ctl = twl4030_read_reg_cache(w->codec, TWL4030_REG_MICBIAS_CTL);
+	/* Prepare the bits for the given TX path:
+	 * shift_l == 0: TX1 microphone path
+	 * shift_l == 2: TX2 microphone path */
+	if (e->shift_l) {
+		/* TX2 microphone path */
+		if (adcmicsel & TWL4030_TX2IN_SEL)
+			micbias_ctl |= TWL4030_MICBIAS2_CTL; /* digimic */
+		else
+			micbias_ctl &= ~TWL4030_MICBIAS2_CTL;
+	} else {
+		/* TX1 microphone path */
+		if (adcmicsel & TWL4030_TX1IN_SEL)
+			micbias_ctl |= TWL4030_MICBIAS1_CTL; /* digimic */
+		else
+			micbias_ctl &= ~TWL4030_MICBIAS1_CTL;
+	}
+
+	twl4030_write(w->codec, TWL4030_REG_MICBIAS_CTL, micbias_ctl);
+
+	return 0;
+}
+
 static int handsfree_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
@@ -501,162 +580,6 @@ static int snd_soc_put_volsw_r2_twl4030(struct snd_kcontrol *kcontrol,
 	return err;
 }
 
-static int twl4030_get_left_input(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = kcontrol->private_data;
-	u8 reg = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
-	int result = 0;
-
-	/* one bit must be set a time */
-	reg &= TWL4030_CKMIC_EN | TWL4030_AUXL_EN | TWL4030_HSMIC_EN
-			| TWL4030_MAINMIC_EN;
-	if (reg != 0) {
-		result++;
-		while ((reg & 1) == 0) {
-			result++;
-			reg >>= 1;
-		}
-	}
-
-	ucontrol->value.integer.value[0] = result;
-	return 0;
-}
-
-static int twl4030_put_left_input(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = kcontrol->private_data;
-	int value = ucontrol->value.integer.value[0];
-	u8 anamicl, micbias, avadc_ctl;
-
-	anamicl = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
-	anamicl &= ~(TWL4030_CKMIC_EN | TWL4030_AUXL_EN | TWL4030_HSMIC_EN
-			| TWL4030_MAINMIC_EN);
-	micbias = twl4030_read_reg_cache(codec, TWL4030_REG_MICBIAS_CTL);
-	micbias &= ~(TWL4030_HSMICBIAS_EN | TWL4030_MICBIAS1_EN);
-	avadc_ctl = twl4030_read_reg_cache(codec, TWL4030_REG_AVADC_CTL);
-
-	switch (value) {
-	case 1:
-		anamicl |= TWL4030_MAINMIC_EN;
-		micbias |= TWL4030_MICBIAS1_EN;
-		break;
-	case 2:
-		anamicl |= TWL4030_HSMIC_EN;
-		micbias |= TWL4030_HSMICBIAS_EN;
-		break;
-	case 3:
-		anamicl |= TWL4030_AUXL_EN;
-		break;
-	case 4:
-		anamicl |= TWL4030_CKMIC_EN;
-		break;
-	default:
-		break;
-	}
-
-	/* If some input is selected, enable amp and ADC */
-	if (value != 0) {
-		anamicl |= TWL4030_MICAMPL_EN;
-		avadc_ctl |= TWL4030_ADCL_EN;
-	} else {
-		anamicl &= ~TWL4030_MICAMPL_EN;
-		avadc_ctl &= ~TWL4030_ADCL_EN;
-	}
-
-	twl4030_write(codec, TWL4030_REG_ANAMICL, anamicl);
-	twl4030_write(codec, TWL4030_REG_MICBIAS_CTL, micbias);
-	twl4030_write(codec, TWL4030_REG_AVADC_CTL, avadc_ctl);
-
-	return 1;
-}
-
-static int twl4030_get_right_input(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = kcontrol->private_data;
-	u8 reg = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICR);
-	int value = 0;
-
-	reg &= TWL4030_SUBMIC_EN|TWL4030_AUXR_EN;
-	switch (reg) {
-	case TWL4030_SUBMIC_EN:
-		value = 1;
-		break;
-	case TWL4030_AUXR_EN:
-		value = 2;
-		break;
-	default:
-		break;
-	}
-
-	ucontrol->value.integer.value[0] = value;
-	return 0;
-}
-
-static int twl4030_put_right_input(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = kcontrol->private_data;
-	int value = ucontrol->value.integer.value[0];
-	u8 anamicr, micbias, avadc_ctl;
-
-	anamicr = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICR);
-	anamicr &= ~(TWL4030_SUBMIC_EN|TWL4030_AUXR_EN);
-	micbias = twl4030_read_reg_cache(codec, TWL4030_REG_MICBIAS_CTL);
-	micbias &= ~TWL4030_MICBIAS2_EN;
-	avadc_ctl = twl4030_read_reg_cache(codec, TWL4030_REG_AVADC_CTL);
-
-	switch (value) {
-	case 1:
-		anamicr |= TWL4030_SUBMIC_EN;
-		micbias |= TWL4030_MICBIAS2_EN;
-		break;
-	case 2:
-		anamicr |= TWL4030_AUXR_EN;
-		break;
-	default:
-		break;
-	}
-
-	if (value != 0) {
-		anamicr |= TWL4030_MICAMPR_EN;
-		avadc_ctl |= TWL4030_ADCR_EN;
-	} else {
-		anamicr &= ~TWL4030_MICAMPR_EN;
-		avadc_ctl &= ~TWL4030_ADCR_EN;
-	}
-
-	twl4030_write(codec, TWL4030_REG_ANAMICR, anamicr);
-	twl4030_write(codec, TWL4030_REG_MICBIAS_CTL, micbias);
-	twl4030_write(codec, TWL4030_REG_AVADC_CTL, avadc_ctl);
-
-	return 1;
-}
-
-static const char *twl4030_left_in_sel[] = {
-	"None",
-	"Main Mic",
-	"Headset Mic",
-	"Line In",
-	"Carkit Mic",
-};
-
-static const char *twl4030_right_in_sel[] = {
-	"None",
-	"Sub Mic",
-	"Line In",
-};
-
-static const struct soc_enum twl4030_left_input_mux =
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(twl4030_left_in_sel),
-		twl4030_left_in_sel);
-
-static const struct soc_enum twl4030_right_input_mux =
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(twl4030_right_in_sel),
-		twl4030_right_in_sel);
-
 /*
  * FGAIN volume control:
  * from -62 to 0 dB in 1 dB steps (mute instead of -63 dB)
@@ -739,18 +662,15 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 		TWL4030_REG_EAR_CTL, 4, 3, 0, output_tvl),
 
 	/* Common capture gain controls */
-	SOC_DOUBLE_R_TLV("Capture Volume",
+	SOC_DOUBLE_R_TLV("TX1 Digital Capture Volume",
 		TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
 		0, 0x1f, 0, digital_capture_tlv),
+	SOC_DOUBLE_R_TLV("TX2 Digital Capture Volume",
+		TWL4030_REG_AVTXL2PGA, TWL4030_REG_AVTXR2PGA,
+		0, 0x1f, 0, digital_capture_tlv),
 
-	SOC_DOUBLE_TLV("Input Boost Volume", TWL4030_REG_ANAMIC_GAIN,
+	SOC_DOUBLE_TLV("Analog Capture Volume", TWL4030_REG_ANAMIC_GAIN,
 		0, 3, 5, 0, input_gain_tlv),
-
-	/* Input source controls */
-	SOC_ENUM_EXT("Left Input Source", twl4030_left_input_mux,
-		twl4030_get_left_input, twl4030_put_left_input),
-	SOC_ENUM_EXT("Right Input Source", twl4030_right_input_mux,
-		twl4030_get_right_input, twl4030_put_right_input),
 };
 
 /* add non dapm controls */
@@ -770,9 +690,19 @@ static int twl4030_add_controls(struct snd_soc_codec *codec)
 }
 
 static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
-	SND_SOC_DAPM_INPUT("INL"),
-	SND_SOC_DAPM_INPUT("INR"),
-
+	/* Left channel inputs */
+	SND_SOC_DAPM_INPUT("MAINMIC"),
+	SND_SOC_DAPM_INPUT("HSMIC"),
+	SND_SOC_DAPM_INPUT("AUXL"),
+	SND_SOC_DAPM_INPUT("CARKITMIC"),
+	/* Right channel inputs */
+	SND_SOC_DAPM_INPUT("SUBMIC"),
+	SND_SOC_DAPM_INPUT("AUXR"),
+	/* Digital microphones (Stereo) */
+	SND_SOC_DAPM_INPUT("DIGIMIC0"),
+	SND_SOC_DAPM_INPUT("DIGIMIC1"),
+
+	/* Outputs */
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
 	SND_SOC_DAPM_OUTPUT("EARPIECE"),
@@ -835,8 +765,50 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 		&twl4030_dapm_handsfreer_control, handsfree_event,
 		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 
-	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
+	/* Introducing four virtual ADC, since TWL4030 have four channel for
+	   capture */
+	SND_SOC_DAPM_ADC("ADC Virtual Left1", "Left Front Capture",
+		SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC Virtual Right1", "Right Front Capture",
+		SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC Virtual Left2", "Left Rear Capture",
+		SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC Virtual Right2", "Right Rear Capture",
+		SND_SOC_NOPM, 0, 0),
+
+	/* Analog/Digital mic path selection.
+	   TX1 Left/Right: either analog Left/Right or Digimic0
+	   TX2 Left/Right: either analog Left/Right or Digimic1 */
+	SND_SOC_DAPM_MUX_E("TX1 Capture Route", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_micpathtx1_control, micpath_event,
+		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD|
+		SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_MUX_E("TX2 Capture Route", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_micpathtx2_control, micpath_event,
+		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD|
+		SND_SOC_DAPM_POST_REG),
+
+	/* Analog input muxes with power switch for the physical ADCL/R */
+	SND_SOC_DAPM_MUX_E("Analog Left Capture Route",
+		TWL4030_REG_AVADC_CTL, 3, 0, &twl4030_dapm_analoglmic_control,
+		twl4030_enum_event, SND_SOC_DAPM_PRE_REG),
+	SND_SOC_DAPM_MUX_E("Analog Right Capture Route",
+		TWL4030_REG_AVADC_CTL, 1, 0, &twl4030_dapm_analogrmic_control,
+		twl4030_enum_event, SND_SOC_DAPM_PRE_REG),
+
+	SND_SOC_DAPM_PGA("Analog Left Amplifier",
+		TWL4030_REG_ANAMICL, 4, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Analog Right Amplifier",
+		TWL4030_REG_ANAMICR, 4, 0, NULL, 0),
+
+	SND_SOC_DAPM_PGA("Digimic0 Enable",
+		TWL4030_REG_ADCMICSEL, 1, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Digimic1 Enable",
+		TWL4030_REG_ADCMICSEL, 3, 0, NULL, 0),
+
+	SND_SOC_DAPM_MICBIAS("Mic Bias 1", TWL4030_REG_MICBIAS_CTL, 0, 0),
+	SND_SOC_DAPM_MICBIAS("Mic Bias 2", TWL4030_REG_MICBIAS_CTL, 1, 0),
+	SND_SOC_DAPM_MICBIAS("Headset Mic Bias", TWL4030_REG_MICBIAS_CTL, 2, 0),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
@@ -892,9 +864,39 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HFL", NULL, "HandsfreeL Mux"},
 	{"HFR", NULL, "HandsfreeR Mux"},
 
-	/* inputs */
-	{"ADCL", NULL, "INL"},
-	{"ADCR", NULL, "INR"},
+	/* Capture path */
+	{"Analog Left Capture Route", "Main mic", "MAINMIC"},
+	{"Analog Left Capture Route", "Headset mic", "HSMIC"},
+	{"Analog Left Capture Route", "AUXL", "AUXL"},
+	{"Analog Left Capture Route", "Carkit mic", "CARKITMIC"},
+
+	{"Analog Right Capture Route", "Sub mic", "SUBMIC"},
+	{"Analog Right Capture Route", "AUXR", "AUXR"},
+
+	{"Analog Left Amplifier", NULL, "Analog Left Capture Route"},
+	{"Analog Right Amplifier", NULL, "Analog Right Capture Route"},
+
+	{"Digimic0 Enable", NULL, "DIGIMIC0"},
+	{"Digimic1 Enable", NULL, "DIGIMIC1"},
+
+	/* TX1 Left capture path */
+	{"TX1 Capture Route", "Analog", "Analog Left Amplifier"},
+	{"TX1 Capture Route", "Digimic0", "Digimic0 Enable"},
+	/* TX1 Right capture path */
+	{"TX1 Capture Route", "Analog", "Analog Right Amplifier"},
+	{"TX1 Capture Route", "Digimic0", "Digimic0 Enable"},
+	/* TX2 Left capture path */
+	{"TX2 Capture Route", "Analog", "Analog Left Amplifier"},
+	{"TX2 Capture Route", "Digimic1", "Digimic1 Enable"},
+	/* TX2 Right capture path */
+	{"TX2 Capture Route", "Analog", "Analog Right Amplifier"},
+	{"TX2 Capture Route", "Digimic1", "Digimic1 Enable"},
+
+	{"ADC Virtual Left1", NULL, "TX1 Capture Route"},
+	{"ADC Virtual Right1", NULL, "TX1 Capture Route"},
+	{"ADC Virtual Left2", NULL, "TX2 Capture Route"},
+	{"ADC Virtual Right2", NULL, "TX2 Capture Route"},
+
 };
 
 static int twl4030_add_widgets(struct snd_soc_codec *codec)
@@ -921,6 +923,7 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 	twl4030_write(codec, TWL4030_REG_ANAMICL,
 		anamicl | TWL4030_CNCL_OFFSET_START);
 
+
 	/* wait for offset cancellation to complete */
 	do {
 		/* this takes a little while, so don't slam i2c */
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index 54615c7..442e5a8 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -147,6 +147,13 @@
 #define TWL4030_AVADC_CLK_PRIORITY	0x04
 #define TWL4030_ADCR_EN			0x02
 
+/* TWL4030_REG_ADCMICSEL (0x08) Fields */
+
+#define TWL4030_DIGMIC1_EN		0x08
+#define TWL4030_TX2IN_SEL		0x04
+#define TWL4030_DIGMIC0_EN		0x02
+#define TWL4030_TX1IN_SEL		0x01
+
 /* AUDIO_IF (0x0E) Fields */
 
 #define TWL4030_AIF_SLAVE_EN		0x80
-- 
1.6.0.6
