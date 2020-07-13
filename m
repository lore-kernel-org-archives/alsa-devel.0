Return-Path: <SRS0=sipn=AY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713C1C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:27:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C72206F4
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VH1sYjIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C72206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 512D484D;
	Mon, 13 Jul 2020 12:26:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 512D484D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594636034;
	bh=+FHdZDZD15/J+MNzXnODLuZOvF1Vnwq4p7AAlPgnJFU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VH1sYjIMqCdOcsuAjh3f1y0NMzavxKzx7pZ3sQqvj1HzvR9XRzYOhVr5ZpOx4foMU
	 hpu/XEBJwOmvv3OMzyVs7lL2edFrVBkY2SmexxdKz2ScjvQy3XfL0Zq2/DUuHgKl0J
	 ZWkRTqgmpgvBoXlbPJgwO33UxNbWrG7UfaWkJIoY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B27B8F800E5;
	Mon, 13 Jul 2020 12:26:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C61B5F8021D; Mon, 13 Jul 2020 12:26:21 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.130])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AB0FF800E5
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2020 12:26:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AB0FF800E5
Received: from localhost (unknown [192.168.167.69])
 by lucky1.263xmail.com (Postfix) with ESMTP id BCE20CA52C;
 Mon, 13 Jul 2020 18:26:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P8591T140098829747968S1594635967092824_; 
 Mon, 13 Jul 2020 18:26:08 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <dfe795403dc7e7e9647a2a61f1a0f504>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: broonie@kernel.org
Subject: [PATCH] ASoC: rockchip: spdif: Handle clk by pm runtime
Date: Mon, 13 Jul 2020 18:26:00 +0800
Message-Id: <1594635960-67855-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Sugar Zhang <sugar.zhang@rock-chips.com>,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

This patch handle the clk by pm runtime mechanism to simplify
the clk management.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_spdif.c | 59 +++++++++++--------------------------
 1 file changed, 17 insertions(+), 42 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 6635145..6748108 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -306,44 +306,22 @@ static int rk_spdif_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spdif->hclk = devm_clk_get(&pdev->dev, "hclk");
-	if (IS_ERR(spdif->hclk)) {
-		dev_err(&pdev->dev, "Can't retrieve rk_spdif bus clock\n");
+	if (IS_ERR(spdif->hclk))
 		return PTR_ERR(spdif->hclk);
-	}
-	ret = clk_prepare_enable(spdif->hclk);
-	if (ret) {
-		dev_err(spdif->dev, "hclock enable failed %d\n", ret);
-		return ret;
-	}
 
 	spdif->mclk = devm_clk_get(&pdev->dev, "mclk");
-	if (IS_ERR(spdif->mclk)) {
-		dev_err(&pdev->dev, "Can't retrieve rk_spdif master clock\n");
-		ret = PTR_ERR(spdif->mclk);
-		goto err_disable_hclk;
-	}
-
-	ret = clk_prepare_enable(spdif->mclk);
-	if (ret) {
-		dev_err(spdif->dev, "clock enable failed %d\n", ret);
-		goto err_disable_clocks;
-	}
+	if (IS_ERR(spdif->mclk))
+		return PTR_ERR(spdif->mclk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(regs)) {
-		ret = PTR_ERR(regs);
-		goto err_disable_clocks;
-	}
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	spdif->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "hclk", regs,
 						  &rk_spdif_regmap_config);
-	if (IS_ERR(spdif->regmap)) {
-		dev_err(&pdev->dev,
-			"Failed to initialise managed register map\n");
-		ret = PTR_ERR(spdif->regmap);
-		goto err_disable_clocks;
-	}
+	if (IS_ERR(spdif->regmap))
+		return PTR_ERR(spdif->regmap);
 
 	spdif->playback_dma_data.addr = res->start + SPDIF_SMPDR;
 	spdif->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -352,47 +330,44 @@ static int rk_spdif_probe(struct platform_device *pdev)
 	spdif->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, spdif);
 
-	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	pm_request_idle(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = rk_spdif_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_runtime;
+	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &rk_spdif_component,
 					      &rk_spdif_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI\n");
-		goto err_pm_runtime;
+		goto err_pm_suspend;
 	}
 
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
-		goto err_pm_runtime;
+		goto err_pm_suspend;
 	}
 
 	return 0;
 
+err_pm_suspend:
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		rk_spdif_runtime_suspend(&pdev->dev);
 err_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
-err_disable_clocks:
-	clk_disable_unprepare(spdif->mclk);
-err_disable_hclk:
-	clk_disable_unprepare(spdif->hclk);
 
 	return ret;
 }
 
 static int rk_spdif_remove(struct platform_device *pdev)
 {
-	struct rk_spdif_dev *spdif = dev_get_drvdata(&pdev->dev);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		rk_spdif_runtime_suspend(&pdev->dev);
 
-	clk_disable_unprepare(spdif->mclk);
-	clk_disable_unprepare(spdif->hclk);
-
 	return 0;
 }
 
-- 
2.7.4



