From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: share same dev_dbg() for sysclk" to the asoc tree
Date: Tue, 06 Jun 2017 20:05:54 +0100
Message-ID: <E1dIJne-00079x-0Z@debutante>
References: <87a85ndpve.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87a85ndpve.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: share same dev_dbg() for sysclk

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

>From 8e16638256425faf74c5b9ffa40e5f0d9aa4413b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 5 Jun 2017 04:28:45 +0000
Subject: [PATCH] ASoC: simple-card-utils: share same dev_dbg() for sysclk

Let's share same debug message for sysclk

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h        | 9 ++++++---
 sound/soc/generic/audio-graph-card.c     | 7 -------
 sound/soc/generic/audio-graph-scu-card.c | 5 -----
 sound/soc/generic/simple-card-utils.c    | 5 ++++-
 sound/soc/generic/simple-card.c          | 7 -------
 sound/soc/generic/simple-scu-card.c      | 5 -----
 6 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index efab584af11b..108cae459ed0 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -35,13 +35,16 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 				     char *prefix);
 
 #define asoc_simple_card_parse_clk_cpu(dev, node, dai_link, simple_dai)		\
-	asoc_simple_card_parse_clk(dev, node, dai_link->cpu_of_node, simple_dai)
+	asoc_simple_card_parse_clk(dev, node, dai_link->cpu_of_node, simple_dai, \
+				   dai_link->cpu_dai_name)
 #define asoc_simple_card_parse_clk_codec(dev, node, dai_link, simple_dai)	\
-	asoc_simple_card_parse_clk(dev, node, dai_link->codec_of_node, simple_dai)
+	asoc_simple_card_parse_clk(dev, node, dai_link->codec_of_node, simple_dai,\
+				   dai_link->codec_dai_name)
 int asoc_simple_card_parse_clk(struct device *dev,
 			       struct device_node *node,
 			       struct device_node *dai_of_node,
-			       struct asoc_simple_dai *simple_dai);
+			       struct asoc_simple_dai *simple_dai,
+			       const char *name);
 
 #define asoc_simple_card_parse_cpu(node, dai_link,				\
 				   list_name, cells_name, is_single_link)	\
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 2c3a1cc01442..0180b286bee3 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -169,13 +169,6 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	dai_link->ops = &asoc_graph_card_ops;
 	dai_link->init = asoc_graph_card_dai_init;
 
-	dev_dbg(dev, "\tcpu : %s / %d\n",
-		dai_link->cpu_dai_name,
-		cpu_dai->sysclk);
-	dev_dbg(dev, "\tcodec : %s / %d\n",
-		dai_link->codec_dai_name,
-		codec_dai->sysclk);
-
 	asoc_simple_card_canonicalize_cpu(dai_link,
 					  card->num_links == 1);
 
diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index 1ce727b6bc21..0066102f5bc4 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -185,11 +185,6 @@ static int asoc_graph_card_dai_link_of(struct device_node *ep,
 	dai_link->ops			= &asoc_graph_card_ops;
 	dai_link->init			= asoc_graph_card_dai_init;
 
-	dev_dbg(dev, "\t%s / %04x / %d\n",
-		dai_link->name,
-		dai_link->dai_fmt,
-		dai_props->sysclk);
-
 	return 0;
 }
 
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 1f08064f65b1..d9d8b8a58348 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -113,7 +113,8 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
 int asoc_simple_card_parse_clk(struct device *dev,
 			       struct device_node *node,
 			       struct device_node *dai_of_node,
-			       struct asoc_simple_dai *simple_dai)
+			       struct asoc_simple_dai *simple_dai,
+			       const char *name)
 {
 	struct clk *clk;
 	u32 val;
@@ -136,6 +137,8 @@ int asoc_simple_card_parse_clk(struct device *dev,
 			simple_dai->sysclk = clk_get_rate(clk);
 	}
 
+	dev_dbg(dev, "%s : sysclk = %d\n", name, simple_dai->sysclk);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_clk);
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 1da0e2b068c3..e86c6e16146b 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -301,13 +301,6 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	dai_link->ops = &asoc_simple_card_ops;
 	dai_link->init = asoc_simple_card_dai_init;
 
-	dev_dbg(dev, "\tcpu : %s / %d\n",
-		dai_link->cpu_dai_name,
-		dai_props->cpu_dai.sysclk);
-	dev_dbg(dev, "\tcodec : %s / %d\n",
-		dai_link->codec_dai_name,
-		dai_props->codec_dai.sysclk);
-
 	asoc_simple_card_canonicalize_cpu(dai_link, single_cpu);
 
 dai_link_of_err:
diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 5f4384f322c1..9a251400685e 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -189,11 +189,6 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 	dai_link->ops			= &asoc_simple_card_ops;
 	dai_link->init			= asoc_simple_card_dai_init;
 
-	dev_dbg(dev, "\t%s / %04x / %d\n",
-		dai_link->name,
-		dai_link->dai_fmt,
-		dai_props->sysclk);
-
 	return 0;
 }
 
-- 
2.11.0
