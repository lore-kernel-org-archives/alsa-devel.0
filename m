From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/9] ASoC: adav80x: Cleanup manual bias level
	transitions
Date: Thu,  4 Sep 2014 19:44:10 +0200
Message-ID: <1409852652-27939-8-git-send-email-lars@metafoo.de>
References: <1409852652-27939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 34AE92656DE
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
 sound/soc/codecs/adav80x.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index c43b93f..ce3cdca 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -812,42 +812,23 @@ static int adav80x_probe(struct snd_soc_codec *codec)
 	/* Disable DAC zero flag */
 	regmap_write(adav80x->regmap, ADAV80X_DAC_CTRL3, 0x6);
 
-	return adav80x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-}
-
-static int adav80x_suspend(struct snd_soc_codec *codec)
-{
-	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	ret = adav80x_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	regcache_cache_only(adav80x->regmap, true);
-
-	return ret;
+	return 0;
 }
 
 static int adav80x_resume(struct snd_soc_codec *codec)
 {
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 
-	regcache_cache_only(adav80x->regmap, false);
-	adav80x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	regcache_sync(adav80x->regmap);
 
 	return 0;
 }
 
-static int adav80x_remove(struct snd_soc_codec *codec)
-{
-	return adav80x_set_bias_level(codec, SND_SOC_BIAS_OFF);
-}
-
 static struct snd_soc_codec_driver adav80x_codec_driver = {
 	.probe = adav80x_probe,
-	.remove = adav80x_remove,
-	.suspend = adav80x_suspend,
 	.resume = adav80x_resume,
 	.set_bias_level = adav80x_set_bias_level,
+	.suspend_bias_off = true,
 
 	.set_pll = adav80x_set_pll,
 	.set_sysclk = adav80x_set_sysclk,
-- 
1.8.0
