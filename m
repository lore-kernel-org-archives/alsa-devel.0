From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/11] ASoC: cq93vc: Cleanup manual bias level
	transitions
Date: Wed, 26 Nov 2014 20:57:51 +0100
Message-ID: <1417031880-11364-2-git-send-email-lars@metafoo.de>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-046.synserver.de (smtp-out-050.synserver.de
 [212.40.185.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A7C52612AC
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 22:26:41 +0100 (CET)
In-Reply-To: <1417031880-11364-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

Remove the manual transition back to SND_SOC_BIAS_STANDBY in resume. This
is already be automatically handled by the ASoC core.

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed. While we are at it also remove the unused codec field from
the cq93vc struct so the whole probe function can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/cq93vc.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 036a877..8d638e8 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -122,28 +122,6 @@ static struct snd_soc_dai_driver cq93vc_dai = {
 	.ops = &cq93vc_dai_ops,
 };
 
-static int cq93vc_resume(struct snd_soc_codec *codec)
-{
-	cq93vc_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
-static int cq93vc_probe(struct snd_soc_codec *codec)
-{
-	/* Off, with power on */
-	cq93vc_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
-static int cq93vc_remove(struct snd_soc_codec *codec)
-{
-	cq93vc_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
 static struct regmap *cq93vc_get_regmap(struct device *dev)
 {
 	struct davinci_vc *davinci_vc = dev->platform_data;
@@ -153,9 +131,6 @@ static struct regmap *cq93vc_get_regmap(struct device *dev)
 
 static struct snd_soc_codec_driver soc_codec_dev_cq93vc = {
 	.set_bias_level = cq93vc_set_bias_level,
-	.probe = cq93vc_probe,
-	.remove = cq93vc_remove,
-	.resume = cq93vc_resume,
 	.get_regmap = cq93vc_get_regmap,
 	.controls = cq93vc_snd_controls,
 	.num_controls = ARRAY_SIZE(cq93vc_snd_controls),
-- 
1.8.0
