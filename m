Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC356C5DF65
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:44:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751D02187F
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uinI/LGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751D02187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80BCE1685;
	Wed,  6 Nov 2019 16:43:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80BCE1685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573055049;
	bh=85W3m92pLPsXLPRIKYpLaxu4xsjoWI/OjtQo8GA2NoY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uinI/LGmnnph+xBaEeP2ak9z9tIQscKoi6Rs8vRtWELM19E4+Mk/si2tVgk08riEZ
	 BliucQC6diJ74X1EwzaDBcYr7FwwVBGNd03SJ5mQsb+PylfWCsbhRmW8qJjrrqthZ6
	 9JdRKqtEk4NYGDhEOrrWidK+T5rsx30fqo4i96rE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A876F80291;
	Wed,  6 Nov 2019 16:43:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4C8FF80321; Wed,  6 Nov 2019 16:43:11 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B64BAF8015B
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 16:43:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B64BAF8015B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6B735B1D2
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 15:42:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Wed,  6 Nov 2019 16:42:57 +0100
Message-Id: <20191106154257.5853-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: timer: Limit max amount of slave
	instances
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The fuzzer tries to open the timer instances as much as possible, and
this may cause a system hiccup easily.  We've already introduced the
cap for the max number of available instances for the h/w timers, and
we should put such a limit also to the slave timers, too.

This patch introduces the limit to the multiple opened slave timers.
The upper limit is hard-coded to 1000 for now, which should suffice
for any practical usages up to now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 5c9fbf3f4340..219249627cc3 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -74,6 +74,9 @@ static LIST_HEAD(snd_timer_slave_list);
 /* lock for slave active lists */
 static DEFINE_SPINLOCK(slave_active_lock);
 
+#define MAX_SLAVE_INSTANCES	1000
+static int num_slaves;
+
 static DEFINE_MUTEX(register_mutex);
 
 static int snd_timer_free(struct snd_timer *timer);
@@ -250,6 +253,10 @@ int snd_timer_open(struct snd_timer_instance **ti,
 			err = -EINVAL;
 			goto unlock;
 		}
+		if (num_slaves >= MAX_SLAVE_INSTANCES) {
+			err = -EBUSY;
+			goto unlock;
+		}
 		timeri = snd_timer_instance_new(owner, NULL);
 		if (!timeri) {
 			err = -ENOMEM;
@@ -259,6 +266,7 @@ int snd_timer_open(struct snd_timer_instance **ti,
 		timeri->slave_id = tid->device;
 		timeri->flags |= SNDRV_TIMER_IFLG_SLAVE;
 		list_add_tail(&timeri->open_list, &snd_timer_slave_list);
+		num_slaves++;
 		err = snd_timer_check_slave(timeri);
 		if (err < 0) {
 			snd_timer_close_locked(timeri);
@@ -350,6 +358,8 @@ static int snd_timer_close_locked(struct snd_timer_instance *timeri)
 	}
 
 	list_del(&timeri->open_list);
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		num_slaves--;
 
 	/* force to stop the timer */
 	snd_timer_stop(timeri);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
