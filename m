From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_component_init_regmap() on
	mc13783" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:41 +0000
Message-ID: <E1eLvoD-0000aN-55@debutante>
References: <87lglzkla8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C85626766D
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:44 +0100 (CET)
In-Reply-To: <87lglzkla8.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: use snd_soc_component_init_regmap() on mc13783

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

>From 33953d851d37f8b62b96d70fdccd35b62dffebe8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Nov 2017 06:05:31 +0000
Subject: [PATCH] ASoC: use snd_soc_component_init_regmap() on mc13783

To setup regmap, ALSA SoC has snd_soc_component_init_regmap() and
.get_regmap. But these are duplicated feature.
Let's use snd_soc_component_init_regmap() and remove .get_regmap

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/mc13783.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 4fd8d1dc4eef..be7a45f05bbf 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -610,6 +610,9 @@ static int mc13783_probe(struct snd_soc_codec *codec)
 {
 	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
 
+	snd_soc_codec_init_regmap(codec,
+				  dev_get_regmap(codec->dev->parent, NULL));
+
 	/* these are the reset values */
 	mc13xxx_reg_write(priv->mc13xxx, MC13783_AUDIO_RX0, 0x25893);
 	mc13xxx_reg_write(priv->mc13xxx, MC13783_AUDIO_RX1, 0x00d35A);
@@ -728,15 +731,9 @@ static struct snd_soc_dai_driver mc13783_dai_sync[] = {
 	}
 };
 
-static struct regmap *mc13783_get_regmap(struct device *dev)
-{
-	return dev_get_regmap(dev->parent, NULL);
-}
-
 static const struct snd_soc_codec_driver soc_codec_dev_mc13783 = {
 	.probe		= mc13783_probe,
 	.remove		= mc13783_remove,
-	.get_regmap	= mc13783_get_regmap,
 	.component_driver = {
 		.controls		= mc13783_control_list,
 		.num_controls		= ARRAY_SIZE(mc13783_control_list),
-- 
2.15.0
