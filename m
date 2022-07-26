Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFDEC00140
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jul 2022 15:36:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 432A041;
	Tue, 26 Jul 2022 17:35:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 432A041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658849807;
	bh=g0xwvfCQjK6jl5kRUgz2LsSmg86rr3gVF3LjWEqPW8k=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HaGMo43OjgYQ+8lU6q5mJ+yhDTwRwr+H4ZcjUh6lPcfPNhriFQgDaomf6xAz6lyAF
	 V6Tqv9vAp4qmC85kUlEL3M9JihWcYdNbz2nEiuzsRZNaYuBaEE6CA903V89863qKXu
	 lvkVIG2uo8KznGD8LSMCJGnPMYYB18bXTl/UEY5Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80B6BF8055B;
	Tue, 26 Jul 2022 17:34:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECF0AF80543; Tue, 26 Jul 2022 17:34:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4816BF80238
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2022 17:34:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4816BF80238
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="io7hkD/1"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="kw9QmDJh"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 610C73802B;
 Tue, 26 Jul 2022 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658849667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7iuRQ2leetPJMX0VdaUUT5+7Gf6IbWbIxaPQQh9gbC0=;
 b=io7hkD/1YEflhrkg+Pq8yTQ5FT2ae4zfsvwZ10qc6NbnA1fHvku+4sL5bYIObPVrximKGH
 9r/RGbhtVAdjlrLXQHsOhnRH9U0pdXI/YWlGj4cN6f2W8WwvE8WVenHgY1Uj+JjAclA+20
 qzoM00LiNnj/h7rxEM5Zia00QIM4dFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658849667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7iuRQ2leetPJMX0VdaUUT5+7Gf6IbWbIxaPQQh9gbC0=;
 b=kw9QmDJhBDaKNym8s92jj/ughKmS7Bk4JbnZv5zOgzIKMDlJaNCa8EDDSf0KW1NP9NVgg+
 tmeI82yO6I/cctAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 414A913A7C;
 Tue, 26 Jul 2022 15:34:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kMQoD4MJ4GKiWgAAMHmgww
 (envelope-from <tiwai@suse.de>); Tue, 26 Jul 2022 15:34:27 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/4] ALSA: control: Use deferred fasync helper
Date: Tue, 26 Jul 2022 17:34:20 +0200
Message-Id: <20220726153420.3403-5-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220726153420.3403-1-tiwai@suse.de>
References: <20220726153420.3403-1-tiwai@suse.de>
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

For avoiding the potential deadlock via kill_fasync() call, use the
new fasync helpers to defer the invocation from the control API.  Note
that it's merely a workaround.

Another note: although we haven't received reports about the deadlock
with the control API, the deadlock is still potentially possible, and
it's better to align the behavior with other core APIs (PCM and
timer); so let's move altogether.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/control.h | 2 +-
 sound/core/control.c    | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index fcd3cce673ec..eae443ba79ba 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -109,7 +109,7 @@ struct snd_ctl_file {
 	int preferred_subdevice[SND_CTL_SUBDEV_ITEMS];
 	wait_queue_head_t change_sleep;
 	spinlock_t read_lock;
-	struct fasync_struct *fasync;
+	struct snd_fasync *fasync;
 	int subscribed;			/* read interface is activated */
 	struct list_head events;	/* waiting events for read */
 };
diff --git a/sound/core/control.c b/sound/core/control.c
index 4dba3a342458..f3e893715369 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -127,6 +127,7 @@ static int snd_ctl_release(struct inode *inode, struct file *file)
 			if (control->vd[idx].owner == ctl)
 				control->vd[idx].owner = NULL;
 	up_write(&card->controls_rwsem);
+	snd_fasync_free(ctl->fasync);
 	snd_ctl_empty_read_queue(ctl);
 	put_pid(ctl->pid);
 	kfree(ctl);
@@ -181,7 +182,7 @@ void snd_ctl_notify(struct snd_card *card, unsigned int mask,
 	_found:
 		wake_up(&ctl->change_sleep);
 		spin_unlock(&ctl->read_lock);
-		kill_fasync(&ctl->fasync, SIGIO, POLL_IN);
+		snd_kill_fasync(ctl->fasync, SIGIO, POLL_IN);
 	}
 	read_unlock_irqrestore(&card->ctl_files_rwlock, flags);
 }
@@ -2134,7 +2135,7 @@ static int snd_ctl_fasync(int fd, struct file * file, int on)
 	struct snd_ctl_file *ctl;
 
 	ctl = file->private_data;
-	return fasync_helper(fd, file, on, &ctl->fasync);
+	return snd_fasync_helper(fd, file, on, &ctl->fasync);
 }
 
 /* return the preferred subdevice number if already assigned;
@@ -2302,7 +2303,7 @@ static int snd_ctl_dev_disconnect(struct snd_device *device)
 	read_lock_irqsave(&card->ctl_files_rwlock, flags);
 	list_for_each_entry(ctl, &card->ctl_files, list) {
 		wake_up(&ctl->change_sleep);
-		kill_fasync(&ctl->fasync, SIGIO, POLL_ERR);
+		snd_kill_fasync(ctl->fasync, SIGIO, POLL_ERR);
 	}
 	read_unlock_irqrestore(&card->ctl_files_rwlock, flags);
 
-- 
2.35.3

