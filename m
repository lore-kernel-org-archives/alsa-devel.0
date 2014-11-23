From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: alc5623: Cleanup bias level
	transitions
Date: Sun, 23 Nov 2014 13:47:50 +0100
Message-ID: <1416746872-11513-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E26D26262A
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:47:53 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Set the CODEC driver's suspend_bias_off flag rather than manually going to
SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
the code a bit shorter and cleaner. Also remove the manual sequencing back
to SND_SOC_BIAS_ON in resume as this is already handled by the ASoC core.

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/alc5623.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 9d0755a..bdf8c5a 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -866,7 +866,6 @@ static int alc5623_suspend(struct snd_soc_codec *codec)
 {
 	struct alc5623_priv *alc5623 = snd_soc_codec_get_drvdata(codec);
 
-	alc5623_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	regcache_cache_only(alc5623->regmap, true);
 
 	return 0;
@@ -887,15 +886,6 @@ static int alc5623_resume(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	alc5623_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	/* charge alc5623 caps */
-	if (codec->dapm.suspend_bias_level == SND_SOC_BIAS_ON) {
-		alc5623_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-		codec->dapm.bias_level = SND_SOC_BIAS_ON;
-		alc5623_set_bias_level(codec, codec->dapm.bias_level);
-	}
-
 	return 0;
 }
 
@@ -906,9 +896,6 @@ static int alc5623_probe(struct snd_soc_codec *codec)
 
 	alc5623_reset(codec);
 
-	/* power on device */
-	alc5623_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	if (alc5623->add_ctrl) {
 		snd_soc_write(codec, ALC5623_ADD_CTRL_REG,
 				alc5623->add_ctrl);
@@ -964,19 +951,12 @@ static int alc5623_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-/* power down chip */
-static int alc5623_remove(struct snd_soc_codec *codec)
-{
-	alc5623_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_device_alc5623 = {
 	.probe = alc5623_probe,
-	.remove = alc5623_remove,
 	.suspend = alc5623_suspend,
 	.resume = alc5623_resume,
 	.set_bias_level = alc5623_set_bias_level,
+	.suspend_bias_off = true,
 };
 
 static const struct regmap_config alc5623_regmap = {
-- 
1.8.0
