From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 2/2] ASoC: tlv320dac33: Move DAC LR power on
	to a supply widget
Date: Wed,  8 Dec 2010 16:04:33 +0200
Message-ID: <1291817073-27599-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1291817073-27599-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 724F2103C39
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 15:04:40 +0100 (CET)
In-Reply-To: <1291817073-27599-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The power for the DACs need to be enabled, even when only
the analog bypass is in use with the codec, otherwise
the audio is going to be distorted.
Make sure that the DACs are powered all the time, when
there is audio activity.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 8e340a5..b3445b3 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -590,8 +590,8 @@ static const struct snd_soc_dapm_widget dac33_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("LINEL"),
 	SND_SOC_DAPM_INPUT("LINER"),
 
-	SND_SOC_DAPM_DAC("DACL", "Left Playback", DAC33_LDAC_PWR_CTRL, 2, 0),
-	SND_SOC_DAPM_DAC("DACR", "Right Playback", DAC33_RDAC_PWR_CTRL, 2, 0),
+	SND_SOC_DAPM_DAC("DACL", "Left Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DACR", "Right Playback", SND_SOC_NOPM, 0, 0),
 
 	/* Analog bypass */
 	SND_SOC_DAPM_SWITCH("Analog Left Bypass", SND_SOC_NOPM, 0, 0,
@@ -604,6 +604,11 @@ static const struct snd_soc_dapm_widget dac33_dapm_widgets[] = {
 	SND_SOC_DAPM_REG(snd_soc_dapm_mixer, "Output Right Amplifier",
 			 DAC33_OUT_AMP_PWR_CTRL, 4, 3, 3, 0),
 
+	SND_SOC_DAPM_SUPPLY("Left DAC Power",
+			    DAC33_LDAC_PWR_CTRL, 2, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Right DAC Power",
+			    DAC33_RDAC_PWR_CTRL, 2, 0, NULL, 0),
+
 	SND_SOC_DAPM_PRE("Prepare Playback", playback_event),
 };
 
@@ -618,6 +623,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Output Left Amplifier", NULL, "Analog Left Bypass"},
 	{"Output Right Amplifier", NULL, "Analog Right Bypass"},
 
+	{"Output Left Amplifier", NULL, "Left DAC Power"},
+	{"Output Right Amplifier", NULL, "Right DAC Power"},
+
 	/* output */
 	{"LEFT_LO", NULL, "Output Left Amplifier"},
 	{"RIGHT_LO", NULL, "Output Right Amplifier"},
-- 
1.7.3.2
