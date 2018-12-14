From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: tidyup
	convert_rate/channel method" to the asoc tree
Date: Fri, 14 Dec 2018 12:37:37 +0000 (GMT)
Message-ID: <20181214123737.7DD4211258A1@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F32F6267A78
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:37:37 +0100 (CET)
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

   ASoC: audio-graph-card: tidyup convert_rate/channel method

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

>From 7ced65ffb82fa58c6e314c16770288fe9ce3dfc8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 14 Dec 2018 11:32:36 +0900
Subject: [PATCH] ASoC: audio-graph-card: tidyup convert_rate/channel method

Current audio-graph-card is handling "convert_rate/channel"
by many ways. But, it is not useful and readable.
We want to do is that allow having it everywere.
This patch support it.
It will be overwrote if lower node has it.

sound {
	convert-channels = <xxx>; // initial
};

codec {
	audio-graph-card,convert-channels = <xxx>; // overwrite
	ports {
		convert_channels = <xxx>; // overwrite
		port {
			convert_channels = <xxx>; // overwrite
			endpoint {
				convert_channels = <xxx>; // overwrite
			};
		};
	};
};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 7e32380e7a6f..368b8ae463af 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -35,7 +35,6 @@ struct graph_card_data {
 	struct asoc_simple_jack mic_jack;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_dai *dais;
-	struct asoc_simple_card_data adata;
 	struct snd_soc_codec_conf *codec_conf;
 	struct gpio_desc *pa_gpio;
 };
@@ -167,9 +166,6 @@ static int asoc_graph_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	asoc_simple_card_convert_fixup(&dai_props->adata, params);
 
-	/* overwrite by top level adata if exist */
-	asoc_simple_card_convert_fixup(&priv->adata, params);
-
 	return 0;
 }
 
@@ -197,6 +193,13 @@ static int asoc_graph_card_dai_link_of_dpcm(struct device_node *top,
 	of_property_read_u32(ports, "mclk-fs", &dai_props->mclk_fs);
 	of_property_read_u32(port,  "mclk-fs", &dai_props->mclk_fs);
 	of_property_read_u32(ep,    "mclk-fs", &dai_props->mclk_fs);
+
+	asoc_simple_card_parse_convert(dev, top,   NULL,   &dai_props->adata);
+	asoc_simple_card_parse_convert(dev, node,  PREFIX, &dai_props->adata);
+	asoc_simple_card_parse_convert(dev, ports, NULL,   &dai_props->adata);
+	asoc_simple_card_parse_convert(dev, port,  NULL,   &dai_props->adata);
+	asoc_simple_card_parse_convert(dev, ep,    NULL,   &dai_props->adata);
+
 	of_node_put(ports);
 	of_node_put(port);
 
@@ -276,8 +279,6 @@ static int asoc_graph_card_dai_link_of_dpcm(struct device_node *top,
 						     PREFIX "prefix");
 	}
 
-	asoc_simple_card_parse_convert(dev, node, PREFIX, &dai_props->adata);
-
 	ret = asoc_simple_card_of_parse_tdm(ep, dai);
 	if (ret)
 		return ret;
@@ -409,8 +410,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	asoc_simple_card_parse_convert(dev, node, NULL, &priv->adata);
-
 	link_idx	= 0;
 	dai_idx		= 0;
 	conf_idx	= 0;
-- 
2.19.0.rc2
