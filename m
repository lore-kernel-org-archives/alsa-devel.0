From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add support graph base DT phase 1" to the asoc tree
Date: Fri, 19 May 2017 18:37:11 +0100
Message-ID: <E1dBlpv-00052c-Vx@debutante>
References: <87inkzot58.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87inkzot58.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add support graph base DT phase 1

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

>From 11d0f8ed6dc3e553b20329bc85f2a1aefb5f180f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 May 2017 01:27:48 +0000
Subject: [PATCH] ASoC: rsnd: add support graph base DT phase 1

To enable OF-graph base DT on rsnd driver, and to keep compatible
previous normal sound card style, it need to support both
"rcar_sound,dai" and "ports" (or "port") on DT.

This patch modify rsnd_dai_of_node() to parse
"rcar_sound,dai" and "ports" (or "port") as phase 1. It can detect
graph base style, but do nothing at this point.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 39 ++++++++++++++++++++++++++++++++++++++-
 sound/soc/sh/rcar/rsnd.h |  2 +-
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 3c47af1990cb..72a3139b70c3 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -774,6 +774,42 @@ void rsnd_parse_connect_common(struct rsnd_dai *rdai,
 	of_node_put(node);
 }
 
+static struct device_node *rsnd_dai_of_node(struct rsnd_priv *priv,
+					    int *is_graph)
+{
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct device_node *np = dev->of_node;
+	struct device_node *dai_node;
+	struct device_node *ret;
+
+	*is_graph = 0;
+
+	/*
+	 * parse both previous dai (= rcar_sound,dai), and
+	 * graph dai (= ports/port)
+	 */
+	dai_node = of_get_child_by_name(np, RSND_NODE_DAI);
+	if (dai_node) {
+		ret = dai_node;
+		goto of_node_compatible;
+	}
+
+	ret = np;
+
+	dai_node = of_graph_get_next_endpoint(np, NULL);
+	if (dai_node)
+		goto of_node_graph;
+
+	return NULL;
+
+of_node_graph:
+	*is_graph = 1;
+of_node_compatible:
+	of_node_put(dai_node);
+
+	return ret;
+}
+
 static int rsnd_dai_probe(struct rsnd_priv *priv)
 {
 	struct device_node *dai_node;
@@ -785,9 +821,10 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 	struct rsnd_dai *rdai;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	int nr, dai_i, io_i;
+	int is_graph;
 	int ret;
 
-	dai_node = rsnd_dai_of_node(priv);
+	dai_node = rsnd_dai_of_node(priv, &is_graph);
 	nr = of_get_child_count(dai_node);
 	if (!nr) {
 		ret = -EINVAL;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index dbf4163427e8..4d8e0584b644 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -18,6 +18,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_graph.h>
 #include <linux/of_irq.h>
 #include <linux/sh_dma.h>
 #include <linux/workqueue.h>
@@ -475,7 +476,6 @@ int rsnd_dai_pointer_offset(struct rsnd_dai_stream *io, int additional);
 int rsnd_dai_connect(struct rsnd_mod *mod,
 		     struct rsnd_dai_stream *io,
 		     enum rsnd_mod_type type);
-#define rsnd_dai_of_node(priv) rsnd_parse_of_node(priv, RSND_NODE_DAI)
 
 /*
  *	R-Car Gen1/Gen2
-- 
2.11.0
