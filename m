From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 2/5] ASoC: simple-scu-card: care link / dai
	count
Date: Tue, 11 Dec 2018 03:25:08 +0000
Message-ID: <878t0wbvp6.wl-kuninori.morimoto.gx@renesas.com>
References: <87bm5sbvq6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400122.outbound.protection.outlook.com [40.107.140.122])
 by alsa0.perex.cz (Postfix) with ESMTP id A8E99267B64
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 04:25:11 +0100 (CET)
In-Reply-To: <87bm5sbvq6.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <863268A3482D1D4BB866FF37D4269234@jpnprd01.prod.outlook.com>
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
Now, we want to merge simple-card and simple-scu-card,
then, we need to care both link / dai count more carefly
This patch cares it, and prepare for merging simple card

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/simple-scu-card.c | 90 ++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 7 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 666ace6..1c6382f 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -256,6 +256,80 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	return 0;
 }
 
+static void asoc_simple_card_get_dais_count(struct device *dev,
+					    int *link_num,
+					    int *dais_num,
+					    int *ccnf_num)
+{
+	struct device_node *top = dev->of_node;
+	struct device_node *node;
+	int loop;
+	int num;
+
+	/*
+	 * link_num :	number of links.
+	 *		CPU-Codec / CPU-dummy / dummy-Codec
+	 * dais_num :	number of DAIs
+	 * ccnf_num :	number of codec_conf
+	 *		same number for "dummy-Codec"
+	 *
+	 * ex1)
+	 * CPU0 --- Codec0	link : 5
+	 * CPU1 --- Codec1	dais : 7
+	 * CPU2 -/		ccnf : 1
+	 * CPU3 --- Codec2
+	 *
+	 *	=> 5 links = 2xCPU-Codec + 2xCPU-dummy + 1xdummy-Codec
+	 *	=> 7 DAIs  = 4xCPU + 3xCodec
+	 *	=> 1 ccnf  = 1xdummy-Codec
+	 *
+	 * ex2)
+	 * CPU0 --- Codec0	link : 5
+	 * CPU1 --- Codec1	dais : 6
+	 * CPU2 -/		ccnf : 1
+	 * CPU3 -/
+	 *
+	 *	=> 5 links = 1xCPU-Codec + 3xCPU-dummy + 1xdummy-Codec
+	 *	=> 6 DAIs  = 4xCPU + 2xCodec
+	 *	=> 1 ccnf  = 1xdummy-Codec
+	 *
+	 * ex3)
+	 * CPU0 --- Codec0	link : 6
+	 * CPU1 -/		dais : 6
+	 * CPU2 --- Codec1	ccnf : 2
+	 * CPU3 -/
+	 *
+	 *	=> 6 links = 0xCPU-Codec + 4xCPU-dummy + 2xdummy-Codec
+	 *	=> 6 DAIs  = 4xCPU + 2xCodec
+	 *	=> 2 ccnf  = 2xdummy-Codec
+	 */
+	if (!top) {
+		(*link_num) = 1;
+		(*dais_num) = 2;
+		(*ccnf_num) = 0;
+		return;
+	}
+
+	loop = 1;
+	node = of_get_child_by_name(top, PREFIX "dai-link");
+	if (!node) {
+		node = top;
+		loop = 0;
+	}
+
+	do {
+		num = of_get_child_count(node);
+		(*dais_num) += num;
+		if (num > 2) {
+			(*link_num) += num;
+			(*ccnf_num)++;
+		} else {
+			(*link_num)++;
+		}
+		node = of_get_next_child(top, node);
+	} while (loop && node);
+}
+
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
 	struct simple_card_data *priv;
@@ -263,18 +337,20 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	struct simple_dai_props *dai_props;
 	struct snd_soc_card *card;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	int num, ret, i;
+	int ret, i;
+	int lnum = 0, dnum = 0, cnum = 0;
 
 	/* Allocate the private data */
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	num = of_get_child_count(np);
+	asoc_simple_card_get_dais_count(dev, &lnum, &dnum, &cnum);
+	if (!lnum || !dnum)
+		return -EINVAL;
 
-	dai_props = devm_kcalloc(dev, num, sizeof(*dai_props), GFP_KERNEL);
-	dai_link  = devm_kcalloc(dev, num, sizeof(*dai_link), GFP_KERNEL);
+	dai_props = devm_kcalloc(dev, lnum, sizeof(*dai_props), GFP_KERNEL);
+	dai_link  = devm_kcalloc(dev, lnum, sizeof(*dai_link), GFP_KERNEL);
 	if (!dai_props || !dai_link)
 		return -ENOMEM;
 
@@ -284,7 +360,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	 * see
 	 *	soc-core.c :: snd_soc_init_multicodec()
 	 */
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < lnum; i++) {
 		dai_link[i].codecs	= &dai_props[i].codecs;
 		dai_link[i].num_codecs	= 1;
 		dai_link[i].platform	= &dai_props[i].platform;
@@ -298,7 +374,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	card->owner		= THIS_MODULE;
 	card->dev		= dev;
 	card->dai_link		= priv->dai_link;
-	card->num_links		= num;
+	card->num_links		= lnum;
 	card->codec_conf	= &priv->codec_conf;
 	card->num_configs	= 1;
 
-- 
2.7.4
