From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: share
	asoc_simple_be_hw_params_fixup()" to the asoc tree
Date: Thu, 21 Mar 2019 15:06:51 +0000 (GMT)
Message-ID: <20190321150651.9478F11288EC@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D3A5F89717
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:06:52 +0100 (CET)
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

   ASoC: simple-card-utils: share asoc_simple_be_hw_params_fixup()

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

>From 629f75440a68220a78aef9d8569831824890c47d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Mar 2019 13:56:06 +0900
Subject: [PATCH] ASoC: simple-card-utils: share
 asoc_simple_be_hw_params_fixup()

The difference between simple-card / audio-graph are just using
OF graph style, or not. In other words, other things should be same.
This means, simple-card/audio-graph common functions should be
implemented at simple-card-utils, and its own functions should be
implemented at each files.

Current simple-card / audio-graph have almost same functions.
This patch shares asoc_simple_be_hw_params_fixup() between in these
2 drivers.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 ++
 sound/soc/generic/audio-graph-card.c  | 13 +------------
 sound/soc/generic/simple-card-utils.c | 12 ++++++++++++
 sound/soc/generic/simple-card.c       | 13 +------------
 4 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 204343789ae7..20d41bb14ea8 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -89,6 +89,8 @@ void asoc_simple_shutdown(struct snd_pcm_substream *substream);
 int asoc_simple_hw_params(struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params);
 int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd);
+int asoc_simple_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				   struct snd_pcm_hw_params *params);
 
 #define asoc_simple_card_parse_cpu(node, dai_link,				\
 				   list_name, cells_name, is_single_link)	\
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index b1ceefc60879..605126fb2810 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -62,17 +62,6 @@ static const struct snd_soc_ops graph_ops = {
 	.hw_params	= asoc_simple_hw_params,
 };
 
-static int graph_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-				    struct snd_pcm_hw_params *params)
-{
-	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
-
-	asoc_simple_card_convert_fixup(&dai_props->adata, params);
-
-	return 0;
-}
-
 static void graph_parse_convert(struct device *dev,
 				struct device_node *ep,
 				struct asoc_simple_card_data *adata)
@@ -186,7 +175,7 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 		/* BE settings */
 		dai_link->no_pcm		= 1;
-		dai_link->be_hw_params_fixup	= graph_be_hw_params_fixup;
+		dai_link->be_hw_params_fixup	= asoc_simple_be_hw_params_fixup;
 
 		dai =
 		dai_props->codec_dai	= &priv->dais[li->dais++];
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index c9b53b340028..ec4a010400a0 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -293,6 +293,18 @@ int asoc_simple_hw_params(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_hw_params);
 
+int asoc_simple_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				   struct snd_pcm_hw_params *params)
+{
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
+
+	asoc_simple_card_convert_fixup(&dai_props->adata, params);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_be_hw_params_fixup);
+
 int asoc_simple_card_parse_dai(struct device_node *node,
 				    struct snd_soc_dai_link_component *dlc,
 				    struct device_node **dai_of_node,
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index bf4482ecfe3e..60a88a55c071 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -32,17 +32,6 @@ static const struct snd_soc_ops simple_ops = {
 	.hw_params	= asoc_simple_hw_params,
 };
 
-static int simple_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-				     struct snd_pcm_hw_params *params)
-{
-	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
-
-	asoc_simple_card_convert_fixup(&dai_props->adata, params);
-
-	return 0;
-}
-
 static void simple_parse_convert(struct device *dev,
 				 struct device_node *np,
 				 struct asoc_simple_card_data *adata)
@@ -154,7 +143,7 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 		/* BE settings */
 		dai_link->no_pcm		= 1;
-		dai_link->be_hw_params_fixup	= simple_be_hw_params_fixup;
+		dai_link->be_hw_params_fixup	= asoc_simple_be_hw_params_fixup;
 
 		dai =
 		dai_props->codec_dai	= &priv->dais[li->dais++];
-- 
2.20.1
