From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] ASoC: jz4740: Cleanup manual bias level
	transitions
Date: Sat,  6 Sep 2014 14:29:33 +0200
Message-ID: <1410006575-499-3-git-send-email-lars@metafoo.de>
References: <1410006575-499-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AF24264F1A
 for <alsa-devel@alsa-project.org>; Sat,  6 Sep 2014 14:29:43 +0200 (CEST)
In-Reply-To: <1410006575-499-1-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sean Cross <xobs@kosagi.com>
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
 sound/soc/codecs/jz4740.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index bcebd1a..df7c01c 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -293,41 +293,13 @@ static int jz4740_codec_dev_probe(struct snd_soc_codec *codec)
 	regmap_update_bits(jz4740_codec->regmap, JZ4740_REG_CODEC_1,
 			JZ4740_CODEC_1_SW2_ENABLE, JZ4740_CODEC_1_SW2_ENABLE);
 
-	jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 }
 
-static int jz4740_codec_dev_remove(struct snd_soc_codec *codec)
-{
-	jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM_SLEEP
-
-static int jz4740_codec_suspend(struct snd_soc_codec *codec)
-{
-	return jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_OFF);
-}
-
-static int jz4740_codec_resume(struct snd_soc_codec *codec)
-{
-	return jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-}
-
-#else
-#define jz4740_codec_suspend NULL
-#define jz4740_codec_resume NULL
-#endif
-
 static struct snd_soc_codec_driver soc_codec_dev_jz4740_codec = {
 	.probe = jz4740_codec_dev_probe,
-	.remove = jz4740_codec_dev_remove,
-	.suspend = jz4740_codec_suspend,
-	.resume = jz4740_codec_resume,
 	.set_bias_level = jz4740_codec_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls = jz4740_codec_controls,
 	.num_controls = ARRAY_SIZE(jz4740_codec_controls),
-- 
1.8.0
