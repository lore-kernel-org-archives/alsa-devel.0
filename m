Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BF2C43217
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Nov 2022 14:08:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCBFC16F6;
	Thu, 24 Nov 2022 15:07:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCBFC16F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669298896;
	bh=CeNH+9Qg2xDuH+dN/h4c0EPz/luFqRSZty09ok/I9qg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HN93Xva4gI2eB2cFpiWpeqVs3rC4mhemU5vbEx3m/MKBoUX4bBZY3O327hLwrT313
	 NjNKdZnBe98inIbNc8IdTY6VqOj1ZBqg6kWintqv0i4/nfN6/wtncZIMVxwJjTzqiO
	 NEiGQMvL6G55EzFoWVoEBDS10PZH4T3pK4bR1kP4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AAE1F80245;
	Thu, 24 Nov 2022 15:07:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 165CCF80431; Thu, 24 Nov 2022 15:07:25 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8824EF8014E
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2022 15:07:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8824EF8014E
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NJ0D02Gj0z15Mp6;
 Thu, 24 Nov 2022 22:06:40 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 24 Nov
 2022 22:07:12 +0800
From: Yuan Can <yuancan@huawei.com>
To: <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <rohitkr@codeaurora.org>, <ajitp@codeaurora.org>,
 <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: qcom: Add checks for devm_kcalloc
Date: Thu, 24 Nov 2022 14:05:10 +0000
Message-ID: <20221124140510.63468-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Cc: yuancan@huawei.com
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

As the devm_kcalloc may return NULL, the return value needs to be checked
to avoid NULL poineter dereference.

Fixes: 24caf8d9eb10 ("ASoC: qcom: lpass-sc7180: Add platform driver for lpass audio")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 sound/soc/qcom/lpass-sc7180.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index 77a556b27cf0..24a1c121cb2e 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -131,6 +131,9 @@ static int sc7180_lpass_init(struct platform_device *pdev)
 
 	drvdata->clks = devm_kcalloc(dev, variant->num_clks,
 				     sizeof(*drvdata->clks), GFP_KERNEL);
+	if (!drvdata->clks)
+		return -ENOMEM;
+
 	drvdata->num_clks = variant->num_clks;
 
 	for (i = 0; i < drvdata->num_clks; i++)
-- 
2.17.1

