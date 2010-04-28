From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: TWL4030: AIF/APLL fix in DAPM domain
Date: Wed, 28 Apr 2010 14:00:24 +0300
Message-ID: <1272452424-12746-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CE00244E9
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 13:00:38 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch orders the APLL and AIF power sequence in
case of HiFi (audio in TWL4030 terms) playback.

We also need to make sure that the AIF is running during
playback/capture, when there is no valid DAPM route
available.

The apll and aif reference counting code has been lifted,
and reused from Liam Girdwood's earlier patch.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

Some of the ideas (appl, aif refcounting) has been taken from Liam's patch:
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-April/027217.html

But I'm reusing the existing DAPM_SUPPLY widgets to handle the APLL
and AIF enable.

I have tested all possible scenarios, and the codec behaved correctly.
The voice path was not verified due to missing HW, but that part has not been
changed, so I expect no regressions related to that.

 sound/soc/codecs/twl4030.c |   91 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 71 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 2e025a3..816a995 100644
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
@@ -259,22 +262,49 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 static void twl4030_apll_enable(struct snd_soc_codec *codec, int enable)
 {
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
-	int status;
-
-	if (enable == twl4030->apll_enabled)
-		return;
+	int status = -1;
 
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
+static void twl4030_aif_enable(struct snd_soc_codec *codec, int enable)
+{
+	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
+	u8 audio_if;
+
+	/* update the user count */
+	if (enable)
+		twl4030->aif_enabled++;
+	else
+		twl4030->aif_enabled--;
+
+	audio_if = twl4030_read_reg_cache(codec, TWL4030_REG_AUDIO_IF);
+	if (enable && twl4030->aif_enabled == 1) {
+		/* Enable AIF */
+		/* enable the PLL before we use it to clock the DAI */
+		twl4030_apll_enable(codec, 1);
+
+		twl4030_write(codec, TWL4030_REG_AUDIO_IF,
+						audio_if | TWL4030_AIF_EN);
+	} else if (!enable && twl4030->aif_enabled == 0) {
+		/* disable the DAI before we stop it's source PLL */
+		twl4030_write(codec, TWL4030_REG_AUDIO_IF,
+						audio_if &  ~TWL4030_AIF_EN);
+		twl4030_apll_enable(codec, 0);
+	}
 }
 
 static void twl4030_power_up(struct snd_soc_codec *codec)
@@ -672,6 +702,20 @@ static int apll_event(struct snd_soc_dapm_widget *w,
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
@@ -1167,8 +1211,6 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("DIGIMIC1"),
 
 	/* Outputs */
-	SND_SOC_DAPM_OUTPUT("OUTL"),
-	SND_SOC_DAPM_OUTPUT("OUTR"),
 	SND_SOC_DAPM_OUTPUT("EARPIECE"),
 	SND_SOC_DAPM_OUTPUT("PREDRIVEL"),
 	SND_SOC_DAPM_OUTPUT("PREDRIVER"),
@@ -1180,6 +1222,11 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
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
@@ -1243,7 +1290,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("APLL Enable", SND_SOC_NOPM, 0, 0, apll_event,
 			    SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
 
-	SND_SOC_DAPM_SUPPLY("AIF Enable", TWL4030_REG_AUDIO_IF, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("AIF Enable", SND_SOC_NOPM, 0, 0, aif_event,
+			    SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
 
 	/* Output MIXER controls */
 	/* Earpiece */
@@ -1373,10 +1421,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Digital Voice Playback Mixer", NULL, "DAC Voice"},
 
 	/* Supply for the digital part (APLL) */
-	{"Digital R1 Playback Mixer", NULL, "APLL Enable"},
-	{"Digital L1 Playback Mixer", NULL, "APLL Enable"},
-	{"Digital R2 Playback Mixer", NULL, "APLL Enable"},
-	{"Digital L2 Playback Mixer", NULL, "APLL Enable"},
 	{"Digital Voice Playback Mixer", NULL, "APLL Enable"},
 
 	{"Digital R1 Playback Mixer", NULL, "AIF Enable"},
@@ -1450,8 +1494,14 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Vibra Mux", "AudioR2", "DAC Right2"},
 
 	/* outputs */
-	{"OUTL", NULL, "Analog L2 Playback Mixer"},
-	{"OUTR", NULL, "Analog R2 Playback Mixer"},
+	/* Must be always connected (for AIF and APLL) */
+	{"AIF DAC", NULL, "Digital L1 Playback Mixer"},
+	{"AIF DAC", NULL, "Digital R1 Playback Mixer"},
+	{"AIF DAC", NULL, "Digital L2 Playback Mixer"},
+	{"AIF DAC", NULL, "Digital R2 Playback Mixer"},
+	/* Must be always connected (for APLL) */
+	{"APLL", NULL, "Digital Voice Playback Mixer"},
+	/* Physical outputs */
 	{"EARPIECE", NULL, "Earpiece PGA"},
 	{"PREDRIVEL", NULL, "PredriveL PGA"},
 	{"PREDRIVER", NULL, "PredriveR PGA"},
@@ -1465,6 +1515,12 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"VIBRA", NULL, "Vibra Route"},
 
 	/* Capture path */
+	/* Must be always connected (for AIF and APLL) */
+	{"ADC Virtual Left1", NULL, "AIF ADC"},
+	{"ADC Virtual Right1", NULL, "AIF ADC"},
+	{"ADC Virtual Left2", NULL, "AIF ADC"},
+	{"ADC Virtual Right2", NULL, "AIF ADC"},
+	/* Physical inputs */
 	{"Analog Left", "Main Mic Capture Switch", "MAINMIC"},
 	{"Analog Left", "Headset Mic Capture Switch", "HSMIC"},
 	{"Analog Left", "AUXL Capture Switch", "AUXL"},
@@ -1497,11 +1553,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"ADC Virtual Left2", NULL, "TX2 Capture Route"},
 	{"ADC Virtual Right2", NULL, "TX2 Capture Route"},
 
-	{"ADC Virtual Left1", NULL, "APLL Enable"},
-	{"ADC Virtual Right1", NULL, "APLL Enable"},
-	{"ADC Virtual Left2", NULL, "APLL Enable"},
-	{"ADC Virtual Right2", NULL, "APLL Enable"},
-
 	{"ADC Virtual Left1", NULL, "AIF Enable"},
 	{"ADC Virtual Right1", NULL, "AIF Enable"},
 	{"ADC Virtual Left2", NULL, "AIF Enable"},
-- 
1.7.0.4
