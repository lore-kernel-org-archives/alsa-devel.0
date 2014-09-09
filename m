From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] ASoC: cs42l52: Cleanup manual bias level
	transitions
Date: Tue,  9 Sep 2014 20:42:40 +0200
Message-ID: <1410288165-32127-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B09C265314
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 20:42:44 +0200 (CEST)
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>
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
 sound/soc/codecs/cs42l52.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index da4f758..35fbef7 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -946,20 +946,6 @@ static struct snd_soc_dai_driver cs42l52_dai = {
 		.ops = &cs42l52_ops,
 };
 
-static int cs42l52_suspend(struct snd_soc_codec *codec)
-{
-	cs42l52_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int cs42l52_resume(struct snd_soc_codec *codec)
-{
-	cs42l52_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
 static int beep_rates[] = {
 	261, 522, 585, 667, 706, 774, 889, 1000,
 	1043, 1200, 1333, 1412, 1600, 1714, 2000, 2182
@@ -1104,8 +1090,6 @@ static int cs42l52_probe(struct snd_soc_codec *codec)
 
 	cs42l52_init_beep(codec);
 
-	cs42l52_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	cs42l52->sysclk = CS42L52_DEFAULT_CLK;
 	cs42l52->config.format = CS42L52_DEFAULT_FORMAT;
 
@@ -1115,7 +1099,6 @@ static int cs42l52_probe(struct snd_soc_codec *codec)
 static int cs42l52_remove(struct snd_soc_codec *codec)
 {
 	cs42l52_free_beep(codec);
-	cs42l52_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
@@ -1123,9 +1106,8 @@ static int cs42l52_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_cs42l52 = {
 	.probe = cs42l52_probe,
 	.remove = cs42l52_remove,
-	.suspend = cs42l52_suspend,
-	.resume = cs42l52_resume,
 	.set_bias_level = cs42l52_set_bias_level,
+	.suspend_bias_off = true,
 
 	.dapm_widgets = cs42l52_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(cs42l52_dapm_widgets),
-- 
1.8.0
