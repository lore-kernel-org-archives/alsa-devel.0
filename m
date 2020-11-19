Return-Path: <SRS0=WcGQ=EZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5EDC388F9
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 12:15:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C985246E8
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 12:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tnmcFhpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C985246E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 993BF16FF;
	Thu, 19 Nov 2020 13:14:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 993BF16FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605788146;
	bh=i8SgCfucK9ee0UObGZ7+gt2gyI5+kc5LwxBp8dtjojM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tnmcFhprY7F29JsPQGb6pEaxdTJ1l+cYt53WMDMCev6GTk/3CfsA5ZooxS2wLEfNa
	 +0l6ElVSVOnh6w6iQ7VLrCho7jf6CvggEWmg03/mtfgq+G7IL80djm7cqyNpUcwwBZ
	 vMTOEyXXAg+IZq3NsaUTUjrzcCZA2w3/peyvrN4w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5139F80169;
	Thu, 19 Nov 2020 13:14:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73872F801ED; Thu, 19 Nov 2020 13:14:50 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B8D7F8015A
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2020 13:14:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B8D7F8015A
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 91DA7AFEA;
 Thu, 19 Nov 2020 12:14:41 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: mixart: Fix mutex deadlock
Date: Thu, 19 Nov 2020 13:14:40 +0100
Message-Id: <20201119121440.18945-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Dan Carpenter <dan.carpenter@oracle.com>
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

The code change for switching to non-atomic mode brought the
unexpected mutex deadlock in get_msg().  It converted the spinlock
with the existing mutex, but there were calls with the already holding
the mutex.  Since the only place that needs the extra lock is the code
path from snd_mixart_send_msg(), remove the mutex lock in get_msg()
and apply in the caller side for fixing the mutex deadlock.

Fixes: 8d3a8b5cb57d ("ALSA: mixart: Use nonatomic PCM ops")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/mixart/mixart_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/mixart/mixart_core.c b/sound/pci/mixart/mixart_core.c
index 0bdd33b0af65..fb8895af0363 100644
--- a/sound/pci/mixart/mixart_core.c
+++ b/sound/pci/mixart/mixart_core.c
@@ -70,7 +70,6 @@ static int get_msg(struct mixart_mgr *mgr, struct mixart_msg *resp,
 	unsigned int i;
 #endif
 
-	mutex_lock(&mgr->msg_lock);
 	err = 0;
 
 	/* copy message descriptor from miXart to driver */
@@ -119,8 +118,6 @@ static int get_msg(struct mixart_mgr *mgr, struct mixart_msg *resp,
 	writel_be(headptr, MIXART_MEM(mgr, MSG_OUTBOUND_FREE_HEAD));
 
  _clean_exit:
-	mutex_unlock(&mgr->msg_lock);
-
 	return err;
 }
 
@@ -258,7 +255,9 @@ int snd_mixart_send_msg(struct mixart_mgr *mgr, struct mixart_msg *request, int
 	resp.data = resp_data;
 	resp.size = max_resp_size;
 
+	mutex_lock(&mgr->msg_lock);
 	err = get_msg(mgr, &resp, msg_frame);
+	mutex_unlock(&mgr->msg_lock);
 
 	if( request->message_id != resp.message_id )
 		dev_err(&mgr->pci->dev, "RESPONSE ERROR!\n");
-- 
2.16.4

