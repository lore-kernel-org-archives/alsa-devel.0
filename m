From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/32] ASoC: wm8350: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:17 +0100
Message-ID: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 0467A26155A
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:37:50 +0100 (CET)
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
 sound/soc/codecs/wm8350.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 628ec77..87f664b 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1242,19 +1242,6 @@ static int wm8350_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm8350_suspend(struct snd_soc_codec *codec)
-{
-	wm8350_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int wm8350_resume(struct snd_soc_codec *codec)
-{
-	wm8350_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
 static void wm8350_hp_work(struct wm8350_data *priv,
 			   struct wm8350_jack_data *jack,
 			   u16 mask)
@@ -1565,9 +1552,6 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_MICD,
 			    wm8350_mic_handler, 0, "Microphone detect", priv);
 
-
-	wm8350_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 }
 
@@ -1596,8 +1580,6 @@ static int  wm8350_codec_remove(struct snd_soc_codec *codec)
 	 * wait for its completion */
 	flush_delayed_work(&codec->dapm.delayed_work);
 
-	wm8350_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
 	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
 
 	return 0;
@@ -1613,10 +1595,9 @@ static struct regmap *wm8350_get_regmap(struct device *dev)
 static struct snd_soc_codec_driver soc_codec_dev_wm8350 = {
 	.probe =	wm8350_codec_probe,
 	.remove =	wm8350_codec_remove,
-	.suspend = 	wm8350_suspend,
-	.resume =	wm8350_resume,
 	.get_regmap =	wm8350_get_regmap,
 	.set_bias_level = wm8350_set_bias_level,
+	.suspend_bias_off = true,
 
 	.controls = wm8350_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8350_snd_controls),
-- 
1.8.0
