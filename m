Return-Path: <SRS0=O8MK=6T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D067C47258
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 21:01:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5962068E
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 21:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XnRr93F4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdzLzTr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5962068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4814C1787;
	Tue,  5 May 2020 23:00:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4814C1787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588712489;
	bh=U/iDXf2bYlWYRCEbdyfuyYR9SDh00NStnMVLg1pRE2U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XnRr93F4rgdXMUPCIDtq4P7NDPMoaKceucShlvhnOIzMw98tVEJ2gth6i8Aq+oHvT
	 0qDIzp1k6FUpsnnXZwFnKx4XDPtFOYDj89CX8PXdtma/O+/l0sL9GF1Z79046xLleh
	 GUrKCZKSjMQgeRB1qHDzv6gwQUefj31A5KexKWlY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D08B5F80322;
	Tue,  5 May 2020 22:54:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C66FF802DC; Tue,  5 May 2020 22:54:05 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D707BF80162
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2020 22:53:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D707BF80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="bdzLzTr1"
Received: by mail-qk1-x741.google.com with SMTP id b6so3857520qkh.11
 for <alsa-devel@alsa-project.org>; Tue, 05 May 2020 13:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zl7pcfzXJtjCnfrJXGSUPEfQXLlX5/v8HMiMayaQu3k=;
 b=bdzLzTr1Ote/kOZJ9vHGPY74rBBzxk0soyu7EChlEKRQOy17XnVDkyiLfJ3R5cNbq6
 YM/Xuaf9jtKIcujLohNBdwGAKwlXOeEQOuEaCRriVpUBEp46n/8NcXoqmmbzHK5GJw4y
 JgjaHAgq/tgTDPPiJ3HPqiYEH6u2zHdaawG918N5EqqM8Ly3OhLYri/JAKfRUxgmVG/C
 trrhQ85f5PXAcdgT8XY/9kGp9IpMHnCCf/RupDzTSyFhWa7gWPOLvPMHsvLkrEhKZvAx
 WrM2lWnvHe0NvS/fn8Kk4FlAYHXE5yPEPIb8l+fiVcOp309pPNdLx6/CpXOT4TTup9zH
 fMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zl7pcfzXJtjCnfrJXGSUPEfQXLlX5/v8HMiMayaQu3k=;
 b=dujyeWaoEFkfBnbN4ThgQsDkCorvXbtX9j8AROkhb20T4d/hew9xAN+O6XOgmE14DM
 qCOqs8nBM+foRbNLpBhFMeLTYp0IYQaYx/hyxTN0uc/GS17Tee8xnJf4N1sY2EYRGpPv
 zVtXB2enIsrzfy1IPn6il3OZlxBgtkDYY4uR/Z8DcYjnH5oc26Vzb+Xr34OcXTcM0aon
 pUVbQ0YEsH/h30nz6MvYEZv/D8i67BA01Ik/Sp9PqEANbTgo2VOmiyPPsgIF89C3hbBE
 cs4caBcr5oCiQKpGr4TDGel+J6d/vS27qcLudAnV48nYnRvSqpTJxXv00qOUAPBnMyDC
 Mr/A==
X-Gm-Message-State: AGi0PuasgWE6sDO4GaFKjdAbo5ieb9SMU8TPvNRLglvsDxDrudlklxjJ
 7Z1ut5Kf8EOP3gOAO6z0nV73oOZY
X-Google-Smtp-Source: APiQypL/GSqTNhwFCfQsa8Mp6MaYYcQJ56077FGPqHiQD2WUmLIxAfYRQju+kQtO1MQbkVLEeHF6gA==
X-Received: by 2002:a37:b105:: with SMTP id a5mr5515459qkf.308.1588712032330; 
 Tue, 05 May 2020 13:53:52 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k58sm2972513qtf.40.2020.05.05.13.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 13:53:51 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: alsa-devel@alsa-project.org, broonie@kernel.org, vijendar.mukunda@amd.com,
 tiwai@suse.de
Subject: [PATCH 12/14] ASoC: amd: create platform devices for Renoir
Date: Tue,  5 May 2020 16:53:25 -0400
Message-Id: <20200505205327.642282-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200505205327.642282-1-alexander.deucher@amd.com>
References: <20200505205327.642282-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Create platform devices for generic dmic codec driver and
machine driver.
These platform devices required for creation of sound card.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/amd/renoir/rn-pci-acp3x.c | 51 ++++++++++++++++++-----------
 sound/soc/amd/renoir/rn_acp3x.h     |  1 +
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index 6d013a1bffa6..04dc6237a4b3 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -21,7 +21,7 @@ MODULE_PARM_DESC(acp_power_gating, "Enable acp power gating");
 struct acp_dev_data {
 	void __iomem *acp_base;
 	struct resource *res;
-	struct platform_device *pdev;
+	struct platform_device *pdev[ACP_DEVS];
 };
 
 static int rn_acp_power_on(void __iomem *acp_base)
@@ -156,9 +156,9 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 			    const struct pci_device_id *pci_id)
 {
 	struct acp_dev_data *adata;
-	struct platform_device_info pdevinfo;
+	struct platform_device_info pdevinfo[ACP_DEVS];
 	unsigned int irqflags;
-	int ret;
+	int ret, index;
 	u32 addr;
 
 	if (pci_enable_device(pci)) {
@@ -219,20 +219,29 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 	adata->res[1].end = pci->irq;
 
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
-	pdevinfo.name = "acp_rn_pdm_dma";
-	pdevinfo.id = 0;
-	pdevinfo.parent = &pci->dev;
-	pdevinfo.num_res = 2;
-	pdevinfo.res = adata->res;
-	pdevinfo.data = &irqflags;
-	pdevinfo.size_data = sizeof(irqflags);
-
-	adata->pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(adata->pdev)) {
-		dev_err(&pci->dev, "cannot register %s device\n",
-			pdevinfo.name);
-		ret = PTR_ERR(adata->pdev);
-		goto unregister_devs;
+	pdevinfo[0].name = "acp_rn_pdm_dma";
+	pdevinfo[0].id = 0;
+	pdevinfo[0].parent = &pci->dev;
+	pdevinfo[0].num_res = 2;
+	pdevinfo[0].res = adata->res;
+	pdevinfo[0].data = &irqflags;
+	pdevinfo[0].size_data = sizeof(irqflags);
+
+	pdevinfo[1].name = "dmic-codec";
+	pdevinfo[1].id = 0;
+	pdevinfo[1].parent = &pci->dev;
+	pdevinfo[2].name = "acp_pdm_mach";
+	pdevinfo[2].id = 0;
+	pdevinfo[2].parent = &pci->dev;
+	for (index = 0; index < ACP_DEVS; index++) {
+		adata->pdev[index] =
+				platform_device_register_full(&pdevinfo[index]);
+		if (IS_ERR(adata->pdev[index])) {
+			dev_err(&pci->dev, "cannot register %s device\n",
+				pdevinfo[index].name);
+			ret = PTR_ERR(adata->pdev[index]);
+			goto unregister_devs;
+		}
 	}
 	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&pci->dev);
@@ -243,7 +252,8 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 	return 0;
 
 unregister_devs:
-	platform_device_unregister(adata->pdev);
+	for (index = 0; index < ACP_DEVS; index++)
+		platform_device_unregister(adata->pdev[index]);
 de_init:
 	if (rn_acp_deinit(adata->acp_base))
 		dev_err(&pci->dev, "ACP de-init failed\n");
@@ -296,10 +306,11 @@ static const struct dev_pm_ops rn_acp_pm = {
 static void snd_rn_acp_remove(struct pci_dev *pci)
 {
 	struct acp_dev_data *adata;
-	int ret;
+	int ret, index;
 
 	adata = pci_get_drvdata(pci);
-	platform_device_unregister(adata->pdev);
+	for (index = 0; index < ACP_DEVS; index++)
+		platform_device_unregister(adata->pdev[index]);
 	ret = rn_acp_deinit(adata->acp_base);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
diff --git a/sound/soc/amd/renoir/rn_acp3x.h b/sound/soc/amd/renoir/rn_acp3x.h
index f24a4da8c721..ed1a4d27eea7 100644
--- a/sound/soc/amd/renoir/rn_acp3x.h
+++ b/sound/soc/amd/renoir/rn_acp3x.h
@@ -7,6 +7,7 @@
 
 #include "rn_chip_offset_byte.h"
 
+#define ACP_DEVS		3
 #define ACP_PHY_BASE_ADDRESS 0x1240000
 #define	ACP_REG_START	0x1240000
 #define	ACP_REG_END	0x1250200
-- 
2.25.4

