From: Adam Goode <agoode@google.com>
Subject: [PATCH 1/1] Alsa: seq: correctly detect input buffer
	overflow
Date: Wed,  4 Jun 2014 01:02:51 -0400
Message-ID: <1401858171-4448-1-git-send-email-agoode@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f44.google.com (mail-yh0-f44.google.com
 [209.85.213.44])
 by alsa0.perex.cz (Postfix) with ESMTP id F190E2625DB
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 07:03:02 +0200 (CEST)
Received: by mail-yh0-f44.google.com with SMTP id b6so6002242yha.31
 for <alsa-devel@alsa-project.org>; Tue, 03 Jun 2014 22:03:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adam Goode <agoode@google.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_seq_event_dup returns -ENOMEM in some buffer-full conditions,
but usually returns -EAGAIN. Make -EAGAIN trigger the overflow
condition in snd_seq_fifo_event_in so that the fifo is cleared
and -ENOSPC is returned to userspace as stated in the alsa-lib docs.

Signed-off-by: Adam Goode <agoode@google.com>

diff --git a/sound/core/seq/seq_fifo.c b/sound/core/seq/seq_fifo.c
index 5599899..53a403e 100644
--- a/sound/core/seq/seq_fifo.c
+++ b/sound/core/seq/seq_fifo.c
@@ -124,7 +124,7 @@ int snd_seq_fifo_event_in(struct snd_seq_fifo *f,
 	snd_use_lock_use(&f->use_lock);
 	err = snd_seq_event_dup(f->pool, event, &cell, 1, NULL); /* always non-blocking */
 	if (err < 0) {
-		if (err == -ENOMEM)
+		if ((err == -ENOMEM) || (err == -EAGAIN))
 			atomic_inc(&f->overflow);
 		snd_use_lock_free(&f->use_lock);
 		return err;
-- 
1.9.1.423.g4596e3a
