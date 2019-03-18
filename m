From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph: add graph_parse_mclk_fs()"
	to the asoc tree
Date: Mon, 18 Mar 2019 14:50:54 +0000 (GMT)
Message-ID: <20190318145054.5A2221128874@debutante.sirena.org.uk>
References: <87zhpsyezj.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 348F8F80709
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 15:50:56 +0100 (CET)
In-Reply-To: <87zhpsyezj.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph: add graph_parse_mclk_fs()

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

>From 4346a745df4107d7ac61846f60087992e9d6e1b8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Mar 2019 13:50:31 +0900
Subject: [PATCH] ASoC: audio-graph: add graph_parse_mclk_fs()

It is parsing mclk_fs at many places, but it should be
same operation. This patch adds graph_parse_mclk_fs()
and parse it.

This patch also renames similar function graph_get_conversion()
to graph_parse_convert().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 50 +++++++++++++---------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 733ba1e89dd6..7dd772a895e2 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -196,6 +196,24 @@ static void graph_parse_convert(struct device *dev,
 	of_node_put(node);
 }
 
+static void graph_parse_mclk_fs(struct device_node *top,
+				struct device_node *ep,
+				struct graph_dai_props *props)
+{
+	struct device_node *port	= of_get_parent(ep);
+	struct device_node *ports	= of_get_parent(port);
+	struct device_node *node	= of_graph_get_port_parent(ep);
+
+	of_property_read_u32(top,	"mclk-fs", &props->mclk_fs);
+	of_property_read_u32(ports,	"mclk-fs", &props->mclk_fs);
+	of_property_read_u32(port,	"mclk-fs", &props->mclk_fs);
+	of_property_read_u32(ep,	"mclk-fs", &props->mclk_fs);
+
+	of_node_put(port);
+	of_node_put(ports);
+	of_node_put(node);
+}
+
 static int graph_dai_link_of_dpcm(struct graph_priv *priv,
 				  struct device_node *cpu_ep,
 				  struct device_node *codec_ep,
@@ -226,13 +244,6 @@ static int graph_dai_link_of_dpcm(struct graph_priv *priv,
 
 	dev_dbg(dev, "link_of DPCM (%pOF)\n", ep);
 
-	of_property_read_u32(top,   "mclk-fs", &dai_props->mclk_fs);
-	of_property_read_u32(ports, "mclk-fs", &dai_props->mclk_fs);
-	of_property_read_u32(port,  "mclk-fs", &dai_props->mclk_fs);
-	of_property_read_u32(ep,    "mclk-fs", &dai_props->mclk_fs);
-
-	graph_parse_convert(dev, ep, &dai_props->adata);
-
 	of_node_put(ports);
 	of_node_put(port);
 	of_node_put(node);
@@ -311,6 +322,9 @@ static int graph_dai_link_of_dpcm(struct graph_priv *priv,
 					     "prefix");
 	}
 
+	graph_parse_convert(dev, ep, &dai_props->adata);
+	graph_parse_mclk_fs(top, ep, dai_props);
+
 	asoc_simple_card_canonicalize_platform(dai_link);
 
 	ret = asoc_simple_card_of_parse_tdm(ep, dai);
@@ -339,10 +353,6 @@ static int graph_dai_link_of(struct graph_priv *priv,
 	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, li->link);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, li->link);
 	struct device_node *top = dev->of_node;
-	struct device_node *cpu_port;
-	struct device_node *cpu_ports;
-	struct device_node *codec_port;
-	struct device_node *codec_ports;
 	struct asoc_simple_dai *cpu_dai;
 	struct asoc_simple_dai *codec_dai;
 	int ret;
@@ -351,11 +361,6 @@ static int graph_dai_link_of(struct graph_priv *priv,
 	if (!li->cpu)
 		return 0;
 
-	cpu_port	= of_get_parent(cpu_ep);
-	cpu_ports	= of_get_parent(cpu_port);
-	codec_port	= of_get_parent(codec_ep);
-	codec_ports	= of_get_parent(codec_port);
-
 	dev_dbg(dev, "link_of (%pOF)\n", cpu_ep);
 
 	li->link++;
@@ -366,17 +371,8 @@ static int graph_dai_link_of(struct graph_priv *priv,
 	dai_props->codec_dai	= &priv->dais[li->dais++];
 
 	/* Factor to mclk, used in hw_params() */
-	of_property_read_u32(top,         "mclk-fs", &dai_props->mclk_fs);
-	of_property_read_u32(cpu_ports,   "mclk-fs", &dai_props->mclk_fs);
-	of_property_read_u32(codec_ports, "mclk-fs", &dai_props->mclk_fs);
-	of_property_read_u32(cpu_port,    "mclk-fs", &dai_props->mclk_fs);
-	of_property_read_u32(codec_port,  "mclk-fs", &dai_props->mclk_fs);
-	of_property_read_u32(cpu_ep,      "mclk-fs", &dai_props->mclk_fs);
-	of_property_read_u32(codec_ep,    "mclk-fs", &dai_props->mclk_fs);
-	of_node_put(cpu_port);
-	of_node_put(cpu_ports);
-	of_node_put(codec_port);
-	of_node_put(codec_ports);
+	graph_parse_mclk_fs(top, cpu_ep,   dai_props);
+	graph_parse_mclk_fs(top, codec_ep, dai_props);
 
 	ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
 					    NULL, &dai_link->dai_fmt);
-- 
2.20.1
