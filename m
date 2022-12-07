Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C40C352A1
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Dec 2022 08:38:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 270A118A7;
	Wed,  7 Dec 2022 09:37:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 270A118A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670402290;
	bh=JwQLZcwdhX1upzAYdVwHe9cj56twZgxZu0F41RlgX+w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rhOm/81HpL/2JCwVh/s6agcYU/KGKoEpDeOrJBSfeWWI9zx1lJK3VyNv4xGdiYYBO
	 9MAhBN+jAmOjqKkKvTisiTrsQZld+8bvixJT2EV8zsI6yyuq88GHcpW3juCfos8OJC
	 4eSYjX2c6ZAbhfcsSXShgO5nZfxvrRf5uJ7sIVqQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2116F8021D;
	Wed,  7 Dec 2022 09:37:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84B4AF802BE; Wed,  7 Dec 2022 09:37:18 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B970FF80121
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2022 09:37:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B970FF80121
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRrC00KngzpW8C;
 Wed,  7 Dec 2022 16:33:00 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 16:36:35 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
 <srinivas.kandagatla@linaro.org>, <sdharia@codeaurora.org>,
 <gregkh@linuxfoundation.org>, <cuigaosheng1@huawei.com>
Subject: [PATCH] slimbus: qcom-ctrl: fix possible memory leak in
 qcom_slim_probe()
Date: Wed, 7 Dec 2022 16:36:34 +0800
Message-ID: <20221207083634.1759211-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
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

The kfree() should be called to free ctrl->wr_comp when something
fails, we should also free it in qcom_slim_remove(), otherwise
there will be a memory leak, so use devm_kcalloc instead of kcalloc
to fix it.

Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/slimbus/qcom-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 400b7b385a44..e4d92ce52c41 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -529,8 +529,8 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	ctrl->tx.sl_sz = SLIM_MSGQ_BUF_LEN;
 	ctrl->rx.n = QCOM_RX_MSGS;
 	ctrl->rx.sl_sz = SLIM_MSGQ_BUF_LEN;
-	ctrl->wr_comp = kcalloc(QCOM_TX_MSGS, sizeof(struct completion *),
-				GFP_KERNEL);
+	ctrl->wr_comp = devm_kcalloc(&pdev->dev, QCOM_TX_MSGS, sizeof(struct completion *),
+				     GFP_KERNEL);
 	if (!ctrl->wr_comp)
 		return -ENOMEM;
 
-- 
2.25.1

