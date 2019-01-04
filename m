From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: cleanup DAI link loop
	method - step2" to the asoc tree
Date: Fri,  4 Jan 2019 14:01:22 +0000 (GMT)
Message-ID: <20190104140122.627C611270A3@debutante.sirena.org.uk>
References: <87pntx7ze3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DF0E267B56
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 15:01:22 +0100 (CET)
In-Reply-To: <87pntx7ze3.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-card: cleanup DAI link loop method - step2

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

>From fce9b90c1ab7e915553c57353355700c79b39c86 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Dec 2018 10:46:20 +0900
Subject: [PATCH] ASoC: audio-graph-card: cleanup DAI link loop method - step2

Current audio-graph-card is parsing DAI link for both "normal sound" and
"DPCM sound". On this driver, it needs to count and parse
DAIs/Links/Codec Conf from each links.
Then, counting/parsing link loop are very similar, but using different
implementation. Because of this background, the link loop code is very
mysterious. Mystery code will be trouble in the future.

This patch cleanups the code by using asoc_graph_card_for_each_link()
which judges normal link / DPCM link.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 168 ++++++++++++---------------
 1 file changed, 77 insertions(+), 91 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index fbd32129c518..1152de37110e 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -425,22 +425,80 @@ static int asoc_graph_card_dai_link_of(struct graph_card_data *priv,
 	return 0;
 }
 
-static int asoc_graph_card_parse_of(struct graph_card_data *priv)
+static int asoc_graph_card_for_each_link(struct graph_card_data *priv,
+			struct link_info *li,
+			int (*func_noml)(struct graph_card_data *priv,
+					 struct device_node *cpu_ep,
+					 struct device_node *codec_ep,
+					 struct link_info *li),
+			int (*func_dpcm)(struct graph_card_data *priv,
+					 struct device_node *cpu_ep,
+					 struct device_node *codec_ep,
+					 struct link_info *li, int dup_codec))
 {
 	struct of_phandle_iterator it;
 	struct device *dev = graph_priv_to_dev(priv);
-	struct snd_soc_card *card = graph_priv_to_card(priv);
-	struct device_node *top = dev->of_node;
-	struct device_node *node = top;
+	struct device_node *node = dev->of_node;
 	struct device_node *cpu_port;
-	struct device_node *cpu_ep		= NULL;
-	struct device_node *codec_ep		= NULL;
-	struct device_node *codec_port		= NULL;
-	struct device_node *codec_port_old	= NULL;
+	struct device_node *cpu_ep;
+	struct device_node *codec_ep;
+	struct device_node *codec_port;
+	struct device_node *codec_port_old = NULL;
 	struct asoc_simple_card_data adata;
-	struct link_info li;
 	int rc, ret;
 
+	/* loop for all listed CPU port */
+	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
+		cpu_port = it.node;
+		cpu_ep	 = NULL;
+
+		/* loop for all CPU endpoint */
+		while (1) {
+			cpu_ep = of_get_next_child(cpu_port, cpu_ep);
+			if (!cpu_ep)
+				break;
+
+			/* get codec */
+			codec_ep = of_graph_get_remote_endpoint(cpu_ep);
+			codec_port = of_get_parent(codec_ep);
+
+			of_node_put(codec_ep);
+			of_node_put(codec_port);
+
+			/* get convert-xxx property */
+			memset(&adata, 0, sizeof(adata));
+			asoc_graph_card_get_conversion(dev, codec_ep, &adata);
+			asoc_graph_card_get_conversion(dev, cpu_ep,   &adata);
+
+			/*
+			 * It is DPCM
+			 * if Codec port has many endpoints,
+			 * or has convert-xxx property
+			 */
+			if ((of_get_child_count(codec_port) > 1) ||
+			    adata.convert_rate || adata.convert_channels)
+				ret = func_dpcm(priv, cpu_ep, codec_ep, li,
+						(codec_port_old == codec_port));
+			/* else normal sound */
+			else
+				ret = func_noml(priv, cpu_ep, codec_ep, li);
+
+			if (ret < 0)
+				return ret;
+
+			codec_port_old = codec_port;
+		}
+	}
+
+	return 0;
+}
+
+static int asoc_graph_card_parse_of(struct graph_card_data *priv)
+{
+	struct snd_soc_card *card = graph_priv_to_card(priv);
+	struct link_info li;
+	int ret;
+
 	ret = asoc_simple_card_of_parse_widgets(card, NULL);
 	if (ret < 0)
 		return ret;
@@ -450,7 +508,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 		return ret;
 
 	memset(&li, 0, sizeof(li));
-	codec_port_old	= NULL;
 	for (li.cpu = 1; li.cpu >= 0; li.cpu--) {
 		/*
 		 * Detect all CPU first, and Detect all Codec 2nd.
@@ -464,47 +521,11 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 		 * To avoid random sub-device numbering,
 		 * detect "dummy-Codec" in last;
 		 */
-		of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
-			cpu_port = it.node;
-			cpu_ep	 = NULL;
-			while (1) {
-				cpu_ep = of_get_next_child(cpu_port, cpu_ep);
-				if (!cpu_ep)
-					break;
-
-				codec_ep   = of_graph_get_remote_endpoint(cpu_ep);
-				codec_port = of_get_parent(codec_ep);
-
-				of_node_put(codec_ep);
-				of_node_put(codec_port);
-
-				dev_dbg(dev, "%pOFf <-> %pOFf\n", cpu_ep, codec_ep);
-
-				memset(&adata, 0, sizeof(adata));
-				asoc_graph_card_get_conversion(dev, codec_ep, &adata);
-				asoc_graph_card_get_conversion(dev, cpu_ep,   &adata);
-
-				if ((of_get_child_count(codec_port) > 1) ||
-				    adata.convert_rate ||
-				    adata.convert_channels) {
-					/*
-					 * for DPCM sound
-					 */
-					ret = asoc_graph_card_dai_link_of_dpcm(
-						priv, cpu_ep, codec_ep, &li,
-						(codec_port_old == codec_port));
-				} else if (li.cpu) {
-					/*
-					 * for Normal sound
-					 */
-					ret = asoc_graph_card_dai_link_of(
-						priv, cpu_ep, codec_ep, &li);
-				}
-				if (ret < 0)
-					return ret;
-				codec_port_old = codec_port;
-			}
-		}
+		ret = asoc_graph_card_for_each_link(priv, &li,
+						    asoc_graph_card_dai_link_of,
+						    asoc_graph_card_dai_link_of_dpcm);
+		if (ret < 0)
+			return ret;
 	}
 
 	return asoc_simple_card_parse_card_name(card, NULL);
@@ -551,15 +572,6 @@ static void asoc_graph_get_dais_count(struct graph_card_data *priv,
 				      struct link_info *li)
 {
 	struct device *dev = graph_priv_to_dev(priv);
-	struct of_phandle_iterator it;
-	struct device_node *node = dev->of_node;
-	struct device_node *cpu_port;
-	struct device_node *cpu_ep;
-	struct device_node *codec_ep;
-	struct device_node *codec_port;
-	struct device_node *codec_port_old;
-	struct asoc_simple_card_data adata;
-	int rc;
 
 	/*
 	 * link_num :	number of links.
@@ -607,37 +619,11 @@ static void asoc_graph_get_dais_count(struct graph_card_data *priv,
 	 *	=> 4 DAIs  = 2xCPU + 2xCodec
 	 *	=> 1 ccnf  = 1xdummy-Codec
 	 */
-	codec_port_old = NULL;
-	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
-		cpu_port = it.node;
-		cpu_ep	 = NULL;
-		while (1) {
-			cpu_ep = of_get_next_child(cpu_port, cpu_ep);
-			if (!cpu_ep)
-				break;
-
-			codec_ep = of_graph_get_remote_endpoint(cpu_ep);
-			codec_port = of_get_parent(codec_ep);
-
-			of_node_put(codec_ep);
-			of_node_put(codec_port);
-
-			memset(&adata, 0, sizeof(adata));
-			asoc_graph_card_get_conversion(dev, codec_ep, &adata);
-			asoc_graph_card_get_conversion(dev, cpu_ep,   &adata);
-
-			if ((of_get_child_count(codec_port) > 1) ||
-			    adata.convert_rate || adata.convert_channels) {
-				asoc_graph_card_count_dpcm(priv,
-						cpu_ep, codec_ep, li,
-						(codec_port_old == codec_port));
-			} else {
-				asoc_graph_card_count_noml(priv,
-						cpu_ep, codec_ep, li);
-			}
-			codec_port_old = codec_port;
-		}
-	}
+	asoc_graph_card_for_each_link(priv, li,
+				      asoc_graph_card_count_noml,
+				      asoc_graph_card_count_dpcm);
+	dev_dbg(dev, "link %d, dais %d, ccnf %d\n",
+		li->link, li->dais, li->conf);
 }
 
 static int asoc_graph_soc_card_probe(struct snd_soc_card *card)
-- 
2.20.1
