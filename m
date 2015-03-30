From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/8] ASoC: wm8753: Cleanup manual bias level
	transitions
Date: Mon, 30 Mar 2015 21:04:49 +0200
Message-ID: <1427742293-8588-5-git-send-email-lars@metafoo.de>
References: <1427742293-8588-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id BB4DF2605B2
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 21:04:53 +0200 (CEST)
In-Reply-To: <1427742293-8588-1-git-send-email-lars@metafoo.de>
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

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8753.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 176fcb1..c50a595 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1447,19 +1447,12 @@ static struct snd_soc_dai_driver wm8753_dai[] = {
 },
 };
 
-static int wm8753_suspend(struct snd_soc_codec *codec)
-{
-	wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static int wm8753_resume(struct snd_soc_codec *codec)
 {
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 
 	regcache_sync(wm8753->regmap);
 
-	wm8753_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
 
@@ -1476,7 +1469,6 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	wm8753_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	wm8753->dai_func = 0;
 
 	/* set the update bits */
@@ -1494,20 +1486,11 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-/* power down chip */
-static int wm8753_remove(struct snd_soc_codec *codec)
-{
-	wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_wm8753 = {
 	.probe =	wm8753_probe,
-	.remove =	wm8753_remove,
-	.suspend =	wm8753_suspend,
 	.resume =	wm8753_resume,
 	.set_bias_level = wm8753_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls = wm8753_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8753_snd_controls),
-- 
1.8.0
