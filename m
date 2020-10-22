Return-Path: <SRS0=uLsF=D5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065ABC388F7
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:04:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CF722267
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ky3UDtO3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiEfgRwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CF722267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 81CED17D5;
	Thu, 22 Oct 2020 15:03:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 81CED17D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603371857;
	bh=N/tYBwPqG9AQH9Ur5MTTu9Of//y8Vh8iRmS1V/i4W6o=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ky3UDtO35y0ILWBAUDUkxWNjYSla4JcICiUxUpxpJluOZbkA2PtOcuO1C7uFCFsbj
	 NAfhaCFD/9769+EoXbP/wAL2p0QTVXlmLAR6hdkCRQttiy/k54O/nMSaR6q3E2Txhw
	 ViKMLzGKqrJmGh0aXSK+qaPcGQRi0QuwpM1Qf/Zw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E617F800CE;
	Thu, 22 Oct 2020 15:03:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DDEAEF804A9; Thu, 22 Oct 2020 15:03:25 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2E4CF80247
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2020 15:03:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2E4CF80247
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="OiEfgRwH"
Received: by mail-wm1-x342.google.com with SMTP id d78so1985930wmd.3
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2020 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JX1+Nd2NMN3YgumN5l7d/iU16tJSrs+AyQOv7OqussM=;
 b=OiEfgRwHO4RHB2ajFDtyhUv0emmGE3Mfj6csuFijExTsUCqStVBs9xPPiqio03ZED4
 Ds5kmkqvMiW/nWz/lawqt7iAjDUoh7Sz4SgE4HBWOcs7M8SxoWf23R81bvDTC21pv+N5
 KkYfLick8Hjahnd8KGEw4fO4VtlRfnaa+a/JKWZVTxLaam4XVek8kTyGoKHwlu8NBOwM
 jmUntjClG/VQET+rS+5H3TdlPexnFa++T3ju4p9OkesOz39TyCzD5iABkChZel/lTmnn
 g7Qfxw8DuH1LdTZF1DXkIM4A9ayUpxeS2fzYHo2RkyuTSgwsohCIp5qg3/K3ZQF0hZor
 A6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JX1+Nd2NMN3YgumN5l7d/iU16tJSrs+AyQOv7OqussM=;
 b=EpLpKHGdcOnR0tk1mnvZ+POKuqwres4MfofNSf/RBmZE/weI3i/9quxXiZ8vugD0KS
 PaQ4SgVFMkGNPkO+L/PDz179DX9KknFz5LJNqeXurPetXSp124Hc3ogiytpPIvObWJ4q
 IfzsrnOM/zxb0QL5hzcj5lmXczP5VmbY6jZtGNpftaIIQdHVx5oJCL/n462bKyRClCzr
 WkMsogjkcfUf3n5ZiAYgd/xe7uw+6dru7vM97MO/E98hvNdQu8o0HRQ+LbY7oKTu8MUq
 xzRye+CU5mXNpK4jTIjfDMRa4KVgTaUZJPWnfUSfxkYhUBc3yGoHx05ZnY/ajloGjEzG
 zgLg==
X-Gm-Message-State: AOAM530eoHpf0wCilXW409L2f1oE3jECIQlpSXcP/vk2BX2ioqOw4xMi
 QlCwcBXyGKXSOolsAsBegqufww==
X-Google-Smtp-Source: ABdhPJwmfpkqQOZIduZK7eQOlIhxMw1GvztKPG1ikqKZEp5ek0w7uSuu53iY/P1EhvWosnvGkow31A==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr2317121wmk.127.1603371799182; 
 Thu, 22 Oct 2020 06:03:19 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id m12sm3705818wrs.92.2020.10.22.06.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 06:03:18 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH] ASoC: qcom: qdsp6: make use of devm_of_platform_populate
Date: Thu, 22 Oct 2020 14:02:54 +0100
Message-Id: <20201022130254.29937-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org
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

make use of devm_of_platform_populate to remove some redundant code!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6adm.c | 10 +---------
 sound/soc/qcom/qdsp6/q6afe.c | 10 +---------
 sound/soc/qcom/qdsp6/q6asm.c |  9 +--------
 3 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 2f3ea6beb066..e4b3d566447a 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -601,14 +601,7 @@ static int q6adm_probe(struct apr_device *adev)
 	INIT_LIST_HEAD(&adm->copps_list);
 	spin_lock_init(&adm->copps_list_lock);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
-}
-
-static int q6adm_remove(struct apr_device *adev)
-{
-	of_platform_depopulate(&adev->dev);
-
-	return 0;
+	return devm_of_platform_populate(dev);
 }
 
 static const struct of_device_id q6adm_device_id[]  = {
@@ -619,7 +612,6 @@ MODULE_DEVICE_TABLE(of, q6adm_device_id);
 
 static struct apr_driver qcom_q6adm_driver = {
 	.probe = q6adm_probe,
-	.remove = q6adm_remove,
 	.callback = q6adm_callback,
 	.driver = {
 		.name = "qcom-q6adm",
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 688878a002a4..2efde6bd2123 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -1740,14 +1740,7 @@ static int q6afe_probe(struct apr_device *adev)
 
 	dev_set_drvdata(dev, afe);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
-}
-
-static int q6afe_remove(struct apr_device *adev)
-{
-	of_platform_depopulate(&adev->dev);
-
-	return 0;
+	return devm_of_platform_populate(dev);
 }
 
 static const struct of_device_id q6afe_device_id[]  = {
@@ -1758,7 +1751,6 @@ MODULE_DEVICE_TABLE(of, q6afe_device_id);
 
 static struct apr_driver qcom_q6afe_driver = {
 	.probe = q6afe_probe,
-	.remove = q6afe_remove,
 	.callback = q6afe_callback,
 	.driver = {
 		.name = "qcom-q6afe",
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index d745a02fcd5f..0965c0d4ac2d 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1724,15 +1724,9 @@ static int q6asm_probe(struct apr_device *adev)
 	spin_lock_init(&q6asm->slock);
 	dev_set_drvdata(dev, q6asm);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+	return devm_of_platform_populate(dev);
 }
 
-static int q6asm_remove(struct apr_device *adev)
-{
-	of_platform_depopulate(&adev->dev);
-
-	return 0;
-}
 static const struct of_device_id q6asm_device_id[]  = {
 	{ .compatible = "qcom,q6asm" },
 	{},
@@ -1741,7 +1735,6 @@ MODULE_DEVICE_TABLE(of, q6asm_device_id);
 
 static struct apr_driver qcom_q6asm_driver = {
 	.probe = q6asm_probe,
-	.remove = q6asm_remove,
 	.callback = q6asm_srvc_callback,
 	.driver = {
 		.name = "qcom-q6asm",
-- 
2.21.0

