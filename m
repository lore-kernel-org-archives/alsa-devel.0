Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_DOTEDU_SUSP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177BEC2D0A3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 22:34:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C7D22456
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 22:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="otGMRyNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C7D22456
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B2C71696;
	Tue,  3 Nov 2020 23:33:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B2C71696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604442879;
	bh=DlUvCCn63GVCDgHqHBEFxIPJfNn/K71qmi82mPPzo0M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=otGMRyNyXEmizvjizUtjfOAODIRzmbG7U81x265hAE+5mzhy+sPg9Axx2lFKelAoz
	 YpQcmnjMOQF2lgWPLqJuAPo9cGuWh3NqVzqgiHOqUw43nxxxaTsVVOJ8pTsOJ50ByB
	 nWCeH2QOUrBoYkqMWLBdgmLOqoTeDn0+O8Qg2W10=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FC6CF80162;
	Tue,  3 Nov 2020 23:33:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF8F3F80171; Tue,  3 Nov 2020 23:33:46 +0100 (CET)
Received: from zerg.cs.ucr.edu (zerg.cs.ucr.edu [169.235.26.103])
 by alsa1.perex.cz (Postfix) with ESMTP id 42589F80108
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 23:33:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42589F80108
Received: by zerg.cs.ucr.edu (Postfix, from userid 69049)
 id A8C121C20852; Tue,  3 Nov 2020 14:33:37 -0800 (PST)
From: Yu Hao <yuhaobehappy@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org
Subject: [PATCH] sound/core/seq: remove useless function
Date: Tue,  3 Nov 2020 14:33:35 -0800
Message-Id: <20201103223335.21831-1-yuhaobehappy@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: yuhaobehappy@gmail.com, linux-kernel@vger.kernel.org
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

The function snd_seq_queue_client_termination() is only called from
the function seq_free_client1(). The function seq_free_client1() calls
the function snd_seq_queue_client_leave() and the function
snd_seq_queue_client_termination() together. Because the function
snd_seq_queue_client_leave() does all things, so the function
snd_seq_queue_client_termination() is a useless function.

Signed-off-by: Yu Hao <yuhaobehappy@gmail.com>
---
 sound/core/seq/seq_clientmgr.c |  1 -
 sound/core/seq/seq_queue.c     | 27 ---------------------------
 sound/core/seq/seq_queue.h     |  3 ---
 3 files changed, 31 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index cc93157fa950..f9f2fea58b32 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -279,7 +279,6 @@ static int seq_free_client1(struct snd_seq_client *client)
 	snd_seq_delete_all_ports(client);
 	snd_seq_queue_client_leave(client->number);
 	snd_use_lock_sync(&client->use_lock);
-	snd_seq_queue_client_termination(client->number);
 	if (client->pool)
 		snd_seq_pool_delete(&client->pool);
 	spin_lock_irq(&clients_lock);
diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
index 71a6ea62c3be..13cfc2d47fa7 100644
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -537,33 +537,6 @@ int snd_seq_queue_is_used(int queueid, int client)
 
 /*----------------------------------------------------------------*/
 
-/* notification that client has left the system -
- * stop the timer on all queues owned by this client
- */
-void snd_seq_queue_client_termination(int client)
-{
-	unsigned long flags;
-	int i;
-	struct snd_seq_queue *q;
-	bool matched;
-
-	for (i = 0; i < SNDRV_SEQ_MAX_QUEUES; i++) {
-		if ((q = queueptr(i)) == NULL)
-			continue;
-		spin_lock_irqsave(&q->owner_lock, flags);
-		matched = (q->owner == client);
-		if (matched)
-			q->klocked = 1;
-		spin_unlock_irqrestore(&q->owner_lock, flags);
-		if (matched) {
-			if (q->timer->running)
-				snd_seq_timer_stop(q->timer);
-			snd_seq_timer_reset(q->timer);
-		}
-		queuefree(q);
-	}
-}
-
 /* final stage notification -
  * remove cells for no longer exist client (for non-owned queue)
  * or delete this queue (for owned queue)
diff --git a/sound/core/seq/seq_queue.h b/sound/core/seq/seq_queue.h
index 9254c8dbe5e3..1c3a8d3254d9 100644
--- a/sound/core/seq/seq_queue.h
+++ b/sound/core/seq/seq_queue.h
@@ -59,9 +59,6 @@ struct snd_seq_queue *snd_seq_queue_alloc(int client, int locked, unsigned int f
 /* delete queue (destructor) */
 int snd_seq_queue_delete(int client, int queueid);
 
-/* notification that client has left the system */
-void snd_seq_queue_client_termination(int client);
-
 /* final stage */
 void snd_seq_queue_client_leave(int client);
 
-- 
2.17.1

