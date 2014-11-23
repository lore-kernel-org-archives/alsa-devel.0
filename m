From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 19/32] ASoC: wm8974: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:35 +0100
Message-ID: <1416746269-4935-19-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BF002619D9
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:38:04 +0100 (CET)
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
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8974.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 682e9ed..ff0e464 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -568,18 +568,6 @@ static struct snd_soc_dai_driver wm8974_dai = {
 	.symmetric_rates = 1,
 };
 
-static int wm8974_suspend(struct snd_soc_codec *codec)
-{
-	wm8974_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int wm8974_resume(struct snd_soc_codec *codec)
-{
-	wm8974_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-
 static const struct regmap_config wm8974_regmap = {
 	.reg_bits = 7,
 	.val_bits = 9,
@@ -599,24 +587,13 @@ static int wm8974_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	wm8974_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return ret;
-}
-
-/* power down chip */
-static int wm8974_remove(struct snd_soc_codec *codec)
-{
-	wm8974_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_wm8974 = {
 	.probe = 	wm8974_probe,
-	.remove = 	wm8974_remove,
-	.suspend = 	wm8974_suspend,
-	.resume =	wm8974_resume,
 	.set_bias_level = wm8974_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls = wm8974_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8974_snd_controls),
-- 
1.8.0
