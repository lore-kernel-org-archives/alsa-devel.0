From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/11] ASoC: tlv320aic23: Cleanup manual bias
	level transitions
Date: Wed, 26 Nov 2014 20:57:54 +0100
Message-ID: <1417031880-11364-5-git-send-email-lars@metafoo.de>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-046.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id AC3D1265DAB
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 22:28:55 +0100 (CET)
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
 sound/soc/codecs/tlv320aic23.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index d671679..cc17e7e 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -540,19 +540,11 @@ static struct snd_soc_dai_driver tlv320aic23_dai = {
 	.ops = &tlv320aic23_dai_ops,
 };
 
-static int tlv320aic23_suspend(struct snd_soc_codec *codec)
-{
-	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
 static int tlv320aic23_resume(struct snd_soc_codec *codec)
 {
 	struct aic23 *aic23 = snd_soc_codec_get_drvdata(codec);
 	regcache_mark_dirty(aic23->regmap);
 	regcache_sync(aic23->regmap);
-	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
@@ -562,9 +554,6 @@ static int tlv320aic23_codec_probe(struct snd_soc_codec *codec)
 	/* Reset codec */
 	snd_soc_write(codec, TLV320AIC23_RESET, 0);
 
-	/* power on device */
-	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	snd_soc_write(codec, TLV320AIC23_DIGT, TLV320AIC23_DEEMP_44K);
 
 	/* Unmute input */
@@ -589,18 +578,12 @@ static int tlv320aic23_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int tlv320aic23_remove(struct snd_soc_codec *codec)
-{
-	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_tlv320aic23 = {
 	.probe = tlv320aic23_codec_probe,
-	.remove = tlv320aic23_remove,
-	.suspend = tlv320aic23_suspend,
 	.resume = tlv320aic23_resume,
 	.set_bias_level = tlv320aic23_set_bias_level,
+	.suspend_bias_off = true,
+
 	.controls = tlv320aic23_snd_controls,
 	.num_controls = ARRAY_SIZE(tlv320aic23_snd_controls),
 	.dapm_widgets = tlv320aic23_dapm_widgets,
-- 
1.8.0
