Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EB0C2BA2B
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 04:46:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D35020784
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 04:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OvMCoQY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D35020784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E12ED1657;
	Wed, 15 Apr 2020 06:45:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E12ED1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586925971;
	bh=28BAiipkb0qr+SNdIctYRRpvJifU8VmfcfM354aXek8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OvMCoQY40owK92mBPQyAD8JbqiA0Q7zLLV/X7F5y5yVIJ5baLZDGflsywZ2gVQlOt
	 CdA0igLillBr6n5Ku6RVGmZGSGXlkJL2akcWaAd6b2QoKGjkdcG4k4erUriWjK3hmr
	 xcsc7AocCE3ZS4f4OAzOvOM/KrXuEFg2BbhRE18c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60FC9F80229;
	Wed, 15 Apr 2020 06:45:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 728BEF80245; Wed, 15 Apr 2020 06:45:12 +0200 (CEST)
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com
 [221.176.66.81])
 by alsa1.perex.cz (Postfix) with ESMTP id 77FD1F80115
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 06:44:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77FD1F80115
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by
 rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5e9690f5ddd-61fbb;
 Wed, 15 Apr 2020 12:43:34 +0800 (CST)
X-RM-TRANSID: 2eec5e9690f5ddd-61fbb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65e9690f3a89-00121;
 Wed, 15 Apr 2020 12:43:33 +0800 (CST)
X-RM-TRANSID: 2ee65e9690f3a89-00121
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ASoC: fsl_micfil: Omit superfluous error message in
 fsl_micfil_probe()
Date: Wed, 15 Apr 2020 12:45:13 +0800
Message-Id: <20200415044513.17492-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Shengju Zhang <zhangshengju@cmss.chinamobile.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Tang Bin <tangbin@cmss.chinamobile.com>
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

In the function fsl_micfil_probe(), when get irq failed, the function 
platform_get_irq() logs an error message, so remove redundant message here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_micfil.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index f7f2d29f1..e73bd6570 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -702,10 +702,8 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	for (i = 0; i < MICFIL_IRQ_LINES; i++) {
 		micfil->irq[i] = platform_get_irq(pdev, i);
 		dev_err(&pdev->dev, "GET IRQ: %d\n", micfil->irq[i]);
-		if (micfil->irq[i] < 0) {
-			dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+		if (micfil->irq[i] < 0)
 			return micfil->irq[i];
-		}
 	}
 
 	if (of_property_read_bool(np, "fsl,shared-interrupt"))
-- 
2.20.1.windows.1



