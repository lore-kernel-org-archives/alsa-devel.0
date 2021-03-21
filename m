Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0149BC433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 11:30:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EFE6198E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 11:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EFE6198E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3510E1657;
	Mon, 22 Mar 2021 12:30:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3510E1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616412650;
	bh=7/OWK8jEXsMEiXV55uSvnbFhg7rNYOQIMV0WECcZD4Q=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L8YjEUU+Xlp6erS3qrxb5k2o4PT+k3wTBhq4ETQdwuyyQhHnKwxHb5SWBgqVxMcoY
	 r5zIsAh3gvt1tDqFRBV2nSEPbCtD1k6i29AWPtN0ovr3E69sQDzbNrt8yAC8JiH65+
	 YpIoBZmm7ZMFfuAt1GM4eL+6TOm6Ml/NnytdNCW8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72CF5F801EB;
	Mon, 22 Mar 2021 12:29:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2898F80254; Sun, 21 Mar 2021 10:15:35 +0100 (CET)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1940F80155
 for <alsa-devel@alsa-project.org>; Sun, 21 Mar 2021 10:15:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1940F80155
Received: from DAG2EX05-BASE.srv.huawei-3com.com ([10.8.0.68])
 by h3cspam02-ex.h3c.com with ESMTP id 12L9F2Rs099394;
 Sun, 21 Mar 2021 17:15:02 +0800 (GMT-8)
 (envelope-from xi.fengfei@h3c.com)
Received: from localhost.localdomain (10.99.222.162) by
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 21 Mar 2021 17:15:05 +0800
From: Fengfei Xi <xi.fengfei@h3c.com>
To: <perex@perex.cz>, <tiwai@suse.com>
Subject: [PATCH] sound: remove unnecessary blank
Date: Sun, 21 Mar 2021 16:59:48 +0800
Message-ID: <20210321085948.11491-1-xi.fengfei@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.222.162]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 12L9F2Rs099394
X-Mailman-Approved-At: Mon, 22 Mar 2021 12:28:47 +0100
Cc: Fengfei Xi <xi.fengfei@h3c.com>, alsa-devel@alsa-project.org,
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

Remove unnecessary blank when calling kmalloc_array().

Signed-off-by: Fengfei Xi <xi.fengfei@h3c.com>
---
 sound/oss/dmasound/dmasound_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index 49679aa86..78bb9dfe2 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -421,7 +421,7 @@ static int sq_allocate_buffers(struct sound_queue *sq, int num, int size)
 		return 0;
 	sq->numBufs = num;
 	sq->bufSize = size;
-	sq->buffers = kmalloc_array (num, sizeof(char *), GFP_KERNEL);
+	sq->buffers = kmalloc_array(num, sizeof(char *), GFP_KERNEL);
 	if (!sq->buffers)
 		return -ENOMEM;
 	for (i = 0; i < num; i++) {
-- 
2.17.1

