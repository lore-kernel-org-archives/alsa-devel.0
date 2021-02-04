Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE26DC433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 13:52:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF1A64F64
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 13:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF1A64F64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEDB016DD;
	Thu,  4 Feb 2021 14:51:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEDB016DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612446743;
	bh=mkd9TGWy7AUI8/5tDz7YxNTlMGPOnV/fwV+UkKX32N0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nHjMj3w+dHbwXqWXDQ/zLYpQpmsK/plS6Jfu67ZJCl2yAvSJX5inGtSRhW8LD5VhL
	 88eTF2mM4Ls2Q4rLbz3HYMCZFSDVuD5jgwz6JANCnqHyOQnGAhqi2v4QLVEyu6e79n
	 dmY52qXqvxWRuiFj/GT6za2CJvl/VcaTMhQyKx60=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7984F8025C;
	Thu,  4 Feb 2021 14:50:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AB89F8025D; Thu,  4 Feb 2021 14:50:46 +0100 (CET)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0DF6F80139
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 14:50:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0DF6F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="BkQeR+6Q"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B601bfbac0008>; Thu, 04 Feb 2021 05:50:36 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 13:50:36 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Feb 2021 13:50:33 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>
Subject: [PATCH v2 2/3] ASoC: tegra: Update references of audio graph helpers
Date: Thu, 4 Feb 2021 19:20:11 +0530
Message-ID: <1612446612-32613-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612446612-32613-1-git-send-email-spujar@nvidia.com>
References: <1612446612-32613-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612446636; bh=2pd/AAFg5WK8Z9T8q9P2ZlY87W9EDATBwGUAwCiwYCk=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=BkQeR+6QhRlKhDEgPxy6UFGIPv4QDrRzDG+oFlUteHrHqMqmGsAA7Y1JGbTtf/ogl
 EbcXVAjV3GFY7/CTQNy0Gd3dAOSdSotDCb/nwnSgmIj2GtGxOq5/Qe/POexb1rJlSc
 n0IqFTqgl5gxPg3xz+xK0WIMUvqXx9PbXhQpiNbMizxCmJNVg0NejlwhMakN/otCjj
 Y207POoob1DHm0fVKszVv2vX6snBlW8VRx2O2ccUtRe6xodhpbnhsBxFv+Q+kuY4z6
 oM+VRZX/o0Ine/LGWc7ydcIl6x+xBwpU7m/NZ7YIIr1naHzCvm3gZY0j6QViq0eTul
 mLLzAA8SNA89g==
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

The audio graph helper functions are renamed now for a better global
visibility and hence references need to be updated in Tegra audio
graph.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra_audio_graph_card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra_audio_graph_card.c b/sound/soc/tegra/tegra_audio_graph_card.c
index 9e43f16..121e572 100644
--- a/sound/soc/tegra/tegra_audio_graph_card.c
+++ b/sound/soc/tegra/tegra_audio_graph_card.c
@@ -184,7 +184,7 @@ static int tegra_audio_graph_card_probe(struct snd_soc_card *card)
 		return PTR_ERR(priv->clk_plla_out0);
 	}
 
-	return graph_card_probe(card);
+	return audio_graph_card_probe(card);
 }
 
 static int tegra_audio_graph_probe(struct platform_device *pdev)
@@ -201,12 +201,12 @@ static int tegra_audio_graph_probe(struct platform_device *pdev)
 
 	card->probe = tegra_audio_graph_card_probe;
 
-	/* graph_parse_of() depends on below */
+	/* audio_graph_parse_of() depends on below */
 	card->component_chaining = 1;
 	priv->simple.ops = &tegra_audio_graph_ops;
 	priv->simple.force_dpcm = 1;
 
-	return graph_parse_of(&priv->simple, dev);
+	return audio_graph_parse_of(&priv->simple, dev);
 }
 
 static const struct tegra_audio_cdata tegra210_data = {
-- 
2.7.4

