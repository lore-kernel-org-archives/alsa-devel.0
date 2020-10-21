Return-Path: <SRS0=H+KG=D4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39117C388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:48:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267EB20BED
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GSNo1nrh";
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DnInzNMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267EB20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84B691810;
	Wed, 21 Oct 2020 15:47:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84B691810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603288128;
	bh=7hCe+pMZubg2y01pOMmn9CafC3sJu7WaipbcARvwHd8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GSNo1nrhMVDrSXA8kgGzl7ZyBKydRuAYB2wejjV/YsTBgfCwE+xn9nngEjsJOD20Z
	 Aj6x6h+sK/q+mMby+HkMAKTFnnA1aIrNXCmfXLWDM/MohNXCR00h2t/7tvDMXBLVCN
	 aj7snu5woCPX91PFsWlRj9S3AALuyHjYJBWrTb38=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AE85F80567;
	Wed, 21 Oct 2020 15:38:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39184F80264; Wed, 21 Oct 2020 09:04:58 +0200 (CEST)
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD4D3F80111
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2020 09:04:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD4D3F80111
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.b="DnInzNMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=p03GQ3/3M5H2l6FbiI
 2Wsg8qkYfOo4GdiyO4pQ0cRiI=; b=DnInzNMqK54g8JOg39d3hXqaGbnwCpyjvY
 JFMufgMvnXKtRe2UKXlCGaE/GAR4cARv1mvfGbOWsUXm5uDYSK/OtyKwxtc7pF1D
 167z+2ZXYAfSUIzzwjGiwZSpjzMxzwxrpDtC1SX5DARj2AooivblnbAgQuSBIAti
 TlFaXGphQ=
Received: from localhost.localdomain (unknown [36.112.86.14])
 by smtp9 (Coremail) with SMTP id NeRpCgBHXxeR3Y9fD5tdMQ--.10747S2;
 Wed, 21 Oct 2020 15:04:49 +0800 (CST)
From: Defang Bo <bodefang@126.com>
To: broonie@kernel.org,
	perex@perex.cz
Subject: [PATCH v2] ASoC: amd: move the call to devm_kzalloc below
 platform_get_resource()
Date: Wed, 21 Oct 2020 15:04:27 +0800
Message-Id: <1603263867-8754-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <broonie@kernel.org>
References: <broonie@kernel.org>
X-CM-TRANSID: NeRpCgBHXxeR3Y9fD5tdMQ--.10747S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFW7try7tr13WryxAr48tFb_yoWfKwb_ta
 yDu34qgryUWr1agry8Cr43Arn5K3ZIkrn5G34agryav348uws3Ca1UZrZruFZruws2kFWU
 Xw1v9rWay343AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUngo2UUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbikhHE11pEBlwrewAAsE
X-Mailman-Approved-At: Wed, 21 Oct 2020 15:37:33 +0200
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, Defang Bo <bodefang@126.com>,
 akshu.agrawal@amd.com, weiyongjun1@huawei.com,
 Vishnuvardhanrao.Ravulapati@amd.com
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

Just as the commit <4cb79ef9c6c4>("ASoC: amd: Fix potential NULL pointer dereference"),it makes no sense to allocate any resources if platform_get_resource fails,so move the call to devm_kzalloc() below the mentioned code.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index c9c69eb..04ec603 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -307,9 +307,11 @@ static int acp3x_dai_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
 		return -ENOMEM;
 	}
+
 	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data), GFP_KERNEL);
 	if (!adata)
 		return -ENOMEM;
+
 	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
 						resource_size(res));
 	if (!adata->acp3x_base)
-- 
1.9.1

