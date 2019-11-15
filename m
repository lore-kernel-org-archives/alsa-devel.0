Return-Path: <SRS0=30sX=ZH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4C2C432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:01:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3675206D9
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eTIfhfP/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHWeWXEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3675206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35FF9166C;
	Fri, 15 Nov 2019 18:00:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35FF9166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573837292;
	bh=Yn7mE+ZHc9S56WFpZler7KrbEvg1Dg95U/RLtBygQ9Y=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eTIfhfP/p798eVmUgtP4SLgWx/px/vUpzbNeDjkMFbydJbnrSGWCiZqAPgLWr3D3n
	 8LgzSF2nlMqZ4phWmEL69gTgoy0FJ9Vn5y64GgpsHtAMEyiKpdZFs/Iez0A158eCk8
	 laM0aZBYBf3KNAPpyTrrksYjbecLmoYzMLS3BZ9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66540F8022D;
	Fri, 15 Nov 2019 17:51:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD9F1F8013D; Fri, 15 Nov 2019 17:51:16 +0100 (CET)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FD98F80117
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 17:51:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FD98F80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kHWeWXEf"
Received: by mail-qk1-x743.google.com with SMTP id m4so8596414qke.9
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 08:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8hE3r61GdZq3+ScqgSjzwEaLKbwG45nDSlGOvpz7c5c=;
 b=kHWeWXEftvvvKPKMITMAQDq8ikJFKQpxZMUs2RfkoaNgNxrBxh9rCWSoHHOUxuyAIK
 qvMRNrR1NZ/+9Lb5UBVxBUMOD9hHrH49nKfapc7ZtyI83i+hh7loyOpoE1Z9hC6a6Tmg
 6n3vJLbsGfGudyo3BXZk/iULSPfyrvLl2jaLTzDpEyPFOILELeofRTfuCRjcmhdXF+DX
 5fInCbw4qgblgHd91AbtXSn/EZJ/ZNWvHYBW7e4uv/G4fWF6sqemZTnUDZthtiUL7sr+
 Ohh4Jl0MCPGC+a8KC24uj0Z21ncq2pAdWsouannMrQwk3+lVhrdmMppQ3bVahRL+Zc5s
 G0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8hE3r61GdZq3+ScqgSjzwEaLKbwG45nDSlGOvpz7c5c=;
 b=E0QKDIOhuVGwzxnUb4tV2tCCPuYQOGJHTSWMW4R/TPZmj+N441T0bGdv9/N/Bqm+Ad
 Usfq/uH/yj+BF087LrqirJ0kXoSzCcyKFSjM4k/m17g9LoJh8p0Hc8j8uCnDznjnvwR3
 dA4/YKeVhnNfcFLLhrPit2uYYmKpGzQDUrQO2JAeZaFDTsgPr9E6akCZwQve1HApov4+
 FE1QGbegpmZkDW1so5yqKaLFAvbie0xHHWl/6JhHNdLjP1l/rVcTOMKf01mD0Hoy+iQr
 eBvl/MYpIqQoLqDijRHx0a7fi/bEkx6TGsO2t5fuGKId0+ajchyQEncLH7zj+8H/ob2m
 OFDA==
X-Gm-Message-State: APjAAAWjUSExb55WPyuVc1jrbQRayyGBed9IRHIYTW+W1aawejxi9/Bc
 nWjNAuCsSH4qK/p3DNBqxL8=
X-Google-Smtp-Source: APXvYqySYcyyaQUZJxJXvrZrF21Ko2VRWHCr/XnaxaNL9ofCEirZGmWhGzTLX+Ox9PgH1kXrZW/BMw==
X-Received: by 2002:a05:620a:113a:: with SMTP id
 p26mr13471732qkk.479.1573836660812; 
 Fri, 15 Nov 2019 08:51:00 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:51:00 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Date: Fri, 15 Nov 2019 11:50:32 -0500
Message-Id: <20191115165038.56646-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: [alsa-devel] [PATCH 14/20] drm/amdgpu: disentangle runtime pm and
	vga_switcheroo
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Originally we only supported runtime pm on PX/HG laptops
so vga_switcheroo and runtime pm are sort of entangled.

Attempt to logically separate them.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7195ef83ddba..f48c4898e31a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2744,7 +2744,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		       uint32_t flags)
 {
 	int r, i;
-	bool runtime = false;
+	bool boco = false;
 	u32 max_MBps;
 
 	adev->shutdown = false;
@@ -2915,11 +2915,14 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	vga_client_register(adev->pdev, adev, NULL, amdgpu_device_vga_set_decode);
 
 	if (amdgpu_device_supports_boco(ddev))
-		runtime = true;
-	if (!pci_is_thunderbolt_attached(adev->pdev))
+		boco = true;
+	if (amdgpu_has_atpx() &&
+	    (amdgpu_is_atpx_hybrid() ||
+	     amdgpu_has_atpx_dgpu_power_cntl()) &&
+	    !pci_is_thunderbolt_attached(adev->pdev))
 		vga_switcheroo_register_client(adev->pdev,
-					       &amdgpu_switcheroo_ops, runtime);
-	if (runtime)
+					       &amdgpu_switcheroo_ops, boco);
+	if (boco)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
 
 	if (amdgpu_emu_mode == 1) {
@@ -3103,7 +3106,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 failed:
 	amdgpu_vf_error_trans_all(adev);
-	if (runtime)
+	if (boco)
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
 
 	return r;
@@ -3153,9 +3156,12 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 
 	kfree(adev->bios);
 	adev->bios = NULL;
-	if (!pci_is_thunderbolt_attached(adev->pdev))
+	if (amdgpu_has_atpx() &&
+	    (amdgpu_is_atpx_hybrid() ||
+	     amdgpu_has_atpx_dgpu_power_cntl()) &&
+	    !pci_is_thunderbolt_attached(adev->pdev))
 		vga_switcheroo_unregister_client(adev->pdev);
-	if (adev->flags & AMD_IS_PX)
+	if (amdgpu_device_supports_boco(adev->ddev))
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
 	vga_client_register(adev->pdev, NULL, NULL, NULL);
 	if (adev->rio_mem)
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
