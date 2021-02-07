Return-Path: <SRS0=N3b0=HJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F98C433E0
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Feb 2021 17:39:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245F664DEB
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Feb 2021 17:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245F664DEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 967931682;
	Sun,  7 Feb 2021 18:38:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 967931682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612719545;
	bh=EyOw1MVks+HfQlbZ2OiU5YUEmTkg3PUw3LDX6ZnV9JY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kW3voLnXHs55whSmxQ3Cy+xxYf813MFsyS7g1a1Hwg//vWSd7iSNRpeWddnYUw8IX
	 q5eMalkeBeCa7ZHdKyo+f5iFqTOaRLyKYPoIQUO23vYWfZvbDWvS3FPW26rpeNmcKP
	 YA3QXHkxMjHAbvJWkGU3Ing5XyUaOVEd+7g95iEA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B58A5F80275;
	Sun,  7 Feb 2021 18:37:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E1ABF80277; Sun,  7 Feb 2021 18:37:26 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41025F801EB
 for <alsa-devel@alsa-project.org>; Sun,  7 Feb 2021 18:37:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41025F801EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="gU9qYH07"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6020254a0000>; Sun, 07 Feb 2021 09:37:14 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 7 Feb
 2021 17:37:14 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Sun, 7 Feb 2021 17:37:11 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>
Subject: [PATCH v3 2/2] ASoC: tegra: Add driver remove() callback
Date: Sun, 7 Feb 2021 23:06:58 +0530
Message-ID: <1612719418-5858-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612719418-5858-1-git-send-email-spujar@nvidia.com>
References: <1612719418-5858-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612719434; bh=KVg63vf5VvqvH+XrCPWnE0FONvvdchylgE/elPzsp7U=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=gU9qYH07cR0wRn/KNECToKq50Rk2cxEOgfyYQeXfUHZl1zTBQ0wEzHyixn5fK6FMb
 3Qmv2jfFPinbTQwkooqkZW4h4BmHoLzpos/etMIg5BhQZD2YRJxsO6vzB7/zLC5Q1M
 O6SZEsEE7LwsVpzmUFDlv14xRMBMGvz8hvBT6z2l3aU0BvNnApdWYXViMzz8D6Z1N8
 6RAX9IBcjlDar3oJGQHG2BfZDSng13e2Pr39chHd0KDHHqyV4qVuEsQhCC30seJYNm
 nUD19eWlaQUbQGImaS5ZiTe/nv8NgF34+WDWE3ZjJn/SFKvrHHFA0OqapVqpKd6+MB
 vO/ZEZ6jLuG/g==
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 Sameer Pujar <spujar@nvidia.com>, linux-kernel@vger.kernel.org,
 jonathanh@nvidia.com, sharadg@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

There is cleanup required, related to release of phandles, during driver
removal and hence point remove callback to audio_graph_remove().

Fixes: 202e2f774543 ("ASoC: tegra: Add audio graph based card driver")
Depends-on: "ASoC: audio-graph: Rename functions needed for export"
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/tegra/tegra_audio_graph_card.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_audio_graph_card.c b/sound/soc/tegra/tegra_audio_graph_card.c
index 121e572..ddedf18 100644
--- a/sound/soc/tegra/tegra_audio_graph_card.c
+++ b/sound/soc/tegra/tegra_audio_graph_card.c
@@ -2,7 +2,7 @@
 //
 // tegra_audio_graph_card.c - Audio Graph based Tegra Machine Driver
 //
-// Copyright (c) 2020 NVIDIA CORPORATION.  All rights reserved.
+// Copyright (c) 2020-2021 NVIDIA CORPORATION.  All rights reserved.
 
 #include <linux/math64.h>
 #include <linux/module.h>
@@ -243,6 +243,7 @@ static struct platform_driver tegra_audio_graph_card = {
 		.of_match_table = graph_of_tegra_match,
 	},
 	.probe = tegra_audio_graph_probe,
+	.remove = audio_graph_remove,
 };
 module_platform_driver(tegra_audio_graph_card);
 
-- 
2.7.4

