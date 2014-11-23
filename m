From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 17/32] ASoC: wm8960: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:33 +0100
Message-ID: <1416746269-4935-17-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id EF9F1261740
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
the code a bit shorter and cleaner.

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8960.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 99d6457..bc8793cd 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -943,22 +943,6 @@ static struct snd_soc_dai_driver wm8960_dai = {
 	.symmetric_rates = 1,
 };
 
-static int wm8960_suspend(struct snd_soc_codec *codec)
-{
-	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
-
-	wm8960->set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int wm8960_resume(struct snd_soc_codec *codec)
-{
-	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
-
-	wm8960->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-
 static int wm8960_probe(struct snd_soc_codec *codec)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
@@ -976,8 +960,6 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	wm8960->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	/* Latch the update bits */
 	snd_soc_update_bits(codec, WM8960_LINVOL, 0x100, 0x100);
 	snd_soc_update_bits(codec, WM8960_RINVOL, 0x100, 0x100);
@@ -997,21 +979,10 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-/* power down chip */
-static int wm8960_remove(struct snd_soc_codec *codec)
-{
-	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
-
-	wm8960->set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_wm8960 = {
 	.probe =	wm8960_probe,
-	.remove =	wm8960_remove,
-	.suspend =	wm8960_suspend,
-	.resume =	wm8960_resume,
 	.set_bias_level = wm8960_set_bias_level,
+	.suspend_bias_off = true,
 };
 
 static const struct regmap_config wm8960_regmap = {
-- 
1.8.0
