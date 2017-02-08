From: Dmitry Vyukov <dvyukov@google.com>
Subject: sound: use-after-free in snd_seq_queue_alloc
Date: Wed, 8 Feb 2017 10:41:14 +0100
Message-ID: <CACT4Y+ZytWZ59CQe0LnmB-5PirxsggNPe5ATFybGzf8etW3fqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com
 [209.85.213.49])
 by alsa0.perex.cz (Postfix) with ESMTP id EF94B2669E6
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 10:41:35 +0100 (CET)
Received: by mail-vk0-f49.google.com with SMTP id t8so96965526vke.3
 for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2017 01:41:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

Hello,


I've got the following report while running syzkaller fuzzer on
8b1b41ee74f9712c355d66dc105bbea663ae0afd:

BUG: KASAN: use-after-free in snd_seq_queue_alloc+0x663/0x690
sound/core/seq/seq_queue.c:200 at addr ffff880086ba1d00
Read of size 4 by task syz-executor2/31851
CPU: 2 PID: 31851 Comm: syz-executor2 Not tainted 4.10.0-rc5+ #201
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011

Call Trace:
 __asan_report_load4_noabort+0x3e/0x40 mm/kasan/report.c:327
 snd_seq_queue_alloc+0x663/0x690 sound/core/seq/seq_queue.c:200
 snd_seq_ioctl_create_queue+0xad/0x310 sound/core/seq/seq_clientmgr.c:1508
 snd_seq_ioctl+0x2da/0x4d0 sound/core/seq/seq_clientmgr.c:2130
 vfs_ioctl fs/ioctl.c:43 [inline]
 do_vfs_ioctl+0x1bf/0x1790 fs/ioctl.c:683
 SYSC_ioctl fs/ioctl.c:698 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:689
 entry_SYSCALL_64_fastpath+0x1f/0xc2

Allocated:
PID = 31851
[<ffffffff83483a17>] kzalloc include/linux/slab.h:490 [inline]
[<ffffffff83483a17>] queue_new sound/core/seq/seq_queue.c:113 [inline]
[<ffffffff83483a17>] snd_seq_queue_alloc+0x107/0x690
sound/core/seq/seq_queue.c:191
[<ffffffff834748dd>] snd_seq_ioctl_create_queue+0xad/0x310
sound/core/seq/seq_clientmgr.c:1508
[<ffffffff8347878a>] snd_seq_ioctl+0x2da/0x4d0
sound/core/seq/seq_clientmgr.c:2130
[<ffffffff81aa41cf>] vfs_ioctl fs/ioctl.c:43 [inline]
[<ffffffff81aa41cf>] do_vfs_ioctl+0x1bf/0x1790 fs/ioctl.c:683
[<ffffffff81aa582f>] SYSC_ioctl fs/ioctl.c:698 [inline]
[<ffffffff81aa582f>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:689
[<ffffffff841c9c81>] entry_SYSCALL_64_fastpath+0x1f/0xc2

Freed:
PID = 31854
[<ffffffff81a0b5c3>] kfree+0xd3/0x250 mm/slab.c:3822
[<ffffffff834817e0>] queue_delete+0x90/0xb0 sound/core/seq/seq_queue.c:156
[<ffffffff834826cc>] snd_seq_queue_delete+0x3c/0x50
sound/core/seq/seq_queue.c:213
[<ffffffff8347480a>] snd_seq_ioctl_delete_queue+0x6a/0x90
sound/core/seq/seq_clientmgr.c:1534
[<ffffffff8347878a>] snd_seq_ioctl+0x2da/0x4d0
sound/core/seq/seq_clientmgr.c:2130
[<ffffffff81aa41cf>] vfs_ioctl fs/ioctl.c:43 [inline]
[<ffffffff81aa41cf>] do_vfs_ioctl+0x1bf/0x1790 fs/ioctl.c:683
[<ffffffff81aa582f>] SYSC_ioctl fs/ioctl.c:698 [inline]
[<ffffffff81aa582f>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:689



Looking at the code:

int snd_seq_queue_alloc(int client, int locked, unsigned int info_flags)
{
        struct snd_seq_queue *q;

        q = queue_new(client, locked);
        if (q == NULL)
                return -ENOMEM;
        q->info_flags = info_flags;
        if (queue_list_add(q) < 0) {
                queue_delete(q);
                return -ENOMEM;
        }
        snd_seq_queue_use(q->queue, client, 1); /* use this queue */
        return q->queue;
}

After queue_list_add(q) q can be deleted by another thread, so
snd_seq_queue_use(q->queue, client, 1) already potentially operates on
deleted object.
