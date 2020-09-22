Return-Path: <SRS0=PysP=C7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75530C2D0E2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:40:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612982084C
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iY+UexgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612982084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A9A016A4;
	Tue, 22 Sep 2020 10:40:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A9A016A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600764052;
	bh=nuYGqNWBAfs3mDcoIRhiSmBRUGr3YZKcEPG7C6CnVqo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iY+UexgXhJNbj/YzqQCQkA0bFfhulP9K42VQBoynLCH81joe8N9H0H9aq86Rlv0Wg
	 t11SfWlrXeOQTuUBqG4d/dYtJh1+REULsQvP7QGmW0rDAZGz6LLcPQumCqPODFH7Oa
	 CIfp0yjZuccngjgSbCuRRGNefyFg6l9jSE8+hDtI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83159F8023E;
	Tue, 22 Sep 2020 10:39:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B318AF8010A; Tue, 22 Sep 2020 10:39:08 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CBD6F80229
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 10:38:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CBD6F80229
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 71755AFEC;
 Tue, 22 Sep 2020 08:39:34 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: seq: oss: Avoid mutex lock for a long-time ioctl
Date: Tue, 22 Sep 2020 10:38:56 +0200
Message-Id: <20200922083856.28572-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Pavel Machek <pavel@ucw.cz>
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

Recently we applied a fix to cover the whole OSS sequencer ioctls with
the mutex for dealing with the possible races.  This works fine in
general, but in theory, this may lead to unexpectedly long stall if an
ioctl like SNDCTL_SEQ_SYNC is issued and an event with the far future
timestamp was queued.

For fixing such a potential stall, this patch changes the mutex lock
applied conditionally excluding such an ioctl command.  Also, change
the mutex_lock() with the interruptible version for user to allow
escaping from the big-hammer mutex.

Fixes: 80982c7e834e ("ALSA: seq: oss: Serialize ioctls")
Suggested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/oss/seq_oss.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss.c b/sound/core/seq/oss/seq_oss.c
index c8b9c0b315d8..250a92b18726 100644
--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -174,9 +174,12 @@ odev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (snd_BUG_ON(!dp))
 		return -ENXIO;
 
-	mutex_lock(&register_mutex);
+	if (cmd != SNDCTL_SEQ_SYNC &&
+	    mutex_lock_interruptible(&register_mutex))
+		return -ERESTARTSYS;
 	rc = snd_seq_oss_ioctl(dp, cmd, arg);
-	mutex_unlock(&register_mutex);
+	if (cmd != SNDCTL_SEQ_SYNC)
+		mutex_unlock(&register_mutex);
 	return rc;
 }
 
-- 
2.16.4

