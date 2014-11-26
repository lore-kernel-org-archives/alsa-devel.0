From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/11] ASoC: twl6040: Cleanup manual bias level
	transitions
Date: Wed, 26 Nov 2014 20:58:00 +0100
Message-ID: <1417031880-11364-11-git-send-email-lars@metafoo.de>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-046.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E78E6265DDF
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 22:29:03 +0100 (CET)
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

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/twl6040.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 0f6067f..5ff2b1e 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1095,25 +1095,6 @@ static struct snd_soc_dai_driver twl6040_dai[] = {
 },
 };
 
-#ifdef CONFIG_PM
-static int twl6040_suspend(struct snd_soc_codec *codec)
-{
-	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int twl6040_resume(struct snd_soc_codec *codec)
-{
-	twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-#else
-#define twl6040_suspend NULL
-#define twl6040_resume NULL
-#endif
-
 static int twl6040_probe(struct snd_soc_codec *codec)
 {
 	struct twl6040_data *priv;
@@ -1160,7 +1141,6 @@ static int twl6040_remove(struct snd_soc_codec *codec)
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
 	free_irq(priv->plug_irq, codec);
-	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
@@ -1168,11 +1148,10 @@ static int twl6040_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
 	.probe = twl6040_probe,
 	.remove = twl6040_remove,
-	.suspend = twl6040_suspend,
-	.resume = twl6040_resume,
 	.read = twl6040_read,
 	.write = twl6040_write,
 	.set_bias_level = twl6040_set_bias_level,
+	.suspend_bias_off = true,
 	.ignore_pmdown_time = true,
 
 	.controls = twl6040_snd_controls,
-- 
1.8.0
