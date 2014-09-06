From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] ASoC: ml26124: Cleanup manual bias level
	transitions
Date: Sat,  6 Sep 2014 14:29:34 +0200
Message-ID: <1410006575-499-4-git-send-email-lars@metafoo.de>
References: <1410006575-499-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 07BB2264F1D
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

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ml26124.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index e661e84..711f550 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -565,41 +565,19 @@ static struct snd_soc_dai_driver ml26124_dai = {
 	.symmetric_rates = 1,
 };
 
-#ifdef CONFIG_PM
-static int ml26124_suspend(struct snd_soc_codec *codec)
-{
-	ml26124_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int ml26124_resume(struct snd_soc_codec *codec)
-{
-	ml26124_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-#else
-#define ml26124_suspend NULL
-#define ml26124_resume NULL
-#endif
-
 static int ml26124_probe(struct snd_soc_codec *codec)
 {
 	/* Software Reset */
 	snd_soc_update_bits(codec, ML26124_SW_RST, 0x01, 1);
 	snd_soc_update_bits(codec, ML26124_SW_RST, 0x01, 0);
 
-	ml26124_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_ml26124 = {
 	.probe =	ml26124_probe,
-	.suspend =	ml26124_suspend,
-	.resume =	ml26124_resume,
 	.set_bias_level = ml26124_set_bias_level,
+	.suspend_bias_off = true,
 	.dapm_widgets = ml26124_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(ml26124_dapm_widgets),
 	.dapm_routes = ml26124_intercon,
-- 
1.8.0
