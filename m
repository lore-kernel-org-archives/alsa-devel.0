From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: add
	asoc_graph_card_get_conversion()" to the asoc tree
Date: Fri,  4 Jan 2019 14:01:42 +0000 (GMT)
Message-ID: <20190104140142.7945111270A3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E09A267C95
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 15:01:43 +0100 (CET)
In-Reply-To: 
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

   ASoC: audio-graph-card: add asoc_graph_card_get_conversion()

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

>From 40dfae169ad047535d566a4791daae3b08f71c0c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Dec 2018 10:45:48 +0900
Subject: [PATCH] ASoC: audio-graph-card: add asoc_graph_card_get_conversion()

audio-graph-card is now supporting normal sound and DPCM sound.
For DPCM sound, original sound card (= audio-graph-scu) had been
supported 1 CPU : 1 Codec connection which uses hw_params_fixup()
for convert-rate/channel.
But, merged audio-graph-card is completely forgeting about it.

To re-support 1 CPU : 1 Codec DPCM for hw_params_fixup(),
it need to judge whether it is DPCM by checking convert-rate/channel.
For this purpose, this patch adds asoc_graph_card_get_conversion()
as preparation

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 0d6144560a1e..c3e80bc27e80 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -169,6 +169,22 @@ static int asoc_graph_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
+static void asoc_graph_card_get_conversion(struct device *dev,
+					   struct device_node *ep,
+					   struct asoc_simple_card_data *adata)
+{
+	struct device_node *top = dev->of_node;
+	struct device_node *port = of_get_parent(ep);
+	struct device_node *ports = of_get_parent(port);
+	struct device_node *node = of_graph_get_port_parent(ep);
+
+	asoc_simple_card_parse_convert(dev, top,   NULL,   adata);
+	asoc_simple_card_parse_convert(dev, node,  PREFIX, adata);
+	asoc_simple_card_parse_convert(dev, ports, NULL,   adata);
+	asoc_simple_card_parse_convert(dev, port,  NULL,   adata);
+	asoc_simple_card_parse_convert(dev, ep,    NULL,   adata);
+}
+
 static int asoc_graph_card_dai_link_of_dpcm(struct device_node *top,
 					    struct device_node *cpu_ep,
 					    struct device_node *codec_ep,
@@ -194,11 +210,7 @@ static int asoc_graph_card_dai_link_of_dpcm(struct device_node *top,
 	of_property_read_u32(port,  "mclk-fs", &dai_props->mclk_fs);
 	of_property_read_u32(ep,    "mclk-fs", &dai_props->mclk_fs);
 
-	asoc_simple_card_parse_convert(dev, top,   NULL,   &dai_props->adata);
-	asoc_simple_card_parse_convert(dev, node,  PREFIX, &dai_props->adata);
-	asoc_simple_card_parse_convert(dev, ports, NULL,   &dai_props->adata);
-	asoc_simple_card_parse_convert(dev, port,  NULL,   &dai_props->adata);
-	asoc_simple_card_parse_convert(dev, ep,    NULL,   &dai_props->adata);
+	asoc_graph_card_get_conversion(dev, ep, &dai_props->adata);
 
 	of_node_put(ports);
 	of_node_put(port);
-- 
2.20.1
