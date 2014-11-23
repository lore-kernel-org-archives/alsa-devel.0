From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: alc5632: Cleanup bias level
	transitions
Date: Sun, 23 Nov 2014 13:47:51 +0100
Message-ID: <1416746872-11513-2-git-send-email-lars@metafoo.de>
References: <1416746872-11513-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FA9B264EAA
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:47:54 +0100 (CET)
In-Reply-To: <1416746872-11513-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
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
 sound/soc/codecs/alc5632.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 85942ca..d1fdbc2 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1038,23 +1038,15 @@ static struct snd_soc_dai_driver alc5632_dai = {
 };
 
 #ifdef CONFIG_PM
-static int alc5632_suspend(struct snd_soc_codec *codec)
-{
-	alc5632_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static int alc5632_resume(struct snd_soc_codec *codec)
 {
 	struct alc5632_priv *alc5632 = snd_soc_codec_get_drvdata(codec);
 
 	regcache_sync(alc5632->regmap);
 
-	alc5632_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
 #else
-#define	alc5632_suspend	NULL
 #define	alc5632_resume	NULL
 #endif
 
@@ -1062,9 +1054,6 @@ static int alc5632_probe(struct snd_soc_codec *codec)
 {
 	struct alc5632_priv *alc5632 = snd_soc_codec_get_drvdata(codec);
 
-	/* power on device  */
-	alc5632_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	switch (alc5632->id) {
 	case 0x5c:
 		snd_soc_add_codec_controls(codec, alc5632_vol_snd_controls,
@@ -1077,19 +1066,12 @@ static int alc5632_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-/* power down chip */
-static int alc5632_remove(struct snd_soc_codec *codec)
-{
-	alc5632_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_device_alc5632 = {
 	.probe = alc5632_probe,
-	.remove = alc5632_remove,
-	.suspend = alc5632_suspend,
 	.resume = alc5632_resume,
 	.set_bias_level = alc5632_set_bias_level,
+	.suspend_bias_off = true,
+
 	.controls = alc5632_snd_controls,
 	.num_controls = ARRAY_SIZE(alc5632_snd_controls),
 	.dapm_widgets = alc5632_dapm_widgets,
-- 
1.8.0
