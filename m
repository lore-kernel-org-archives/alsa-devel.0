Return-Path: <SRS0=HRrq=LM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260C6C48BDF
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Jun 2021 13:59:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C451611CE
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Jun 2021 13:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C451611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DAF01720;
	Fri, 18 Jun 2021 15:58:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DAF01720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624024745;
	bh=nzT9waZs3iwwjBkhYqL+oFxX18KTEzTWElpp6kVVsl4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lFRO/OmQ7bUHMcfjXUcsGE2hYI51QK2NmJSDEuk/f8rYUg8cDFe7bWuWB7HlZ4PDA
	 Rh4MlRZnlHGUmvKc54xuOTt3C9VjH77HiTWkqrFMsjMOBzSK4gLOleWAgjUulkctee
	 7K/jv7VU/VDfi0OIBcq7da1m2sg1+RY0Htb8PsuU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0B84F804CA;
	Fri, 18 Jun 2021 15:57:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AE3BF804B0; Fri, 18 Jun 2021 15:57:23 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2A98F80148
 for <alsa-devel@alsa-project.org>; Fri, 18 Jun 2021 15:57:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2A98F80148
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G60j01mM1zXff6;
 Fri, 18 Jun 2021 21:52:04 +0800 (CST)
Received: from dggema755-chm.china.huawei.com (10.1.198.197) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 21:57:08 +0800
Received: from huawei.com (10.90.53.225) by dggema755-chm.china.huawei.com
 (10.1.198.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 18
 Jun 2021 21:57:07 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
Subject: [PATCH -next 2/2] ASoC: mediatek: mt8183: Fix Unbalanced
 pm_runtime_enable in mt8183_afe_pcm_dev_probe
Date: Fri, 18 Jun 2021 22:11:04 +0800
Message-ID: <20210618141104.105047-3-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20210618141104.105047-1-zhangqilong3@huawei.com>
References: <20210618141104.105047-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema755-chm.china.huawei.com (10.1.198.197)
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 lgirdwood@gmail.com, broonie@kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
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

Add missing pm_runtime_disable() when probe error out. It could
avoid pm_runtime implementation complains when removing and probing
again the driver.

Fixes:a94aec035a122 ("ASoC: mediatek: mt8183: add platform driver")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 43 ++++++++++++++--------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index c4a598cbbdaa..14e77df06b01 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -1119,25 +1119,26 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->regmap = syscon_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(afe->regmap)) {
 		dev_err(dev, "could not get regmap from parent\n");
-		return PTR_ERR(afe->regmap);
+		ret = PTR_ERR(afe->regmap);
+		goto err_pm_disable;
 	}
 	ret = regmap_attach_dev(dev, afe->regmap, &mt8183_afe_regmap_config);
 	if (ret) {
 		dev_warn(dev, "regmap_attach_dev fail, ret %d\n", ret);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	rstc = devm_reset_control_get(dev, "audiosys");
 	if (IS_ERR(rstc)) {
 		ret = PTR_ERR(rstc);
 		dev_err(dev, "could not get audiosys reset:%d\n", ret);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = reset_control_reset(rstc);
 	if (ret) {
 		dev_err(dev, "failed to trigger audio reset:%d\n", ret);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	/* enable clock for regcache get default value from hw */
@@ -1147,7 +1148,7 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 	ret = regmap_reinit_cache(afe->regmap, &mt8183_afe_regmap_config);
 	if (ret) {
 		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	pm_runtime_put_sync(&pdev->dev);
@@ -1160,8 +1161,10 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->memif_size = MT8183_MEMIF_NUM;
 	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
 				  GFP_KERNEL);
-	if (!afe->memif)
-		return -ENOMEM;
+	if (!afe->memif) {
+		ret = -ENOMEM;
+		goto err_pm_disable;
+	}
 
 	for (i = 0; i < afe->memif_size; i++) {
 		afe->memif[i].data = &memif_data[i];
@@ -1178,22 +1181,26 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->irqs_size = MT8183_IRQ_NUM;
 	afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs),
 				 GFP_KERNEL);
-	if (!afe->irqs)
-		return -ENOMEM;
+	if (!afe->irqs) {
+		ret = -ENOMEM;
+		goto err_pm_disable;
+	}
 
 	for (i = 0; i < afe->irqs_size; i++)
 		afe->irqs[i].irq_data = &irq_data[i];
 
 	/* request irq */
 	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id < 0)
-		return irq_id;
+	if (irq_id < 0) {
+		ret = irq_id;
+		goto err_pm_disable;
+	}
 
 	ret = devm_request_irq(dev, irq_id, mt8183_afe_irq_handler,
 			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
 	if (ret) {
 		dev_err(dev, "could not request_irq for asys-isr\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	/* init sub_dais */
@@ -1204,7 +1211,7 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_warn(afe->dev, "dai register i %d fail, ret %d\n",
 				 i, ret);
-			return ret;
+			goto err_pm_disable;
 		}
 	}
 
@@ -1213,7 +1220,7 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_warn(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
 			 ret);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	afe->mtk_afe_hardware = &mt8183_afe_hardware;
@@ -1229,7 +1236,7 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 					      NULL, 0);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = devm_snd_soc_register_component(afe->dev,
@@ -1238,10 +1245,14 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 					      afe->num_dai_drivers);
 	if (ret) {
 		dev_warn(dev, "err_dai_component\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	return ret;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static int mt8183_afe_pcm_dev_remove(struct platform_device *pdev)
-- 
2.31.1

