Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DC3C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 06:26:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B067561058
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 06:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B067561058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66D691670;
	Wed, 18 Aug 2021 08:25:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66D691670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629267995;
	bh=KNTpsINW5HU4ftM3zxMJ8YZTnfLxKApxQpw1USEmb1A=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u+g7P7Y7BLS/DZneIWsBN45Yc/MqVFCQOMKqHXkmmNjDHmxbDiW7BdRTVX5oBkzg4
	 BTiMCpMaxsTIfMsRsVYTCVfF0JxE7GRUa8OaltiOMsEbLxXnY11eBVC0F5O4IfJPFx
	 86YTwmz2cFvhOIItFhMlCxgIm4ja7ymKPkLu5OV0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9FECF80246;
	Wed, 18 Aug 2021 08:25:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 065FAF80249; Wed, 18 Aug 2021 08:25:40 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 976B1F80163
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 08:25:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 976B1F80163
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 629391A1481;
 Wed, 18 Aug 2021 08:25:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2AD7D1A146D;
 Wed, 18 Aug 2021 08:25:30 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BA890183AD27;
 Wed, 18 Aug 2021 14:25:28 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl_rpmsg: Check -EPROBE_DEFER for getting clocks
Date: Wed, 18 Aug 2021 14:03:34 +0800
Message-Id: <1629266614-6942-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

The devm_clk_get() may return -EPROBE_DEFER, then clocks
will be assigned to NULL wrongly. As the clocks are
optional so we can use devm_clk_get_optional() instead of
devm_clk_get().

Fixes: b73d9e6225e8 ("ASoC: fsl_rpmsg: Add CPU DAI driver for audio base on rpmsg")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_rpmsg.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_rpmsg.c b/sound/soc/fsl/fsl_rpmsg.c
index ea5c973e2e84..d60f4dac6c1b 100644
--- a/sound/soc/fsl/fsl_rpmsg.c
+++ b/sound/soc/fsl/fsl_rpmsg.c
@@ -165,25 +165,25 @@ static int fsl_rpmsg_probe(struct platform_device *pdev)
 	}
 
 	/* Get the optional clocks */
-	rpmsg->ipg = devm_clk_get(&pdev->dev, "ipg");
+	rpmsg->ipg = devm_clk_get_optional(&pdev->dev, "ipg");
 	if (IS_ERR(rpmsg->ipg))
-		rpmsg->ipg = NULL;
+		return PTR_ERR(rpmsg->ipg);
 
-	rpmsg->mclk = devm_clk_get(&pdev->dev, "mclk");
+	rpmsg->mclk = devm_clk_get_optional(&pdev->dev, "mclk");
 	if (IS_ERR(rpmsg->mclk))
-		rpmsg->mclk = NULL;
+		return PTR_ERR(rpmsg->mclk);
 
-	rpmsg->dma = devm_clk_get(&pdev->dev, "dma");
+	rpmsg->dma = devm_clk_get_optional(&pdev->dev, "dma");
 	if (IS_ERR(rpmsg->dma))
-		rpmsg->dma = NULL;
+		return PTR_ERR(rpmsg->dma);
 
-	rpmsg->pll8k = devm_clk_get(&pdev->dev, "pll8k");
+	rpmsg->pll8k = devm_clk_get_optional(&pdev->dev, "pll8k");
 	if (IS_ERR(rpmsg->pll8k))
-		rpmsg->pll8k = NULL;
+		return PTR_ERR(rpmsg->pll8k);
 
-	rpmsg->pll11k = devm_clk_get(&pdev->dev, "pll11k");
+	rpmsg->pll11k = devm_clk_get_optional(&pdev->dev, "pll11k");
 	if (IS_ERR(rpmsg->pll11k))
-		rpmsg->pll11k = NULL;
+		return PTR_ERR(rpmsg->pll11k);
 
 	platform_set_drvdata(pdev, rpmsg);
 	pm_runtime_enable(&pdev->dev);
-- 
2.27.0

