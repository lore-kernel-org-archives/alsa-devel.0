Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC7FC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Feb 2022 00:16:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20E8A1660;
	Sun, 20 Feb 2022 01:15:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20E8A1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645316185;
	bh=xnXUXTD/gkGINVh7sS8pU9Yrwu33QtFHQs04hrKbosQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TRwve1PIrkHUyoLwjNDp/3cgc6uKtC/24n8nvxODzESnFnf7qRqy0zUjEUboIrbaf
	 LNW8NYydBZ1eXKcJeR02EKrLW2Fsv3JhWB0OPZFjkJrFrlMo4axD+e8yXykaH6CZRE
	 bBh1YptkCg2aoK7CkbtM4sinwcjrOCxWqvT8FajY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A378DF8014B;
	Sun, 20 Feb 2022 01:15:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0515F8016A; Sun, 20 Feb 2022 01:15:32 +0100 (CET)
Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu
 [31.186.226.237])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FCD1F8014B
 for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2022 01:15:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FCD1F8014B
ARC-Seal: i=1; a=rsa-sha256; t=1645316110; cv=none; d=zohomail.eu; s=zohoarc; 
 b=bigFUDdZ2wMnQ2d/5wIhFdqxm3e8RFNL8UU+YYJizwNThxZm2DV8IQKCTnEoydNVnYatyeug07+MC93WV0Cq/s9FHTcVvyWsA0YO//W6wQzsr61yFSr4K62tVuBOom7duvYVg9kIin+zWA4Npo/GwoksTbXnqHY7lw1APVC7jlI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1645316110;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=TxrtmrJJ22codCwapsCweA2PwXwm9IdvB4gM7D6ogMw=; 
 b=PZjAw1owXJ0EQauvT7b9RidiwdVqelT8/XA9GjOJizyZx7o8556Vmvw4VT9QEKXHd+2RA6e+8NeZ3g7oenDhDka+bP+cAhhQcDKrNFbKj/n5VZKeeGUHOi1kGKNqNjiEem1rcYLcvzUtouaPJmr6uaFN0ILZb0Z+G50R8qk0KsY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
 spf=pass  smtp.mailfrom=philipp@uvos.xyz;
 dmarc=pass header.from=<philipp@uvos.xyz>
Received: from UVOSLinux (ip-037-201-192-120.um10.pools.vodafone-ip.de
 [37.201.192.120]) by mx.zoho.eu
 with SMTPS id 1645316109044132.10370953547556;
 Sun, 20 Feb 2022 01:15:09 +0100 (CET)
Date: Sun, 20 Feb 2022 01:15:08 +0100
From: Carl Philipp Klemm <philipp@uvos.xyz>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 2/6] ASoC: audio-graph-card: use new functionality in
 simple_card_utils to implement has-hp-jack of property
Message-Id: <20220220011508.b60109377252d188ed3ccb02@uvos.xyz>
In-Reply-To: <OS3PR01MB8426FD3FD1B45BB31C971A56D4509@OS3PR01MB8426.jpnprd01.prod.outlook.com>
References: <20211228190931.df5d518220080a734532ebfd@uvos.xyz>
 <87a6gawxpe.wl-kuninori.morimoto.gx@gmail.com>
 <20220105101028.620b7f2cb7727eedfccd933e@uvos.xyz>
 <87r19ld48v.wl-kuninori.morimoto.gx@gmail.com>
 <20220108145749.f55500222b049f344415a5c3@uvos.xyz>
 <OS3PR01MB8426FD3FD1B45BB31C971A56D4509@OS3PR01MB8426.jpnprd01.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tony@atomide.com" <tony@atomide.com>,
 "merlijn@wizzup.org" <merlijn@wizzup.org>, "sre@kernel.org" <sre@kernel.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "kuninori.morimoto.gx@gmail.com" <kuninori.morimoto.gx@gmail.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Setting this will cause audio-graph-card to register a headphone jack
and provide it to its componants via set_jack.

Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
---
 sound/soc/generic/audio-graph-card.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 7eb027238327..32a81bf10f18 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -259,7 +259,7 @@ static int graph_link_init(struct asoc_simple_priv *priv,
 	if (ret < 0)
 		return ret;
 
-	dai_link->init		= asoc_simple_dai_init;
+	dai_link->init		= asoc_graph_dai_init;
 	dai_link->ops		= &graph_ops;
 	if (priv->ops)
 		dai_link->ops	= priv->ops;
@@ -568,6 +568,8 @@ int audio_graph_parse_of(struct asoc_simple_priv *priv, struct device *dev)
 	if (ret < 0)
 		return ret;
 
+	asoc_simple_init_jack(card, &priv->hp_jack, TRUE, "has-hp-jack", NULL);
+
 	memset(li, 0, sizeof(*li));
 	ret = graph_for_each_link(priv, li,
 				  graph_dai_link_of,
@@ -719,7 +721,6 @@ static int graph_probe(struct platform_device *pdev)
 	card = simple_priv_to_card(priv);
 	card->dapm_widgets	= graph_dapm_widgets;
 	card->num_dapm_widgets	= ARRAY_SIZE(graph_dapm_widgets);
-	card->probe		= asoc_graph_card_probe;
 
 	if (of_device_get_match_data(dev))
 		priv->dpcm_selectable = 1;
-- 
2.35.1

