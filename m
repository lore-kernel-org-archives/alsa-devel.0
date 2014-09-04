From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 9/9] ASoC: ssm2602: Cleanup manual bias level
	transitions
Date: Thu,  4 Sep 2014 19:44:12 +0200
Message-ID: <1409852652-27939-10-git-send-email-lars@metafoo.de>
References: <1409852652-27939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C3062656E8
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 19:44:43 +0200 (CEST)
In-Reply-To: <1409852652-27939-1-git-send-email-lars@metafoo.de>
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

Set the CODEC driver's suspend_bias_off flag rather than manually going to
SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
the code a bit shorter and cleaner. While we are at it also remove the
regcache_cache_only() calls from suspend/resume as there shouldn't be any IO
between suspend and resume.

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 484b3bb..0dec1364 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -502,18 +502,11 @@ static struct snd_soc_dai_driver ssm2602_dai = {
 	.symmetric_samplebits = 1,
 };
 
-static int ssm2602_suspend(struct snd_soc_codec *codec)
-{
-	ssm2602_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static int ssm2602_resume(struct snd_soc_codec *codec)
 {
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 
 	regcache_sync(ssm2602->regmap);
-	ssm2602_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
@@ -586,27 +579,14 @@ static int ssm260x_codec_probe(struct snd_soc_codec *codec)
 		break;
 	}
 
-	if (ret)
-		return ret;
-
-	ssm2602_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
-/* remove everything here */
-static int ssm2602_remove(struct snd_soc_codec *codec)
-{
-	ssm2602_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
+	return ret;
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
 	.probe =	ssm260x_codec_probe,
-	.remove =	ssm2602_remove,
-	.suspend =	ssm2602_suspend,
 	.resume =	ssm2602_resume,
 	.set_bias_level = ssm2602_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls = ssm260x_snd_controls,
 	.num_controls = ARRAY_SIZE(ssm260x_snd_controls),
-- 
1.8.0
