From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 03/10] ASoC: simple-scu-card: tidyup "prefix"
	parsing
Date: Thu, 22 Nov 2018 00:55:40 +0000
Message-ID: <87wop6lz1a.wl-kuninori.morimoto.gx@renesas.com>
References: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400131.outbound.protection.outlook.com [40.107.140.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CB1526770D
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 01:55:44 +0100 (CET)
In-Reply-To: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <64A7725C50C9864A8442A0108C7A07CA@jpnprd01.prod.outlook.com>
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

simple-scu-card.c is supporting "prefix" which is used to avoid
DAI naming conflict when CPU/Codec matching.
But, sound card might have multi sub-devices, and each codec might need
each prefix.

Now, ASoC is supporting snd_soc_of_parse_node_prefix(), let's support
it on audio-graph-scu-card, too. It is keeping existing DT style.

It can't support each codec's prefix if sound card had multi sub-devices
without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/simple-scu-card.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index e650143..7ae1901 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -157,10 +157,17 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 		if (ret < 0)
 			return ret;
 
+		/* check "prefix" from top node */
 		snd_soc_of_parse_audio_prefix(card,
 					      &priv->codec_conf,
 					      dai_link->codecs->of_node,
 					      PREFIX "prefix");
+		/* check "prefix" from each node if top doesn't have */
+		if (!priv->codec_conf.of_node)
+			snd_soc_of_parse_node_prefix(np,
+						     &priv->codec_conf,
+						     dai_link->codecs->of_node,
+						     "prefix");
 	}
 
 	ret = asoc_simple_card_of_parse_tdm(np, &dai_props->dai);
-- 
2.7.4
