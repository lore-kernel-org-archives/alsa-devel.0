Return-Path: <SRS0=P7Dr=G7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154CBC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 11:28:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D949264D9F
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 11:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D949264D9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3197A16BB;
	Thu, 28 Jan 2021 12:27:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3197A16BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611833317;
	bh=pKfK3oFDLdUDZKA58TXdpKMp6coON408HLxMQ7IIot4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D0lXQmprEAuoOmhi52Yz682pa9H8qpwp1I9xrL2E+UCUxy6f4MLTlliewFunm6Ub7
	 fTiITJs76/dEmG18KDonBcJ/9J9w5fSYbpfDRic/VtwPgOuBffTrpTBwHRuTbmTPrj
	 hkJ+5ZCGDb6djn77px7TP9ilDD7/O32mrjscSg5M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A33F8F80158;
	Thu, 28 Jan 2021 12:27:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C6E8F8015B; Thu, 28 Jan 2021 12:27:45 +0100 (CET)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com
 [221.176.66.80])
 by alsa1.perex.cz (Postfix) with ESMTP id 8E1B1F800E9
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2021 12:27:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E1B1F800E9
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by
 rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee760129f8fe10-38bc6;
 Thu, 28 Jan 2021 19:27:11 +0800 (CST)
X-RM-TRANSID: 2ee760129f8fe10-38bc6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee560129f8be3a-d290f;
 Thu, 28 Jan 2021 19:27:11 +0800 (CST)
X-RM-TRANSID: 2ee560129f8be3a-d290f
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ASoC: fsl_spdif: Utilize the defined parameter to clear code
Date: Thu, 28 Jan 2021 19:27:14 +0800
Message-Id: <20210128112714.16324-1-tangbin@cmss.chinamobile.com>
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

Utilize the defined parameter 'dev' to make the code cleaner.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_spdif.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 455f96908..b6d5563df 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1215,7 +1215,7 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 
 	for (i = 0; i < STC_TXCLK_SRC_MAX; i++) {
 		sprintf(tmp, "rxtx%d", i);
-		clk = devm_clk_get(&pdev->dev, tmp);
+		clk = devm_clk_get(dev, tmp);
 		if (IS_ERR(clk)) {
 			dev_err(dev, "no rxtx%d clock in devicetree\n", i);
 			return PTR_ERR(clk);
@@ -1237,14 +1237,14 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 			break;
 	}
 
-	dev_dbg(&pdev->dev, "use rxtx%d as tx clock source for %dHz sample rate\n",
+	dev_dbg(dev, "use rxtx%d as tx clock source for %dHz sample rate\n",
 			spdif_priv->txclk_src[index], rate[index]);
-	dev_dbg(&pdev->dev, "use txclk df %d for %dHz sample rate\n",
+	dev_dbg(dev, "use txclk df %d for %dHz sample rate\n",
 			spdif_priv->txclk_df[index], rate[index]);
 	if (clk_is_match(spdif_priv->txclk[index], spdif_priv->sysclk))
-		dev_dbg(&pdev->dev, "use sysclk df %d for %dHz sample rate\n",
+		dev_dbg(dev, "use sysclk df %d for %dHz sample rate\n",
 				spdif_priv->sysclk_df[index], rate[index]);
-	dev_dbg(&pdev->dev, "the best rate for %dHz sample rate is %dHz\n",
+	dev_dbg(dev, "the best rate for %dHz sample rate is %dHz\n",
 			rate[index], spdif_priv->txrate[index]);
 
 	return 0;
-- 
2.20.1.windows.1



