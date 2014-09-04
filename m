From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/9] ASoC: adau1373: Cleanup manual bias level
	transitions
Date: Thu,  4 Sep 2014 19:44:08 +0200
Message-ID: <1409852652-27939-6-git-send-email-lars@metafoo.de>
References: <1409852652-27939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 374342656DF
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

The ASoC core now takes care of setting the bias level to SND_SOC_BIAS_OFF
when removing the CODEC, no need to do it manually anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1373.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 1947565..7c784ad 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1448,12 +1448,6 @@ static int adau1373_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int adau1373_remove(struct snd_soc_codec *codec)
-{
-	adau1373_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static int adau1373_resume(struct snd_soc_codec *codec)
 {
 	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
@@ -1488,7 +1482,6 @@ static const struct regmap_config adau1373_regmap_config = {
 
 static struct snd_soc_codec_driver adau1373_codec_driver = {
 	.probe =	adau1373_probe,
-	.remove =	adau1373_remove,
 	.resume =	adau1373_resume,
 	.set_bias_level = adau1373_set_bias_level,
 	.idle_bias_off = true,
-- 
1.8.0
