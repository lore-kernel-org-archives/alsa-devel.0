Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAC7C47094
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 15:22:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22A5613BC
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 15:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22A5613BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6524717BB;
	Thu, 10 Jun 2021 17:21:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6524717BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623338521;
	bh=i7PEeqsJHRAhEX7MXg0a8qhNgu1oYYt4sMwPfdqnZdc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lywt6qsbNk4X5vfGzewEoyby6abfrMxToFagYsvrNPb7dbmRnfQ6BV4JRvEZo1h1B
	 edVdvRY57XjJdson28Z0S8ec0wwhN67XgPuIb8L4pUDteBhhAYR8+w2YjdS8Yv8MQp
	 HrwjlGEY8yErnanfV/uhoVPWqvxDeYAi/8WUasDw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3360F8020D;
	Thu, 10 Jun 2021 17:21:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1927F80218; Thu, 10 Jun 2021 17:21:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 913F1F800FC
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 17:21:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 913F1F800FC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="vW9xHAoc"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="HMSkippm"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4AFE121A6E
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623338461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Pl2iizoSi+LqT+7TUZ65MOE5utzuR43uFPMd+s8oChA=;
 b=vW9xHAocGvdJ82KiUbR2T+mQfeD5kkqL6E198nD05UETzAKXE9Kt+MInNcoaqe0IRcL1Kg
 CLWsySMxBJ10IOKdQ7P9Cmi+AEtRWYU7QJsczk+mjVH8GujoYwY7Z+fpiE1/1p4fSXO1uU
 wYIqNKrPjB1hdk7Dj1EF7l+emMLpD2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623338461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Pl2iizoSi+LqT+7TUZ65MOE5utzuR43uFPMd+s8oChA=;
 b=HMSkippmnFjWvDqH5IUacxWYYzs+SiayFP+c5iz81OvgKOH1f/e7zuNd+UVX6ZZ1jaxh8a
 vfEdc2si5Ljw1GAg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 46B38A3B8C;
 Thu, 10 Jun 2021 15:21:01 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: seq: Fix race of snd_seq_timer_open()
Date: Thu, 10 Jun 2021 17:20:59 +0200
Message-Id: <20210610152059.24633-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The timer instance per queue is exclusive, and snd_seq_timer_open()
should have managed the concurrent accesses.  It looks as if it's
checking the already existing timer instance at the beginning, but
it's not right, because there is no protection, hence any later
concurrent call of snd_seq_timer_open() may override the timer
instance easily.  This may result in UAF, as the leftover timer
instance can keep running while the queue itself gets closed, as
spotted by syzkaller recently.

For avoiding the race, add a proper check at the assignment of
tmr->timeri again, and return -EBUSY if it's been already registered.

Reported-by: syzbot+ddc1260a83ed1cbf6fb5@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/000000000000dce34f05c42f110c@google.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_timer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index 1645e4142e30..9863be6fd43e 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -297,8 +297,16 @@ int snd_seq_timer_open(struct snd_seq_queue *q)
 		return err;
 	}
 	spin_lock_irq(&tmr->lock);
-	tmr->timeri = t;
+	if (tmr->timeri)
+		err = -EBUSY;
+	else
+		tmr->timeri = t;
 	spin_unlock_irq(&tmr->lock);
+	if (err < 0) {
+		snd_timer_close(t);
+		snd_timer_instance_free(t);
+		return err;
+	}
 	return 0;
 }
 
-- 
2.26.2

