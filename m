Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6289DCA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 21:47:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D761D21479
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 21:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B2lVawWu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqSRfikc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D761D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2977C210E;
	Mon, 28 Oct 2019 22:46:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2977C210E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572299225;
	bh=Z8XnqJrNVJv56cbiDpjidXyypBfAv0b62NKRe2jX3es=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B2lVawWuUd973ZjL3KtZrda7Hn5cY2MeZd34zBk1k57qUasNY/bxVc8aQHa+OQ0z1
	 Akxi3cve4AyKnRmpwFZk5F/bh1j8WKy/u58+GAwBOs03Bx8IJHFLuLv6GVX/3UfD9y
	 7dqeKV9HCZyEvgtaiyZ/qIuoiNojHcWHTXoXsqac=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0C88F80638;
	Mon, 28 Oct 2019 22:43:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E41C2F80635; Mon, 28 Oct 2019 22:43:08 +0100 (CET)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49E16F80635
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 22:43:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49E16F80635
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="GqSRfikc"
Received: by mail-yb1-xb44.google.com with SMTP id m1so4644274ybm.1
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oO2VfC8qhxADPkDyDVx31uSOTMR49nkzK5iaws33oXY=;
 b=GqSRfikcwsoUbWIBFY3nlHQgUas/rRXXLqxAQjmJNt4f0CVRfoYx/N2gnibVSO4NUw
 D4nktghmwXxEKi3U7oTJmBfqCpNpQjMK4OvtumWqc8praPWwMbZMk/aTbDBNOlfE9W7G
 NVbp9KvO8aqRK5OpBOtDRAtUlcOeVXs/jMQUwBmcPqo4YCApGahENbHn6YC9h173sxzr
 G2wdB++CJ8ycStxZNsy8EnOnSVUB4NMtHuo873w27RBjPNpAA0v47kIk22fJNNF7uF82
 uCtn+Bm+1bWYhPgbef1QbPlclbzBBnQT97UBfH0R+Hlacc8caz8riSxIXcad/Rg6PMEK
 9TvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oO2VfC8qhxADPkDyDVx31uSOTMR49nkzK5iaws33oXY=;
 b=s/T/MTJPVlcRcC96clH+yCRLrf4u9lG7dRVV8zrj5RVMk8kz/TJ3TbK0dwHaKwUCU0
 2527xzCw7l44c74WX6dBH/nFda71Q1jSz2REsh7CXHGTkhc2SqiP0AVDYdvfxoQ6jVWU
 VDW82amsrm9iOhCOU1nmINoKB1rW0lFgPMdNggGmONP+3+vFISzXTT3glz6edFK/DEYw
 QwSaRbIgnmqzguDvS8u7iNW76DN94NdwxfULInZGhR6wvxYWsYvcAkIPzduDTs9MkZ6e
 voUu1SDQjjdxOwaPp9VOoa6bfrW/WftrqG9GntWwdlK9cpcEjTUMVS6J/H5hsg3IWi6c
 OEBA==
X-Gm-Message-State: APjAAAWoCOgNC82GlNXXHTGR63xVhhttg4wKkV62WYd1NL9coI3IbU11
 KFIT6C7OiWx8csbZcBcdRY0=
X-Google-Smtp-Source: APXvYqxuZYB6YLp24fLhrslA2nUyFzZaJ9f+WGfEm3FNdTDcnG15ALi6t9c/r09asY7Bh53BWI0Ixg==
X-Received: by 2002:a25:bc04:: with SMTP id i4mr15313193ybh.427.1572298985060; 
 Mon, 28 Oct 2019 14:43:05 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Date: Mon, 28 Oct 2019 17:41:59 -0400
Message-Id: <20191028214216.1508370-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: [alsa-devel] [PATCH 04/21] drm/amdgpu: add supports_baco callback
	for SI asics.
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

Not supported.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 29024e64c886..cb682d44737a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1197,6 +1197,11 @@ static int si_asic_reset(struct amdgpu_device *adev)
 	return 0;
 }
 
+static bool si_asic_supports_baco(struct amdgpu_device *adev)
+{
+	return false;
+}
+
 static enum amd_reset_method
 si_asic_reset_method(struct amdgpu_device *adev)
 {
@@ -1425,6 +1430,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
 	.get_pcie_usage = &si_get_pcie_usage,
 	.need_reset_on_init = &si_need_reset_on_init,
 	.get_pcie_replay_count = &si_get_pcie_replay_count,
+	.supports_baco = &si_asic_supports_baco,
 };
 
 static uint32_t si_get_rev_id(struct amdgpu_device *adev)
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
