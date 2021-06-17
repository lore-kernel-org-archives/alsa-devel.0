Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F60CC48BE5
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 03:36:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE34A613E4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 03:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE34A613E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AB42169D;
	Thu, 17 Jun 2021 05:35:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AB42169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623900978;
	bh=1jsQ5Bt0yyTICYt2uyMugrZLM0CBzY+r4vmoF7Japvg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LM+UMDb0n6gFCnik0F26L7xOo4P+e/cVXcYZDYEXdTOmBHDAvAvPrR2XsisIdvJJl
	 aHVt/YyrMoD2ss2ckmpTWlnP/BLEUKD/sUB5BQDhIyn6ZiO7ZQlp+sG7Md8jnRet1w
	 79wFTL+UR068SCwCYboQZVAIlHERusn0jsIERopA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD892F80171;
	Thu, 17 Jun 2021 05:35:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1DBD1F8025A; Thu, 17 Jun 2021 05:35:26 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8D7AF80148
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 05:35:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8D7AF80148
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G56xw1wFyzWlbg;
 Thu, 17 Jun 2021 11:30:12 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 11:35:14 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 11:35:14 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH -next] ASoC: sti: sti_uniperif: Use
 devm_platform_get_and_ioremap_resource()
Date: Thu, 17 Jun 2021 11:39:03 +0800
Message-ID: <20210617033903.613727-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Cc: arnaud.pouliquen@foss.st.com, broonie@kernel.org, lgirdwood@gmail.com
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
 sound/soc/sti/sti_uniperif.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index e3561f00ed40..34668fe3909d 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -410,16 +410,8 @@ static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 	*dai = sti_uniperiph_dai_template;
 	dai->name = dev_data->dai_names;
 
-	/* Get resources */
-	uni->mem_region = platform_get_resource(priv->pdev, IORESOURCE_MEM, 0);
-
-	if (!uni->mem_region) {
-		dev_err(dev, "Failed to get memory resource\n");
-		return -ENODEV;
-	}
-
-	uni->base = devm_ioremap_resource(dev, uni->mem_region);
-
+	/* Get resources and base address */
+	uni->base = devm_platform_get_and_ioremap_resource(priv->pdev, 0, &uni->mem_region);
 	if (IS_ERR(uni->base))
 		return PTR_ERR(uni->base);
 
-- 
2.25.1

