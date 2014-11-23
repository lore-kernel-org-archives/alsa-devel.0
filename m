From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: uda134x: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 15:04:13 +0100
Message-ID: <1416751454-16916-2-git-send-email-lars@metafoo.de>
References: <1416751454-16916-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 2833B26166B
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 15:04:17 +0100 (CET)
In-Reply-To: <1416751454-16916-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
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
 sound/soc/codecs/uda134x.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 54240f1..4056260 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -518,8 +518,6 @@ static int uda134x_soc_probe(struct snd_soc_codec *codec)
 
 	uda134x_reset(codec);
 
-	uda134x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	if (pd->model == UDA134X_UDA1341) {
 		widgets = uda1341_dapm_widgets;
 		num_widgets = ARRAY_SIZE(uda1341_dapm_widgets);
@@ -571,44 +569,21 @@ static int uda134x_soc_remove(struct snd_soc_codec *codec)
 {
 	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
 
-	uda134x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	uda134x_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
 	kfree(uda134x);
 	return 0;
 }
 
-#if defined(CONFIG_PM)
-static int uda134x_soc_suspend(struct snd_soc_codec *codec)
-{
-	uda134x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	uda134x_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int uda134x_soc_resume(struct snd_soc_codec *codec)
-{
-	uda134x_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
-	uda134x_set_bias_level(codec, SND_SOC_BIAS_ON);
-	return 0;
-}
-#else
-#define uda134x_soc_suspend NULL
-#define uda134x_soc_resume NULL
-#endif /* CONFIG_PM */
-
 static struct snd_soc_codec_driver soc_codec_dev_uda134x = {
 	.probe =        uda134x_soc_probe,
 	.remove =       uda134x_soc_remove,
-	.suspend =      uda134x_soc_suspend,
-	.resume =       uda134x_soc_resume,
 	.reg_cache_size = sizeof(uda134x_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = uda134x_reg,
 	.reg_cache_step = 1,
 	.read = uda134x_read_reg_cache,
-	.write = uda134x_write,
 	.set_bias_level = uda134x_set_bias_level,
+	.suspend_bias_off = true,
+
 	.dapm_widgets = uda134x_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(uda134x_dapm_widgets),
 	.dapm_routes = uda134x_dapm_routes,
-- 
1.8.0
