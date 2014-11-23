From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/32] ASoC: wm8903: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:30 +0100
Message-ID: <1416746269-4935-14-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BF8726172B
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:38:00 +0100 (CET)
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

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed. Also remove the unused codec field from the wm8903_priv
struct so we can remove the whole probe callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8903.c | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index ffbe6df..cc6b0ef 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -118,7 +118,6 @@ static const struct reg_default wm8903_reg_defaults[] = {
 struct wm8903_priv {
 	struct wm8903_platform_data *pdata;
 	struct device *dev;
-	struct snd_soc_codec *codec;
 	struct regmap *regmap;
 
 	int sysclk;
@@ -1759,21 +1758,12 @@ static struct snd_soc_dai_driver wm8903_dai = {
 	.symmetric_rates = 1,
 };
 
-static int wm8903_suspend(struct snd_soc_codec *codec)
-{
-	wm8903_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
 static int wm8903_resume(struct snd_soc_codec *codec)
 {
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 
 	regcache_sync(wm8903->regmap);
 
-	wm8903_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 }
 
@@ -1891,33 +1881,12 @@ static void wm8903_free_gpio(struct wm8903_priv *wm8903)
 }
 #endif
 
-static int wm8903_probe(struct snd_soc_codec *codec)
-{
-	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-
-	wm8903->codec = codec;
-
-	/* power on device */
-	wm8903_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
-/* power down chip */
-static int wm8903_remove(struct snd_soc_codec *codec)
-{
-	wm8903_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_wm8903 = {
-	.probe =	wm8903_probe,
-	.remove =	wm8903_remove,
-	.suspend =	wm8903_suspend,
 	.resume =	wm8903_resume,
 	.set_bias_level = wm8903_set_bias_level,
 	.seq_notifier = wm8903_seq_notifier,
+	.suspend_bias_off = true,
+
 	.controls = wm8903_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8903_snd_controls),
 	.dapm_widgets = wm8903_dapm_widgets,
-- 
1.8.0
