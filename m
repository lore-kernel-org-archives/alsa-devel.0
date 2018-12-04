From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 3/7] ASoC: simple-scu-card: add dai-link support
Date: Tue, 4 Dec 2018 08:20:26 +0000
Message-ID: <87a7ll3e5y.wl-kuninori.morimoto.gx@renesas.com>
References: <87efax3e85.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400123.outbound.protection.outlook.com [40.107.140.123])
 by alsa0.perex.cz (Postfix) with ESMTP id CEA09267B37
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 09:20:28 +0100 (CET)
In-Reply-To: <87efax3e85.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <641592CEB9284443A00DCFFAD6E2244C@jpnprd01.prod.outlook.com>
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

simple-card is supporting dai-link support, but simple-scu-card
doesn't have it.
This patch support it. This is prepare for merging simple-card
and simple-scu-card.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/simple-scu-card.c | 46 ++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 77c1efb..666ace6 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -202,14 +202,15 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 
 {
 	struct device *dev = simple_priv_to_dev(priv);
-	struct device_node *node = dev->of_node;
+	struct device_node *top = dev->of_node;
+	struct device_node *node;
 	struct device_node *np;
 	struct device_node *codec;
 	struct snd_soc_card *card = simple_priv_to_card(priv);
 	bool is_fe;
-	int ret, i;
+	int ret, i, loop;
 
-	if (!node)
+	if (!top)
 		return -EINVAL;
 
 	ret = asoc_simple_card_of_parse_widgets(card, PREFIX);
@@ -220,25 +221,34 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	asoc_simple_card_parse_convert(dev, node, PREFIX, &priv->adata);
+	asoc_simple_card_parse_convert(dev, top, PREFIX, &priv->adata);
 
+	loop = 1;
 	i = 0;
-	codec = of_get_child_by_name(node, PREFIX "codec");
-	if (!codec)
-		return -ENODEV;
-
-	for_each_child_of_node(node, np) {
-		is_fe = false;
-		if (strcmp(np->name, PREFIX "cpu") == 0)
-			is_fe = true;
-
-		ret = asoc_simple_card_dai_link_of(node, np, codec, priv,
-						   i, is_fe, true);
-		if (ret < 0)
-			return ret;
-		i++;
+	node = of_get_child_by_name(top, PREFIX "dai-link");
+	if (!node) {
+		node = dev->of_node;
+		loop = 0;
 	}
 
+	do  {
+		codec = of_get_child_by_name(node,
+					     loop ? "codec" : PREFIX "codec");
+		if (!codec)
+			return -ENODEV;
+
+		for_each_child_of_node(node, np) {
+			is_fe = (np != codec);
+
+			ret = asoc_simple_card_dai_link_of(node, np, codec, priv,
+							   i, is_fe, !loop);
+			if (ret < 0)
+				return ret;
+			i++;
+		}
+		node = of_get_next_child(top, node);
+	} while (loop && node);
+
 	ret = asoc_simple_card_parse_card_name(card, PREFIX);
 	if (ret < 0)
 		return ret;
-- 
2.7.4
