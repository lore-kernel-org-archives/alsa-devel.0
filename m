From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Make ioctls race-free
Date: Thu, 11 Jan 2018 14:38:57 +0100
Message-ID: <20180111133857.32311-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 800D4266E3A
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 14:39:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luo Quan <a4651386@163.com>, Kees Cook <keescook@chromium.org>
List-Id: alsa-devel@alsa-project.org

The ALSA sequencer ioctls have no protection against racy calls while
the concurrent operations may lead to interfere with each other.  As
reported recently, for example, the concurrent calls of setting client
pool with a combination of write calls may lead to either the
unkillable dead-lock or UAF.

As a slightly big hammer solution, this patch introduces the mutex to
make each ioctl exclusive.  Although this may reduce performance via
parallel ioctl calls, usually it's not demanded for sequencer usages,
hence it should be negligible.

Reported-by: Luo Quan <a4651386@163.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 3 +++
 sound/core/seq/seq_clientmgr.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 6e22eea72654..d01913404581 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -221,6 +221,7 @@ static struct snd_seq_client *seq_create_client1(int client_index, int poolsize)
 	rwlock_init(&client->ports_lock);
 	mutex_init(&client->ports_mutex);
 	INIT_LIST_HEAD(&client->ports_list_head);
+	mutex_init(&client->ioctl_mutex);
 
 	/* find free slot in the client table */
 	spin_lock_irqsave(&clients_lock, flags);
@@ -2130,7 +2131,9 @@ static long snd_seq_ioctl(struct file *file, unsigned int cmd,
 			return -EFAULT;
 	}
 
+	mutex_lock(&client->ioctl_mutex);
 	err = handler->func(client, &buf);
+	mutex_unlock(&client->ioctl_mutex);
 	if (err >= 0) {
 		/* Some commands includes a bug in 'dir' field. */
 		if (handler->cmd == SNDRV_SEQ_IOCTL_SET_QUEUE_CLIENT ||
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index c6614254ef8a..0611e1e0ed5b 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -61,6 +61,7 @@ struct snd_seq_client {
 	struct list_head ports_list_head;
 	rwlock_t ports_lock;
 	struct mutex ports_mutex;
+	struct mutex ioctl_mutex;
 	int convert32;		/* convert 32->64bit */
 
 	/* output pool */
-- 
2.15.1
