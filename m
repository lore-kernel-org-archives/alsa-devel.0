From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph: rename
	graph_get_conversion() to graph_parse_convert()" to the asoc tree
Date: Mon, 18 Mar 2019 14:50:56 +0000 (GMT)
Message-ID: <20190318145056.849181128874@debutante.sirena.org.uk>
References: <871s34ztk5.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59554F80C0B
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 15:51:02 +0100 (CET)
In-Reply-To: <871s34ztk5.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph: rename graph_get_conversion() to graph_parse_convert()

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

>From d2bf008ad11abc52d6e084bc109be2ee34a74a14 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Mar 2019 13:50:25 +0900
Subject: [PATCH] ASoC: audio-graph: rename graph_get_conversion() to
 graph_parse_convert()

use same naming rule, and this patch add missing of_node_put() on it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index bb12351330e8..733ba1e89dd6 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -176,9 +176,9 @@ static int graph_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static void graph_get_conversion(struct device *dev,
-				 struct device_node *ep,
-				 struct asoc_simple_card_data *adata)
+static void graph_parse_convert(struct device *dev,
+				struct device_node *ep,
+				struct asoc_simple_card_data *adata)
 {
 	struct device_node *top = dev->of_node;
 	struct device_node *port = of_get_parent(ep);
@@ -190,6 +190,10 @@ static void graph_get_conversion(struct device *dev,
 	asoc_simple_card_parse_convert(dev, ports, NULL,   adata);
 	asoc_simple_card_parse_convert(dev, port,  NULL,   adata);
 	asoc_simple_card_parse_convert(dev, ep,    NULL,   adata);
+
+	of_node_put(port);
+	of_node_put(ports);
+	of_node_put(node);
 }
 
 static int graph_dai_link_of_dpcm(struct graph_priv *priv,
@@ -227,7 +231,7 @@ static int graph_dai_link_of_dpcm(struct graph_priv *priv,
 	of_property_read_u32(port,  "mclk-fs", &dai_props->mclk_fs);
 	of_property_read_u32(ep,    "mclk-fs", &dai_props->mclk_fs);
 
-	graph_get_conversion(dev, ep, &dai_props->adata);
+	graph_parse_convert(dev, ep, &dai_props->adata);
 
 	of_node_put(ports);
 	of_node_put(port);
@@ -462,8 +466,8 @@ static int graph_for_each_link(struct graph_priv *priv,
 
 			/* get convert-xxx property */
 			memset(&adata, 0, sizeof(adata));
-			graph_get_conversion(dev, codec_ep, &adata);
-			graph_get_conversion(dev, cpu_ep,   &adata);
+			graph_parse_convert(dev, codec_ep, &adata);
+			graph_parse_convert(dev, cpu_ep,   &adata);
 
 			/*
 			 * It is DPCM
-- 
2.20.1
