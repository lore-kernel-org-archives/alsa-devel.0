From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/32] ASoC: wm8955: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:32 +0100
Message-ID: <1416746269-4935-16-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 2287D2615DC
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:38:02 +0100 (CET)
In-Reply-To: <1416746269-4935-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Set the CODEC driver's suspend_bias_off flag rather than manually going to
SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
the code a bit shorter and cleaner. Also remove the regcache_mark_dirty()
from the suspend handler since this is already done by the ASoC core.

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8955.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 09d91d9..1173f7f 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -866,29 +866,6 @@ static struct snd_soc_dai_driver wm8955_dai = {
 	.ops = &wm8955_dai_ops,
 };
 
-#ifdef CONFIG_PM
-static int wm8955_suspend(struct snd_soc_codec *codec)
-{
-	struct wm8955_priv *wm8955 = snd_soc_codec_get_drvdata(codec);
-
-	wm8955_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	regcache_mark_dirty(wm8955->regmap);
-
-	return 0;
-}
-
-static int wm8955_resume(struct snd_soc_codec *codec)
-{
-	wm8955_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-#else
-#define wm8955_suspend NULL
-#define wm8955_resume NULL
-#endif
-
 static int wm8955_probe(struct snd_soc_codec *codec)
 {
 	struct wm8955_priv *wm8955 = snd_soc_codec_get_drvdata(codec);
@@ -964,18 +941,10 @@ err_enable:
 	return ret;
 }
 
-static int wm8955_remove(struct snd_soc_codec *codec)
-{
-	wm8955_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_wm8955 = {
 	.probe =	wm8955_probe,
-	.remove =	wm8955_remove,
-	.suspend =	wm8955_suspend,
-	.resume =	wm8955_resume,
 	.set_bias_level = wm8955_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls =	wm8955_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8955_snd_controls),
-- 
1.8.0
