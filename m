From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ssm2602: Fix cache sync
Date: Sat, 31 Aug 2013 18:15:23 +0200
Message-ID: <1377965723-2812-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DABF261AE5
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 18:13:58 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The ssm2602 uses regmap for caching not soc-cache, so we need to use
regcache_sync() instead of snd_soc_cache_sync().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index f8d30e5..492644e 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -561,8 +561,9 @@ static int ssm2602_suspend(struct snd_soc_codec *codec)
 
 static int ssm2602_resume(struct snd_soc_codec *codec)
 {
-	snd_soc_cache_sync(codec);
+	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 
+	regcache_sync(ssm2602->regmap);
 	ssm2602_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
-- 
1.8.0
