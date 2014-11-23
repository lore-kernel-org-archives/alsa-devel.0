From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/32] ASoC: wm8400: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:18 +0100
Message-ID: <1416746269-4935-2-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id BA1ED26155D
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:37:51 +0100 (CET)
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

The manual asynchronous transition to SND_SOC_BIAS_STANDBY at the end of
CODEC probe() can also be removed as the core will automatically do this
after the CODEC has been probed. Also running this asynchronously has the
problem of potential race conditions with the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8400.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 72471be..385894f 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -58,12 +58,10 @@ static struct regulator_bulk_data power[] = {
 
 /* codec private data */
 struct wm8400_priv {
-	struct snd_soc_codec *codec;
 	struct wm8400 *wm8400;
 	u16 fake_register;
 	unsigned int sysclk;
 	unsigned int pcmclk;
-	struct work_struct work;
 	int fll_in, fll_out;
 };
 
@@ -1278,30 +1276,6 @@ static struct snd_soc_dai_driver wm8400_dai = {
 	.ops = &wm8400_dai_ops,
 };
 
-static int wm8400_suspend(struct snd_soc_codec *codec)
-{
-	wm8400_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int wm8400_resume(struct snd_soc_codec *codec)
-{
-	wm8400_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
-static void wm8400_probe_deferred(struct work_struct *work)
-{
-	struct wm8400_priv *priv = container_of(work, struct wm8400_priv,
-						work);
-	struct snd_soc_codec *codec = priv->codec;
-
-	/* charge output caps */
-	wm8400_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-}
-
 static int wm8400_codec_probe(struct snd_soc_codec *codec)
 {
 	struct wm8400 *wm8400 = dev_get_platdata(codec->dev);
@@ -1316,7 +1290,6 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 
 	snd_soc_codec_set_drvdata(codec, priv);
 	priv->wm8400 = wm8400;
-	priv->codec = codec;
 
 	ret = devm_regulator_bulk_get(wm8400->dev,
 				 ARRAY_SIZE(power), &power[0]);
@@ -1325,8 +1298,6 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	INIT_WORK(&priv->work, wm8400_probe_deferred);
-
 	wm8400_codec_reset(codec);
 
 	reg = snd_soc_read(codec, WM8400_POWER_MANAGEMENT_1);
@@ -1343,8 +1314,6 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, WM8400_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
 	snd_soc_write(codec, WM8400_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
 
-	if (!schedule_work(&priv->work))
-		return -EINVAL;
 	return 0;
 }
 
@@ -1369,10 +1338,9 @@ static struct regmap *wm8400_get_regmap(struct device *dev)
 static struct snd_soc_codec_driver soc_codec_dev_wm8400 = {
 	.probe =	wm8400_codec_probe,
 	.remove =	wm8400_codec_remove,
-	.suspend =	wm8400_suspend,
-	.resume =	wm8400_resume,
 	.get_regmap =	wm8400_get_regmap,
 	.set_bias_level = wm8400_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls = wm8400_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8400_snd_controls),
-- 
1.8.0
