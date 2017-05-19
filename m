From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add support graph base DT phase 2" to the asoc tree
Date: Fri, 19 May 2017 18:37:07 +0100
Message-ID: <E1dBlpr-000516-Kf@debutante>
References: <87h90jot4o.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87h90jot4o.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add support graph base DT phase 2

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

>From 4d4b334bda47f1b7b57f7aca9bc19b7e317d764d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 May 2017 01:28:06 +0000
Subject: [PATCH] ASoC: rsnd: add support graph base DT phase 2

To enable OF-graph base DT on rsnd driver, and to keep compatible
previous normal sound card style, it need to support both
"rcar_sound,dai" and "ports" (or "port") on DT.

This patch parses both style.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 159 +++++++++++++++++++++++++----------------------
 1 file changed, 84 insertions(+), 75 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 72a3139b70c3..41b2e782b0bf 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -810,33 +810,95 @@ static struct device_node *rsnd_dai_of_node(struct rsnd_priv *priv,
 	return ret;
 }
 
-static int rsnd_dai_probe(struct rsnd_priv *priv)
+static void __rsnd_dai_probe(struct rsnd_priv *priv,
+			     struct device_node *dai_np,
+			     int dai_i, int is_graph)
 {
-	struct device_node *dai_node;
-	struct device_node *dai_np;
 	struct device_node *playback, *capture;
 	struct rsnd_dai_stream *io_playback;
 	struct rsnd_dai_stream *io_capture;
-	struct snd_soc_dai_driver *rdrv, *drv;
+	struct snd_soc_dai_driver *drv;
 	struct rsnd_dai *rdai;
 	struct device *dev = rsnd_priv_to_dev(priv);
-	int nr, dai_i, io_i;
+	int io_i;
+
+	rdai		= rsnd_rdai_get(priv, dai_i);
+	drv		= priv->daidrv + dai_i;
+	io_playback	= &rdai->playback;
+	io_capture	= &rdai->capture;
+
+	snprintf(rdai->name, RSND_DAI_NAME_SIZE, "rsnd-dai.%d", dai_i);
+
+	rdai->priv	= priv;
+	drv->name	= rdai->name;
+	drv->ops	= &rsnd_soc_dai_ops;
+
+	snprintf(rdai->playback.name, RSND_DAI_NAME_SIZE,
+		 "DAI%d Playback", dai_i);
+	drv->playback.rates		= RSND_RATES;
+	drv->playback.formats		= RSND_FMTS;
+	drv->playback.channels_min	= 2;
+	drv->playback.channels_max	= 6;
+	drv->playback.stream_name	= rdai->playback.name;
+
+	snprintf(rdai->capture.name, RSND_DAI_NAME_SIZE,
+		 "DAI%d Capture", dai_i);
+	drv->capture.rates		= RSND_RATES;
+	drv->capture.formats		= RSND_FMTS;
+	drv->capture.channels_min	= 2;
+	drv->capture.channels_max	= 6;
+	drv->capture.stream_name	= rdai->capture.name;
+
+	rdai->playback.rdai		= rdai;
+	rdai->capture.rdai		= rdai;
+	rsnd_set_slot(rdai, 2, 1); /* default */
+
+	for (io_i = 0;; io_i++) {
+		playback = of_parse_phandle(dai_np, "playback", io_i);
+		capture  = of_parse_phandle(dai_np, "capture", io_i);
+
+		if (!playback && !capture)
+			break;
+
+		rsnd_parse_connect_ssi(rdai, playback, capture);
+		rsnd_parse_connect_src(rdai, playback, capture);
+		rsnd_parse_connect_ctu(rdai, playback, capture);
+		rsnd_parse_connect_mix(rdai, playback, capture);
+		rsnd_parse_connect_dvc(rdai, playback, capture);
+
+		of_node_put(playback);
+		of_node_put(capture);
+	}
+
+	dev_dbg(dev, "%s (%s/%s)\n", rdai->name,
+		rsnd_io_to_mod_ssi(io_playback) ? "play"    : " -- ",
+		rsnd_io_to_mod_ssi(io_capture) ? "capture" : "  --   ");
+}
+
+static int rsnd_dai_probe(struct rsnd_priv *priv)
+{
+	struct device_node *dai_node;
+	struct device_node *dai_np;
+	struct snd_soc_dai_driver *rdrv;
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct rsnd_dai *rdai;
+	int nr;
 	int is_graph;
-	int ret;
+	int dai_i;
 
 	dai_node = rsnd_dai_of_node(priv, &is_graph);
-	nr = of_get_child_count(dai_node);
-	if (!nr) {
-		ret = -EINVAL;
-		goto rsnd_dai_probe_done;
-	}
+	if (is_graph)
+		nr = of_graph_get_endpoint_count(dai_node);
+	else
+		nr = of_get_child_count(dai_node);
+
+	if (!nr)
+		return -EINVAL;
 
 	rdrv = devm_kzalloc(dev, sizeof(*rdrv) * nr, GFP_KERNEL);
 	rdai = devm_kzalloc(dev, sizeof(*rdai) * nr, GFP_KERNEL);
-	if (!rdrv || !rdai) {
-		ret = -ENOMEM;
-		goto rsnd_dai_probe_done;
-	}
+	if (!rdrv || !rdai)
+		return -ENOMEM;
 
 	priv->rdai_nr	= nr;
 	priv->daidrv	= rdrv;
@@ -846,68 +908,15 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 	 * parse all dai
 	 */
 	dai_i = 0;
-	for_each_child_of_node(dai_node, dai_np) {
-		rdai		= rsnd_rdai_get(priv, dai_i);
-		drv		= rdrv + dai_i;
-		io_playback	= &rdai->playback;
-		io_capture	= &rdai->capture;
-
-		snprintf(rdai->name, RSND_DAI_NAME_SIZE, "rsnd-dai.%d", dai_i);
-
-		rdai->priv	= priv;
-		drv->name	= rdai->name;
-		drv->ops	= &rsnd_soc_dai_ops;
-
-		snprintf(rdai->playback.name, RSND_DAI_NAME_SIZE,
-			 "DAI%d Playback", dai_i);
-		drv->playback.rates		= RSND_RATES;
-		drv->playback.formats		= RSND_FMTS;
-		drv->playback.channels_min	= 2;
-		drv->playback.channels_max	= 6;
-		drv->playback.stream_name	= rdai->playback.name;
-
-		snprintf(rdai->capture.name, RSND_DAI_NAME_SIZE,
-			 "DAI%d Capture", dai_i);
-		drv->capture.rates		= RSND_RATES;
-		drv->capture.formats		= RSND_FMTS;
-		drv->capture.channels_min	= 2;
-		drv->capture.channels_max	= 6;
-		drv->capture.stream_name	= rdai->capture.name;
-
-		rdai->playback.rdai		= rdai;
-		rdai->capture.rdai		= rdai;
-		rsnd_set_slot(rdai, 2, 1); /* default */
-
-		for (io_i = 0;; io_i++) {
-			playback = of_parse_phandle(dai_np, "playback", io_i);
-			capture  = of_parse_phandle(dai_np, "capture", io_i);
-
-			if (!playback && !capture)
-				break;
-
-			rsnd_parse_connect_ssi(rdai, playback, capture);
-			rsnd_parse_connect_src(rdai, playback, capture);
-			rsnd_parse_connect_ctu(rdai, playback, capture);
-			rsnd_parse_connect_mix(rdai, playback, capture);
-			rsnd_parse_connect_dvc(rdai, playback, capture);
-
-			of_node_put(playback);
-			of_node_put(capture);
-		}
-
-		dai_i++;
-
-		dev_dbg(dev, "%s (%s/%s)\n", rdai->name,
-			rsnd_io_to_mod_ssi(io_playback) ? "play"    : " -- ",
-			rsnd_io_to_mod_ssi(io_capture) ? "capture" : "  --   ");
+	if (is_graph) {
+		for_each_endpoint_of_node(dai_node, dai_np)
+			__rsnd_dai_probe(priv, dai_np, dai_i++, is_graph);
+	} else {
+		for_each_child_of_node(dai_node, dai_np)
+			__rsnd_dai_probe(priv, dai_np, dai_i++, is_graph);
 	}
 
-	ret = 0;
-
-rsnd_dai_probe_done:
-	of_node_put(dai_node);
-
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.11.0
