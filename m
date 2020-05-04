Return-Path: <SRS0=TVyu=6S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E7EC3A5A9
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 07:31:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBAA720735
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 07:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C20PBFjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAA720735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21FEA16D1;
	Mon,  4 May 2020 09:30:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21FEA16D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588577463;
	bh=DAaIvp/yTrJsrQw3Xle2LH6mWH15QBAKPZnsvFV2XNU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C20PBFjs9hVLQ/adQvrSLskt/Ej0pFFlJl082ffl4CoqpUCGxfhessjtwNNatlkqi
	 5fWR0xiggTu31/7VfGaEJqBpDUqzCjn1aHq+0Rm0bTAgFRRADdgFh0z9MP+9UFixfK
	 0CNaSkXKYSShzfSgxsElZTUPNNPSXBjHwm1CTRoM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4490F80234;
	Mon,  4 May 2020 09:30:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C62DF80249; Mon,  4 May 2020 09:30:08 +0200 (CEST)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com
 [221.176.66.80])
 by alsa1.perex.cz (Postfix) with ESMTP id 487B6F800E5
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2020 09:28:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 487B6F800E5
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by
 rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65eafc3f5f76-fd171;
 Mon, 04 May 2020 15:27:49 +0800 (CST)
X-RM-TRANSID: 2ee65eafc3f5f76-fd171
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.182.180])
 by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35eafc3f2125-99285;
 Mon, 04 May 2020 15:27:49 +0800 (CST)
X-RM-TRANSID: 2ee35eafc3f2125-99285
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
 perex@perex.cz
Subject: [PATCH] ASoC: qcom: Use devm_platform_ioremap_resource_byname() to
 simplify code
Date: Mon,  4 May 2020 15:28:20 +0800
Message-Id: <20200504072820.5328-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
 linux-kernel@vger.kernel.org, Tang Bin <tangbin@cmss.chinamobile.com>
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

Use devm_platform_ioremap_resource_byname() instead of
platform_get_resource_byname() + devm_ioremap_resource().

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/qcom/lpass-cpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index dbce7e92b..885c1f2e7 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -417,7 +417,6 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 {
 	struct lpass_data *drvdata;
 	struct device_node *dsp_of_node;
-	struct resource *res;
 	struct lpass_variant *variant;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
@@ -442,9 +441,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 	drvdata->variant = (struct lpass_variant *)match->data;
 	variant = drvdata->variant;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-lpaif");
-
-	drvdata->lpaif = devm_ioremap_resource(&pdev->dev, res);
+	drvdata->lpaif = devm_platform_ioremap_resource_byname(pdev,
+						"lpass-lpaif")
 	if (IS_ERR((void const __force *)drvdata->lpaif)) {
 		dev_err(&pdev->dev, "error mapping reg resource: %ld\n",
 				PTR_ERR((void const __force *)drvdata->lpaif));
-- 
2.20.1.windows.1



