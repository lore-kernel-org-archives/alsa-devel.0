From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/11] ASoC: tlv320aic32x4: Cleanup manual bias
	level transitions
Date: Wed, 26 Nov 2014 20:57:56 +0100
Message-ID: <1417031880-11364-7-git-send-email-lars@metafoo.de>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-046.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 51645265DB9
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 22:28:59 +0100 (CET)
In-Reply-To: <1417031880-11364-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

Set the CODEC driver's suspend_bias_off flag rather than manually going to
SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
the code a bit shorter and cleaner.

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/tlv320aic32x4.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 6ea662d..015467e 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -597,18 +597,6 @@ static struct snd_soc_dai_driver aic32x4_dai = {
 	.symmetric_rates = 1,
 };
 
-static int aic32x4_suspend(struct snd_soc_codec *codec)
-{
-	aic32x4_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int aic32x4_resume(struct snd_soc_codec *codec)
-{
-	aic32x4_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-
 static int aic32x4_probe(struct snd_soc_codec *codec)
 {
 	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
@@ -654,8 +642,6 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 		snd_soc_write(codec, AIC32X4_RMICPGANIN,
 				AIC32X4_RMICPGANIN_CM1R_10K);
 
-	aic32x4_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	/*
 	 * Workaround: for an unknown reason, the ADC needs to be powered up
 	 * and down for the first capture to work properly. It seems related to
@@ -669,18 +655,10 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int aic32x4_remove(struct snd_soc_codec *codec)
-{
-	aic32x4_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
 	.probe = aic32x4_probe,
-	.remove = aic32x4_remove,
-	.suspend = aic32x4_suspend,
-	.resume = aic32x4_resume,
 	.set_bias_level = aic32x4_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls = aic32x4_snd_controls,
 	.num_controls = ARRAY_SIZE(aic32x4_snd_controls),
-- 
1.8.0
