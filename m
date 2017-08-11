From: Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] ALSA: seq: 2nd attempt at fixing race creating a q
Date: Fri, 11 Aug 2017 14:23:42 -0700
Message-ID: <CAE2F3rDKTv+98V7yZ3Hen=Zi5_HVnwW_zHMUDAcSO8SwB9K-GA@mail.gmail.com>
References: <20170811030734.37741-1-danielmentz@google.com> <s5h1soidv2u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h1soidv2u.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 11, 2017 at 7:42 AM, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 11 Aug 2017 05:07:34 +0200,
> Daniel Mentz wrote:
> >
> > commit 4842e98f26dd80be3623c4714a244ba52ea096a8 ("ALSA: seq: Fix race at
> > creating a queue") attempted to fix a race reported by syzkaller. That
> > fix has been described as follows:
> >
> > "
> > When a sequencer queue is created in snd_seq_queue_alloc(),it adds the
> > new queue element to the public list before referencing it.  Thus the
> > queue might be deleted before the call of snd_seq_queue_use(), and it
> > results in the use-after-free error, as spotted by syzkaller.
> >
> > The fix is to reference the queue object at the right time.
> > "
> >
> > The last phrase in that commit message refers to calling queue_use(q, client,
> > 1) which increments queue->clients, but that does not prevent the
> > DELETE_QUEUE ioctl() and queue_delete() from kfree()ing the queue.
> > Hence, the commit is not effective at preventing the race.
>
> kfree() is performed only after snd_use_lock_sync(), thus by acquiring
> snd_use_lock() it doesn't race.  If it were already deleted,
> queue_use() returns NULL so it's also fine.

queue_use() is defined to return void. I am assuming you're referring
to queueptr().

Where do you acquire the snd_use_lock i.e. where do you call
snd_use_lock_use()? My understanding is that it's called from
queueptr(). With that said, there is a tiny gap between the new queue
being added to the list in queue_list_add() (from
snd_seq_queue_alloc()) and the call to queueptr() in
snd_seq_ioctl_create_queue(). syzkaller specifically points to the
last instruction "return q->queue;" in snd_seq_queue_alloc(). This is
*after* q has been added to the list (and is therefore visible to
other threads) but *before* it has been locked through
snd_seq_ioctl_create_queue()->queueptr()->snd_use_lock_use(). Hence,
there is a possibility that the pointer q is no longer valid.
You could capture the return value from queue_list_add() which is
identical to q->queue and then return that. However, the other issue
is that queueptr() indeed returns NULL if the queue with that index
has been deleted, but it's theoretically possible that the queue has
been deleted and a *different* been created that now occupies the same
spot in the queue_list.

> Or do you actually see any crash or the wild behavior?

syzkaller reported a crash:

syzkaller hit the following crash on 7b2727c68878444d8f47d2d394395e4a11929624
https://android.googlesource.com/kernel/common/android-4.9
compiler: gcc (GCC) 7.1.1 20170620

==================================================================
BUG: KASAN: use-after-free in snd_seq_queue_alloc+0x47e/0x4a0
sound/core/seq/seq_queue.c:202 at addr ffff8801c7622000
Read of size 4 by task syz-executor1/23085
CPU: 1 PID: 23085 Comm: syz-executor1 Not tainted 4.9.40-g7b2727c #16
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
 ffff8801cc49faa8 ffffffff81d8f109 ffff8801da001280 ffff8801c7622000
 ffff8801c7622200 ffffed0038ec4400 ffff8801c7622000 ffff8801cc49fad0
 ffffffff8153931c ffffed0038ec4400 ffff8801da001280 0000000000000000
Call Trace:
 [<ffffffff81d8f109>] __dump_stack lib/dump_stack.c:15 [inline]
 [<ffffffff81d8f109>] dump_stack+0xc1/0x128 lib/dump_stack.c:51
 [<ffffffff8153931c>] kasan_object_err+0x1c/0x70 mm/kasan/report.c:160
 [<ffffffff815395dc>] print_address_description mm/kasan/report.c:198 [inline]
 [<ffffffff815395dc>] kasan_report_error mm/kasan/report.c:287 [inline]
 [<ffffffff815395dc>] kasan_report.part.1+0x21c/0x500 mm/kasan/report.c:309
 [<ffffffff81539949>] kasan_report mm/kasan/report.c:329 [inline]
 [<ffffffff81539949>] __asan_report_load4_noabort+0x29/0x30
mm/kasan/report.c:329
 [<ffffffff82e096ee>] snd_seq_queue_alloc+0x47e/0x4a0
sound/core/seq/seq_queue.c:202
 [<ffffffff82dfdabd>] snd_seq_ioctl_create_queue+0xad/0x310
sound/core/seq/seq_clientmgr.c:1508
 [<ffffffff82e01146>] snd_seq_ioctl+0x226/0x4a0
sound/core/seq/seq_clientmgr.c:2131
 [<ffffffff815a922a>] vfs_ioctl fs/ioctl.c:43 [inline]
 [<ffffffff815a922a>] do_vfs_ioctl+0x1aa/0x10c0 fs/ioctl.c:679
 [<ffffffff815aa1cf>] SYSC_ioctl fs/ioctl.c:694 [inline]
 [<ffffffff815aa1cf>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:685
 [<ffffffff838a26c5>] entry_SYSCALL_64_fastpath+0x23/0xc6
Object at ffff8801c7622000, in cache kmalloc-512 size: 512
Allocated:
PID = 23085
 save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:57
 save_stack+0x43/0xd0 mm/kasan/kasan.c:495
 set_track mm/kasan/kasan.c:507 [inline]
 kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:598
 kmem_cache_alloc_trace+0xfb/0x2a0 mm/slub.c:2742
 kmalloc include/linux/slab.h:490 [inline]
 kzalloc include/linux/slab.h:636 [inline]
 queue_new sound/core/seq/seq_queue.c:113 [inline]
 snd_seq_queue_alloc+0x5d/0x4a0 sound/core/seq/seq_queue.c:193
 snd_seq_ioctl_create_queue+0xad/0x310 sound/core/seq/seq_clientmgr.c:1508
 snd_seq_ioctl+0x226/0x4a0 sound/core/seq/seq_clientmgr.c:2131
 vfs_ioctl fs/ioctl.c:43 [inline]
 do_vfs_ioctl+0x1aa/0x10c0 fs/ioctl.c:679
 SYSC_ioctl fs/ioctl.c:694 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:685
 entry_SYSCALL_64_fastpath+0x23/0xc6
Freed:
PID = 23098
 save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:57
 save_stack+0x43/0xd0 mm/kasan/kasan.c:495
 set_track mm/kasan/kasan.c:507 [inline]
 kasan_slab_free+0x73/0xc0 mm/kasan/kasan.c:571
 slab_free_hook mm/slub.c:1355 [inline]
 slab_free_freelist_hook mm/slub.c:1377 [inline]
 slab_free mm/slub.c:2958 [inline]
 kfree+0xf0/0x2f0 mm/slub.c:3878
 queue_delete+0x90/0xb0 sound/core/seq/seq_queue.c:156
 snd_seq_queue_delete+0x3c/0x50 sound/core/seq/seq_queue.c:215
 snd_seq_ioctl_delete_queue+0x6a/0x90 sound/core/seq/seq_clientmgr.c:1534
 snd_seq_ioctl+0x226/0x4a0 sound/core/seq/seq_clientmgr.c:2131
 vfs_ioctl fs/ioctl.c:43 [inline]
 do_vfs_ioctl+0x1aa/0x10c0 fs/ioctl.c:679
 SYSC_ioctl fs/ioctl.c:694 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:685
 entry_SYSCALL_64_fastpath+0x23/0xc6
Memory state around the buggy address:
 ffff8801c7621f00: fb fb fb fb fb fb fb fb fc fc fc fc fb fb fb fb
 ffff8801c7621f80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8801c7622000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8801c7622080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8801c7622100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
