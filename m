Return-Path: <SRS0=Pn0z=6U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6F5C28CBC
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2020 20:44:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B65D20735
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2020 20:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MeM1WnAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B65D20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D29CD17B1;
	Wed,  6 May 2020 22:43:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D29CD17B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588797840;
	bh=CibV1wNGlhRQu4E9ZUPA7682vc9utcdRjckI1NQcqx4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MeM1WnAvmw4DVRKItmn8V+imKD8UDy6/BOTkQBQ35QDcxK3e2nb+8LhrFYSnidLzz
	 4v1y0pwFvxEAEhcFBTEO82rojevUirfPoRWezFkN51AlOdhXcyBvy86OY7vZu551y+
	 3BCm0nbnpFztHSZDf3Smo2QxlZdRnfcRN0FrBpZ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AA21F800DF;
	Wed,  6 May 2020 22:43:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5EA28F80249; Wed,  6 May 2020 22:42:42 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2F61F800AD
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2020 22:42:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2F61F800AD
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9481AAC68
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2020 20:42:32 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib] header: Fix build error with old kernel headers
Date: Wed,  6 May 2020 22:42:29 +0200
Message-Id: <20200506204229.27311-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

Old development environment doesn't necessarily contain the headers
defining __kernel_long_t that is recently used for y2038 timespec
conditional.  Define it explicitly in such a case.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/asound.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 3be4d850a073..89dd7d2f61b8 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -1 +1,11 @@
+/* workaround for building with old glibc / kernel headers */
+#ifdef __linux__
+#include <linux/types.h>
+#else
+#include <sys/types.h>
+#endif
+#ifndef __kernel_long_t
+#define __kernel_long_t long
+#endif
+
 #include <alsa/sound/uapi/asound.h>
-- 
2.16.4

