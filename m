From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/9] ASoC: adau17x1: Cleanup manual bias level
	transitions
Date: Thu,  4 Sep 2014 19:44:09 +0200
Message-ID: <1409852652-27939-7-git-send-email-lars@metafoo.de>
References: <1409852652-27939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 39DF62656E2
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
the code a bit shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1761.c | 2 +-
 sound/soc/codecs/adau1781.c | 2 +-
 sound/soc/codecs/adau17x1.c | 8 --------
 sound/soc/codecs/adau17x1.h | 1 -
 4 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 848cab8..5518ebd 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -714,9 +714,9 @@ static int adau1761_codec_probe(struct snd_soc_codec *codec)
 
 static const struct snd_soc_codec_driver adau1761_codec_driver = {
 	.probe = adau1761_codec_probe,
-	.suspend = adau17x1_suspend,
 	.resume	= adau17x1_resume,
 	.set_bias_level	= adau1761_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls = adau1761_controls,
 	.num_controls = ARRAY_SIZE(adau1761_controls),
diff --git a/sound/soc/codecs/adau1781.c b/sound/soc/codecs/adau1781.c
index 045a614..e9fc00f 100644
--- a/sound/soc/codecs/adau1781.c
+++ b/sound/soc/codecs/adau1781.c
@@ -446,9 +446,9 @@ static int adau1781_codec_probe(struct snd_soc_codec *codec)
 
 static const struct snd_soc_codec_driver adau1781_codec_driver = {
 	.probe = adau1781_codec_probe,
-	.suspend = adau17x1_suspend,
 	.resume = adau17x1_resume,
 	.set_bias_level = adau1781_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls = adau1781_controls,
 	.num_controls = ARRAY_SIZE(adau1781_controls),
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 0b65970..3e16c1c 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -815,13 +815,6 @@ int adau17x1_add_routes(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(adau17x1_add_routes);
 
-int adau17x1_suspend(struct snd_soc_codec *codec)
-{
-	codec->driver->set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(adau17x1_suspend);
-
 int adau17x1_resume(struct snd_soc_codec *codec)
 {
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
@@ -829,7 +822,6 @@ int adau17x1_resume(struct snd_soc_codec *codec)
 	if (adau->switch_mode)
 		adau->switch_mode(codec->dev);
 
-	codec->driver->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	regcache_sync(adau->regmap);
 
 	return 0;
diff --git a/sound/soc/codecs/adau17x1.h b/sound/soc/codecs/adau17x1.h
index 3ffabaf..e4a557f 100644
--- a/sound/soc/codecs/adau17x1.h
+++ b/sound/soc/codecs/adau17x1.h
@@ -52,7 +52,6 @@ int adau17x1_set_micbias_voltage(struct snd_soc_codec *codec,
 	enum adau17x1_micbias_voltage micbias);
 bool adau17x1_readable_register(struct device *dev, unsigned int reg);
 bool adau17x1_volatile_register(struct device *dev, unsigned int reg);
-int adau17x1_suspend(struct snd_soc_codec *codec);
 int adau17x1_resume(struct snd_soc_codec *codec);
 
 extern const struct snd_soc_dai_ops adau17x1_dai_ops;
-- 
1.8.0
