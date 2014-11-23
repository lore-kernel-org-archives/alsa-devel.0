From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 26/32] ASoC: wm8993: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:42 +0100
Message-ID: <1416746269-4935-26-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 5220926167D
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:38:10 +0100 (CET)
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

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8993.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 93b14ed..53c6fe3 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1486,7 +1486,6 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 {
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
 
 	wm8993->hubs_data.hp_startup_mode = 1;
 	wm8993->hubs_data.dcs_codes_l = -2;
@@ -1518,10 +1517,6 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 				      wm8993->pdata.micbias1_lvl,
 				      wm8993->pdata.micbias2_lvl);
 
-	ret = wm8993_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	if (ret != 0)
-		return ret;
-
 	snd_soc_add_codec_controls(codec, wm8993_snd_controls,
 			     ARRAY_SIZE(wm8993_snd_controls));
 	if (wm8993->pdata.num_retune_configs != 0) {
@@ -1550,12 +1545,6 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 
 }
 
-static int wm8993_remove(struct snd_soc_codec *codec)
-{
-	wm8993_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int wm8993_suspend(struct snd_soc_codec *codec)
 {
@@ -1629,7 +1618,6 @@ static const struct regmap_config wm8993_regmap = {
 
 static struct snd_soc_codec_driver soc_codec_dev_wm8993 = {
 	.probe = 	wm8993_probe,
-	.remove = 	wm8993_remove,
 	.suspend =	wm8993_suspend,
 	.resume =	wm8993_resume,
 	.set_bias_level = wm8993_set_bias_level,
-- 
1.8.0
