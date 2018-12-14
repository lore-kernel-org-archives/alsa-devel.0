From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: tidyup mclk-fs method" to
	the asoc tree
Date: Fri, 14 Dec 2018 12:37:30 +0000 (GMT)
Message-ID: <20181214123730.2783111258A1@debutante.sirena.org.uk>
References: <878t0s9755.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BC0DB26798A
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:37:30 +0100 (CET)
In-Reply-To: <878t0s9755.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card: tidyup mclk-fs method

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

>From 79e834914d1fa2d078c586094ad347cc05aa428c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 14 Dec 2018 11:35:15 +0900
Subject: [PATCH] ASoC: simple-card: tidyup mclk-fs method

Current simple-card is handling "mclk-fs" by many way.
But, it is not useful and readable.
We want to do is that allow having mclk-fs everywere.
This patch support it.
It will be overwrote if lower node has it.

sound {
	simple-audio-card,mclk-fs = <xxx>; // for initial

	simple-audio-card,dai-link {
		mclk-fs = <xxx>; // overwrite
		cpu {
			mclk-fs = <xxx>; // overwrite
		};
		codec {
			mclk-fs = <xxx>; // overwrite
		};
	};
};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index c93f2e7dec4b..8593d51e0c6c 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -26,7 +26,6 @@ struct simple_card_data {
 		struct snd_soc_codec_conf *codec_conf;
 		unsigned int mclk_fs;
 	} *dai_props;
-	unsigned int mclk_fs;
 	struct asoc_simple_jack hp_jack;
 	struct asoc_simple_jack mic_jack;
 	struct snd_soc_dai_link *dai_link;
@@ -102,9 +101,7 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 	unsigned int mclk, mclk_fs = 0;
 	int ret = 0;
 
-	if (priv->mclk_fs)
-		mclk_fs = priv->mclk_fs;
-	else if (dai_props->mclk_fs)
+	if (dai_props->mclk_fs)
 		mclk_fs = dai_props->mclk_fs;
 
 	if (mclk_fs) {
@@ -172,7 +169,8 @@ static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static int asoc_simple_card_dai_link_of_dpcm(struct device_node *node,
+static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
+					     struct device_node *node,
 					     struct device_node *np,
 					     struct device_node *codec,
 					     struct simple_card_data *priv,
@@ -185,6 +183,7 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *node,
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, link_idx);
 	struct snd_soc_card *card = simple_priv_to_card(priv);
 	struct asoc_simple_dai *dai;
+	char prop[128];
 	char *prefix = "";
 	int ret;
 
@@ -278,7 +277,10 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *node,
 	if (ret < 0)
 		return ret;
 
-	of_property_read_u32(np, "mclk-fs", &dai_props->mclk_fs);
+	snprintf(prop, sizeof(prop), "%smclk-fs", prefix);
+	of_property_read_u32(top,  PREFIX "mclk-fs", &dai_props->mclk_fs);
+	of_property_read_u32(node, prop, &dai_props->mclk_fs);
+	of_property_read_u32(np,   prop, &dai_props->mclk_fs);
 
 	ret = asoc_simple_card_parse_daifmt(dev, node, codec,
 					    prefix, &dai_link->dai_fmt);
@@ -293,7 +295,8 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *node,
 	return 0;
 }
 
-static int asoc_simple_card_dai_link_of(struct device_node *node,
+static int asoc_simple_card_dai_link_of(struct device_node *top,
+					struct device_node *node,
 					struct simple_card_data *priv,
 					int *dai_idx, int link_idx,
 					bool is_top_level_node)
@@ -345,7 +348,11 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	of_property_read_u32(node, "mclk-fs", &dai_props->mclk_fs);
+	snprintf(prop, sizeof(prop), "%smclk-fs", prefix);
+	of_property_read_u32(top,  PREFIX "mclk-fs", &dai_props->mclk_fs);
+	of_property_read_u32(node,  prop, &dai_props->mclk_fs);
+	of_property_read_u32(cpu,   prop, &dai_props->mclk_fs);
+	of_property_read_u32(codec, prop, &dai_props->mclk_fs);
 
 	ret = asoc_simple_card_parse_cpu(cpu, dai_link,
 					 DAI, CELL, &single_cpu);
@@ -453,9 +460,6 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	/* Factor to mclk, used in hw_params() */
-	of_property_read_u32(top, PREFIX "mclk-fs", &priv->mclk_fs);
-
 	asoc_simple_card_parse_convert(dev, top, PREFIX, &priv->adata);
 
 	/* Single/Muti DAI link(s) & New style of DT node */
@@ -482,13 +486,13 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 				is_fe = (np != codec);
 
 				ret = asoc_simple_card_dai_link_of_dpcm(
-						node, np, codec, priv,
+						top, node, np, codec, priv,
 						&dai_idx, link_idx++, &conf_idx,
 						is_fe, !loop);
 			}
 		} else {
 			ret = asoc_simple_card_dai_link_of(
-						node, priv,
+						top, node, priv,
 						&dai_idx, link_idx++, !loop);
 		}
 		if (ret < 0)
-- 
2.19.0.rc2
