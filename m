Return-Path: <SRS0=FWLr=6Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74DBC47255
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 21:24:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAFC2070B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 21:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GZL1MgOA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxxJwWrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAFC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EA76166F;
	Mon, 11 May 2020 23:23:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EA76166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589232254;
	bh=GehTKoDDGFOTxJpk3GJGGmuPrSH68LMnxi+dt60olJ0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GZL1MgOADWCrJoomUG4oLBUAq+6tEuipxBKldoBb7LZOpnIsnK9vcdsDOS9Z9xEYq
	 5jBfeBHDDkNboAWm49TfryuCoN0yQqmdbW478d17oF7MTRnYumqpWqnXYybWde3GnB
	 N8ThjmJvJSCvFNzqIBblM0LwPy8Vh2pSJ0uzP+kI=
Received: from vmi242170.contaboserver.net (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDB54F802C2;
	Mon, 11 May 2020 23:21:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC19BF802A1; Mon, 11 May 2020 23:20:44 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 363F9F800E3
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 23:20:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 363F9F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="HxxJwWrV"
Received: by mail-qk1-x742.google.com with SMTP id g185so11452954qke.7
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5+MB9Obz4at+9oPU0NMsZMtZIVrFCbQuZxYW6pdZDOE=;
 b=HxxJwWrVKsuYjGTj9bk3DDz5V8NqILNUw3f+aGuXikrfxBJIr+yP/WNeJyX6b4Q7FU
 U4LE9AlaNGkD3/XvZNudae+7xIzreiMwPYHLyrkya1TPW+9QX3Nnz/6802uEJrgJbfc/
 39ANzbCfGhnB3w/sNnnJ29Ui7Qpw54Ep/0MFYke9dNP6KIFYx2d0VaZLQaX6OF4H17jX
 i2w/QUnNhMmx1O/lY8oxgsTHuoldxLjei41peqoHYv5Goi3CJrWxWBUblegWbgEeE34q
 +nDX5K/906k2L09R0S4Stn/dg5del3espAu0WeL1ydk8bhqOxtkgBOCjbQpcW7Ucd3gB
 Zw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5+MB9Obz4at+9oPU0NMsZMtZIVrFCbQuZxYW6pdZDOE=;
 b=AZ5+OQOCv/NCtEyXJULK8O4/4eqQ9E7DmqbckeHVDxFL/Ry04wTzjz3b/FC078mZhO
 WPdj8ObNjoSTsqIkH4OBORoGdJo2Sfok/JIcGBX+1EOw1BZKamZ984AFd9ZWd97ICFQr
 SBR09hyYB/8gGe2DQc8Ff4lZIYOEhAQoN+5ufgaHwz8By5z4rgxQF4bgSWtB1bGI40dr
 xejMz+c+g7yzB9ixDZHG9uEKkbp6lzPq4TYI1vFzCGqw+PkxMWggs5nj0Ui5Ss3asc3N
 MdrdunPTV266P23Ic86AW21x5WHpzsZUdy9m8Fh6t9x6dmT1mOJ1qhp5LvYWOJTM+hoL
 kygA==
X-Gm-Message-State: AGi0PubIfZMRUT7K5hsTGzKWZ7qq7+7FDCiDqI87XVaZdYXD6jK5SZsy
 w91OPW/yhntQWIOlcykOkUilkj00
X-Google-Smtp-Source: APiQypJuSjSQ2QF1McBlNXCKs6SieMhjJ9C3R8sS1cCTeknWsz4EwsyVQpmygtnl8zcte6CdzF9Kkw==
X-Received: by 2002:ae9:ebc3:: with SMTP id b186mr18951015qkg.85.1589232034311; 
 Mon, 11 May 2020 14:20:34 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c26sm9148691qkm.98.2020.05.11.14.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 14:20:33 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: alsa-devel@alsa-project.org, broonie@kernel.org, vijendar.mukunda@amd.com,
 tiwai@suse.de
Subject: [PATCH v2 09/14] ASoC: amd: add Renoir ACP PCI driver PM ops
Date: Mon, 11 May 2020 17:20:09 -0400
Message-Id: <20200511212014.2359225-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200511212014.2359225-1-alexander.deucher@amd.com>
References: <20200511212014.2359225-1-alexander.deucher@amd.com>
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

Add Renoir ACP Pci driver pm ops.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

v2:
- Changed PCI driver pm runtime sequence

 sound/soc/amd/renoir/rn-pci-acp3x.c | 48 +++++++++++++++++++++++++++++
 sound/soc/amd/renoir/rn_acp3x.h     |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index 362409ef0d85..14651df9b5c8 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
 
 #include "rn_acp3x.h"
 
@@ -233,6 +234,11 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 		ret = PTR_ERR(adata->pdev);
 		goto unregister_devs;
 	}
+	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&pci->dev);
+	pm_runtime_allow(&pci->dev);
+	pm_runtime_mark_last_busy(&pci->dev);
+	pm_runtime_put_autosuspend(&pci->dev);
 	return 0;
 
 unregister_devs:
@@ -250,6 +256,42 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 	return ret;
 }
 
+static int snd_rn_acp_suspend(struct device *dev)
+{
+	int ret;
+	struct acp_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	ret = rn_acp_deinit(adata->acp_base);
+	if (ret)
+		dev_err(dev, "ACP de-init failed\n");
+	else
+		dev_dbg(dev, "ACP de-initialized\n");
+
+	return 0;
+}
+
+static int snd_rn_acp_resume(struct device *dev)
+{
+	int ret;
+	struct acp_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	ret = rn_acp_init(adata->acp_base);
+	if (ret) {
+		dev_err(dev, "ACP init failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+static const struct dev_pm_ops rn_acp_pm = {
+	.runtime_suspend = snd_rn_acp_suspend,
+	.runtime_resume =  snd_rn_acp_resume,
+	.suspend = snd_rn_acp_suspend,
+	.resume =	snd_rn_acp_resume,
+};
+
 static void snd_rn_acp_remove(struct pci_dev *pci)
 {
 	struct acp_dev_data *adata;
@@ -260,6 +302,9 @@ static void snd_rn_acp_remove(struct pci_dev *pci)
 	ret = rn_acp_deinit(adata->acp_base);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
+	pm_runtime_put_noidle(&pci->dev);
+	pm_runtime_get_sync(&pci->dev);
+	pm_runtime_forbid(&pci->dev);
 	pci_disable_msi(pci);
 	pci_release_regions(pci);
 	pci_disable_device(pci);
@@ -278,6 +323,9 @@ static struct pci_driver rn_acp_driver  = {
 	.id_table = snd_rn_acp_ids,
 	.probe = snd_rn_acp_probe,
 	.remove = snd_rn_acp_remove,
+	.driver = {
+		.pm = &rn_acp_pm,
+	}
 };
 
 module_pci_driver(rn_acp_driver);
diff --git a/sound/soc/amd/renoir/rn_acp3x.h b/sound/soc/amd/renoir/rn_acp3x.h
index a4f654cf2df0..6e1888167fb3 100644
--- a/sound/soc/amd/renoir/rn_acp3x.h
+++ b/sound/soc/amd/renoir/rn_acp3x.h
@@ -40,6 +40,8 @@
 #define TWO_CH 0x02
 #define DELAY_US 5
 #define ACP_COUNTER 20000
+/* time in ms for runtime suspend delay */
+#define ACP_SUSPEND_DELAY_MS	2000
 
 #define ACP_SRAM_PTE_OFFSET	0x02050000
 #define PAGE_SIZE_4K_ENABLE     0x2
-- 
2.25.4

