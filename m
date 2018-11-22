From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 05/10] ASoC: audio-graph-scu-card: tidyup
	"prefix" parsing
Date: Thu, 22 Nov 2018 00:56:21 +0000
Message-ID: <87tvkalz05.wl-kuninori.morimoto.gx@renesas.com>
References: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410108.outbound.protection.outlook.com [40.107.141.108])
 by alsa0.perex.cz (Postfix) with ESMTP id 534032677E8
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 01:56:24 +0100 (CET)
In-Reply-To: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <E431E87B949F924A94D6577220CDBAAF@jpnprd01.prod.outlook.com>
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

audio-graph-scu-card.c is supporting "prefix" which is used to avoid
DAI naming conflict when CPU/Codec matching.
But, sound card might have multi sub-devices, and each codec might need
each prefix.

Now, ASoC is supporting snd_soc_of_parse_node_prefix(), let's support
it on audio-graph-scu-card, too. It is keeping existing DT style.

It can't support each codec's prefix if sound card had multi sub-devices
without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/audio-graph-scu-card.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index c469473..fdc61f1 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -39,6 +39,8 @@ struct graph_card_data {
 #define graph_priv_to_dev(priv) (graph_priv_to_card(priv)->dev)
 #define graph_priv_to_link(priv, i) (graph_priv_to_card(priv)->dai_link + (i))
 
+#define PREFIX	"audio-graph-card,"
+
 static int asoc_graph_card_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -98,6 +100,7 @@ static int asoc_graph_card_dai_link_of(struct device_node *ep,
 	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, idx);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, idx);
 	struct snd_soc_card *card = graph_priv_to_card(priv);
+	struct device_node *node = of_graph_get_port_parent(ep);
 	int ret;
 
 	if (is_fe) {
@@ -154,10 +157,17 @@ static int asoc_graph_card_dai_link_of(struct device_node *ep,
 		if (ret < 0)
 			return ret;
 
+		/* check "prefix" from top node */
 		snd_soc_of_parse_audio_prefix(card,
 					      &priv->codec_conf,
 					      dai_link->codecs->of_node,
 					      "prefix");
+		/* check "prefix" from each node if top doesn't have */
+		if (!priv->codec_conf.of_node)
+			snd_soc_of_parse_node_prefix(node,
+						     &priv->codec_conf,
+						     dai_link->codecs->of_node,
+						     PREFIX "prefix");
 	}
 
 	ret = asoc_simple_card_of_parse_tdm(ep, &dai_props->dai);
-- 
2.7.4
