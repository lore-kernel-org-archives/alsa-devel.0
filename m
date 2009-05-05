From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 17/18] ASoC: TWL4030: Add VIBRA output
Date: Tue,  5 May 2009 11:02:30 +0100
Message-ID: <1241517751-2634-17-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D0AFE24513
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 12:02:35 +0200 (CEST)
In-Reply-To: <20090505100123.GB2050@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

This patch adds support for the VIBRA output on TWL4030 codec.
The VIBRA output can be driven with audio data or with
local vibrator driver.
Add the needed DAPM elements and routes for the VIBRA output and
controls for the VIBRA driver configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |   61 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 23bae74..1a00e4b 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -396,6 +396,31 @@ static const struct soc_enum twl4030_handsfreer_enum =
 static const struct snd_kcontrol_new twl4030_dapm_handsfreer_control =
 SOC_DAPM_ENUM("Route", twl4030_handsfreer_enum);
 
+/* Vibra */
+/* Vibra audio path selection */
+static const char *twl4030_vibra_texts[] =
+		{"AudioL1", "AudioR1", "AudioL2", "AudioR2"};
+
+static const struct soc_enum twl4030_vibra_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_VIBRA_CTL, 2,
+			ARRAY_SIZE(twl4030_vibra_texts),
+			twl4030_vibra_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_vibra_control =
+SOC_DAPM_ENUM("Route", twl4030_vibra_enum);
+
+/* Vibra path selection: local vibrator (PWM) or audio driven */
+static const char *twl4030_vibrapath_texts[] =
+		{"Local vibrator", "Audio"};
+
+static const struct soc_enum twl4030_vibrapath_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_VIBRA_CTL, 4,
+			ARRAY_SIZE(twl4030_vibrapath_texts),
+			twl4030_vibrapath_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_vibrapath_control =
+SOC_DAPM_ENUM("Route", twl4030_vibrapath_enum);
+
 /* Left analog microphone selection */
 static const char *twl4030_analoglmic_texts[] =
 		{"Off", "Main mic", "Headset mic", "AUXL", "Carkit mic"};
@@ -867,6 +892,26 @@ static const struct soc_enum twl4030_rampdelay_enum =
 			ARRAY_SIZE(twl4030_rampdelay_texts),
 			twl4030_rampdelay_texts);
 
+/* Vibra H-bridge direction mode */
+static const char *twl4030_vibradirmode_texts[] = {
+	"Vibra H-bridge direction", "Audio data MSB",
+};
+
+static const struct soc_enum twl4030_vibradirmode_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_VIBRA_CTL, 5,
+			ARRAY_SIZE(twl4030_vibradirmode_texts),
+			twl4030_vibradirmode_texts);
+
+/* Vibra H-bridge direction */
+static const char *twl4030_vibradir_texts[] = {
+	"Positive polarity", "Negative polarity",
+};
+
+static const struct soc_enum twl4030_vibradir_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_VIBRA_CTL, 1,
+			ARRAY_SIZE(twl4030_vibradir_texts),
+			twl4030_vibradir_texts);
+
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	/* Common playback gain controls */
 	SOC_DOUBLE_R_TLV("DAC1 Digital Fine Playback Volume",
@@ -933,6 +978,9 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 		0, 3, 5, 0, input_gain_tlv),
 
 	SOC_ENUM("HS ramp delay", twl4030_rampdelay_enum),
+
+	SOC_ENUM("Vibra H-bridge mode", twl4030_vibradirmode_enum),
+	SOC_ENUM("Vibra H-bridge direction", twl4030_vibradir_enum),
 };
 
 static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
@@ -960,6 +1008,7 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("CARKITR"),
 	SND_SOC_DAPM_OUTPUT("HFL"),
 	SND_SOC_DAPM_OUTPUT("HFR"),
+	SND_SOC_DAPM_OUTPUT("VIBRA"),
 
 	/* DACs */
 	SND_SOC_DAPM_DAC("DAC Right1", "Right Front Playback",
@@ -1060,6 +1109,11 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX_E("HandsfreeR Mux", TWL4030_REG_HFR_CTL, 5, 0,
 		&twl4030_dapm_handsfreer_control, handsfree_event,
 		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
+	/* Vibra */
+	SND_SOC_DAPM_MUX("Vibra Mux", TWL4030_REG_VIBRA_CTL, 0, 0,
+		&twl4030_dapm_vibra_control),
+	SND_SOC_DAPM_MUX("Vibra Route", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_vibrapath_control),
 
 	/* Introducing four virtual ADC, since TWL4030 have four channel for
 	   capture */
@@ -1161,6 +1215,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HandsfreeR Mux", "AudioR1", "ARXR1_APGA"},
 	{"HandsfreeR Mux", "AudioR2", "ARXR2_APGA"},
 	{"HandsfreeR Mux", "AudioL2", "ARXL2_APGA"},
+	/* Vibra */
+	{"Vibra Mux", "AudioL1", "DAC Left1"},
+	{"Vibra Mux", "AudioR1", "DAC Right1"},
+	{"Vibra Mux", "AudioL2", "DAC Left2"},
+	{"Vibra Mux", "AudioR2", "DAC Right2"},
 
 	/* outputs */
 	{"OUTL", NULL, "ARXL2_APGA"},
@@ -1174,6 +1233,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"CARKITR", NULL, "CarkitR Mixer"},
 	{"HFL", NULL, "HandsfreeL Mux"},
 	{"HFR", NULL, "HandsfreeR Mux"},
+	{"Vibra Route", "Audio", "Vibra Mux"},
+	{"VIBRA", NULL, "Vibra Route"},
 
 	/* Capture path */
 	{"Analog Left Capture Route", "Main mic", "MAINMIC"},
-- 
1.6.2.4
