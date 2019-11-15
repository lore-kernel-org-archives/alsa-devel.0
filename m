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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48638C432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:55:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E2520730
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R/0cSSOe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etDYjVfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E2520730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5961165E;
	Fri, 15 Nov 2019 17:54:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5961165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573836924;
	bh=kLY6zpEdWqLQX4p9jtgwkbMA4rhs/24YQ5LBgJrlOmk=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R/0cSSOelIU4EHcfmMjL/5s96siGb4BcoDGp/itVOzpVTWN7CufgpgOBpEvgQ6n7o
	 7O99Jm/QdpLN/I0XwVnfJIxhc0MDe67r0iN4yVwzQDOJN/ShaSpHpAL2VLyZlOvTah
	 kOAZTovXAfzsmBBVmz0KA5TKlwdjVfspiihErBsk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 221C2F800FF;
	Fri, 15 Nov 2019 17:51:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE00CF8010D; Fri, 15 Nov 2019 17:50:58 +0100 (CET)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD94BF80103
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 17:50:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD94BF80103
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="etDYjVfv"
Received: by mail-qv1-xf42.google.com with SMTP id g18so4013122qvp.8
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 08:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qucmBK8296Afdjp1xdtDTe1Y7Yf+ZSue6Gan8Ja2z+8=;
 b=etDYjVfvaiTiq8LoZFp+pbpIrY63as90VwFoWaW2w0BLbvRngxjyOjoTDF/J0jNjq0
 bm0occN8G+tEtnaory1GUBqcZ3G+ohdGur+c+Dq7/2bwdATs6V1YaTwAaiRSmvEY5PrQ
 met8QnRff2gjc9OjS8ulAlKWqqb62pgf9tu6VXfALtArEktRGaTSDoIP1xnr8bzPxka/
 CasAvql4//VG1EGtw0PsZoesYX/uZqWrl6lbGW9w56r2qkNkuxJHX8EWqLkGJp+8Re7h
 296UtSjjpDVv6JIQAXtQvcTsnxM07tZOfRYy5DfROzVPFz1se50crmxxJkCoeOMNV+NA
 p7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qucmBK8296Afdjp1xdtDTe1Y7Yf+ZSue6Gan8Ja2z+8=;
 b=WgFSqIclFWmFT/YfGKdAheZLVPOiL+34vMRlCJTUfogWM6PHl2wBV6VyGXN8sDHBnw
 Wp0JccJX1k/id+eTQVkWKVb8Sce6h1EjgO+6EjJTZMlB6+HKmtzpOcAcYyaLUZwHZdQR
 zG1ZcvsjqCl81GudahfIpd7a98xlfF1QrkdB65/Wlyk08BoY8QAM+K/Zs7n2FoLCbD6P
 xuw+/UfZD3t/sCeT939VpoljeQO2OGFSBONnuOnJD55MF5nJEX7wb8CEgv2RGYXyJVPn
 OfJBxtdG31DhEDKp5ClIYfyjVnAOzAoLDTR5tbEqkf5ZMlrxCj9PHnal7koRhouU/xe3
 Y2rA==
X-Gm-Message-State: APjAAAUGGyye/uiDFsElqVDDtbDUubi8l+hZT+Vtjk44zrmMtJJrZmSJ
 mefv000BozM4SLSb2VH0uZWmW1aH
X-Google-Smtp-Source: APXvYqxOmZQ/YLV125C7CUYMTHM4y44e2H+5q5R9/bMsVcMDYkOC/tK9M/rmISJNXBSaliKOavMqKw==
X-Received: by 2002:ad4:458b:: with SMTP id x11mr7447279qvu.7.1573836652072;
 Fri, 15 Nov 2019 08:50:52 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:50:51 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Date: Fri, 15 Nov 2019 11:50:23 -0500
Message-Id: <20191115165038.56646-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: [alsa-devel] [PATCH 05/20] drm/amdgpu: add supports_baco callback
	for VI asics.
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

BACO - Bus Active, Chip Off

Check the BACO capabilities from the powerplay table.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 78e5cdc0c058..871c0b8c6b0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -745,6 +745,27 @@ static int vi_asic_pci_config_reset(struct amdgpu_device *adev)
 	return r;
 }
 
+static bool vi_asic_supports_baco(struct amdgpu_device *adev)
+{
+	bool baco_support;
+
+	switch (adev->asic_type) {
+	case CHIP_FIJI:
+	case CHIP_TONGA:
+	case CHIP_POLARIS10:
+	case CHIP_POLARIS11:
+	case CHIP_POLARIS12:
+	case CHIP_TOPAZ:
+		smu7_asic_get_baco_capability(adev, &baco_support);
+		break;
+	default:
+		baco_support = false;
+		break;
+	}
+
+	return baco_support;
+}
+
 static enum amd_reset_method
 vi_asic_reset_method(struct amdgpu_device *adev)
 {
@@ -1116,6 +1137,7 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
 	.get_pcie_usage = &vi_get_pcie_usage,
 	.need_reset_on_init = &vi_need_reset_on_init,
 	.get_pcie_replay_count = &vi_get_pcie_replay_count,
+	.supports_baco = &vi_asic_supports_baco,
 };
 
 #define CZ_REV_BRISTOL(rev)	 \
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
