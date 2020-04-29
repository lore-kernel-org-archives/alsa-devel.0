Return-Path: <SRS0=Op9s=6N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790A1C83006
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:29:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0918E2087E
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rKzTYzxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0918E2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61800166D;
	Wed, 29 Apr 2020 15:28:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61800166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588166969;
	bh=Bxz/YsRsvqnOpE0kKutBvGUJXMyuj+coBxVRW2xrSv4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rKzTYzxacPmvwyK8Nz1RSG8ml1ZIaZsxy0HCp8so/QD7iFWAglg8vFVjgKkGVx9Kv
	 vjr5dRBt3SJhO3CHTm+0zWSqqeIAZjYNm6Y7EJspvRYDNYSNxp2piuLfwOqyfb63cj
	 d/1Nlv9yAf8fA61LPYf/vkcC7E7YAmg5s4bsaXHg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D15D2F80217;
	Wed, 29 Apr 2020 15:28:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC431F8022B; Wed, 29 Apr 2020 15:28:30 +0200 (CEST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72623F800B6
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2020 15:28:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72623F800B6
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 2DFC29AB7CC4F543F003;
 Wed, 29 Apr 2020 21:28:18 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Apr 2020
 21:28:10 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <tglx@linutronix.de>
Subject: [PATCH -next] ALSA: seq: oss: remove unused inline function
 snd_seq_oss_timer_is_realtime
Date: Wed, 29 Apr 2020 21:28:05 +0800
Message-ID: <20200429132805.18712-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>,
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

There's no callers in-tree.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/core/seq/oss/seq_oss_timer.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_timer.h b/sound/core/seq/oss/seq_oss_timer.h
index 2d86125b5d0f..dee190b4ec6b 100644
--- a/sound/core/seq/oss/seq_oss_timer.h
+++ b/sound/core/seq/oss/seq_oss_timer.h
@@ -44,14 +44,4 @@ snd_seq_oss_timer_cur_tick(struct seq_oss_timer *timer)
 	return timer->cur_tick;
 }
 
-
-/*
- * is realtime event?
- */
-static inline int
-snd_seq_oss_timer_is_realtime(struct seq_oss_timer *timer)
-{
-	return timer->realtime;
-}
-
 #endif
-- 
2.17.1


