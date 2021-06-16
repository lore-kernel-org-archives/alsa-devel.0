Return-Path: <SRS0=Vkr5=LK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01914C48BE5
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 09:16:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6D161241
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 09:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6D161241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5E4D168B;
	Wed, 16 Jun 2021 11:15:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5E4D168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623834969;
	bh=5V7YShcuyZIo5gZvUU9fdDG4p3NjSLYv93UCQeJ1H4Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oevsxB6jCuqAbX22w6kpoJgBItHTQTjJ0bZ9yERpWj3+mzJawcEQ+z2NHBfRb9uIX
	 V7dGXIvJBcKfycOTVGb2qhkcjRWZL0cGHoXkReJKzZ+M5EGi8OWO/WN/gh3s07vWPE
	 ZrnPYwd+nLBaPIpQ/sLaqVMvtne76mT6olDA1gIc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69160F804E6;
	Wed, 16 Jun 2021 11:13:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB70CF804E7; Wed, 16 Jun 2021 11:13:25 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AC6AF804E3
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 11:13:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AC6AF804E3
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G4fXx3VsrzZfWY;
 Wed, 16 Jun 2021 17:10:25 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 17:13:01 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 17:13:01 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH -next 3/4] ASoC: samsung: s3c2412-i2s: Use
 devm_platform_get_and_ioremap_resource()
Date: Wed, 16 Jun 2021 17:16:51 +0800
Message-ID: <20210616091652.2552927-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616091652.2552927-1-yangyingliang@huawei.com>
References: <20210616091652.2552927-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Cc: broonie@kernel.org, krzysztof.kozlowski@canonical.com
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
 sound/soc/samsung/s3c2412-i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 81f416ac457e..ec1c6f9d76ac 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -208,8 +208,7 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	s3c2412_i2s.regs = devm_ioremap_resource(&pdev->dev, res);
+	s3c2412_i2s.regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(s3c2412_i2s.regs))
 		return PTR_ERR(s3c2412_i2s.regs);
 
-- 
2.25.1

