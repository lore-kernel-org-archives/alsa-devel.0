From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: sgtl5000: Cleanup bias level
	transitions
Date: Sat,  6 Sep 2014 14:29:35 +0200
Message-ID: <1410006575-499-5-git-send-email-lars@metafoo.de>
References: <1410006575-499-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id BA475264F28
 for <alsa-devel@alsa-project.org>; Sat,  6 Sep 2014 14:29:44 +0200 (CEST)
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
 sound/soc/codecs/sgtl5000.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index e997d27..a604a22 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1073,26 +1073,6 @@ static bool sgtl5000_readable(struct device *dev, unsigned int reg)
 	}
 }
 
-#ifdef CONFIG_SUSPEND
-static int sgtl5000_suspend(struct snd_soc_codec *codec)
-{
-	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int sgtl5000_resume(struct snd_soc_codec *codec)
-{
-	/* Bring the codec back up to standby to enable regulators */
-	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-#else
-#define sgtl5000_suspend NULL
-#define sgtl5000_resume  NULL
-#endif	/* CONFIG_SUSPEND */
-
 /*
  * sgtl5000 has 3 internal power supplies:
  * 1. VAG, normally set to vdda/2
@@ -1352,11 +1332,6 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	 */
 	snd_soc_write(codec, SGTL5000_DAP_CTRL, 0);
 
-	/* leading to standby state */
-	ret = sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	if (ret)
-		goto err;
-
 	return 0;
 
 err:
@@ -1373,8 +1348,6 @@ static int sgtl5000_remove(struct snd_soc_codec *codec)
 {
 	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 
-	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
 	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 						sgtl5000->supplies);
 	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
@@ -1387,9 +1360,8 @@ static int sgtl5000_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver sgtl5000_driver = {
 	.probe = sgtl5000_probe,
 	.remove = sgtl5000_remove,
-	.suspend = sgtl5000_suspend,
-	.resume = sgtl5000_resume,
 	.set_bias_level = sgtl5000_set_bias_level,
+	.suspend_bias_off = true,
 	.controls = sgtl5000_snd_controls,
 	.num_controls = ARRAY_SIZE(sgtl5000_snd_controls),
 	.dapm_widgets = sgtl5000_dapm_widgets,
-- 
1.8.0
