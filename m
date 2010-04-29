From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv3 1/2] ASoC: TWL4030: AIF/APLL fix in DAPM
	domain
Date: Thu, 29 Apr 2010 10:58:08 +0300
Message-ID: <1272527889-22447-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1272527889-22447-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id B106724335
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 09:58:20 +0200 (CEST)
In-Reply-To: <1272527889-22447-1-git-send-email-peter.ujfalusi@nokia.com>
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
case of HiFi (audio in TWL4030 terms) playback/capture.

We also need to make sure that the AIF is running during
playback/capture, when there is no valid DAPM route
available. For this purpose I introduce these virtual
widgets:
/* To have complete playback route all the time */
DAPM_OUTPUT("Virtual HiFi OUT") /* Will keep AIF/APLL enabled */

/* To have complete capture route all the time */
DAPM_INPUT("Virtual HiFi IN") /* Will keep AIF/APLL enabled */

/* To have complete playback route for the voice module */
DAPM_OUTPUT("Virtual Voice OUT") /* Will keep APLL enabled */

The DAPM_SUPPLY widgets for APLL and AIF are placed in a way,
that during any audio activity the needed configuration of AIF
and APLL will be enabled (playback, capture, analog loopback,
digital loopback, and voice activity).

The apll reference counting code has been lifted,
and modified from Liam Girdwood's earlier patch.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   82 ++++++++++++++++++++++++++++++++------------
 1 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 2e025a3..12931f6 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -123,6 +123,8 @@ struct twl4030_priv {
 	struct snd_soc_codec codec;
 
 	unsigned int codec_powered;
+
+	/* reference counts of AIF/APLL users */
 	unsigned int apll_enabled;
 
 	struct snd_pcm_substream *master_substream;
@@ -259,22 +261,22 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 static void twl4030_apll_enable(struct snd_soc_codec *codec, int enable)
 {
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
-	int status;
-
-	if (enable == twl4030->apll_enabled)
-		return;
+	int status = -1;
 
-	if (enable)
-		/* Enable PLL */
-		status = twl4030_codec_enable_resource(TWL4030_CODEC_RES_APLL);
-	else
-		/* Disable PLL */
-		status = twl4030_codec_disable_resource(TWL4030_CODEC_RES_APLL);
+	if (enable) {
+		twl4030->apll_enabled++;
+		if (twl4030->apll_enabled == 1)
+			status = twl4030_codec_enable_resource(
+							TWL4030_CODEC_RES_APLL);
+	} else {
+		twl4030->apll_enabled--;
+		if (!twl4030->apll_enabled)
+			status = twl4030_codec_disable_resource(
+							TWL4030_CODEC_RES_APLL);
+	}
 
 	if (status >= 0)
 		twl4030_write_reg_cache(codec, TWL4030_REG_APLL_CTL, status);
-
-	twl4030->apll_enabled = enable;
 }
 
 static void twl4030_power_up(struct snd_soc_codec *codec)
@@ -672,6 +674,31 @@ static int apll_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int aif_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	u8 audio_if;
+
+	audio_if = twl4030_read_reg_cache(w->codec, TWL4030_REG_AUDIO_IF);
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Enable AIF */
+		/* enable the PLL before we use it to clock the DAI */
+		twl4030_apll_enable(w->codec, 1);
+
+		twl4030_write(w->codec, TWL4030_REG_AUDIO_IF,
+						audio_if | TWL4030_AIF_EN);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* disable the DAI before we stop it's source PLL */
+		twl4030_write(w->codec, TWL4030_REG_AUDIO_IF,
+						audio_if &  ~TWL4030_AIF_EN);
+		twl4030_apll_enable(w->codec, 0);
+		break;
+	}
+	return 0;
+}
+
 static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 {
 	struct snd_soc_device *socdev = codec->socdev;
@@ -1180,6 +1207,11 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("HFR"),
 	SND_SOC_DAPM_OUTPUT("VIBRA"),
 
+	/* AIF and APLL clocks for running DAIs (including loopback) */
+	SND_SOC_DAPM_OUTPUT("Virtual HiFi OUT"),
+	SND_SOC_DAPM_INPUT("Virtual HiFi IN"),
+	SND_SOC_DAPM_OUTPUT("Virtual Voice OUT"),
+
 	/* DACs */
 	SND_SOC_DAPM_DAC("DAC Right1", "Right Front HiFi Playback",
 			SND_SOC_NOPM, 0, 0),
@@ -1243,7 +1275,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("APLL Enable", SND_SOC_NOPM, 0, 0, apll_event,
 			    SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
 
-	SND_SOC_DAPM_SUPPLY("AIF Enable", TWL4030_REG_AUDIO_IF, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("AIF Enable", SND_SOC_NOPM, 0, 0, aif_event,
+			    SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
 
 	/* Output MIXER controls */
 	/* Earpiece */
@@ -1373,10 +1406,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Digital Voice Playback Mixer", NULL, "DAC Voice"},
 
 	/* Supply for the digital part (APLL) */
-	{"Digital R1 Playback Mixer", NULL, "APLL Enable"},
-	{"Digital L1 Playback Mixer", NULL, "APLL Enable"},
-	{"Digital R2 Playback Mixer", NULL, "APLL Enable"},
-	{"Digital L2 Playback Mixer", NULL, "APLL Enable"},
 	{"Digital Voice Playback Mixer", NULL, "APLL Enable"},
 
 	{"Digital R1 Playback Mixer", NULL, "AIF Enable"},
@@ -1450,6 +1479,14 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Vibra Mux", "AudioR2", "DAC Right2"},
 
 	/* outputs */
+	/* Must be always connected (for AIF and APLL) */
+	{"Virtual HiFi OUT", NULL, "Digital L1 Playback Mixer"},
+	{"Virtual HiFi OUT", NULL, "Digital R1 Playback Mixer"},
+	{"Virtual HiFi OUT", NULL, "Digital L2 Playback Mixer"},
+	{"Virtual HiFi OUT", NULL, "Digital R2 Playback Mixer"},
+	/* Must be always connected (for APLL) */
+	{"Virtual Voice OUT", NULL, "Digital Voice Playback Mixer"},
+	/* Physical outputs */
 	{"OUTL", NULL, "Analog L2 Playback Mixer"},
 	{"OUTR", NULL, "Analog R2 Playback Mixer"},
 	{"EARPIECE", NULL, "Earpiece PGA"},
@@ -1465,6 +1502,12 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"VIBRA", NULL, "Vibra Route"},
 
 	/* Capture path */
+	/* Must be always connected (for AIF and APLL) */
+	{"ADC Virtual Left1", NULL, "Virtual HiFi IN"},
+	{"ADC Virtual Right1", NULL, "Virtual HiFi IN"},
+	{"ADC Virtual Left2", NULL, "Virtual HiFi IN"},
+	{"ADC Virtual Right2", NULL, "Virtual HiFi IN"},
+	/* Physical inputs */
 	{"Analog Left", "Main Mic Capture Switch", "MAINMIC"},
 	{"Analog Left", "Headset Mic Capture Switch", "HSMIC"},
 	{"Analog Left", "AUXL Capture Switch", "AUXL"},
@@ -1497,11 +1540,6 @@ static const struct snd_soc_dapm_route intercon[] = {
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
