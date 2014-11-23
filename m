From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: rt5631: Cleanup bias level
	transitions
Date: Sun, 23 Nov 2014 13:47:52 +0100
Message-ID: <1416746872-11513-3-git-send-email-lars@metafoo.de>
References: <1416746872-11513-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 3079F262632
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:47:56 +0100 (CET)
In-Reply-To: <1416746872-11513-1-git-send-email-lars@metafoo.de>
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
the code a bit shorter and cleaner.

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/rt5631.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 9425545..6d7b7ca 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1612,29 +1612,6 @@ static int rt5631_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int rt5631_remove(struct snd_soc_codec *codec)
-{
-	rt5631_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int rt5631_suspend(struct snd_soc_codec *codec)
-{
-	rt5631_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int rt5631_resume(struct snd_soc_codec *codec)
-{
-	rt5631_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-#else
-#define rt5631_suspend NULL
-#define rt5631_resume NULL
-#endif
-
 #define RT5631_STEREO_RATES SNDRV_PCM_RATE_8000_96000
 #define RT5631_FORMAT	(SNDRV_PCM_FMTBIT_S16_LE | \
 			SNDRV_PCM_FMTBIT_S20_3LE | \
@@ -1672,10 +1649,8 @@ static struct snd_soc_dai_driver rt5631_dai[] = {
 
 static struct snd_soc_codec_driver soc_codec_dev_rt5631 = {
 	.probe = rt5631_probe,
-	.remove = rt5631_remove,
-	.suspend = rt5631_suspend,
-	.resume = rt5631_resume,
 	.set_bias_level = rt5631_set_bias_level,
+	.suspend_bias_off = true,
 	.controls = rt5631_snd_controls,
 	.num_controls = ARRAY_SIZE(rt5631_snd_controls),
 	.dapm_widgets = rt5631_dapm_widgets,
-- 
1.8.0
