From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: timer: Fix negative queue usage by racy
	accesses
Date: Mon,  4 Jul 2016 14:06:49 +0200
Message-ID: <20160704120649.14694-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D400F265611
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2016 14:06:50 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4DC1BAAF4
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2016 12:06:50 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The user timer tu->qused counter may go to a negative value when
multiple concurrent reads are performed since both the check and the
decrement of tu->qused are done in two individual locked contexts.
This results in bogus read outs, and the endless loop in the
user-space side.

The fix is to move the decrement of the tu->qused counter into the
same spinlock context as the zero-check of the counter.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index e722022d325d..9a6157ea6881 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1955,6 +1955,7 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 
 		qhead = tu->qhead++;
 		tu->qhead %= tu->queue_size;
+		tu->qused--;
 		spin_unlock_irq(&tu->qlock);
 
 		if (tu->tread) {
@@ -1968,7 +1969,6 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 		}
 
 		spin_lock_irq(&tu->qlock);
-		tu->qused--;
 		if (err < 0)
 			goto _error;
 		result += unit;
-- 
2.9.0
