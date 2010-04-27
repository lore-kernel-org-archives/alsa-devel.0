From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 1/5] ASoC: twl4030 - AIF/APLL clock fix for all
	DAPM routes.
Date: Tue, 27 Apr 2010 15:54:16 +0100
Message-ID: <1272380060-12493-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A0C4024346
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 16:54:39 +0200 (CEST)
Received: by wya21 with SMTP id 21so1472040wya.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 07:54:38 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This allows the AIF and APLL clocks to continue running in
loopback mode and when invalid DAPM routes are selected at
stream runtime.

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/twl4030.c |  123 +++++++++++++++++++++++++++++--------------
 1 files changed, 83 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index dc26b71..1a3e7f6 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -123,7 +123,10 @@ struct twl4030_priv {
 	struct snd_soc_codec codec;
 
 	unsigned int codec_powered;
+
+	/* reference counts of AIF/APLL users */
 	unsigned int apll_enabled;
+	unsigned int aif_enabled;
 
 	struct snd_pcm_substream *master_substream;
 	struct snd_pcm_substream *slave_substream;
@@ -259,22 +262,50 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 static void twl4030_apll_enable(struct snd_soc_codec *codec, int enable)
 {
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
-	int status;
-
-	if (enable == twl4030->apll_enabled)
-		return;
+	int status = -1;
 
+	/* update the user count */
 	if (enable)
+		twl4030->apll_enabled++;
+	else
+		twl4030->apll_enabled--;
+
+	if (enable && twl4030->apll_enabled == 1)
 		/* Enable PLL */
 		status = twl4030_codec_enable_resource(TWL4030_CODEC_RES_APLL);
-	else
+	else if (!enable && twl4030->apll_enabled == 0)
 		/* Disable PLL */
 		status = twl4030_codec_disable_resource(TWL4030_CODEC_RES_APLL);
 
 	if (status >= 0)
 		twl4030_write_reg_cache(codec, TWL4030_REG_APLL_CTL, status);
+}
 
-	twl4030->apll_enabled = enable;
+static void  twl4030_aif_enable(struct snd_soc_codec *codec, int enable)
+{
+	struct twl4030_priv *twl4030 = codec->private_data;
+
+	/* update the user count */
+	if (enable)
+		twl4030->aif_enabled++;
+	else
+		twl4030->aif_enabled--;
+
+	if (enable && twl4030->aif_enabled == 1) {
+		/* Enable AIF */
+		/* enable the PLL before we use it to clock the DAI */
+		twl4030_apll_enable(codec, 1);
+
+		twl4030_write(codec, TWL4030_REG_AUDIO_IF,
+							twl4030_read_reg_cache(codec, TWL4030_REG_AUDIO_IF)
+							| TWL4030_AIF_EN);
+	} else if (!enable && twl4030->aif_enabled == 0) {
+		/* disable the DAI before we stop it's source PLL */
+		twl4030_write(codec, TWL4030_REG_AUDIO_IF,
+							twl4030_read_reg_cache(codec, TWL4030_REG_AUDIO_IF)
+							& ~TWL4030_AIF_EN);
+		twl4030_apll_enable(codec, 0);
+	}
 }
 
 static void twl4030_power_up(struct snd_soc_codec *codec)
@@ -672,6 +703,20 @@ static int apll_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int aif_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		twl4030_aif_enable(w->codec, 1);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		twl4030_aif_enable(w->codec, 0);
+		break;
+	}
+	return 0;
+}
+
 static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 {
 	struct snd_soc_device *socdev = codec->socdev;
@@ -1178,6 +1223,11 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("HFR"),
 	SND_SOC_DAPM_OUTPUT("VIBRA"),
 
+	/* AIF and APLL clocks for running DAIs (including loopback) */
+	SND_SOC_DAPM_OUTPUT("AIF DAC"),
+	SND_SOC_DAPM_INPUT("AIF ADC"),
+	SND_SOC_DAPM_OUTPUT("APLL"),
+
 	/* DACs */
 	SND_SOC_DAPM_DAC("DAC Right1", "Right Front HiFi Playback",
 			SND_SOC_NOPM, 0, 0),
@@ -1215,16 +1265,21 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 			&twl4030_dapm_dbypassv_control),
 
 	/* Digital mixers, power control for the physical DACs */
-	SND_SOC_DAPM_MIXER("Digital R1 Playback Mixer",
-			TWL4030_REG_AVDAC_CTL, 0, 0, NULL, 0),
-	SND_SOC_DAPM_MIXER("Digital L1 Playback Mixer",
-			TWL4030_REG_AVDAC_CTL, 1, 0, NULL, 0),
-	SND_SOC_DAPM_MIXER("Digital R2 Playback Mixer",
-			TWL4030_REG_AVDAC_CTL, 2, 0, NULL, 0),
-	SND_SOC_DAPM_MIXER("Digital L2 Playback Mixer",
-			TWL4030_REG_AVDAC_CTL, 3, 0, NULL, 0),
-	SND_SOC_DAPM_MIXER("Digital Voice Playback Mixer",
-			TWL4030_REG_AVDAC_CTL, 4, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER_E("Digital R1 Playback Mixer",
+			TWL4030_REG_AVDAC_CTL, 0, 0, NULL, 0, aif_event,
+			SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("Digital L1 Playback Mixer",
+			TWL4030_REG_AVDAC_CTL, 1, 0, NULL, 0, aif_event,
+			SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("Digital R2 Playback Mixer",
+			TWL4030_REG_AVDAC_CTL, 2, 0, NULL, 0, aif_event,
+			SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("Digital L2 Playback Mixer",
+			TWL4030_REG_AVDAC_CTL, 3, 0, NULL, 0, aif_event,
+			SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("Digital Voice Playback Mixer",
+			TWL4030_REG_AVDAC_CTL, 4, 0, NULL, 0, apll_event,
+			SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
 
 	/* Analog mixers, power control for the physical PGAs */
 	SND_SOC_DAPM_MIXER("Analog R1 Playback Mixer",
@@ -1238,11 +1293,6 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Analog Voice Playback Mixer",
 			TWL4030_REG_VDL_APGA_CTL, 0, 0, NULL, 0),
 
-	SND_SOC_DAPM_SUPPLY("APLL Enable", SND_SOC_NOPM, 0, 0, apll_event,
-			    SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
-
-	SND_SOC_DAPM_SUPPLY("AIF Enable", TWL4030_REG_AUDIO_IF, 0, 0, NULL, 0),
-
 	/* Output MIXER controls */
 	/* Earpiece */
 	SND_SOC_DAPM_MIXER("Earpiece Mixer", SND_SOC_NOPM, 0, 0,
@@ -1370,17 +1420,14 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Digital R2 Playback Mixer", NULL, "DAC Right2"},
 	{"Digital Voice Playback Mixer", NULL, "DAC Voice"},
 
-	/* Supply for the digital part (APLL) */
-	{"Digital R1 Playback Mixer", NULL, "APLL Enable"},
-	{"Digital L1 Playback Mixer", NULL, "APLL Enable"},
-	{"Digital R2 Playback Mixer", NULL, "APLL Enable"},
-	{"Digital L2 Playback Mixer", NULL, "APLL Enable"},
-	{"Digital Voice Playback Mixer", NULL, "APLL Enable"},
+	/* Route for the digital part (APLL) */
+	{"APLL", NULL, "Digital Voice Playback Mixer"},
 
-	{"Digital R1 Playback Mixer", NULL, "AIF Enable"},
-	{"Digital L1 Playback Mixer", NULL, "AIF Enable"},
-	{"Digital R2 Playback Mixer", NULL, "AIF Enable"},
-	{"Digital L2 Playback Mixer", NULL, "AIF Enable"},
+	/* Route for digital part (AIF) */
+	{"AIF DAC", NULL, "Digital L1 Playback Mixer"},
+	{"AIF DAC", NULL, "Digital R1 Playback Mixer"},
+	{"AIF DAC", NULL, "Digital L2 Playback Mixer"},
+	{"AIF DAC", NULL, "Digital R2 Playback Mixer"},
 
 	{"Analog L1 Playback Mixer", NULL, "Digital L1 Playback Mixer"},
 	{"Analog R1 Playback Mixer", NULL, "Digital R1 Playback Mixer"},
@@ -1493,15 +1540,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"ADC Virtual Left2", NULL, "TX2 Capture Route"},
 	{"ADC Virtual Right2", NULL, "TX2 Capture Route"},
 
-	{"ADC Virtual Left1", NULL, "APLL Enable"},
-	{"ADC Virtual Right1", NULL, "APLL Enable"},
-	{"ADC Virtual Left2", NULL, "APLL Enable"},
-	{"ADC Virtual Right2", NULL, "APLL Enable"},
-
-	{"ADC Virtual Left1", NULL, "AIF Enable"},
-	{"ADC Virtual Right1", NULL, "AIF Enable"},
-	{"ADC Virtual Left2", NULL, "AIF Enable"},
-	{"ADC Virtual Right2", NULL, "AIF Enable"},
+	/* Route for digital part AIF */
+	{"ADC Virtual Left1", NULL, "AIF ADC"},
+	{"ADC Virtual Right1", NULL, "AIF ADC"},
+	{"ADC Virtual Left2", NULL, "AIF ADC"},
+	{"ADC Virtual Right2", NULL, "AIF ADC"},
 
 	/* Analog bypass routes */
 	{"Right1 Analog Loopback", "Switch", "Analog Right"},
-- 
1.6.3.3
