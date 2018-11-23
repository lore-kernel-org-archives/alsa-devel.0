From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: tidyup
	asoc_simple_card_parse_daifmt() timing" to the asoc tree
Date: Fri, 23 Nov 2018 14:11:47 +0000 (GMT)
Message-ID: <20181123141147.94678440078@finisterre.ee.mobilebroadband>
References: <87pnuylyyv.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F01A267A7F
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:11:49 +0100 (CET)
In-Reply-To: <87pnuylyyv.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-scu-card: tidyup asoc_simple_card_parse_daifmt() timing

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

>From 338d7159c488268dd4ccc6a69ab4af8f829f75d0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Nov 2018 00:57:09 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: tidyup
 asoc_simple_card_parse_daifmt() timing

Current audio-graph-scu-card driver is parsing codec position for DPCM
and consider DAI format. But, current operation is doing totally pointless,
because 1) asoc_simple_card_parse_daifmt() will be called not only for 1st
codec on current implementation, and it will be used as fixed format
2) it should be called for each CPU/Codec pair.
Let's tidyup asoc_simple_card_parse_daifmt() timing.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-scu-card.c | 54 +++++++-----------------
 1 file changed, 16 insertions(+), 38 deletions(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index 0f13f11e0d88..ce1f1085ad25 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -96,15 +96,16 @@ static int asoc_graph_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static int asoc_graph_card_dai_link_of(struct device_node *ep,
+static int asoc_graph_card_dai_link_of(struct device_node *cpu_ep,
+				       struct device_node *codec_ep,
 				       struct graph_card_data *priv,
-				       unsigned int daifmt,
 				       int idx, int is_fe)
 {
 	struct device *dev = graph_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, idx);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, idx);
 	struct snd_soc_card *card = graph_priv_to_card(priv);
+	struct device_node *ep = is_fe ? cpu_ep : codec_ep;
 	struct device_node *node = of_graph_get_port_parent(ep);
 	int ret;
 
@@ -185,7 +186,11 @@ static int asoc_graph_card_dai_link_of(struct device_node *ep,
 	if (ret < 0)
 		return ret;
 
-	dai_link->dai_fmt		= daifmt;
+	ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
+					    NULL, &dai_link->dai_fmt);
+	if (ret < 0)
+		return ret;
+
 	dai_link->dpcm_playback		= 1;
 	dai_link->dpcm_capture		= 1;
 	dai_link->ops			= &asoc_graph_card_ops;
@@ -205,7 +210,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	struct device_node *codec_ep;
 	struct device_node *codec_port;
 	struct device_node *codec_port_old;
-	unsigned int daifmt = 0;
 	int dai_idx, ret;
 	int rc, codec;
 
@@ -228,26 +232,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	 * see asoc_graph_get_dais_count
 	 */
 
-	/* find 1st codec */
-	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
-		cpu_port = it.node;
-		cpu_ep   = of_get_next_child(cpu_port, NULL);
-		codec_ep = of_graph_get_remote_endpoint(cpu_ep);
-
-		of_node_put(cpu_ep);
-		of_node_put(codec_ep);
-
-		if (!codec_ep)
-			continue;
-
-		ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
-							    NULL, &daifmt);
-		if (ret < 0) {
-			of_node_put(cpu_port);
-			goto parse_of_err;
-		}
-	}
-
 	dai_idx = 0;
 	codec_port_old = NULL;
 	for (codec = 0; codec < 2; codec++) {
@@ -264,28 +248,22 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 
 			of_node_put(cpu_ep);
 			of_node_put(codec_ep);
+			of_node_put(cpu_port);
 			of_node_put(codec_port);
+			it.node = NULL;
 
 			if (codec) {
 				if (codec_port_old == codec_port)
 					continue;
 
 				codec_port_old = codec_port;
-
-				/* Back-End (= Codec) */
-				ret = asoc_graph_card_dai_link_of(codec_ep, priv, daifmt, dai_idx++, 0);
-				if (ret < 0) {
-					of_node_put(cpu_port);
-					goto parse_of_err;
-				}
-			} else {
-				/* Front-End (= CPU) */
-				ret = asoc_graph_card_dai_link_of(cpu_ep, priv, daifmt, dai_idx++, 1);
-				if (ret < 0) {
-					of_node_put(cpu_port);
-					goto parse_of_err;
-				}
 			}
+
+			ret = asoc_graph_card_dai_link_of(cpu_ep, codec_ep,
+							  priv, dai_idx++,
+							  !codec);
+			if (ret < 0)
+				goto parse_of_err;
 		}
 	}
 
-- 
2.19.1
