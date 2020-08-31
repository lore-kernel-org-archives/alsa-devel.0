Return-Path: <SRS0=wuVw=CJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E39C433E2
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:13:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101672100A
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oc5FHu3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101672100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 595101861;
	Mon, 31 Aug 2020 11:12:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 595101861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598865200;
	bh=D3PlPG7gV6yHwlS8euLBulPj9X3Rb09FdnJHmaMU3dI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oc5FHu3uI5djBnpjekWcgKl7CM/lDz8ada7EbeyecphblYiXGu9Yj0duNPd+fXHU8
	 pWh2psUpo+XniFNEHdkSjv7KIw9YcsXH2yQ7brO0UHva5I7o9l/5YNatHxr0v7MvBv
	 kaQeGmI2vtkOoFozFsIgT61gb+Akav7ct9hoynBU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D479BF802FB;
	Mon, 31 Aug 2020 11:08:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71207F802EA; Mon, 31 Aug 2020 11:08:30 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 611B5F8026F
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 11:08:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 611B5F8026F
IronPort-SDR: V8lsuoFyIvPLXkatYjrXQ0bccFPtnQbE91rcJ+1yEl06asNwHXf577Ar1oPXMQJ/+CJuLjjcPJ
 WEGfwmk0mjcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="136466783"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; d="scan'208";a="136466783"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 02:08:19 -0700
IronPort-SDR: gozAWbBfCOt95Er7Bfi2b3CKNdSZJMQxSxaRiwUCRS7HJWI5z3Lgd1ckeehtJ3yfxlkFvg0XdJ
 jozznpWlYVcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; d="scan'208";a="314286961"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by orsmga002.jf.intel.com with ESMTP; 31 Aug 2020 02:08:18 -0700
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v4 10/10] topology: Make buffer for saving dynamic size
Date: Mon, 31 Aug 2020 11:09:03 +0200
Message-Id: <1598864943-22883-11-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598864943-22883-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1598864943-22883-1-git-send-email-piotrx.maziarz@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
 amadeuszx.slawinski@linux.intel.com, tiwai@suse.com
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

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

