From: Raphael Poggi <poggi.raph@gmail.com>
Subject: [PATCH] sound: codecs: pcm1792x: clean function exit
Date: Thu, 14 Jan 2016 10:00:28 +0100
Message-ID: <1452762028-43931-1-git-send-email-poggi.raph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ECBC260511
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 10:00:49 +0100 (CET)
Received: by mail-wm0-f54.google.com with SMTP id f206so333565812wmf.0
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 01:00:49 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, michael@amarulasolutions.com, Raphael Poggi <poggi.raph@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Raphael Poggi <poggi.raph@gmail.com>
---
 sound/soc/codecs/pcm179x.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index a56c7b7..e04d13c 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -91,14 +91,9 @@ static int pcm179x_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
-	int ret;
 
-	ret = regmap_update_bits(priv->regmap, PCM179X_SOFT_MUTE,
+	return regmap_update_bits(priv->regmap, PCM179X_SOFT_MUTE,
 				 PCM179X_MUTE_MASK, !!mute);
-	if (ret < 0)
-		return ret;
-
-	return 0;
 }
 
 static int pcm179x_hw_params(struct snd_pcm_substream *substream,
@@ -107,7 +102,7 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
-	int val = 0, ret;
+	int val = 0;
 
 	priv->rate = params_rate(params);
 
@@ -145,12 +140,8 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
 
 	val = val << PCM179X_FMT_SHIFT | PCM179X_ATLD_ENABLE;
 
-	ret = regmap_update_bits(priv->regmap, PCM179X_FMT_CONTROL,
+	return regmap_update_bits(priv->regmap, PCM179X_FMT_CONTROL,
 				 PCM179X_FMT_MASK | PCM179X_ATLD_ENABLE, val);
-	if (ret < 0)
-		return ret;
-
-	return 0;
 }
 
 static const struct snd_soc_dai_ops pcm179x_dai_ops = {
-- 
2.1.0
