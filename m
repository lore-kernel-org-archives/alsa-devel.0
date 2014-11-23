From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 21/32] ASoC: wm8983: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:37 +0100
Message-ID: <1416746269-4935-21-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 02DD92619DC
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:38:05 +0100 (CET)
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
 sound/soc/codecs/wm8983.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index ac5defd..5d1cf08 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -967,29 +967,6 @@ static int wm8983_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int wm8983_suspend(struct snd_soc_codec *codec)
-{
-	wm8983_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int wm8983_resume(struct snd_soc_codec *codec)
-{
-	wm8983_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-#else
-#define wm8983_suspend NULL
-#define wm8983_resume NULL
-#endif
-
-static int wm8983_remove(struct snd_soc_codec *codec)
-{
-	wm8983_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static int wm8983_probe(struct snd_soc_codec *codec)
 {
 	int ret;
@@ -1055,10 +1032,8 @@ static struct snd_soc_dai_driver wm8983_dai = {
 
 static struct snd_soc_codec_driver soc_codec_dev_wm8983 = {
 	.probe = wm8983_probe,
-	.remove = wm8983_remove,
-	.suspend = wm8983_suspend,
-	.resume = wm8983_resume,
 	.set_bias_level = wm8983_set_bias_level,
+	.suspend_bias_off = true,
 	.controls = wm8983_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8983_snd_controls),
 	.dapm_widgets = wm8983_dapm_widgets,
-- 
1.8.0
