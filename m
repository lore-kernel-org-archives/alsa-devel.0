Return-Path: <SRS0=phwE=HF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F20C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 16:11:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6237064F78
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 16:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6237064F78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B82C81775;
	Wed,  3 Feb 2021 17:11:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B82C81775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612368716;
	bh=A1QuVQdLMdsLBRKczcnkDlAzUIRaOWqOd0wB1g50I4Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pj+XgwqUwDT7x1WduSEAa5jh+v5I5tvL7ntcYkdCYuUE2ecNCK8lVLtiIsV/tP9+c
	 qZCe8nMAWlsktjxRG/+ohCy6nr6MdwzAp4vP3VAufJthVQ1gP4pXtJYOE2Q00gY7I2
	 9sRTyTF1TSEUh05ZsZr3CnHZaUjI8Dw9DVpvBbEw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21BB8F8025B;
	Wed,  3 Feb 2021 17:10:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8EF19F8025C; Wed,  3 Feb 2021 17:10:13 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31E6DF801DB
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2021 17:10:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31E6DF801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Yq2cMGL1"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B601acad90001>; Wed, 03 Feb 2021 08:10:01 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Feb
 2021 16:10:01 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 3 Feb 2021 16:09:58 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: tegra: Add driver remove() callback
Date: Wed, 3 Feb 2021 21:39:35 +0530
Message-ID: <1612368575-25991-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612368575-25991-1-git-send-email-spujar@nvidia.com>
References: <1612368575-25991-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612368601; bh=PjUOj+qZWimYXJl6j0hq0SkuuiLq1QiE8oYFb4NR7Ig=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=Yq2cMGL1tb4WqGuqAl12zqEaeQN+bQG6fC7vvt10ES+WwvHjjIOmzzT/kFbnO1KU5
 R0aF4HzZ2ZRQsQ3DKnjZah1nQ3Hmb3WA/XQVi3aANfC65RqF4paIa+l1R0HvdZTc1R
 Ps/EfeIwkeecCa6LbUVJjjukeKgIwiEhYo7Y/0kPT+ESkP1cOcNtR9TXUPGSWCPekm
 SujFPThaejc8zg45IPcdtEzspiX1jMqhYE107y+jysZ9vdq7fNPFqMQBRFM7IAef+V
 TmrPaRhM7FLQx0Tckiywv6cvseKwKsU1lOtUpvp46DNhd+7k3MGasgO1F9sEaF60H3
 7qae5XgLWvGpA==
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
removal and hence point remove function pointer to graph_remove().

Fixes: 202e2f774543 ("ASoC: tegra: Add audio graph based card driver")
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra_audio_graph_card.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_audio_graph_card.c b/sound/soc/tegra/tegra_audio_graph_card.c
index 9e43f16..f43d302 100644
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
+	.remove = graph_remove,
 };
 module_platform_driver(tegra_audio_graph_card);
 
-- 
2.7.4

