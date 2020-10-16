Return-Path: <SRS0=z+9C=DX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC6AC433E7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:46:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BFA20708
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vq5fj1On";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YznZ6UF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BFA20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CC4917BD;
	Fri, 16 Oct 2020 16:45:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CC4917BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602859609;
	bh=YbX3Xs+IlkZvwttFLiXjgQc2kMiTtiyWfEmqYnyAdCc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vq5fj1OnLdKX3WqN2HeFMa3Ra0ipJ2c8o2IcbxJSpGNX2Y4vv2A3rm+y7R9zFgba2
	 GiVBd/R4RgMdj8+zQP5O15CCA7rj+hefYcfXUQZUZgxcFtpBPl0QElPojXzIzVs0OU
	 p0zr4aIvJaP2Dj+hJBrb+tmAxYPsEm3Ed0PTVlEo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C78A0F80297;
	Fri, 16 Oct 2020 16:44:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 031EDF8029A; Fri, 16 Oct 2020 16:44:06 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 322B6F8028F
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2020 16:43:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 322B6F8028F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="YznZ6UF1"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f89b19d0001>; Fri, 16 Oct 2020 07:43:41 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 14:43:49 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Oct 2020 14:43:43 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
 <kuninori.morimoto.gx@renesas.com>, <pierre-louis.bossart@linux.intel.com>,
 <perex@perex.cz>, <tiwai@suse.com>, <p.zabel@pengutronix.de>,
 <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
Subject: [PATCH v4 04/15] ASoC: audio-graph: Identify 'no_pcm' DAI links for
 DPCM
Date: Fri, 16 Oct 2020 20:12:51 +0530
Message-ID: <1602859382-19505-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602859382-19505-1-git-send-email-spujar@nvidia.com>
References: <1602859382-19505-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602859421; bh=FxtLB3V25/9092fJImUbmEK5DDd1xaC11DWTieE2aCs=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=YznZ6UF1huzVxz6nXo5V+S8XlLOCPbOg8RYMA942HKtlYpV92JGleS0ns7TRljA2c
 yHTSUpxqLij3Rz+HtfrzWvEN8U4SVdMvRNZQICDQhp+DZLVBuxVmaRu2BDEwqmV3Tn
 SL1rZTZxymYZAX8mVTQ6YB6DDpCHJzp1nzuq9TWScXOEgPCsxx22eNLx7MvBgeMR9h
 Z6JQ0PGbcQOjx6UDnwZh0A8qI9MbuSYCrreIF81vKSj0Wb03HZ/Sf1PH+Lx5IRtgfM
 n/8MLs4DRItv4UxUqiU0/iZDZcxAoSKl7iz85e9Az1IJ9tGQg09PGzGbPvMrG7F0TN
 M01VZAkNjnq7g==
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

