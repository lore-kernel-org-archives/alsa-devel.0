From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/6] ASoC: cs42l73: Cleanup manual bias level
	transitions
Date: Tue,  9 Sep 2014 20:42:42 +0200
Message-ID: <1410288165-32127-3-git-send-email-lars@metafoo.de>
References: <1410288165-32127-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 878B426531B
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 20:42:46 +0200 (CEST)
In-Reply-To: <1410288165-32127-1-git-send-email-lars@metafoo.de>
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
 sound/soc/codecs/cs42l73.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 0e7b9eb..2f8b946 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1330,25 +1330,10 @@ static struct snd_soc_dai_driver cs42l73_dai[] = {
 	 }
 };
 
-static int cs42l73_suspend(struct snd_soc_codec *codec)
-{
-	cs42l73_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int cs42l73_resume(struct snd_soc_codec *codec)
-{
-	cs42l73_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-
 static int cs42l73_probe(struct snd_soc_codec *codec)
 {
 	struct cs42l73_private *cs42l73 = snd_soc_codec_get_drvdata(codec);
 
-	cs42l73_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	/* Set Charge Pump Frequency */
 	if (cs42l73->pdata.chgfreq)
 		snd_soc_update_bits(codec, CS42L73_CPFCHC,
@@ -1362,18 +1347,10 @@ static int cs42l73_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int cs42l73_remove(struct snd_soc_codec *codec)
-{
-	cs42l73_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_cs42l73 = {
 	.probe = cs42l73_probe,
-	.remove = cs42l73_remove,
-	.suspend = cs42l73_suspend,
-	.resume = cs42l73_resume,
 	.set_bias_level = cs42l73_set_bias_level,
+	.suspend_bias_off = true,
 
 	.dapm_widgets = cs42l73_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(cs42l73_dapm_widgets),
-- 
1.8.0
