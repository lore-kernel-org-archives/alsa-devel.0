Return-Path: <SRS0=aG7p=AR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECB5C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:14:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE2F2075B
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FBQ5Ukfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE2F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E92AE1674;
	Mon,  6 Jul 2020 12:13:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E92AE1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594030451;
	bh=0ZHV4pvsMvPkVSlGEvzV6oF0tH2NyWaiE+diYMccbYI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FBQ5UkfhbljOApTRnFJ5JZllj04Ct4IrGXlvaKiJTRpVpTSj+93jwLw+sigftS0CR
	 /AtjePB2N+7vBBgTXfDQxaaudk9hOZMn2+LYKRhciTnsMRCmVt67bdOrIeA81vcEUI
	 gYUV9Ijsw+kqpU/B9mAM1CmhIBQRVziK1lJS4sME=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E053F80308;
	Mon,  6 Jul 2020 12:07:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3C4AF802E1; Mon,  6 Jul 2020 12:07:48 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFF45F802A9
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2020 12:07:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFF45F802A9
IronPort-SDR: lRukALzWDlC/MD8oFj3xGJcnQYWouCtcgrxzXs6D4y5nlnWFhIBiDR8fxfVm/f6Cp2A3lWoJpW
 13Z0C6+zrtWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="135637977"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="135637977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 03:07:45 -0700
IronPort-SDR: BCPE4rHmVdiVXg0k5Y925wfbfC8PwxoABI0/AvT3cCYNPjan4U5tfoZEBa+HxLP2toJkSc9j4O
 3YwRabTEW6Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="313913049"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by orsmga008.jf.intel.com with ESMTP; 06 Jul 2020 03:07:44 -0700
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 10/10] topology: Make buffer for saving dynamic size
Date: Mon,  6 Jul 2020 11:06:03 +0200
Message-Id: <1594026363-30276-11-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594026363-30276-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1594026363-30276-1-git-send-email-piotrx.maziarz@linux.intel.com>
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@intel.com
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

Some fields can exceed size limit, e.g. private data has no size
restriction. Therefore it needs to be dynamically increased.

Change-Id: Ie274fd304eba5d600e198f4febbc6216f01b57e1
---
 src/topology/save.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/src/topology/save.c b/src/topology/save.c
index 4ecf86c..9c74735 100644
--- a/src/topology/save.c
+++ b/src/topology/save.c
@@ -19,22 +19,43 @@
 #include "tplg_local.h"
 
 #define SAVE_ALLOC_SHIFT	(13)	/* 8192 bytes */
+#define PRINT_BUF_SIZE		(1024)
+#define PRINT_BUF_SIZE_MAX	(1024 * 1024)
 
 int tplg_save_printf(char **dst, const char *pfx, const char *fmt, ...)
 {
 	va_list va;
-	char buf[1024], *s;
+	char *buf, *s;
 	size_t n, l, t, pl;
+	int ret = 0;
+
+	buf = malloc(PRINT_BUF_SIZE);
+	if (!buf)
+		return -ENOMEM;
 
 	if (pfx == NULL)
 		pfx = "";
 
 	va_start(va, fmt);
-	n = vsnprintf(buf, sizeof(buf), fmt, va);
+	n = vsnprintf(buf, PRINT_BUF_SIZE, fmt, va);
 	va_end(va);
 
-	if (n >= sizeof(buf))
-		return -EOVERFLOW;
+	if (n >= PRINT_BUF_SIZE_MAX) {
+		ret = -EOVERFLOW;
+		goto end;
+	}
+
+	if (n >= PRINT_BUF_SIZE) {
+		char *tmp = realloc(buf, n + 1);
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto end;
+		}
+		buf = tmp;
+		va_start(va, fmt);
+		n = vsnprintf(buf, n + 1, fmt, va);
+		va_end(va);
+	}
 
 	pl = strlen(pfx);
 	l = *dst ? strlen(*dst) : 0;
@@ -47,7 +68,8 @@ int tplg_save_printf(char **dst, const char *pfx, const char *fmt, ...)
 		if (s == NULL) {
 			free(*dst);
 			*dst = NULL;
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto end;
 		}
 	} else {
 		s = *dst;
@@ -57,6 +79,8 @@ int tplg_save_printf(char **dst, const char *pfx, const char *fmt, ...)
 		strcpy(s + l, pfx);
 	strcpy(s + l + pl, buf);
 	*dst = s;
+end:
+	free(buf);
 	return 0;
 }
 
-- 
2.7.4

