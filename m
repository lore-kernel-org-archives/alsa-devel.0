From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 3/5] ASoC: simple-scu-card: tidyup
 "convert-rate/channels" parsing
Date: Tue, 11 Dec 2018 03:25:18 +0000
Message-ID: <877eggbvov.wl-kuninori.morimoto.gx@renesas.com>
References: <87bm5sbvq6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400105.outbound.protection.outlook.com [40.107.140.105])
 by alsa0.perex.cz (Postfix) with ESMTP id DB548267B4D
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 04:25:21 +0100 (CET)
In-Reply-To: <87bm5sbvq6.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <22EA344CACF63242B43D08E42F182B0F@jpnprd01.prod.outlook.com>
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

simple-scu-card.c is supporting "convert-rate/channels" which is
used for DPCM.
But, sound card might have multi codecs, and each codec might need
each convert-rate/channels.

This patch supports each codec's convert-rate/channles support.
top node convert-rate/channels will overwrite settings if exist.

It can't support each codec's convert-rate/channels if sound card had
multi codecs without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/simple-scu-card.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 1c6382f..3c4e289 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -26,6 +26,7 @@ struct simple_card_data {
 		struct asoc_simple_dai dai;
 		struct snd_soc_dai_link_component codecs;
 		struct snd_soc_dai_link_component platform;
+		struct asoc_simple_card_data adata;
 	} *dai_props;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_card_data adata;
@@ -86,7 +87,11 @@ static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					struct snd_pcm_hw_params *params)
 {
 	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 
+	asoc_simple_card_convert_fixup(&dai_props->adata, params);
+
+	/* overwrite by top level adata if exist */
 	asoc_simple_card_convert_fixup(&priv->adata, params);
 
 	return 0;
@@ -177,6 +182,8 @@ static int asoc_simple_card_dai_link_of(struct device_node *link,
 						     "prefix");
 	}
 
+	asoc_simple_card_parse_convert(dev, link, prefix, &dai_props->adata);
+
 	ret = asoc_simple_card_of_parse_tdm(np, &dai_props->dai);
 	if (ret)
 		return ret;
-- 
2.7.4
