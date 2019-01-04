From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: cleanup DAI link loop
	method - step1" to the asoc tree
Date: Fri,  4 Jan 2019 14:01:24 +0000 (GMT)
Message-ID: <20190104140124.423BF11270A3@debutante.sirena.org.uk>
References: <87r2ed7zei.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E6830267C46
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 15:01:24 +0100 (CET)
In-Reply-To: <87r2ed7zei.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-card: cleanup DAI link loop method - step1

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

>From dd98fbc558a035728beed08a16c443f9fd37eb2b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Dec 2018 10:46:05 +0900
Subject: [PATCH] ASoC: audio-graph-card: cleanup DAI link loop method - step1

Current audio-graph-card is parsing DAI link for both "normal sound" and
"DPCM sound". On this driver, it needs to count and parse
DAIs/Links/Codec Conf from each links.
Then, counting/parsing link loop are very similar, but using different
implementation. Because of this background, the link loop code is very
mysterious. Mystery code will be trouble in the future.

This patch adds/modifies counting and parsing function for
"normal sound" and "DPCM sound", and call it from link loop.
This is prepare for cleanup DAI link loop method.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 134 ++++++++++++++++++---------
 1 file changed, 91 insertions(+), 43 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index cd9beb801fc1..fbd32129c518 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -192,23 +192,32 @@ static void asoc_graph_card_get_conversion(struct device *dev,
 	asoc_simple_card_parse_convert(dev, ep,    NULL,   adata);
 }
 
-static int asoc_graph_card_dai_link_of_dpcm(struct device_node *top,
+static int asoc_graph_card_dai_link_of_dpcm(struct graph_card_data *priv,
 					    struct device_node *cpu_ep,
 					    struct device_node *codec_ep,
-					    struct graph_card_data *priv,
-					    struct link_info *li)
+					    struct link_info *li,
+					    int dup_codec)
 {
 	struct device *dev = graph_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, li->link);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, li->link);
+	struct device_node *top = dev->of_node;
 	struct device_node *ep = li->cpu ? cpu_ep : codec_ep;
-	struct device_node *port = of_get_parent(ep);
-	struct device_node *ports = of_get_parent(port);
-	struct device_node *node = of_graph_get_port_parent(ep);
+	struct device_node *port;
+	struct device_node *ports;
+	struct device_node *node;
 	struct asoc_simple_dai *dai;
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	int ret;
 
+	/* Do it all CPU endpoint, and 1st Codec endpoint */
+	if (!li->cpu && dup_codec)
+		return 0;
+
+	port	= of_get_parent(ep);
+	ports	= of_get_parent(port);
+	node	= of_graph_get_port_parent(ep);
+
 	li->link++;
 
 	dev_dbg(dev, "link_of DPCM (%pOF)\n", ep);
@@ -222,6 +231,7 @@ static int asoc_graph_card_dai_link_of_dpcm(struct device_node *top,
 
 	of_node_put(ports);
 	of_node_put(port);
+	of_node_put(node);
 
 	if (li->cpu) {
 
@@ -318,23 +328,32 @@ static int asoc_graph_card_dai_link_of_dpcm(struct device_node *top,
 	return 0;
 }
 
-static int asoc_graph_card_dai_link_of(struct device_node *top,
+static int asoc_graph_card_dai_link_of(struct graph_card_data *priv,
 					struct device_node *cpu_ep,
 					struct device_node *codec_ep,
-					struct graph_card_data *priv,
 					struct link_info *li)
 {
 	struct device *dev = graph_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, li->link);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, li->link);
-	struct device_node *cpu_port = of_get_parent(cpu_ep);
-	struct device_node *codec_port = of_get_parent(codec_ep);
-	struct device_node *cpu_ports = of_get_parent(cpu_port);
-	struct device_node *codec_ports = of_get_parent(codec_port);
+	struct device_node *top = dev->of_node;
+	struct device_node *cpu_port;
+	struct device_node *codec_port;
+	struct device_node *cpu_ports;
+	struct device_node *codec_ports;
 	struct asoc_simple_dai *cpu_dai;
 	struct asoc_simple_dai *codec_dai;
 	int ret;
 
+	/* Do it only CPU turn */
+	if (!li->cpu)
+		return 0;
+
+	cpu_port	= of_get_parent(cpu_ep);
+	cpu_ports	= of_get_parent(cpu_port);
+	codec_port	= of_get_parent(codec_ep);
+	codec_ports	= of_get_parent(codec_port);
+
 	dev_dbg(dev, "link_of (%pOF)\n", cpu_ep);
 
 	li->link++;
@@ -471,22 +490,19 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 					/*
 					 * for DPCM sound
 					 */
-					if (!li.cpu) {
-						if (codec_port_old == codec_port)
-							continue;
-						codec_port_old = codec_port;
-					}
 					ret = asoc_graph_card_dai_link_of_dpcm(
-						top, cpu_ep, codec_ep, priv, &li);
+						priv, cpu_ep, codec_ep, &li,
+						(codec_port_old == codec_port));
 				} else if (li.cpu) {
 					/*
 					 * for Normal sound
 					 */
 					ret = asoc_graph_card_dai_link_of(
-						top, cpu_ep, codec_ep, priv, &li);
+						priv, cpu_ep, codec_ep, &li);
 				}
 				if (ret < 0)
 					return ret;
+				codec_port_old = codec_port;
 			}
 		}
 	}
@@ -494,9 +510,47 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	return asoc_simple_card_parse_card_name(card, NULL);
 }
 
-static void asoc_graph_get_dais_count(struct device *dev,
+static int asoc_graph_card_count_noml(struct graph_card_data *priv,
+				      struct device_node *cpu_ep,
+				      struct device_node *codec_ep,
 				      struct link_info *li)
 {
+	struct device *dev = graph_priv_to_dev(priv);
+
+	li->link += 1; /* 1xCPU-Codec */
+	li->dais += 2; /* 1xCPU + 1xCodec */
+
+	dev_dbg(dev, "Count As Normal\n");
+
+	return 0;
+}
+
+static int asoc_graph_card_count_dpcm(struct graph_card_data *priv,
+				      struct device_node *cpu_ep,
+				      struct device_node *codec_ep,
+				      struct link_info *li,
+				      int dup_codec)
+{
+	struct device *dev = graph_priv_to_dev(priv);
+
+	li->link++; /* 1xCPU-dummy */
+	li->dais++; /* 1xCPU */
+
+	if (!dup_codec) {
+		li->link++; /* 1xdummy-Codec */
+		li->conf++; /* 1xdummy-Codec */
+		li->dais++; /* 1xCodec */
+	}
+
+	dev_dbg(dev, "Count As DPCM\n");
+
+	return 0;
+}
+
+static void asoc_graph_get_dais_count(struct graph_card_data *priv,
+				      struct link_info *li)
+{
+	struct device *dev = graph_priv_to_dev(priv);
 	struct of_phandle_iterator it;
 	struct device_node *node = dev->of_node;
 	struct device_node *cpu_port;
@@ -568,24 +622,18 @@ static void asoc_graph_get_dais_count(struct device *dev,
 			of_node_put(codec_ep);
 			of_node_put(codec_port);
 
-			li->link++;
-			li->dais++;
-
 			memset(&adata, 0, sizeof(adata));
 			asoc_graph_card_get_conversion(dev, codec_ep, &adata);
 			asoc_graph_card_get_conversion(dev, cpu_ep,   &adata);
 
 			if ((of_get_child_count(codec_port) > 1) ||
 			    adata.convert_rate || adata.convert_channels) {
-
-				if (codec_port_old == codec_port)
-					continue;
-
-				li->link++;
-				li->conf++;
-				li->dais++;
+				asoc_graph_card_count_dpcm(priv,
+						cpu_ep, codec_ep, li,
+						(codec_port_old == codec_port));
 			} else {
-				li->dais++;
+				asoc_graph_card_count_noml(priv,
+						cpu_ep, codec_ep, li);
 			}
 			codec_port_old = codec_port;
 		}
@@ -625,8 +673,15 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	card = graph_priv_to_card(priv);
+	card->owner		= THIS_MODULE;
+	card->dev		= dev;
+	card->dapm_widgets	= asoc_graph_card_dapm_widgets;
+	card->num_dapm_widgets	= ARRAY_SIZE(asoc_graph_card_dapm_widgets);
+	card->probe		= asoc_graph_soc_card_probe;
+
 	memset(&li, 0, sizeof(li));
-	asoc_graph_get_dais_count(dev, &li);
+	asoc_graph_get_dais_count(priv, &li);
 	if (!li.link || !li.dais)
 		return -EINVAL;
 
@@ -656,20 +711,13 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	priv->dai_props			= dai_props;
-	priv->dai_link			= dai_link;
-	priv->dais			= dais;
-	priv->codec_conf		= cconf;
+	priv->dai_props		= dai_props;
+	priv->dai_link		= dai_link;
+	priv->dais		= dais;
+	priv->codec_conf	= cconf;
 
-	/* Init snd_soc_card */
-	card = graph_priv_to_card(priv);
-	card->owner		= THIS_MODULE;
-	card->dev		= dev;
 	card->dai_link		= dai_link;
 	card->num_links		= li.link;
-	card->dapm_widgets	= asoc_graph_card_dapm_widgets;
-	card->num_dapm_widgets	= ARRAY_SIZE(asoc_graph_card_dapm_widgets);
-	card->probe		= asoc_graph_soc_card_probe;
 	card->codec_conf	= cconf;
 	card->num_configs	= li.conf;
 
-- 
2.20.1
