From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 3/4] ASoC: simple-card-utils: tidyup
 asoc_simple_card_parse_convert()
Date: Wed, 21 Nov 2018 02:10:51 +0000
Message-ID: <87sgzvp4se.wl-kuninori.morimoto.gx@renesas.com>
References: <87wop7p4wk.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400109.outbound.protection.outlook.com [40.107.140.109])
 by alsa0.perex.cz (Postfix) with ESMTP id D6CED267936
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 03:10:55 +0100 (CET)
In-Reply-To: <87wop7p4wk.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <52ED6C9C63D07B439D52A11D7FE1470B@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current simple-card-utils has asoc_simple_card_parse_convert() to parse
convert channel/rate for be_hw_params_fixup.
But, it is parsing from top of node.

If sound card had multi subnode, we need to parse it from each sub node.
This patch tidyup asoc_simple_card_parse_convert() to allow parsing
settings from each node.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/sound/simple_card_utils.h        | 3 ++-
 sound/soc/generic/audio-graph-scu-card.c | 2 +-
 sound/soc/generic/simple-card-utils.c    | 5 +++--
 sound/soc/generic/simple-scu-card.c      | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index fb0318f..d1f1717 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -116,7 +116,8 @@ int asoc_simple_card_clean_reference(struct snd_soc_card *card);
 
 void asoc_simple_card_convert_fixup(struct asoc_simple_card_data *data,
 				      struct snd_pcm_hw_params *params);
-void asoc_simple_card_parse_convert(struct device *dev, char *prefix,
+void asoc_simple_card_parse_convert(struct device *dev,
+				    struct device_node *np, char *prefix,
 				    struct asoc_simple_card_data *data);
 
 int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index 2ba35bd..1f75493 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -204,7 +204,7 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	asoc_simple_card_parse_convert(dev, NULL, &priv->adata);
+	asoc_simple_card_parse_convert(dev, node, NULL, &priv->adata);
 
 	/*
 	 * it supports multi CPU, single CODEC only here
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 2fe7ea2..f588c93 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -32,10 +32,11 @@ void asoc_simple_card_convert_fixup(struct asoc_simple_card_data *data,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_convert_fixup);
 
-void asoc_simple_card_parse_convert(struct device *dev, char *prefix,
+void asoc_simple_card_parse_convert(struct device *dev,
+				    struct device_node *np,
+				    char *prefix,
 				    struct asoc_simple_card_data *data)
 {
-	struct device_node *np = dev->of_node;
 	char prop[128];
 
 	if (!prefix)
diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 85b46f0..2d3ef6e 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -202,7 +202,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	asoc_simple_card_parse_convert(dev, PREFIX, &priv->adata);
+	asoc_simple_card_parse_convert(dev, node, PREFIX, &priv->adata);
 
 	/* find 1st codec */
 	np = of_get_child_by_name(node, PREFIX "codec");
-- 
2.7.4
