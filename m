From: Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 1/3] ALSA: timer: fix NULL pointer dereference in read()/ioctl() race
Date: Mon, 29 Aug 2016 00:33:49 +0200
Message-ID: <20160828223351.32489-1-vegard.nossum@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>, Vegard Nossum <vegard.nossum@oracle.com>
List-Id: alsa-devel@alsa-project.org

I got this with syzkaller:

    ==================================================================
    BUG: KASAN: null-ptr-deref on address 0000000000000020
    Read of size 32 by task syz-executor/22519
    CPU: 1 PID: 22519 Comm: syz-executor Not tainted 4.8.0-rc2+ #169
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2
    014
     0000000000000001 ffff880111a17a00 ffffffff81f9f141 ffff880111a17a90
     ffff880111a17c50 ffff880114584a58 ffff880114584a10 ffff880111a17a80
     ffffffff8161fe3f ffff880100000000 ffff880118d74a48 ffff880118d74a68
    Call Trace:
     [<ffffffff81f9f141>] dump_stack+0x83/0xb2
     [<ffffffff8161fe3f>] kasan_report_error+0x41f/0x4c0
     [<ffffffff8161ff74>] kasan_report+0x34/0x40
     [<ffffffff82c84b54>] ? snd_timer_user_read+0x554/0x790
     [<ffffffff8161e79e>] check_memory_region+0x13e/0x1a0
     [<ffffffff8161e9c1>] kasan_check_read+0x11/0x20
     [<ffffffff82c84b54>] snd_timer_user_read+0x554/0x790
     [<ffffffff82c84600>] ? snd_timer_user_info_compat.isra.5+0x2b0/0x2b0
     [<ffffffff817d0831>] ? proc_fault_inject_write+0x1c1/0x250
     [<ffffffff817d0670>] ? next_tgid+0x2a0/0x2a0
     [<ffffffff8127c278>] ? do_group_exit+0x108/0x330
     [<ffffffff8174653a>] ? fsnotify+0x72a/0xca0
     [<ffffffff81674dfe>] __vfs_read+0x10e/0x550
     [<ffffffff82c84600>] ? snd_timer_user_info_compat.isra.5+0x2b0/0x2b0
     [<ffffffff81674cf0>] ? do_sendfile+0xc50/0xc50
     [<ffffffff81745e10>] ? __fsnotify_update_child_dentry_flags+0x60/0x60
     [<ffffffff8143fec6>] ? kcov_ioctl+0x56/0x190
     [<ffffffff81e5ada2>] ? common_file_perm+0x2e2/0x380
     [<ffffffff81746b0e>] ? __fsnotify_parent+0x5e/0x2b0
     [<ffffffff81d93536>] ? security_file_permission+0x86/0x1e0
     [<ffffffff816728f5>] ? rw_verify_area+0xe5/0x2b0
     [<ffffffff81675355>] vfs_read+0x115/0x330
     [<ffffffff81676371>] SyS_read+0xd1/0x1a0
     [<ffffffff816762a0>] ? vfs_write+0x4b0/0x4b0
     [<ffffffff82001c2c>] ? __this_cpu_preempt_check+0x1c/0x20
     [<ffffffff8150455a>] ? __context_tracking_exit.part.4+0x3a/0x1e0
     [<ffffffff816762a0>] ? vfs_write+0x4b0/0x4b0
     [<ffffffff81005524>] do_syscall_64+0x1c4/0x4e0
     [<ffffffff810052fc>] ? syscall_return_slowpath+0x16c/0x1d0
     [<ffffffff83c3276a>] entry_SYSCALL64_slow_path+0x25/0x25
    ==================================================================

There are a couple of problems that I can see:

 - ioctl(SNDRV_TIMER_IOCTL_SELECT), which potentially sets
   tu->queue/tu->tqueue to NULL on memory allocation failure, so read()
   would get a NULL pointer dereference like the above splat

 - the same ioctl() can free tu->queue/to->tqueue which means read()
   could potentially see (and dereference) the freed pointer

We can fix the NULL pointer dereference by not touching the pointers
until we have allocated the new memory (similar to what is done in
ioctl(SNDRV_TIMER_IOCTL_PARAMS)) and we can fix the use-after-free by
taking the ioctl_lock mutex when dereferencing ->queue/->tqueue, since
that's always held over all the ioctl() code.

Just looking at the code I find it likely that there are more problems
here such as tu->qhead pointing outside the buffer if the size is
changed concurrently using SNDRV_TIMER_IOCTL_PARAMS.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 sound/core/timer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 9a6157e..7899e37 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1602,15 +1602,25 @@ static int snd_timer_user_tselect(struct file *file,
 	kfree(tu->tqueue);
 	tu->tqueue = NULL;
 	if (tu->tread) {
-		tu->tqueue = kmalloc(tu->queue_size * sizeof(struct snd_timer_tread),
+		struct snd_timer_tread *ttr;
+		ttr = kmalloc(tu->queue_size * sizeof(struct snd_timer_tread),
 				     GFP_KERNEL);
-		if (tu->tqueue == NULL)
+		if (ttr) {
+			kfree(tu->tqueue);
+			tu->tqueue = ttr;
+		} else {
 			err = -ENOMEM;
+		}
 	} else {
-		tu->queue = kmalloc(tu->queue_size * sizeof(struct snd_timer_read),
+		struct snd_timer_read *tr;
+		tr = kmalloc(tu->queue_size * sizeof(struct snd_timer_read),
 				    GFP_KERNEL);
-		if (tu->queue == NULL)
+		if (tr) {
+			kfree(tu->queue);
+			tu->queue = tr;
+		} else {
 			err = -ENOMEM;
+		}
 	}
 
       	if (err < 0) {
@@ -1958,6 +1968,7 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 		tu->qused--;
 		spin_unlock_irq(&tu->qlock);
 
+		mutex_lock(&tu->ioctl_lock);
 		if (tu->tread) {
 			if (copy_to_user(buffer, &tu->tqueue[qhead],
 					 sizeof(struct snd_timer_tread)))
@@ -1967,6 +1978,7 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 					 sizeof(struct snd_timer_read)))
 				err = -EFAULT;
 		}
+		mutex_unlock(&tu->ioctl_lock);
 
 		spin_lock_irq(&tu->qlock);
 		if (err < 0)
-- 
2.10.0.rc0.1.g07c9292
