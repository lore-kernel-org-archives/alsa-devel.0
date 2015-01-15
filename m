From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/17] ASoC: tlv320aic31xx: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 15 Jan 2015 12:52:03 +0100
Message-ID: <1421322737-19077-4-git-send-email-lars@metafoo.de>
References: <1421322737-19077-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FEEA26055E
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:52:23 +0100 (CET)
In-Reply-To: <1421322737-19077-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/tlv320aic31xx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index dc3223d..c86dd9a 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -349,7 +349,8 @@ static int aic31xx_wait_bits(struct aic31xx_priv *aic31xx, unsigned int reg,
 static int aic31xx_dapm_power_event(struct snd_soc_dapm_widget *w,
 				    struct snd_kcontrol *kcontrol, int event)
 {
-	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(w->codec);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 	unsigned int reg = AIC31XX_DACFLAG1;
 	unsigned int mask;
 
@@ -377,7 +378,7 @@ static int aic31xx_dapm_power_event(struct snd_soc_dapm_widget *w,
 		reg = AIC31XX_ADCFLAG;
 		break;
 	default:
-		dev_err(w->codec->dev, "Unknown widget '%s' calling %s\n",
+		dev_err(codec->dev, "Unknown widget '%s' calling %s\n",
 			w->name, __func__);
 		return -EINVAL;
 	}
@@ -388,7 +389,7 @@ static int aic31xx_dapm_power_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMD:
 		return aic31xx_wait_bits(aic31xx, reg, mask, 0, 5000, 100);
 	default:
-		dev_dbg(w->codec->dev,
+		dev_dbg(codec->dev,
 			"Unhandled dapm widget event %d from %s\n",
 			event, w->name);
 	}
@@ -433,7 +434,7 @@ static const struct snd_kcontrol_new aic31xx_dapm_spr_switch =
 static int mic_bias_event(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
-- 
1.8.0
