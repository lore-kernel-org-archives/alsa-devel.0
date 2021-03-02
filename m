Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D211C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 12:52:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC3A64F0A
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 12:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC3A64F0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E840E16F3;
	Tue,  2 Mar 2021 13:51:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E840E16F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614689531;
	bh=pZn+IWo+aCByh+esLsR5waDbyh6B8P9quBIKKdoOb3U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=N+FMcNWISREvNmpichl0PwgpaqNV9q/zGs+ILvTCjXKCrmra/5Hez2qP+C7H8THIX
	 WKoch1RE4JGIlvrEt7DknRnloMX+Sbtpx44fOVc9dPenuHZerXl+Lcn7f11lrsSNXq
	 o5DyXeiEuAgq6/zFLTYHpPwtNJvdYEY2k5G9Kwaw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E7E6F80271;
	Tue,  2 Mar 2021 13:50:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF222F80277; Tue,  2 Mar 2021 13:50:36 +0100 (CET)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com
 [221.176.66.80])
 by alsa1.perex.cz (Postfix) with ESMTP id DA114F8012D
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 13:50:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA114F8012D
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by
 rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7603e3480fae-934fd;
 Tue, 02 Mar 2021 20:50:09 +0800 (CST)
X-RM-TRANSID: 2ee7603e3480fae-934fd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
 by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea603e347d2a6-1de80;
 Tue, 02 Mar 2021 20:50:09 +0800 (CST)
X-RM-TRANSID: 2eea603e347d2a6-1de80
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ASoC: fsl_xcvr: Use devm_platform_ioremap_resource_byname()
 to simplify code
Date: Tue,  2 Mar 2021 20:50:02 +0800
Message-Id: <20210302125002.23900-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Tang Bin <tangbin@cmss.chinamobile.com>
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

In this function, devm_platform_ioremap_resource_byname() should be 
suitable to simplify code.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_xcvr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 6dd0a5fcd455..5e8284db857b 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1131,7 +1131,7 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct fsl_xcvr *xcvr;
-	struct resource *ram_res, *regs_res, *rx_res, *tx_res;
+	struct resource *rx_res, *tx_res;
 	void __iomem *regs;
 	int ret, irq;
 
@@ -1166,13 +1166,11 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 		return PTR_ERR(xcvr->pll_ipg_clk);
 	}
 
-	ram_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ram");
-	xcvr->ram_addr = devm_ioremap_resource(dev, ram_res);
+	xcvr->ram_addr = devm_platform_ioremap_resource_byname(pdev, "ram");
 	if (IS_ERR(xcvr->ram_addr))
 		return PTR_ERR(xcvr->ram_addr);
 
-	regs_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	regs = devm_ioremap_resource(dev, regs_res);
+	regs = devm_platform_ioremap_resource_byname(pdev, "regs");
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-- 
2.18.2



