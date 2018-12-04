From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 2/7] ASoC: simple-scu-card: tidyup
 asoc_simple_card_parse_daifmt() timing
Date: Tue, 4 Dec 2018 08:20:13 +0000
Message-ID: <87bm613e6b.wl-kuninori.morimoto.gx@renesas.com>
References: <87efax3e85.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410109.outbound.protection.outlook.com [40.107.141.109])
 by alsa0.perex.cz (Postfix) with ESMTP id B4594267B37
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 09:20:16 +0100 (CET)
In-Reply-To: <87efax3e85.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <D25B074E343B2545BDA14C4B4CCE6CD7@jpnprd01.prod.outlook.com>
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

Current simple-scu-card driver is parsing codec position for DPCM
and consider DAI format. But, current operation is doing totally pointless,
because it should be called for each CPU/Codec pair.
Let's tidyup asoc_simple_card_parse_daifmt() timing.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/simple-scu-card.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 7ae1901..77c1efb 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -92,17 +92,24 @@ static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static int asoc_simple_card_dai_link_of(struct device_node *np,
+static int asoc_simple_card_dai_link_of(struct device_node *link,
+					struct device_node *np,
+					struct device_node *codec,
 					struct simple_card_data *priv,
-					unsigned int daifmt,
-					int idx, bool is_fe)
+					int idx, bool is_fe,
+					bool is_top_level_node)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, idx);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, idx);
 	struct snd_soc_card *card = simple_priv_to_card(priv);
+	char *prefix = "";
 	int ret;
 
+	/* For single DAI link & old style of DT node */
+	if (is_top_level_node)
+		prefix = PREFIX;
+
 	if (is_fe) {
 		int is_single_links = 0;
 		struct snd_soc_dai_link_component *codecs;
@@ -178,7 +185,11 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 	if (ret < 0)
 		return ret;
 
-	dai_link->dai_fmt		= daifmt;
+	ret = asoc_simple_card_parse_daifmt(dev, link, codec,
+					    prefix, &dai_link->dai_fmt);
+	if (ret < 0)
+		return ret;
+
 	dai_link->dpcm_playback		= 1;
 	dai_link->dpcm_capture		= 1;
 	dai_link->ops			= &asoc_simple_card_ops;
@@ -191,10 +202,10 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 
 {
 	struct device *dev = simple_priv_to_dev(priv);
+	struct device_node *node = dev->of_node;
 	struct device_node *np;
+	struct device_node *codec;
 	struct snd_soc_card *card = simple_priv_to_card(priv);
-	struct device_node *node = dev->of_node;
-	unsigned int daifmt = 0;
 	bool is_fe;
 	int ret, i;
 
@@ -211,22 +222,18 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 
 	asoc_simple_card_parse_convert(dev, node, PREFIX, &priv->adata);
 
-	/* find 1st codec */
-	np = of_get_child_by_name(node, PREFIX "codec");
-	if (!np)
+	i = 0;
+	codec = of_get_child_by_name(node, PREFIX "codec");
+	if (!codec)
 		return -ENODEV;
 
-	ret = asoc_simple_card_parse_daifmt(dev, node, np, PREFIX, &daifmt);
-	if (ret < 0)
-		return ret;
-
-	i = 0;
 	for_each_child_of_node(node, np) {
 		is_fe = false;
 		if (strcmp(np->name, PREFIX "cpu") == 0)
 			is_fe = true;
 
-		ret = asoc_simple_card_dai_link_of(np, priv, daifmt, i, is_fe);
+		ret = asoc_simple_card_dai_link_of(node, np, codec, priv,
+						   i, is_fe, true);
 		if (ret < 0)
 			return ret;
 		i++;
-- 
2.7.4
