From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/29] ASoC: arizona: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Tue, 13 Jan 2015 10:27:07 +0100
Message-ID: <1421141255-21477-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FFDD26153D
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 10:27:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/arizona.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 9550d74..65977bc 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -84,7 +84,7 @@ static int arizona_spk_ev(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *kcontrol,
 			  int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	bool manual_ena = false;
@@ -692,7 +692,8 @@ static void arizona_in_set_vu(struct snd_soc_codec *codec, int ena)
 int arizona_in_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
 		  int event)
 {
-	struct arizona_priv *priv = snd_soc_codec_get_drvdata(w->codec);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	unsigned int reg;
 
 	if (w->shift % 2)
@@ -705,25 +706,25 @@ int arizona_in_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
 		priv->in_pending++;
 		break;
 	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_update_bits(w->codec, reg, ARIZONA_IN1L_MUTE, 0);
+		snd_soc_update_bits(codec, reg, ARIZONA_IN1L_MUTE, 0);
 
 		/* If this is the last input pending then allow VU */
 		priv->in_pending--;
 		if (priv->in_pending == 0) {
 			msleep(1);
-			arizona_in_set_vu(w->codec, 1);
+			arizona_in_set_vu(codec, 1);
 		}
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(w->codec, reg,
+		snd_soc_update_bits(codec, reg,
 				    ARIZONA_IN1L_MUTE | ARIZONA_IN_VU,
 				    ARIZONA_IN1L_MUTE | ARIZONA_IN_VU);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		/* Disable volume updates if no inputs are enabled */
-		reg = snd_soc_read(w->codec, ARIZONA_INPUT_ENABLES);
+		reg = snd_soc_read(codec, ARIZONA_INPUT_ENABLES);
 		if (reg == 0)
-			arizona_in_set_vu(w->codec, 0);
+			arizona_in_set_vu(codec, 0);
 	}
 
 	return 0;
@@ -760,7 +761,8 @@ int arizona_hp_ev(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol,
 		   int event)
 {
-	struct arizona_priv *priv = snd_soc_codec_get_drvdata(w->codec);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona *arizona = priv->arizona;
 	unsigned int mask = 1 << w->shift;
 	unsigned int val;
-- 
1.8.0
