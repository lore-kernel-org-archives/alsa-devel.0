From: Raphael Poggi <poggi.raph@gmail.com>
Subject: [PATCH v2] sound: codecs: pcm1792a: clean function exit
Date: Wed, 25 Nov 2015 09:10:09 +0100
Message-ID: <1448439009-9778-1-git-send-email-poggi.raph@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: michael@amarulasolutions.com, perex@perex.cz, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Raphael Poggi <poggi.raph@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Raphael Poggi <poggi.raph@gmail.com>
---
 sound/soc/codecs/pcm1792a.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
index 08bb486..27d54bc 100644
--- a/sound/soc/codecs/pcm1792a.c
+++ b/sound/soc/codecs/pcm1792a.c
@@ -91,14 +91,9 @@ static int pcm1792a_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
-	int ret;
 
-	ret = regmap_update_bits(priv->regmap, PCM1792A_SOFT_MUTE,
+	return regmap_update_bits(priv->regmap, PCM1792A_SOFT_MUTE,
 				 PCM1792A_MUTE_MASK, !!mute);
-	if (ret < 0)
-		return ret;
-
-	return 0;
 }
 
 static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
@@ -107,7 +102,7 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
-	int val = 0, ret;
+	int val = 0;
 
 	priv->rate = params_rate(params);
 
@@ -145,12 +140,8 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
 
 	val = val << PCM1792A_FMT_SHIFT | PCM1792A_ATLD_ENABLE;
 
-	ret = regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTROL,
+	return regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTROL,
 				 PCM1792A_FMT_MASK | PCM1792A_ATLD_ENABLE, val);
-	if (ret < 0)
-		return ret;
-
-	return 0;
 }
 
 static const struct snd_soc_dai_ops pcm1792a_dai_ops = {
-- 
2.1.0
