Return-Path: <SRS0=8d/u=A6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1816CC433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2020 05:13:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E34207EA
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2020 05:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="owteMyYX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IJTgaVQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E34207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BD3816B3;
	Sun, 19 Jul 2020 07:12:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BD3816B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595135599;
	bh=biad6c6umRyqljgPM4Kfg2EqtXKjIQus/oDtl9X9RDc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=owteMyYX0vCVIpU1VHs65mV/4wT6qomlRaAMWJSOTTUDhak0D5lKiKjJaYxQXGLjR
	 sbOM9yGYI8X25T3mlF8aSEsZ593EszvjmOShVpniLPyZzb4QgzfBAW7jfOvDzkbcuE
	 O74LyHAdaAxrCAU5EMYP/GU0I1O+2OO9+MxwiD/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 352B5F8024A;
	Sun, 19 Jul 2020 07:10:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C2A1F802BD; Sun, 19 Jul 2020 07:10:54 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FCC7F80141
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2020 07:10:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FCC7F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="IJTgaVQw"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f13d5cc0000>; Sat, 18 Jul 2020 22:10:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sat, 18 Jul 2020 22:10:48 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sat, 18 Jul 2020 22:10:48 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 Jul
 2020 05:10:48 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 19 Jul 2020 05:10:48 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by
 hqnvemgw03.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5f13d5d30000>; Sat, 18 Jul 2020 22:10:47 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
 <lgirdwood@gmail.com>
Subject: [PATCH 02/10] ASoC: audio-graph: Use of_node and DAI for DPCM DAI
 link names
Date: Sun, 19 Jul 2020 10:40:09 +0530
Message-ID: <1595135417-16589-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595135417-16589-1-git-send-email-spujar@nvidia.com>
References: <1595135417-16589-1-git-send-email-spujar@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1595135436; bh=VCqQyFvsC42bD01qDtx7VomZ3rPYcT/ToygIVRhfO88=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=IJTgaVQw5bFtkhvnekZZfHhEYGzVlXuimVGna6X1ObsCKAiSwisB4VgULC1Kpr6L4
 gLvfnSjHs4Wpsu/w2xpVb1DNhJ4bSnAqJUzuiZ9vic3ArYJxEFB94KWvMPeorUYH9K
 OZRKscxqyiJWkaSvOuEaVsJHbabBM36wk2xmHChEnVt0BZTiHzpeSG8wTG1Ezyrn7S
 A08QMAaXVDRbVtC+1mydFLyVFjZctGRIS98Y0Sqf81aDAqAn5vFOkRLFpFxev1Gtya
 Wz9jUuQJQBshw25Y/kh6rquMsQaG/hEwplyWJOrxYR/np5v3vBV2GmvvFSf398izWv
 v2mufBgnCc81g==
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, swarren@nvidia.com,
 Sameer Pujar <spujar@nvidia.com>, nwartikar@nvidia.com,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, viswanathl@nvidia.com,
 sharadg@nvidia.com, thierry.reding@gmail.com, atalambedu@nvidia.com,
 linux-tegra@vger.kernel.org, rlokhande@nvidia.com, mkumard@nvidia.com,
 dramesh@nvidia.com
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

For multiple instances of components, using DAI name alone for DAI links
is causing conflicts. Components can define multiple DAIs and hence using
just a device name won't help either. Thus DT device node reference and
DAI names are used to uniquely represent DAI link names.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/generic/audio-graph-card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 97b4f54..1e20562 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -253,7 +253,8 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 			goto out_put_node;
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
-						   "fe.%s",
+						   "fe.%pOFP.%s",
+						   cpus->of_node,
 						   cpus->dai_name);
 		if (ret < 0)
 			goto out_put_node;
@@ -287,7 +288,8 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 			goto out_put_node;
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
-						   "be.%s",
+						   "be.%pOFP.%s",
+						   codecs->of_node,
 						   codecs->dai_name);
 		if (ret < 0)
 			goto out_put_node;
-- 
2.7.4

