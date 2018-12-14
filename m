From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: tidyup prefix for
	snd_soc_codec_conf" to the asoc tree
Date: Fri, 14 Dec 2018 12:37:35 +0000 (GMT)
Message-ID: <20181214123735.A60CE11258A1@debutante.sirena.org.uk>
References: <87efak979e.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C1EA267AB2
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:37:36 +0100 (CET)
In-Reply-To: <87efak979e.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-card: tidyup prefix for snd_soc_codec_conf

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

>From 66164a4da30dd295a1b60568c02bee37cfd9895a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 14 Dec 2018 11:32:43 +0900
Subject: [PATCH] ASoC: audio-graph-card: tidyup prefix for snd_soc_codec_conf

Current audio-graph-card is handling "prefix" by many ways.
But, it is not useful and readable.
We want to do is that allow having it everywere.
This patch supports it.
It will be overwrote if lower node has it.

	sound {
		prefix = "xxx"; // initial
	};

	codec {
		audio-graph-card,prefix = "xxx"; // overwrite
		ports {
			prefix = "xxx"; // overwrite
			port {
				prefix = "xxx"; // overwrite
			};
		};
	};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 368b8ae463af..0d6144560a1e 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -179,12 +179,12 @@ static int asoc_graph_card_dai_link_of_dpcm(struct device_node *top,
 	struct device *dev = graph_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, link_idx);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, link_idx);
-	struct snd_soc_card *card = graph_priv_to_card(priv);
 	struct device_node *ep = is_cpu ? cpu_ep : codec_ep;
 	struct device_node *port = of_get_parent(ep);
 	struct device_node *ports = of_get_parent(port);
 	struct device_node *node = of_graph_get_port_parent(ep);
 	struct asoc_simple_dai *dai;
+	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	int ret;
 
 	dev_dbg(dev, "link_of DPCM (for %s)\n", is_cpu ? "CPU" : "Codec");
@@ -204,10 +204,8 @@ static int asoc_graph_card_dai_link_of_dpcm(struct device_node *top,
 	of_node_put(port);
 
 	if (is_cpu) {
-		struct snd_soc_dai_link_component *codecs;
 
 		/* BE is dummy */
-		codecs			= dai_link->codecs;
 		codecs->of_node		= NULL;
 		codecs->dai_name	= "snd-soc-dummy-dai";
 		codecs->name		= "snd-soc-dummy";
@@ -264,19 +262,19 @@ static int asoc_graph_card_dai_link_of_dpcm(struct device_node *top,
 
 		ret = asoc_simple_card_set_dailink_name(dev, dai_link,
 							"be.%s",
-							dai_link->codecs->dai_name);
+							codecs->dai_name);
 		if (ret < 0)
 			return ret;
 
 		/* check "prefix" from top node */
-		snd_soc_of_parse_audio_prefix(card, cconf,
-					      dai_link->codecs->of_node,
+		snd_soc_of_parse_node_prefix(top, cconf, codecs->of_node,
 					      "prefix");
-		/* check "prefix" from each node if top doesn't have */
-		if (!cconf->of_node)
-			snd_soc_of_parse_node_prefix(node, cconf,
-						     dai_link->codecs->of_node,
-						     PREFIX "prefix");
+		snd_soc_of_parse_node_prefix(node, cconf, codecs->of_node,
+					     PREFIX "prefix");
+		snd_soc_of_parse_node_prefix(ports, cconf, codecs->of_node,
+					     "prefix");
+		snd_soc_of_parse_node_prefix(port, cconf, codecs->of_node,
+					     "prefix");
 	}
 
 	ret = asoc_simple_card_of_parse_tdm(ep, dai);
-- 
2.19.0.rc2
