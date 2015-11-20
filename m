From: Raphael Poggi <poggi.raph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] sound: codecs: pcm1792a: clean function exit
Date: Fri, 20 Nov 2015 11:09:14 +0100
Message-ID: <1448014157-36526-2-git-send-email-raphael.poggi@avalun.com>
References: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448014157-36526-1-git-send-email-raphael.poggi-jXdF5569nj7QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Raphael Poggi <poggi.raph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Raphael Poggi <poggi.raph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Raphael Poggi <poggi.raph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/codecs/pcm1792a.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
index 08bb486..cf42b24 100644
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
@@ -107,7 +102,8 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
-	int val = 0, ret;
+	int val = 0;
+	int ret = 0;
 
 	priv->rate = params_rate(params);
 
@@ -147,10 +143,8 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
 
 	ret = regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTROL,
 				 PCM1792A_FMT_MASK | PCM1792A_ATLD_ENABLE, val);
-	if (ret < 0)
-		return ret;
 
-	return 0;
+	return ret;
 }
 
 static const struct snd_soc_dai_ops pcm1792a_dai_ops = {
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
