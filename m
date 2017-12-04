From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_component_init_regmap() on
	si476x" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:44 +0000
Message-ID: <E1eLvoG-0000bf-6b@debutante>
References: <87mv6fklbj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A2BE3267679
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:47 +0100 (CET)
In-Reply-To: <87mv6fklbj.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: use snd_soc_component_init_regmap() on si476x

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

>From 3047ec50c3ebbe082217dc20ec0db4f3e5c7abea Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Nov 2017 06:05:15 +0000
Subject: [PATCH] ASoC: use snd_soc_component_init_regmap() on si476x

To setup regmap, ALSA SoC has snd_soc_component_init_regmap() and
.get_regmap. But these are duplicated feature.
Let's use snd_soc_component_init_regmap() and remove .get_regmap

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/si476x.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 354dc0d64f11..7b91ee267b4e 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -231,14 +231,17 @@ static struct snd_soc_dai_driver si476x_dai = {
 	.ops		= &si476x_dai_ops,
 };
 
-static struct regmap *si476x_get_regmap(struct device *dev)
+static int si476x_probe(struct snd_soc_component *component)
 {
-	return dev_get_regmap(dev->parent, NULL);
+	snd_soc_component_init_regmap(component,
+				dev_get_regmap(component->dev->parent, NULL));
+
+	return 0;
 }
 
 static const struct snd_soc_codec_driver soc_codec_dev_si476x = {
-	.get_regmap = si476x_get_regmap,
 	.component_driver = {
+		.probe			= si476x_probe,
 		.dapm_widgets		= si476x_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(si476x_dapm_widgets),
 		.dapm_routes		= si476x_dapm_routes,
-- 
2.15.0
