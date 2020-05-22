Return-Path: <SRS0=jkt5=7E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1802DC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 08:18:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8941D206DD
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 08:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WLeutQUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8941D206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E53871882;
	Fri, 22 May 2020 10:18:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E53871882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590135535;
	bh=4tCkWI+nwB/ngJfOZxhfECJxWBnpmih20sDJZ19FXc4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WLeutQUca9iQ3RxdR4ZDkqjWvM4xuIe4m+VWmg3aO5Pfe1hl+TtF1muqOQCvD1pHg
	 ZEd0+PQ53gHpaT0G7EkM5/CmF/tho29sC25ulOs2V7y+iJUS5IBwHEFK0YU/aLFFzn
	 FnZZNRK2AD/j70YMMpXTzgZHUDztn1XspiqnUG+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DA5EF80121;
	Fri, 22 May 2020 10:18:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B74A0F801F9; Fri, 22 May 2020 10:18:02 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FDB0F80121
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2020 10:17:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FDB0F80121
Received: from [123.114.63.221] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1jc2sL-0003wm-Ik; Fri, 22 May 2020 08:17:54 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org, broonie@kernel.org, Vijendar.Mukunda@amd.com
Subject: [PATCH v2] ASoC: amd: put off registering mach platform_dev to avoid
 -517 err
Date: Fri, 22 May 2020 16:17:38 +0800
Message-Id: <20200522081738.11636-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.17.1
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

If the mach driver's probe is called ahead of codec driver's probe,
the kernel will print -517 error message although the audio still
works finally:
acp_pdm_mach acp_pdm_mach.0: snd_soc_register_card(acp) failed: -517

we could workaround this issue by moving the registration of mach
platform_dev to plat driver's probe.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 13 +++++++++++++
 sound/soc/amd/renoir/rn-pci-acp3x.c  |  3 ---
 sound/soc/amd/renoir/rn_acp3x.h      |  3 ++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 623dfd3ea705..46055c244998 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -402,6 +402,7 @@ static int acp_pdm_audio_probe(struct platform_device *pdev)
 	struct pdm_dev_data *adata;
 	unsigned int irqflags;
 	int status;
+	struct platform_device_info pdevinfo = {0};
 
 	if (!pdev->dev.platform_data) {
 		dev_err(&pdev->dev, "platform_data not retrieved\n");
@@ -448,6 +449,16 @@ static int acp_pdm_audio_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "ACP PDM IRQ request failed\n");
 		return -ENODEV;
 	}
+
+	pdevinfo.name = "acp_pdm_mach";
+	pdevinfo.id = 0;
+	pdevinfo.parent = &pdev->dev;
+	adata->m_pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(adata->m_pdev)) {
+		dev_err(&pdev->dev, "cannot register %s device\n",
+			pdevinfo.name);
+		return PTR_ERR(adata->m_pdev);
+	}
 	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -457,7 +468,9 @@ static int acp_pdm_audio_probe(struct platform_device *pdev)
 
 static int acp_pdm_audio_remove(struct platform_device *pdev)
 {
+	struct pdm_dev_data *adata = dev_get_drvdata(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	platform_device_unregister(adata->m_pdev);
 	return 0;
 }
 
diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index 859ed67b93cf..f5f450cbd249 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -230,9 +230,6 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 	pdevinfo[1].name = "dmic-codec";
 	pdevinfo[1].id = 0;
 	pdevinfo[1].parent = &pci->dev;
-	pdevinfo[2].name = "acp_pdm_mach";
-	pdevinfo[2].id = 0;
-	pdevinfo[2].parent = &pci->dev;
 	for (index = 0; index < ACP_DEVS; index++) {
 		adata->pdev[index] =
 				platform_device_register_full(&pdevinfo[index]);
diff --git a/sound/soc/amd/renoir/rn_acp3x.h b/sound/soc/amd/renoir/rn_acp3x.h
index 75228e306e0b..232eda4db055 100644
--- a/sound/soc/amd/renoir/rn_acp3x.h
+++ b/sound/soc/amd/renoir/rn_acp3x.h
@@ -7,7 +7,7 @@
 
 #include "rn_chip_offset_byte.h"
 
-#define ACP_DEVS		3
+#define ACP_DEVS		2
 #define ACP_PHY_BASE_ADDRESS 0x1240000
 #define	ACP_REG_START	0x1240000
 #define	ACP_REG_END	0x1250200
@@ -59,6 +59,7 @@ struct pdm_dev_data {
 	u32 pdm_irq;
 	void __iomem *acp_base;
 	struct snd_pcm_substream *capture_stream;
+	struct platform_device *m_pdev;
 };
 
 struct pdm_stream_instance {
-- 
2.17.1

