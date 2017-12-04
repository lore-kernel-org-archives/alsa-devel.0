From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_component_init_regmap() on
	wm8400" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:56 +0000
Message-ID: <E1eLvoS-0000fH-JV@debutante>
References: <87shg7kldd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E2BC5267631
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:59 +0100 (CET)
In-Reply-To: <87shg7kldd.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: use snd_soc_component_init_regmap() on wm8400

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

>From 74c76497946e1f15b51d603735eb8273ac89381e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Nov 2017 06:04:17 +0000
Subject: [PATCH] ASoC: use snd_soc_component_init_regmap() on wm8400

To setup regmap, ALSA SoC has snd_soc_component_init_regmap() and
.get_regmap. But these are duplicated feature.
Let's use snd_soc_component_init_regmap() and remove .get_regmap

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8400.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 6c59fb933bd6..a36adf881bca 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1285,6 +1285,7 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 	if (priv == NULL)
 		return -ENOMEM;
 
+	snd_soc_codec_init_regmap(codec, wm8400->regmap);
 	snd_soc_codec_set_drvdata(codec, priv);
 	priv->wm8400 = wm8400;
 
@@ -1325,17 +1326,9 @@ static int  wm8400_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct regmap *wm8400_get_regmap(struct device *dev)
-{
-	struct wm8400 *wm8400 = dev_get_platdata(dev);
-
-	return wm8400->regmap;
-}
-
 static const struct snd_soc_codec_driver soc_codec_dev_wm8400 = {
 	.probe =	wm8400_codec_probe,
 	.remove =	wm8400_codec_remove,
-	.get_regmap =	wm8400_get_regmap,
 	.set_bias_level = wm8400_set_bias_level,
 	.suspend_bias_off = true,
 
-- 
2.15.0
