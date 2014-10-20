From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/12] ASoC: ak4535: Cleanup manual bias level
	transitions
Date: Mon, 20 Oct 2014 10:56:28 +0200
Message-ID: <1413795399-29952-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EFB3260567
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 10:56:42 +0200 (CEST)
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
 sound/soc/codecs/ak4535.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 30e2978..eced46d 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -373,36 +373,19 @@ static struct snd_soc_dai_driver ak4535_dai = {
 	.ops = &ak4535_dai_ops,
 };
 
-static int ak4535_suspend(struct snd_soc_codec *codec)
-{
-	ak4535_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static int ak4535_resume(struct snd_soc_codec *codec)
 {
 	snd_soc_cache_sync(codec);
-	ak4535_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
 
 static int ak4535_probe(struct snd_soc_codec *codec)
 {
-	/* power on device */
-	ak4535_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	snd_soc_add_codec_controls(codec, ak4535_snd_controls,
 				ARRAY_SIZE(ak4535_snd_controls));
 	return 0;
 }
 
-/* power down chip */
-static int ak4535_remove(struct snd_soc_codec *codec)
-{
-	ak4535_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static const struct regmap_config ak4535_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -417,10 +400,10 @@ static const struct regmap_config ak4535_regmap = {
 
 static struct snd_soc_codec_driver soc_codec_dev_ak4535 = {
 	.probe =	ak4535_probe,
-	.remove =	ak4535_remove,
-	.suspend =	ak4535_suspend,
 	.resume =	ak4535_resume,
 	.set_bias_level = ak4535_set_bias_level,
+	.suspend_bias_off = true,
+
 	.dapm_widgets = ak4535_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(ak4535_dapm_widgets),
 	.dapm_routes = ak4535_audio_map,
-- 
1.8.0
