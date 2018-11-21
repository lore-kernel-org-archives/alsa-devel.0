From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: tidyup
	asoc_simple_card_parse_convert()" to the asoc tree
Date: Wed, 21 Nov 2018 13:29:23 +0000 (GMT)
Message-ID: <20181121132923.421FA11250AE@debutante.sirena.org.uk>
References: <87sgzvp4se.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 05D31267A61
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 14:29:23 +0100 (CET)
In-Reply-To: <87sgzvp4se.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: tidyup asoc_simple_card_parse_convert()

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

>From a48bf02b35d9325eedb56ab531038511695a2734 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Nov 2018 02:10:51 +0000
Subject: [PATCH] ASoC: simple-card-utils: tidyup
 asoc_simple_card_parse_convert()

Current simple-card-utils has asoc_simple_card_parse_convert() to parse
convert channel/rate for be_hw_params_fixup.
But, it is parsing from top of node.

If sound card had multi subnode, we need to parse it from each sub node.
This patch tidyup asoc_simple_card_parse_convert() to allow parsing
settings from each node.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h        | 3 ++-
 sound/soc/generic/audio-graph-scu-card.c | 2 +-
 sound/soc/generic/simple-card-utils.c    | 5 +++--
 sound/soc/generic/simple-scu-card.c      | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index fb0318f9b10f..d1f17172dce2 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -116,7 +116,8 @@ int asoc_simple_card_clean_reference(struct snd_soc_card *card);
 
 void asoc_simple_card_convert_fixup(struct asoc_simple_card_data *data,
 				      struct snd_pcm_hw_params *params);
-void asoc_simple_card_parse_convert(struct device *dev, char *prefix,
+void asoc_simple_card_parse_convert(struct device *dev,
+				    struct device_node *np, char *prefix,
 				    struct asoc_simple_card_data *data);
 
 int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index 2ba35bdd3b38..1f754933ea9f 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -204,7 +204,7 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	asoc_simple_card_parse_convert(dev, NULL, &priv->adata);
+	asoc_simple_card_parse_convert(dev, node, NULL, &priv->adata);
 
 	/*
 	 * it supports multi CPU, single CODEC only here
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index f3183a4718b3..a16373193b56 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -32,10 +32,11 @@ void asoc_simple_card_convert_fixup(struct asoc_simple_card_data *data,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_convert_fixup);
 
-void asoc_simple_card_parse_convert(struct device *dev, char *prefix,
+void asoc_simple_card_parse_convert(struct device *dev,
+				    struct device_node *np,
+				    char *prefix,
 				    struct asoc_simple_card_data *data)
 {
-	struct device_node *np = dev->of_node;
 	char prop[128];
 
 	if (!prefix)
diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 85b46f0eae0f..2d3ef6ebe863 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -202,7 +202,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	asoc_simple_card_parse_convert(dev, PREFIX, &priv->adata);
+	asoc_simple_card_parse_convert(dev, node, PREFIX, &priv->adata);
 
 	/* find 1st codec */
 	np = of_get_child_by_name(node, PREFIX "codec");
-- 
2.19.0.rc2
