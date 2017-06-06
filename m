From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: timer: Fix missing queue indices
	reset at SNDRV_TIMER_IOCTL_SELECT
Date: Tue,  6 Jun 2017 17:00:41 +0200
Message-ID: <20170606150043.10525-3-tiwai@suse.de>
References: <20170606150043.10525-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 04E71266EB0
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 17:00:50 +0200 (CEST)
In-Reply-To: <20170606150043.10525-1-tiwai@suse.de>
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
Cc: Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Dmitriy Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@google.com>
List-Id: alsa-devel@alsa-project.org

snd_timer_user_tselect() reallocates the queue buffer dynamically, but
it forgot to reset its indices.  Since the read may happen
concurrently with ioctl and snd_timer_user_tselect() allocates the
buffer via kmalloc(), this may lead to the leak of uninitialized
kernel-space data, as spotted via KMSAN:

  BUG: KMSAN: use of unitialized memory in snd_timer_user_read+0x6c4/0xa10
  CPU: 0 PID: 1037 Comm: probe Not tainted 4.11.0-rc5+ #2739
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
  Call Trace:
   __dump_stack lib/dump_stack.c:16
   dump_stack+0x143/0x1b0 lib/dump_stack.c:52
   kmsan_report+0x12a/0x180 mm/kmsan/kmsan.c:1007
   kmsan_check_memory+0xc2/0x140 mm/kmsan/kmsan.c:1086
   copy_to_user ./arch/x86/include/asm/uaccess.h:725
   snd_timer_user_read+0x6c4/0xa10 sound/core/timer.c:2004
   do_loop_readv_writev fs/read_write.c:716
   __do_readv_writev+0x94c/0x1380 fs/read_write.c:864
   do_readv_writev fs/read_write.c:894
   vfs_readv fs/read_write.c:908
   do_readv+0x52a/0x5d0 fs/read_write.c:934
   SYSC_readv+0xb6/0xd0 fs/read_write.c:1021
   SyS_readv+0x87/0xb0 fs/read_write.c:1018

This patch adds the missing reset of queue indices.  Together with the
previous fix for the ioctl/read race, we cover the whole problem.

Reported-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 1118bd8e2d3c..cd67d1c12cf1 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1618,6 +1618,7 @@ static int snd_timer_user_tselect(struct file *file,
 	if (err < 0)
 		goto __err;
 
+	tu->qhead = tu->qtail = tu->qused = 0;
 	kfree(tu->queue);
 	tu->queue = NULL;
 	kfree(tu->tqueue);
-- 
2.13.0
