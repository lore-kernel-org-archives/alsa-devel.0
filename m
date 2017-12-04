From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_component_init_regmap() on
	cq93vc" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:38 +0000
Message-ID: <E1eLvoA-0000Xw-4S@debutante>
References: <87k21jkl9r.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 86C68267664
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:41 +0100 (CET)
In-Reply-To: <87k21jkl9r.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: use snd_soc_component_init_regmap() on cq93vc

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

>From 60e1780ef27c626c7eaabae6103a218102b6e6ba Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Nov 2017 06:05:46 +0000
Subject: [PATCH] ASoC: use snd_soc_component_init_regmap() on cq93vc

To setup regmap, ALSA SoC has snd_soc_component_init_regmap() and
.get_regmap. But these are duplicated feature.
Let's use snd_soc_component_init_regmap() and remove .get_regmap

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cq93vc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 6ed2cc374768..3bf93652bb31 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -121,17 +121,19 @@ static struct snd_soc_dai_driver cq93vc_dai = {
 	.ops = &cq93vc_dai_ops,
 };
 
-static struct regmap *cq93vc_get_regmap(struct device *dev)
+static int cq93vc_probe(struct snd_soc_component *component)
 {
-	struct davinci_vc *davinci_vc = dev->platform_data;
+	struct davinci_vc *davinci_vc = component->dev->platform_data;
 
-	return davinci_vc->regmap;
+	snd_soc_component_init_regmap(component, davinci_vc->regmap);
+
+	return 0;
 }
 
 static const struct snd_soc_codec_driver soc_codec_dev_cq93vc = {
 	.set_bias_level = cq93vc_set_bias_level,
-	.get_regmap = cq93vc_get_regmap,
 	.component_driver = {
+		.probe = cq93vc_probe,
 		.controls = cq93vc_snd_controls,
 		.num_controls = ARRAY_SIZE(cq93vc_snd_controls),
 	},
-- 
2.15.0
