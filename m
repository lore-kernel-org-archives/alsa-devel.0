From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_component_init_regmap() on
	88pm860x" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:29 +0000
Message-ID: <E1eLvo1-0000VZ-9R@debutante>
References: <87h8wnkl8q.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B412526764A
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:32 +0100 (CET)
In-Reply-To: <87h8wnkl8q.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: use snd_soc_component_init_regmap() on 88pm860x

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

>From 79b4885967cff17e0344b451e8fc4782013f0c9c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Nov 2017 06:06:15 +0000
Subject: [PATCH] ASoC: use snd_soc_component_init_regmap() on 88pm860x

To setup regmap, ALSA SoC has snd_soc_component_init_regmap() and
.get_regmap. But these are duplicated feature.
Let's use snd_soc_component_init_regmap() and remove .get_regmap

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/88pm860x-codec.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 848c5fe49bc7..be8ea723dff9 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1319,6 +1319,7 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 	int i, ret;
 
 	pm860x->codec = codec;
+	snd_soc_codec_init_regmap(codec,  pm860x->regmap);
 
 	for (i = 0; i < 4; i++) {
 		ret = request_threaded_irq(pm860x->irq[i], NULL,
@@ -1348,18 +1349,10 @@ static int pm860x_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct regmap *pm860x_get_regmap(struct device *dev)
-{
-	struct pm860x_priv *pm860x = dev_get_drvdata(dev);
-
-	return pm860x->regmap;
-}
-
 static const struct snd_soc_codec_driver soc_codec_dev_pm860x = {
 	.probe		= pm860x_probe,
 	.remove		= pm860x_remove,
 	.set_bias_level	= pm860x_set_bias_level,
-	.get_regmap	= pm860x_get_regmap,
 
 	.component_driver = {
 		.controls		= pm860x_snd_controls,
-- 
2.15.0
