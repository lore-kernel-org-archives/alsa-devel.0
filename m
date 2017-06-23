From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: support 2nd codec endpoint on DT" to the asoc tree
Date: Fri, 23 Jun 2017 13:03:36 +0100
Message-ID: <E1dONJI-0006Ko-VZ@debutante>
References: <87fuesczrm.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87fuesczrm.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-scu-card: support 2nd codec endpoint on DT

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

>From f1f940490d3ccff96da9cc81d57c2c083c398a18 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jun 2017 06:22:49 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: support 2nd codec endpoint on DT

audio-graph-scu-card can handle below connection which is mainly
for sound mixing purpose.

	+----------+   +-------+
	| CPU0--+--|-->| Codec |
	|       |  |   +-------+
	| CPU1--+  |
	+----------+

>From OF-graph point of view, it should have
CPU0 <-> Codec, and CPU1 <-> Codec on DT.
But current driver doesn't care about 2nd connection
of Codec, because it is dummy from DPCM point of view.

This patch can care 2nd Codec connection, and it should be
supported from OF-graph point of view.
It still have backward compatibility.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/audio-graph-scu-card.txt        |  9 +++++--
 sound/soc/generic/audio-graph-scu-card.c           | 28 +++++++++++++++++++---
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
index b63c5594bbb3..8b8afe9fcb31 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
@@ -90,9 +90,12 @@ Example 2. 2 CPU 1 Codec (Mixing)
 		...
 
 		port {
-			codec_endpoint: endpoint {
+			codec_endpoint0: endpoint {
 				remote-endpoint = <&cpu_endpoint0>;
 			};
+			codec_endpoint1: endpoint {
+				remote-endpoint = <&cpu_endpoint1>;
+			};
 		};
 	};
 
@@ -101,7 +104,7 @@ Example 2. 2 CPU 1 Codec (Mixing)
 		ports {
 			cpu_port0: port {
 				cpu_endpoint0: endpoint {
-					remote-endpoint = <&codec_endpoint>;
+					remote-endpoint = <&codec_endpoint0>;
 
 					dai-format = "left_j";
 					...
@@ -109,6 +112,8 @@ Example 2. 2 CPU 1 Codec (Mixing)
 			};
 			cpu_port1: port {
 				cpu_endpoint1: endpoint {
+					remote-endpoint = <&codec_endpoint1>;
+
 					dai-format = "left_j";
 					...
 				};
diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index 061c7a60d6b4..dcd2df37bc3b 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -183,6 +183,8 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	struct device_node *cpu_ep;
 	struct device_node *codec_ep;
 	struct device_node *rcpu_ep;
+	struct device_node *codec_port;
+	struct device_node *codec_port_old;
 	unsigned int daifmt = 0;
 	int dai_idx, ret;
 	int rc, codec;
@@ -235,6 +237,7 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	}
 
 	dai_idx = 0;
+	codec_port_old = NULL;
 	for (codec = 0; codec < 2; codec++) {
 		/*
 		 * To listup valid sounds continuously,
@@ -245,15 +248,22 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 			cpu_port = it.node;
 			cpu_ep   = of_get_next_child(cpu_port, NULL);
 			codec_ep = of_graph_get_remote_endpoint(cpu_ep);
+			codec_port = of_graph_get_port_parent(codec_ep);
 
 			of_node_put(cpu_port);
 			of_node_put(cpu_ep);
 			of_node_put(codec_ep);
+			of_node_put(codec_port);
 
 			if (codec) {
-				if (!codec_ep)
+				if (!codec_port)
 					continue;
 
+				if (codec_port_old == codec_port)
+					continue;
+
+				codec_port_old = codec_port;
+
 				/* Back-End (= Codec) */
 				ret = asoc_graph_card_dai_link_of(codec_ep, priv, daifmt, dai_idx++, 0);
 				if (ret < 0)
@@ -284,22 +294,34 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	struct device_node *cpu_port;
 	struct device_node *cpu_ep;
 	struct device_node *codec_ep;
+	struct device_node *codec_port;
+	struct device_node *codec_port_old;
 	int count = 0;
 	int rc;
 
+	codec_port_old = NULL;
 	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
 		cpu_port = it.node;
 		cpu_ep   = of_get_next_child(cpu_port, NULL);
 		codec_ep = of_graph_get_remote_endpoint(cpu_ep);
+		codec_port = of_graph_get_port_parent(codec_ep);
 
 		of_node_put(cpu_port);
 		of_node_put(cpu_ep);
 		of_node_put(codec_ep);
+		of_node_put(codec_port);
 
 		if (cpu_ep)
 			count++;
-		if (codec_ep)
-			count++;
+
+		if (!codec_port)
+			continue;
+
+		if (codec_port_old == codec_port)
+			continue;
+
+		count++;
+		codec_port_old = codec_port;
 	}
 
 	return count;
-- 
2.13.1
