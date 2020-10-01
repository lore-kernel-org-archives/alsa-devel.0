Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674D6C4727E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:37:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C922054F
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="s2HPZjDB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qh6ixMdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C922054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4423B1A16;
	Thu,  1 Oct 2020 19:36:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4423B1A16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601573823;
	bh=YbX3Xs+IlkZvwttFLiXjgQc2kMiTtiyWfEmqYnyAdCc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s2HPZjDB5WGWnp/yW1C+f4vIGjxo83Kh0dHQ/ff7j5vQc3fLVoHwYLVbgf+QuqXrH
	 f/TFB673LfnNdBs6/qQXyZjkikhsOGs49EpPSrhIF42xjhy7wexXl7mcdCoexaexku
	 lKbO7wWPsqTv6uYxKdJEUMTduuN5P1dYEDk3YaXw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2B6CF802EB;
	Thu,  1 Oct 2020 19:34:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EF7EF802EC; Thu,  1 Oct 2020 19:34:19 +0200 (CEST)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9274AF802E7
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 19:34:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9274AF802E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="qh6ixMdr"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f7612de0002>; Thu, 01 Oct 2020 10:33:18 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 17:34:06 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 1 Oct 2020 17:34:01 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
 <kuninori.morimoto.gx@renesas.com>, <pierre-louis.bossart@linux.intel.com>,
 <perex@perex.cz>, <tiwai@suse.com>, <thierry.reding@gmail.com>,
 <jonathanh@nvidia.com>
Subject: [PATCH v3 04/13] ASoC: audio-graph: Identify 'no_pcm' DAI links for
 DPCM
Date: Thu, 1 Oct 2020 23:02:58 +0530
Message-ID: <1601573587-15288-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
References: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1601573599; bh=FxtLB3V25/9092fJImUbmEK5DDd1xaC11DWTieE2aCs=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=qh6ixMdrkj816QIY0WmOUzRZcLvyEd3MNzsOR3UMAb1KnCe6PBtrKmtui7l835exM
 FMWyfdPQkYQUmGT8bfc32gsUqdTerVWX7S4tl8Z/HUpnDESTtGu+xub8jU5N1Q6Fk3
 P/97eKI5f4bV/QxpDQj3+W+dEs/MFv3xLZq8ixCR+1Bf9li/Dz1jr4ZeKEj0tCfoZb
 KHwAq0yES2wk5QeT0eyqz2xzciFfAR3vS0Jckk6/Nb2LTsNOknf7MVoF02QpxPRbHq
 7RtUYGew/iybPmTll5JvwEasbWt6OnVq8u+H1PDPSCE6RQBt9exOoUBbgpnl0mwxeE
 hRzEpYfvFMaAA==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 nicoleotsuka@gmail.com, swarren@nvidia.com, Sameer Pujar <spujar@nvidia.com>,
 linux-kernel@vger.kernel.org, atalambedu@nvidia.com, viswanathl@nvidia.com,
 sharadg@nvidia.com, nwartikar@nvidia.com, linux-tegra@vger.kernel.org,
 rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
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

PCM devices are created for FE dai links with 'no-pcm' flag as '0'.
Such DAI links have CPU component which implement either pcm_construct()
or pcm_new() at component or dai level respectively. Based on this,
current patch exposes a helper function to identify such components
and populate 'no_pcm' flag for DPCM DAI link.

This helps to have BE<->BE component links where PCM devices need
not be created for CPU component involved in such links.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/audio-graph-card.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 1e20562..9b06841 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -111,6 +111,17 @@ static int graph_get_dai_id(struct device_node *ep)
 	return id;
 }
 
+static bool soc_component_is_pcm(struct snd_soc_dai_link_component *dlc)
+{
+	struct snd_soc_dai *dai = snd_soc_find_dai_with_mutex(dlc);
+
+	if (dai && (dai->component->driver->pcm_construct ||
+		    dai->driver->pcm_new))
+		return true;
+
+	return false;
+}
+
 static int asoc_simple_parse_dai(struct device_node *ep,
 				 struct snd_soc_dai_link_component *dlc,
 				 int *is_single_link)
@@ -205,6 +216,7 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 				  int dup_codec)
 {
 	struct device *dev = simple_priv_to_dev(priv);
+	struct snd_soc_card *card = simple_priv_to_card(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, li->link);
 	struct device_node *top = dev->of_node;
@@ -259,6 +271,19 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 		if (ret < 0)
 			goto out_put_node;
 
+		/*
+		 * In BE<->BE connections it is not required to create
+		 * PCM devices at CPU end of the dai link and thus 'no_pcm'
+		 * flag needs to be set. It is useful when there are many
+		 * BE components and some of these have to be connected to
+		 * form a valid audio path.
+		 *
+		 * For example: FE <-> BE1 <-> BE2 <-> ... <-> BEn where
+		 * there are 'n' BE components in the path.
+		 */
+		if (card->component_chaining && !soc_component_is_pcm(cpus))
+			dai_link->no_pcm = 1;
+
 		/* card->num_links includes Codec */
 		asoc_simple_canonicalize_cpu(dai_link, is_single_links);
 	} else {
-- 
2.7.4

