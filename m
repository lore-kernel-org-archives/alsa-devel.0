From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/32] ASoC: wm8731: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:24 +0100
Message-ID: <1416746269-4935-8-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D6B826167A
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
 sound/soc/codecs/wm8731.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 7c0fb97..b9211b4 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -562,25 +562,6 @@ static struct snd_soc_dai_driver wm8731_dai = {
 	.symmetric_rates = 1,
 };
 
-#ifdef CONFIG_PM
-static int wm8731_suspend(struct snd_soc_codec *codec)
-{
-	wm8731_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int wm8731_resume(struct snd_soc_codec *codec)
-{
-	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-#else
-#define wm8731_suspend NULL
-#define wm8731_resume NULL
-#endif
-
 static int wm8731_probe(struct snd_soc_codec *codec)
 {
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
@@ -636,8 +617,6 @@ static int wm8731_remove(struct snd_soc_codec *codec)
 {
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
 
-	wm8731_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
 	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
 
 	return 0;
@@ -646,9 +625,9 @@ static int wm8731_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
 	.probe =	wm8731_probe,
 	.remove =	wm8731_remove,
-	.suspend =	wm8731_suspend,
-	.resume =	wm8731_resume,
 	.set_bias_level = wm8731_set_bias_level,
+	.suspend_bias_off = true,
+
 	.dapm_widgets = wm8731_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wm8731_dapm_widgets),
 	.dapm_routes = wm8731_intercon,
-- 
1.8.0
