From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: TWL4030: Change APLL powering
	sequence
Date: Thu, 29 Oct 2009 11:58:10 +0200
Message-ID: <1256810290-20478-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1256810290-20478-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256810290-20478-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id EC05624658
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 10:58:29 +0100 (CET)
In-Reply-To: <1256810290-20478-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, ext-jari.vanhala@nokia.com
List-Id: alsa-devel@alsa-project.org

It seams that certain part of the twl4030 codec needs the APLL
enabled before they are enabled.
Paths which has any digital processing needs need the APLL
enabled before they can function.
For example the vibra output will have some random data after
it is enabled and before the APLL also enabled.

If only analog components are in use (analog bypass), than it
seams, that the APLL does not need to be enabled. This lowers
the power consumption with around ~0.005A.

Adding DAPM_SUPPLY to the Digital playback route and also
to the capture route to enable and disable the APLL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index ccaeb36..277e99c 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -620,6 +620,20 @@ static int vibramux_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int apll_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		twl4030_apll_enable(w->codec, 1);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		twl4030_apll_enable(w->codec, 0);
+		break;
+	}
+	return 0;
+}
+
 static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 {
 	struct snd_soc_device *socdev = codec->socdev;
@@ -1185,6 +1199,9 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Analog Voice Playback Mixer",
 			TWL4030_REG_VDL_APGA_CTL, 0, 0, NULL, 0),
 
+	SND_SOC_DAPM_SUPPLY("APLL Enable", SND_SOC_NOPM, 0, 0, apll_event,
+			    SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
+
 	/* Output MIXER controls */
 	/* Earpiece */
 	SND_SOC_DAPM_MIXER("Earpiece Mixer", SND_SOC_NOPM, 0, 0,
@@ -1312,6 +1329,13 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Digital R2 Playback Mixer", NULL, "DAC Right2"},
 	{"Digital Voice Playback Mixer", NULL, "DAC Voice"},
 
+	/* Supply for the digital part (APLL) */
+	{"Digital R1 Playback Mixer", NULL, "APLL Enable"},
+	{"Digital L1 Playback Mixer", NULL, "APLL Enable"},
+	{"Digital R2 Playback Mixer", NULL, "APLL Enable"},
+	{"Digital L2 Playback Mixer", NULL, "APLL Enable"},
+	{"Digital Voice Playback Mixer", NULL, "APLL Enable"},
+
 	{"Analog L1 Playback Mixer", NULL, "Digital L1 Playback Mixer"},
 	{"Analog R1 Playback Mixer", NULL, "Digital R1 Playback Mixer"},
 	{"Analog L2 Playback Mixer", NULL, "Digital L2 Playback Mixer"},
@@ -1472,14 +1496,12 @@ static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 {
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		twl4030_apll_enable(codec, 1);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF)
 			twl4030_power_up(codec);
-		twl4030_apll_enable(codec, 0);
 		break;
 	case SND_SOC_BIAS_OFF:
 		twl4030_power_down(codec);
-- 
1.6.5.1
