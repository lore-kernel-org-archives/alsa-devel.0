Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCBFC433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Oct 2022 11:44:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 515D028C8;
	Mon, 10 Oct 2022 13:43:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 515D028C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665402284;
	bh=GOU4t9yqHznR3dgfuVRv65ynXhL6gd0l6Hv4Hcg3bpc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S/2qjt2fYf5S0YXdhXxWGeqeFgLZgA8M4bMPJ3j1w7DSxtFAhoTcm+kMxHZDRRZzq
	 g2wDAC9z3j0Q4JFTiWmbQn7E06ozLnWMWO1s3VcS9qhd4aL5SK+Vf5yQ+tbaHpdR7C
	 8Q8r8cgnLI7/YTPa2jfzCFa61nfVIpafwC7yoOCc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6F6AF80155;
	Mon, 10 Oct 2022 13:43:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F60AF804D8; Mon, 10 Oct 2022 13:43:52 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40293F80155
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2022 13:43:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40293F80155
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmH476GWZzHv7K;
 Mon, 10 Oct 2022 19:38:47 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 19:43:45 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 19:43:45 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <matthias.bgg@gmail.com>,
 <ckeepax@opensource.wolfsonmicro.com>, <jeff_chang@richtek.com>,
 <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 -next 1/3] ASoC: wm5102: Revert "ASoC: wm5102: Fix PM
 disable depth imbalance in wm5102_probe"
Date: Mon, 10 Oct 2022 19:48:50 +0800
Message-ID: <20221010114852.88127-2-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20221010114852.88127-1-zhangqilong3@huawei.com>
References: <20221010114852.88127-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-mediatek@lists.infradead.org
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

This reverts commit fcbb60820cd3008bb44334a0395e5e57ccb77329.

The pm_runtime_disable is redundant when error returns in
wm5102_probe, we just revert the old patch to fix it.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm5102.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index e56e30d59760..adaf886b0a9d 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -2099,6 +2099,9 @@ static int wm5102_probe(struct platform_device *pdev)
 		regmap_update_bits(arizona->regmap, wm5102_digital_vu[i],
 				   WM5102_DIG_VU, WM5102_DIG_VU);
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_idle(&pdev->dev);
+
 	ret = arizona_request_irq(arizona, ARIZONA_IRQ_DSP_IRQ1,
 				  "ADSP2 Compressed IRQ", wm5102_adsp2_irq,
 				  wm5102);
@@ -2131,9 +2134,6 @@ static int wm5102_probe(struct platform_device *pdev)
 		goto err_spk_irqs;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_idle(&pdev->dev);
-
 	return ret;
 
 err_spk_irqs:
-- 
2.25.1

