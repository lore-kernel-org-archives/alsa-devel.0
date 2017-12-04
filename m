From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_component_init_regmap() on
	wm8350" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:53 +0000
Message-ID: <E1eLvoP-0000eS-I6@debutante>
References: <87r2vrklcw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 448BE26762E
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:57 +0100 (CET)
In-Reply-To: <87r2vrklcw.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: use snd_soc_component_init_regmap() on wm8350

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 40b84884617d9f07663862770d2574a71e313bc7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Nov 2017 06:04:31 +0000
Subject: [PATCH] ASoC: use snd_soc_component_init_regmap() on wm8350

To setup regmap, ALSA SoC has snd_soc_component_init_regmap() and
.get_regmap. But these are duplicated feature.
Let's use snd_soc_component_init_regmap() and remove .get_regmap

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8350.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 2efc5b41ad0f..fc79c6725d06 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1472,6 +1472,8 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 			    GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
+
+	snd_soc_codec_init_regmap(codec, wm8350->regmap);
 	snd_soc_codec_set_drvdata(codec, priv);
 
 	priv->wm8350 = wm8350;
@@ -1580,17 +1582,9 @@ static int  wm8350_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct regmap *wm8350_get_regmap(struct device *dev)
-{
-	struct wm8350 *wm8350 = dev_get_platdata(dev);
-
-	return wm8350->regmap;
-}
-
 static const struct snd_soc_codec_driver soc_codec_dev_wm8350 = {
 	.probe =	wm8350_codec_probe,
 	.remove =	wm8350_codec_remove,
-	.get_regmap =	wm8350_get_regmap,
 	.set_bias_level = wm8350_set_bias_level,
 	.suspend_bias_off = true,
 
-- 
2.15.0
