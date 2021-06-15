Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10D3C2B9F4
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 01:36:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09667611CE
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 01:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09667611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4A9A167A;
	Tue, 15 Jun 2021 03:35:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4A9A167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623720991;
	bh=xYS6kiiQRm7AjzBLwGjAOR0PYgoYY/9if6ZnCDs63B8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VnGnZWRt5va0HuDNiuVYzhNpPQmw7Se/Kz7I6A0m59PpX7dsuQnZafIA/UQQLLu6d
	 TnHoi7OvD53b/ZRTrdZHpXrD6RXc0piJKawSSuTT9iCi1yaF7KkAiI8UBxbfQBkl/Q
	 NRj3f/3F++CA/kBNbWZlT6sn1X6x6jj0oqjpOZ3Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42750F80424;
	Tue, 15 Jun 2021 03:35:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F4F3F8025E; Tue, 15 Jun 2021 03:35:39 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 458FBF8028B
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 03:35:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 458FBF8028B
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G3rQq48gHz6yqm;
 Tue, 15 Jun 2021 09:32:19 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:35:28 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 09:35:27 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <alsa-devel@alsa-project.org>
Subject: [PATCH -next v2 7/9] ASoC: fsl_spdif: Use
 devm_platform_get_and_ioremap_resource()
Date: Tue, 15 Jun 2021 09:39:20 +0800
Message-ID: <20210615013922.784296-8-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615013922.784296-1-yangyingliang@huawei.com>
References: <20210615013922.784296-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Cc: broonie@kernel.org, timur@kernel.org
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

Use devm_platform_get_and_ioremap_resource() to simplify
code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/fsl/fsl_spdif.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 2a76714eb8e6..d812a3ff5845 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1355,8 +1355,7 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 				spdif_priv->soc->tx_formats;
 
 	/* Get the addresses and IRQ */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, res);
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-- 
2.25.1

