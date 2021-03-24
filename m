Return-Path: <SRS0=3oXn=IW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41CBC433C1
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 10:16:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A44619F7
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 10:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A44619F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CE121669;
	Wed, 24 Mar 2021 11:15:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CE121669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616580978;
	bh=EE2yedZmi6l6xgFdYdKoZzDA44UD3wszv9cKYSWBpN0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=py4w6Nvr2cg8xHmjzoVSSM074LgMqo8HlKLmhdrUIGsaz4/tjD0iuonBJdSitDw+/
	 K7ZM2meohGZEMGmXKkhD8yibIHCnvNh6x0TpkBiLcGUlwY2vkLPiFUldtrWO+JqRaw
	 tME5Ma4Q+hxOUECmf7j5b8w/jOORdSKxbhay0tDQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 315B3F804AD;
	Wed, 24 Mar 2021 11:13:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A855F8025D; Wed, 24 Mar 2021 11:13:17 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6FE2AF801EB
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 11:13:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FE2AF801EB
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B17DB202743;
 Wed, 24 Mar 2021 11:13:03 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A7526202740;
 Wed, 24 Mar 2021 11:12:59 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 63D8040341;
 Wed, 24 Mar 2021 11:12:36 +0100 (CET)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH 6/6] ASoC: fsl_micfil: Don't use devm_regmap_init_mmio_clk
Date: Wed, 24 Mar 2021 17:58:48 +0800
Message-Id: <1616579928-22428-7-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616579928-22428-1-git-send-email-shengjiu.wang@nxp.com>
References: <1616579928-22428-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

When there is power domain bind with ipg_clk clock,

The call flow:
devm_regmap_init_mmio_clk
   - clk_prepare()
      - clk_pm_runtime_get()

cause the power domain of clock always be enabled after
regmap_init(). which impact the power consumption.

So use devm_regmap_init_mmio instead of
devm_regmap_init_mmio_clk,but explicitly enable
clock when it is used.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Viorel Suman <viorel.suman@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 2b9edd4bb94d..3cf789ed6cbe 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -31,6 +31,7 @@ struct fsl_micfil {
 	struct platform_device *pdev;
 	struct regmap *regmap;
 	const struct fsl_micfil_soc_data *soc;
+	struct clk *busclk;
 	struct clk *mclk;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	unsigned int dataline;
@@ -660,16 +661,22 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 		return PTR_ERR(micfil->mclk);
 	}
 
+	micfil->busclk = devm_clk_get(&pdev->dev, "ipg_clk");
+	if (IS_ERR(micfil->busclk)) {
+		dev_err(&pdev->dev, "failed to get ipg clock: %ld\n",
+			PTR_ERR(micfil->busclk));
+		return PTR_ERR(micfil->busclk);
+	}
+
 	/* init regmap */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	micfil->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
-						   "ipg_clk",
-						   regs,
-						   &fsl_micfil_regmap_config);
+	micfil->regmap = devm_regmap_init_mmio(&pdev->dev,
+					       regs,
+					       &fsl_micfil_regmap_config);
 	if (IS_ERR(micfil->regmap)) {
 		dev_err(&pdev->dev, "failed to init MICFIL regmap: %ld\n",
 			PTR_ERR(micfil->regmap));
@@ -729,6 +736,7 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, micfil);
 
 	pm_runtime_enable(&pdev->dev);
+	regcache_cache_only(micfil->regmap, true);
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_micfil_component,
 					      &fsl_micfil_dai, 1);
@@ -752,6 +760,7 @@ static int __maybe_unused fsl_micfil_runtime_suspend(struct device *dev)
 	regcache_cache_only(micfil->regmap, true);
 
 	clk_disable_unprepare(micfil->mclk);
+	clk_disable_unprepare(micfil->busclk);
 
 	return 0;
 }
@@ -761,10 +770,16 @@ static int __maybe_unused fsl_micfil_runtime_resume(struct device *dev)
 	struct fsl_micfil *micfil = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_prepare_enable(micfil->mclk);
+	ret = clk_prepare_enable(micfil->busclk);
 	if (ret < 0)
 		return ret;
 
+	ret = clk_prepare_enable(micfil->mclk);
+	if (ret < 0) {
+		clk_disable_unprepare(micfil->busclk);
+		return ret;
+	}
+
 	regcache_cache_only(micfil->regmap, false);
 	regcache_mark_dirty(micfil->regmap);
 	regcache_sync(micfil->regmap);
-- 
2.27.0

