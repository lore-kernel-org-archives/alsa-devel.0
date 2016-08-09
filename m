From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use asoc_simple_card_init_dai()" to the asoc tree
Date: Tue, 09 Aug 2016 13:43:57 +0100
Message-ID: <E1bX6Nx-0003YA-JX@debutante>
References: <87eg8xqcq9.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87eg8xqcq9.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use asoc_simple_card_init_dai()

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d8cb9354c86dddb1fb67d3f247c9ebbacd6b4c07 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 9 Aug 2016 05:48:53 +0000
Subject: [PATCH] ASoC: simple-card: use asoc_simple_card_init_dai()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 99028c190ea3..03ecca85a724 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -179,51 +179,19 @@ static struct snd_soc_ops asoc_simple_card_ops = {
 	.hw_params = asoc_simple_card_hw_params,
 };
 
-static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
-				       struct asoc_simple_dai *set)
-{
-	int ret;
-
-	if (set->sysclk) {
-		ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk, 0);
-		if (ret && ret != -ENOTSUPP) {
-			dev_err(dai->dev, "simple-card: set_sysclk error\n");
-			goto err;
-		}
-	}
-
-	if (set->slots) {
-		ret = snd_soc_dai_set_tdm_slot(dai,
-					       set->tx_slot_mask,
-					       set->rx_slot_mask,
-						set->slots,
-						set->slot_width);
-		if (ret && ret != -ENOTSUPP) {
-			dev_err(dai->dev, "simple-card: set_tdm_slot error\n");
-			goto err;
-		}
-	}
-
-	ret = 0;
-
-err:
-	return ret;
-}
-
 static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *codec = rtd->codec_dai;
 	struct snd_soc_dai *cpu = rtd->cpu_dai;
-	struct simple_dai_props *dai_props;
+	struct simple_dai_props *dai_props = &priv->dai_props[rtd->num];
 	int ret;
 
-	dai_props = &priv->dai_props[rtd->num];
-	ret = __asoc_simple_card_dai_init(codec, &dai_props->codec_dai);
+	ret = asoc_simple_card_init_dai(codec, &dai_props->codec_dai);
 	if (ret < 0)
 		return ret;
 
-	ret = __asoc_simple_card_dai_init(cpu, &dai_props->cpu_dai);
+	ret = asoc_simple_card_init_dai(cpu, &dai_props->cpu_dai);
 	if (ret < 0)
 		return ret;
 
-- 
2.8.1
