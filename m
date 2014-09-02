From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] ASoC: adau1373: Remove unnecessary
	suspend/resume bias level changes
Date: Tue,  2 Sep 2014 22:20:30 +0200
Message-ID: <1409689234-14774-2-git-send-email-lars@metafoo.de>
References: <1409689234-14774-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id F2AE42654BF
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 22:20:41 +0200 (CEST)
In-Reply-To: <1409689234-14774-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The ASoC core will only call the suspend/resume callbacks when the device's
DAPM context is idle. Since this driver sets idle_bias_off to true this
means that the device is already in SND_SOC_BIAS_OFF when the suspend
callback is called, so there is no need to manually set this state again.
There is also no need to go to SND_SOC_BIAS_STANDBY in the resume callback
since the core will go right back to SND_SOC_BIAS_OFF.

Also drop the regcache_cache_only() calls from the suspend and resume
handlers. There shouldn't be any IO happening after suspend and before
resume.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1373.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 1ff7d4d..1947565 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1454,23 +1454,10 @@ static int adau1373_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int adau1373_suspend(struct snd_soc_codec *codec)
-{
-	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	ret = adau1373_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	regcache_cache_only(adau1373->regmap, true);
-
-	return ret;
-}
-
 static int adau1373_resume(struct snd_soc_codec *codec)
 {
 	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
 
-	regcache_cache_only(adau1373->regmap, false);
-	adau1373_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	regcache_sync(adau1373->regmap);
 
 	return 0;
@@ -1502,7 +1489,6 @@ static const struct regmap_config adau1373_regmap_config = {
 static struct snd_soc_codec_driver adau1373_codec_driver = {
 	.probe =	adau1373_probe,
 	.remove =	adau1373_remove,
-	.suspend =	adau1373_suspend,
 	.resume =	adau1373_resume,
 	.set_bias_level = adau1373_set_bias_level,
 	.idle_bias_off = true,
-- 
1.8.0
