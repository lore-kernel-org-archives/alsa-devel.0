Return-Path: <SRS0=W3EJ=LF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C10EC4743D
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 04:59:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CF861374
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 04:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CF861374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9B311868;
	Fri, 11 Jun 2021 06:58:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9B311868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623387575;
	bh=mgw77DMZ2mzjHoBCH1YCfX4TstUGl26gprqem1H9gbU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EOCw/0IAa6WMW1Mgor+j2rLf9+0LABomSuGt9MrPu43rtfSnnoXbtj44egh4JF5Ya
	 wMTjd622DrU8mUbefDii7no9HjTf9xV2PQMi+Ol8JROGzTE5CgOspJ3uvafUWh57lr
	 R4uFQE/SoJYtsP4kV2qcl5OtDoL760rrllfDuPog=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D983F80212;
	Fri, 11 Jun 2021 06:58:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F4E8F8026C; Fri, 11 Jun 2021 06:58:43 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2EB3F80149
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 06:58:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2EB3F80149
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G1T7H3k81zZfPn;
 Fri, 11 Jun 2021 12:55:39 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 12:58:30 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 12:58:30 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH -next] ASoC: bcm: cygnus_ssp: Use
 devm_platform_ioremap_resource_byname()
Date: Fri, 11 Jun 2021 13:02:35 +0800
Message-ID: <20210611050235.4182746-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Cc: broonie@kernel.org, lgirdwood@gmail.com
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

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/bcm/cygnus-ssp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index ba03bb62ba96..fca5a3f2eec5 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1308,7 +1308,6 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *child_node;
-	struct resource *res;
 	struct cygnus_audio *cygaud;
 	int err;
 	int node_count;
@@ -1320,13 +1319,11 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, cygaud);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "aud");
-	cygaud->audio = devm_ioremap_resource(dev, res);
+	cygaud->audio = devm_platform_ioremap_resource_byname(pdev, "aud");
 	if (IS_ERR(cygaud->audio))
 		return PTR_ERR(cygaud->audio);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "i2s_in");
-	cygaud->i2s_in = devm_ioremap_resource(dev, res);
+	cygaud->i2s_in = devm_platform_ioremap_resource_byname(pdev, "i2s_in");
 	if (IS_ERR(cygaud->i2s_in))
 		return PTR_ERR(cygaud->i2s_in);
 
-- 
2.25.1

