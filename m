From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 1/4] ASoC: audio-graph-scu-card: care link /
	dai count
Date: Mon, 26 Nov 2018 04:59:04 +0000
Message-ID: <87a7lw30k9.wl-kuninori.morimoto.gx@renesas.com>
References: <87bm6c30kz.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400093.outbound.protection.outlook.com [40.107.140.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 383C82679A7
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 05:59:06 +0100 (CET)
In-Reply-To: <87bm6c30kz.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <ED5D81C3E0E5814C971D4772DEE8F46B@jpnprd01.prod.outlook.com>
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

In DPCM case, it uses CPU-dummy / dummy-Codec dai links.
If sound card is caring only DPCM, link count = dai count,
but, if non DPCM case, link count != dai count.
Now, we want to merge audio-graph-card and audio-graph-scu-card,
then, we need to care both link / dai count more carefly
This patch cares it, and prepare for merging audio card

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/audio-graph-scu-card.c | 59 ++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index ce1f108..96ecd5a 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -277,7 +277,10 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	return ret;
 }
 
-static int asoc_graph_get_dais_count(struct device *dev)
+static void asoc_graph_get_dais_count(struct device *dev,
+				      int *link_num,
+				      int *dais_num,
+				      int *ccnf_num)
 {
 	struct of_phandle_iterator it;
 	struct device_node *node = dev->of_node;
@@ -286,10 +289,31 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	struct device_node *codec_ep;
 	struct device_node *codec_port;
 	struct device_node *codec_port_old;
-	int count = 0;
+	struct device_node *codec_port_old2;
 	int rc;
 
+	/*
+	 * ex1)
+	 *
+	 * CPU0 --- Codec0	link : 5
+	 * CPU1 --- Codec1	dais : 7
+	 * CPU2 -/		ccnf : 1
+	 * CPU3 --- Codec2
+	 *
+	 * ex2)
+	 * CPU0 --- Codec0	link : 5
+	 * CPU1 --- Codec1	dais : 6
+	 * CPU2 -/		ccnf : 1
+	 * CPU3 -/
+	 *
+	 * ex3)
+	 * CPU0 --- Codec0	link : 6
+	 * CPU1 -/		dais : 6
+	 * CPU2 --- Codec1	ccnf : 2
+	 * CPU3 -/
+	 */
 	codec_port_old = NULL;
+	codec_port_old2 = NULL;
 	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
 		cpu_port = it.node;
 		cpu_ep   = of_get_next_child(cpu_port, NULL);
@@ -300,16 +324,22 @@ static int asoc_graph_get_dais_count(struct device *dev)
 		of_node_put(codec_ep);
 		of_node_put(codec_port);
 
-		count++;
+		(*link_num)++;
+		(*dais_num)++;
+
+		if (codec_port_old == codec_port) {
+			if (codec_port_old2 != codec_port_old) {
+				(*link_num)++;
+				(*ccnf_num)++;
+			}
 
-		if (codec_port_old == codec_port)
+			codec_port_old2 = codec_port_old;
 			continue;
+		}
 
-		count++;
+		(*dais_num)++;
 		codec_port_old = codec_port;
 	}
-
-	return count;
 }
 
 static int asoc_graph_card_probe(struct platform_device *pdev)
@@ -319,19 +349,20 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	struct graph_dai_props *dai_props;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card;
-	int num, ret, i;
+	int lnum = 0, dnum = 0, cnum = 0;
+	int ret, i;
 
 	/* Allocate the private data and the DAI link array */
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	num = asoc_graph_get_dais_count(dev);
-	if (num == 0)
+	asoc_graph_get_dais_count(dev, &lnum, &dnum, &cnum);
+	if (!lnum || !dnum)
 		return -EINVAL;
 
-	dai_props = devm_kcalloc(dev, num, sizeof(*dai_props), GFP_KERNEL);
-	dai_link  = devm_kcalloc(dev, num, sizeof(*dai_link), GFP_KERNEL);
+	dai_props = devm_kcalloc(dev, lnum, sizeof(*dai_props), GFP_KERNEL);
+	dai_link  = devm_kcalloc(dev, lnum, sizeof(*dai_link),  GFP_KERNEL);
 	if (!dai_props || !dai_link)
 		return -ENOMEM;
 
@@ -341,7 +372,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	 * see
 	 *	soc-core.c :: snd_soc_init_multicodec()
 	 */
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < lnum; i++) {
 		dai_link[i].codecs	= &dai_props[i].codecs;
 		dai_link[i].num_codecs	= 1;
 		dai_link[i].platform	= &dai_props[i].platform;
@@ -355,7 +386,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	card->owner		= THIS_MODULE;
 	card->dev		= dev;
 	card->dai_link		= priv->dai_link;
-	card->num_links		= num;
+	card->num_links		= lnum;
 	card->codec_conf	= &priv->codec_conf;
 	card->num_configs	= 1;
 
-- 
2.7.4
