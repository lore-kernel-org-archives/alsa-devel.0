Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05170C2BB55
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:02:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F9A20771
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZeYYgYZU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="poFbNxuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F9A20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 473D41665;
	Thu, 16 Apr 2020 17:01:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 473D41665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587049339;
	bh=KqGytBxknoCm2EX8RBJYDzdBmYPWvznw31VgqU8yeUA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZeYYgYZUTfzP8Yza37frXKQZ27O66TnAu/KOt6qxYC73TOi9J3JxtcwDtVmRdeM4m
	 Wl/SGkWtI9EK/l0QVxzMLvM7M4iRjpsVpnnTn9B+haAHKjoTn2bfh9Pp2zaSYKUklZ
	 jhVnmKsMRd6/dnbTZZ2hhr7iJKAL3Ct1wA/UUhhQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F76AF8028F;
	Thu, 16 Apr 2020 17:00:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0132F8027D; Thu, 16 Apr 2020 17:00:33 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1494F8013D
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 17:00:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1494F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="poFbNxuZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=+StCyVKVCq0UE0CgHb0xeQ2f1v6WIGLWJIGurS7IV14=; b=poFbNxuZdMO9WGexcKzq87NMkE
 r+GxiiuR1cnjh9NzmZy4MvPzu0G35Qnrv5KxX1WXho7H6P6vMEau3sUUjeUMv0KaOREnyUXZAujHR
 Azze5N6dEDM5J5sPqYiq7bKXrdBac3JAUXswQmbMafKLfcq8Tg5sHG8queUAqb2qEZ3JqX++GdwIw
 OJ0/mfKCNLAWITk9bOcv5EMLXk4l3qkQV9phtdfBuK779em0je9iYPfbkj6mdc9ByBh+w78a2DGRf
 8bVtbtha5WCeC9siEdjpN66KYyMmsArUeGrNFiHrw0suZeZ0ds9rGstenFaAaWFAgLmOvS2sV6ZHc
 I9Ao/djw==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jP600-0001wG-8g; Thu, 16 Apr 2020 15:00:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 1/7] ASoC: txx9: don't work around too small resource_size_t
Date: Thu, 16 Apr 2020 17:00:05 +0200
Message-Id: <20200416150011.820984-2-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416150011.820984-1-hch@lst.de>
References: <20200416150011.820984-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-mips@vger.kernel.org
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

The txx9 sound driver deends on HAS_TXX9_ACLC, which is only set for
three tx49xx SOCs, and thus always has a 64-bit phys_addr_t and
resource_size_t.  Instead of poking into ioremap internals to work
around a potentially too small resource_size_t just add a BUILD_BUG_ON
to catch such a case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 sound/soc/txx9/txx9aclc-ac97.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index b1d9615f2375..7402448bdb09 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -175,6 +175,8 @@ static int txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 	int err;
 	int irq;
 
+	BUILD_BUG_ON(sizeof(drvdata->physbase) > sizeof(r->start));
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -190,10 +192,6 @@ static int txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, drvdata);
 	drvdata->physbase = r->start;
-	if (sizeof(drvdata->physbase) > sizeof(r->start) &&
-	    r->start >= TXX9_DIRECTMAP_BASE &&
-	    r->start < TXX9_DIRECTMAP_BASE + 0x400000)
-		drvdata->physbase |= 0xf00000000ull;
 	err = devm_request_irq(&pdev->dev, irq, txx9aclc_ac97_irq,
 			       0, dev_name(&pdev->dev), drvdata);
 	if (err < 0)
-- 
2.25.1

