From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/12] ASoC: ak4641: Cleanup manual bias level
	transitions
Date: Mon, 20 Oct 2014 10:56:30 +0200
Message-ID: <1413795399-29952-3-git-send-email-lars@metafoo.de>
References: <1413795399-29952-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id B217A260589
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 10:56:43 +0200 (CEST)
In-Reply-To: <1413795399-29952-1-git-send-email-lars@metafoo.de>
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
Cc: Johannes Stezenbach <js@sig21.net>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Sven Brandau <brandau@gmx.de>, alsa-devel@alsa-project.org, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <morimoto.kuninori@renesas.com>
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
 sound/soc/codecs/ak4641.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 7afe8f4..70861c7 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -505,39 +505,7 @@ static struct snd_soc_dai_driver ak4641_dai[] = {
 },
 };
 
-static int ak4641_suspend(struct snd_soc_codec *codec)
-{
-	ak4641_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int ak4641_resume(struct snd_soc_codec *codec)
-{
-	ak4641_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-
-static int ak4641_probe(struct snd_soc_codec *codec)
-{
-	/* power on device */
-	ak4641_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
-static int ak4641_remove(struct snd_soc_codec *codec)
-{
-	ak4641_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-
 static struct snd_soc_codec_driver soc_codec_dev_ak4641 = {
-	.probe			= ak4641_probe,
-	.remove			= ak4641_remove,
-	.suspend		= ak4641_suspend,
-	.resume			= ak4641_resume,
 	.controls		= ak4641_snd_controls,
 	.num_controls		= ARRAY_SIZE(ak4641_snd_controls),
 	.dapm_widgets		= ak4641_dapm_widgets,
@@ -545,6 +513,7 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4641 = {
 	.dapm_routes		= ak4641_audio_map,
 	.num_dapm_routes	= ARRAY_SIZE(ak4641_audio_map),
 	.set_bias_level		= ak4641_set_bias_level,
+	.suspend_bias_off	= true,
 };
 
 static const struct regmap_config ak4641_regmap = {
-- 
1.8.0
