From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 07/10] ASoC: audio-graph-scu-card: tidyup
 "convert-rate/channels" parsing
Date: Thu, 22 Nov 2018 00:56:53 +0000
Message-ID: <87r2felyz9.wl-kuninori.morimoto.gx@renesas.com>
References: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400109.outbound.protection.outlook.com [40.107.140.109])
 by alsa0.perex.cz (Postfix) with ESMTP id BA51126770D
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 01:56:58 +0100 (CET)
In-Reply-To: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <3217E89043FBA041BA5E71F27BBAF345@jpnprd01.prod.outlook.com>
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

audio-graph-scu-card.c is supporting "convert-rate/channels" which is
used for DPCM.
But, sound card might have multi codecs, and each codec might need
each convert-rate/channels.

This patch supports each codec's convert-rate/channles support.
top node convert-rate/channels will overwrite settings if exist.

It can't support each codec's convert-rate/channels if sound card had
multi codecs without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/audio-graph-scu-card.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index fdc61f1..0f13f11 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -29,6 +29,7 @@ struct graph_card_data {
 		struct asoc_simple_dai dai;
 		struct snd_soc_dai_link_component codecs;
 		struct snd_soc_dai_link_component platform;
+		struct asoc_simple_card_data adata;
 	} *dai_props;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_card_data adata;
@@ -85,7 +86,11 @@ static int asoc_graph_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					       struct snd_pcm_hw_params *params)
 {
 	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
+
+	asoc_simple_card_convert_fixup(&dai_props->adata, params);
 
+	/* overwrite by top level adata if exist */
 	asoc_simple_card_convert_fixup(&priv->adata, params);
 
 	return 0;
@@ -170,6 +175,8 @@ static int asoc_graph_card_dai_link_of(struct device_node *ep,
 						     PREFIX "prefix");
 	}
 
+	asoc_simple_card_parse_convert(dev, node, PREFIX, &dai_props->adata);
+
 	ret = asoc_simple_card_of_parse_tdm(ep, &dai_props->dai);
 	if (ret)
 		return ret;
-- 
2.7.4
