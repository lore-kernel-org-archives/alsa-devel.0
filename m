From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] ASoC: wm8971: Cleanup manual bias level
	transitions
Date: Mon, 30 Mar 2015 21:04:47 +0200
Message-ID: <1427742293-8588-3-git-send-email-lars@metafoo.de>
References: <1427742293-8588-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id E2851260599
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 21:04:51 +0200 (CEST)
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
 sound/soc/codecs/wm8971.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 4ab034d..f9cbabd 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -629,18 +629,6 @@ static struct snd_soc_dai_driver wm8971_dai = {
 	.ops = &wm8971_dai_ops,
 };
 
-static int wm8971_suspend(struct snd_soc_codec *codec)
-{
-	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int wm8971_resume(struct snd_soc_codec *codec)
-{
-	wm8971_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-
 static int wm8971_probe(struct snd_soc_codec *codec)
 {
 	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
@@ -649,8 +637,6 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 
 	wm8971_reset(codec);
 
-	wm8971_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	/* set the update bits */
 	snd_soc_update_bits(codec, WM8971_LDAC, 0x0100, 0x0100);
 	snd_soc_update_bits(codec, WM8971_RDAC, 0x0100, 0x0100);
@@ -664,21 +650,10 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-
-/* power down chip */
-static int wm8971_remove(struct snd_soc_codec *codec)
-{
-	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_wm8971 = {
 	.probe =	wm8971_probe,
-	.remove =	wm8971_remove,
-	.suspend =	wm8971_suspend,
-	.resume =	wm8971_resume,
 	.set_bias_level = wm8971_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls = wm8971_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8971_snd_controls),
-- 
1.8.0
