From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: care link / dai
	count" to the asoc tree
Date: Tue,  4 Dec 2018 17:27:06 +0000 (GMT)
Message-ID: <20181204172706.7F10411251E3@debutante.sirena.org.uk>
References: <87woovz5rx.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F3E3267B6E
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 18:27:08 +0100 (CET)
In-Reply-To: <87woovz5rx.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-scu-card: care link / dai count

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

>From c89ff03ac8c67773d43e78f6dd452a4832492722 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Nov 2018 02:06:51 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: care link / dai count

In DPCM case, it uses CPU-dummy / dummy-Codec dai links.
If sound card is caring only DPCM, link count = dai count,
but, if non DPCM case, link count != dai count.
Now, we want to merge audio-graph-card and audio-graph-scu-card,
then, we need to care both link / dai count more carefly
This patch cares it, and prepare for merging audio card

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-scu-card.c | 76 +++++++++++++++++++-----
 1 file changed, 62 insertions(+), 14 deletions(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index ce1f1085ad25..a0a28671948a 100644
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
@@ -286,10 +289,48 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	struct device_node *codec_ep;
 	struct device_node *codec_port;
 	struct device_node *codec_port_old;
-	int count = 0;
+	struct device_node *codec_port_old2;
 	int rc;
 
+	/*
+	 * link_num :	number of links.
+	 *		CPU-Codec / CPU-dummy / dummy-Codec
+	 * dais_num :	number of DAIs
+	 * ccnf_num :	number of codec_conf
+	 *		same number for dummy-Codec
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
 	codec_port_old = NULL;
+	codec_port_old2 = NULL;
 	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
 		cpu_port = it.node;
 		cpu_ep   = of_get_next_child(cpu_port, NULL);
@@ -300,16 +341,22 @@ static int asoc_graph_get_dais_count(struct device *dev)
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
@@ -319,19 +366,20 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
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
 
@@ -341,7 +389,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	 * see
 	 *	soc-core.c :: snd_soc_init_multicodec()
 	 */
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < lnum; i++) {
 		dai_link[i].codecs	= &dai_props[i].codecs;
 		dai_link[i].num_codecs	= 1;
 		dai_link[i].platform	= &dai_props[i].platform;
@@ -355,7 +403,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	card->owner		= THIS_MODULE;
 	card->dev		= dev;
 	card->dai_link		= priv->dai_link;
-	card->num_links		= num;
+	card->num_links		= lnum;
 	card->codec_conf	= &priv->codec_conf;
 	card->num_configs	= 1;
 
-- 
2.19.0.rc2
