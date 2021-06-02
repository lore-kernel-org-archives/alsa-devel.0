Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E660C4708F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 15:19:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C95FC6138C
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 15:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95FC6138C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DD0616F4;
	Wed,  2 Jun 2021 17:19:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DD0616F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622647197;
	bh=mfyJLXOGHy5u9WpAO4Lis4MVQAN1zsrZKp0fMJjxZw4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pd/ohMLIl8aHS2m/Sp99nM1XdVdhrWmyIrTXdudbDf9SC5YMBd+ck5LjkOALMnnBo
	 dIrImLjtiMNkqCSYF8bHH7CoTotSs/jewKDZSQZk6wPJ8g7kY9iPMWj30Et2tISASQ
	 jwDjvZexkMGG6UKlIqW9EVIoFgWKGQu0fBClLDvA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98A39F804BB;
	Wed,  2 Jun 2021 17:18:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C19C0F804BC; Wed,  2 Jun 2021 17:18:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 371EDF80431
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 17:18:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 371EDF80431
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="jk6WgQt5"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="mh5zPdHK"
Received: from relay2.suse.de (unknown [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2A53722BFC
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622647107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yjVYTZzKH7BJUuIkohINcBaczc5rJq1VVShRZ+Aswps=;
 b=jk6WgQt59nlWHukME00aS1pXnZiLyoPDhwbDAQpu05S0OlvSBNUGjnX4DBEmPD968XK1ix
 mCrV4g7cBscjnqDPiNraNA4FiZ5FuyzWsIYSBeTOX4Y+o7535GbAfLaiWYJh6cDZLjeB3G
 IggYwb5gBw1rnCPb3j47ebJIXG8ej2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622647107;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yjVYTZzKH7BJUuIkohINcBaczc5rJq1VVShRZ+Aswps=;
 b=mh5zPdHKg9a4uB8LW6tc5Vxm1v/XT0rluJWLrHf2IJOhHDeL9miq/3zViJW5OpLxWcsfMm
 04fP5drVzTHpWFDQ==
Received: by relay2.suse.de (Postfix, from userid 51)
 id 26606A3BD3; Wed,  2 Jun 2021 16:03:45 +0000 (UTC)
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id A59A2A4D7A;
 Wed,  2 Jun 2021 11:38:24 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: timer: Fix master timer notification
Date: Wed,  2 Jun 2021 13:38:23 +0200
Message-Id: <20210602113823.23777-1-tiwai@suse.de>
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

snd_timer_notify1() calls the notification to each slave for a master
event, but it passes a wrong event number.  It should be +10 offset,
corresponding to SNDRV_TIMER_EVENT_MXXX, but it's incorrectly with
+100 offset.  Casually this was spotted by UBSAN check via syzkaller.

Reported-by: syzbot+d102fa5b35335a7e544e@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/000000000000e5560e05c3bd1d63@google.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 6898b1ac0d7f..92b7008fcdb8 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -520,9 +520,10 @@ static void snd_timer_notify1(struct snd_timer_instance *ti, int event)
 		return;
 	if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
 		return;
+	event += 10; /* convert to SNDRV_TIMER_EVENT_MXXX */
 	list_for_each_entry(ts, &ti->slave_active_head, active_list)
 		if (ts->ccallback)
-			ts->ccallback(ts, event + 100, &tstamp, resolution);
+			ts->ccallback(ts, event, &tstamp, resolution);
 }
 
 /* start/continue a master timer */
-- 
2.26.2

