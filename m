From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/32] ASoC: wm8737: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:25 +0100
Message-ID: <1416746269-4935-9-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id EAE9D26167D
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:37:56 +0100 (CET)
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
the code a bit shorter and cleaner.

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8737.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index fe41dd2b..ada9ac1 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -537,23 +537,6 @@ static struct snd_soc_dai_driver wm8737_dai = {
 	.ops = &wm8737_dai_ops,
 };
 
-#ifdef CONFIG_PM
-static int wm8737_suspend(struct snd_soc_codec *codec)
-{
-	wm8737_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int wm8737_resume(struct snd_soc_codec *codec)
-{
-	wm8737_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-#else
-#define wm8737_suspend NULL
-#define wm8737_resume NULL
-#endif
-
 static int wm8737_probe(struct snd_soc_codec *codec)
 {
 	struct wm8737_priv *wm8737 = snd_soc_codec_get_drvdata(codec);
@@ -590,18 +573,10 @@ err_get:
 	return ret;
 }
 
-static int wm8737_remove(struct snd_soc_codec *codec)
-{
-	wm8737_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_wm8737 = {
 	.probe		= wm8737_probe,
-	.remove		= wm8737_remove,
-	.suspend	= wm8737_suspend,
-	.resume		= wm8737_resume,
 	.set_bias_level = wm8737_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls = wm8737_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8737_snd_controls),
-- 
1.8.0
