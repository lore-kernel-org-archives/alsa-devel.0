From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Move codec power up to DAPM
Date: Thu, 24 Mar 2011 09:11:49 +0200
Message-ID: <1300950709-13695-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 8788010397B
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 08:11:53 +0100 (CET)
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

Move the codec power on (in reg 0x01, bit 4) from
set_bias_level:SND_SOC_BIAS_ON to a DAPM supply.
In this way we can be sure, that all the things within
the codec is powered before the external amp is
going to be enabled.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 6c3735d..c109f6d 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -587,6 +587,9 @@ static const struct snd_soc_dapm_widget dac33_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("Right DAC Power",
 			    DAC33_RDAC_PWR_CTRL, 2, 0, NULL, 0),
 
+	SND_SOC_DAPM_SUPPLY("Codec Power",
+			    DAC33_PWR_CTRL, 4, 0, NULL, 0),
+
 	SND_SOC_DAPM_PRE("Pre Playback", dac33_playback_event),
 	SND_SOC_DAPM_POST("Post Playback", dac33_playback_event),
 };
@@ -619,6 +622,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	/* output */
 	{"LEFT_LO", NULL, "Output Left Amplifier"},
 	{"RIGHT_LO", NULL, "Output Right Amplifier"},
+
+	{"LEFT_LO", NULL, "Codec Power"},
+	{"RIGHT_LO", NULL, "Codec Power"},
 };
 
 static int dac33_add_widgets(struct snd_soc_codec *codec)
@@ -636,13 +642,10 @@ static int dac33_add_widgets(struct snd_soc_codec *codec)
 static int dac33_set_bias_level(struct snd_soc_codec *codec,
 				enum snd_soc_bias_level level)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		if (!dac33->substream)
-			dac33_soft_power(codec, 1);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
-- 
1.7.4.1
