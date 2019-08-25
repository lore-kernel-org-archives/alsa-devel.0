From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Fix potential concurrent access to
	the deleted pool
Date: Sun, 25 Aug 2019 09:33:25 +0200
Message-ID: <20190825073325.25809-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FBF0F80144
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2019 09:33:27 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1589BAF9F
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2019 07:33:27 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The input pool of a client might be deleted via the resize ioctl, the
the access to it should be covered by the proper locks.  Currently the
only missing place is the call in snd_seq_ioctl_get_client_pool(), and
this patch papers over it.

Reported-by: syzbot+4a75454b9ca2777f35c7@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c |  3 +--
 sound/core/seq/seq_fifo.c      | 17 +++++++++++++++++
 sound/core/seq/seq_fifo.h      |  2 ++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 7737b2670064..6d9592f0ae1d 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1835,8 +1835,7 @@ static int snd_seq_ioctl_get_client_pool(struct snd_seq_client *client,
 	if (cptr->type == USER_CLIENT) {
 		info->input_pool = cptr->data.user.fifo_pool_size;
 		info->input_free = info->input_pool;
-		if (cptr->data.user.fifo)
-			info->input_free = snd_seq_unused_cells(cptr->data.user.fifo->pool);
+		info->input_free = snd_seq_fifo_unused_cells(cptr->data.user.fifo);
 	} else {
 		info->input_pool = 0;
 		info->input_free = 0;
diff --git a/sound/core/seq/seq_fifo.c b/sound/core/seq/seq_fifo.c
index ea69261f269a..eaaa8b5830bb 100644
--- a/sound/core/seq/seq_fifo.c
+++ b/sound/core/seq/seq_fifo.c
@@ -263,3 +263,20 @@ int snd_seq_fifo_resize(struct snd_seq_fifo *f, int poolsize)
 
 	return 0;
 }
+
+/* get the number of unused cells safely */
+int snd_seq_fifo_unused_cells(struct snd_seq_fifo *f)
+{
+	unsigned long flags;
+	int cells;
+
+	if (!f)
+		return 0;
+
+	snd_use_lock_use(&f->use_lock);
+	spin_lock_irqsave(&f->lock, flags);
+	cells = snd_seq_unused_cells(f->pool);
+	spin_unlock_irqrestore(&f->lock, flags);
+	snd_use_lock_free(&f->use_lock);
+	return cells;
+}
diff --git a/sound/core/seq/seq_fifo.h b/sound/core/seq/seq_fifo.h
index edc68743943d..b56a7b897c9c 100644
--- a/sound/core/seq/seq_fifo.h
+++ b/sound/core/seq/seq_fifo.h
@@ -53,5 +53,7 @@ int snd_seq_fifo_poll_wait(struct snd_seq_fifo *f, struct file *file, poll_table
 /* resize pool in fifo */
 int snd_seq_fifo_resize(struct snd_seq_fifo *f, int poolsize);
 
+/* get the number of unused cells safely */
+int snd_seq_fifo_unused_cells(struct snd_seq_fifo *f);
 
 #endif
-- 
2.16.4
