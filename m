From: Dmitry Vyukov <dvyukov@google.com>
Subject: sound: use-after-free in snd_seq_cell_alloc
Date: Thu, 23 Mar 2017 13:23:03 +0100
Message-ID: <CACT4Y+a5eqN0GjVA8WuF9VKg4_4ZK-+b+ZVsiVnTuHvc8-rgFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I've got the following report while running syzkaller fuzzer on
093b995e3b55a0ae0670226ddfcb05bfbf0099ae. Unfortunately this is not
reproducible so far.

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x39df/0x3a80
kernel/locking/lockdep.c:3230 at addr ffff8800495fb6a0
Read of size 8 by task syz-executor7/17253
CPU: 2 PID: 17253 Comm: syz-executor7 Not tainted 4.11.0-rc3+ #364
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __asan_report_load8_noabort+0x29/0x30 mm/kasan/report.c:337
 __lock_acquire+0x39df/0x3a80 kernel/locking/lockdep.c:3230
 lock_acquire+0x1ee/0x590 kernel/locking/lockdep.c:3762
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x9f/0xd0 kernel/locking/spinlock.c:159
 snd_seq_cell_alloc.isra.1+0x17d/0x6a0 sound/core/seq/seq_memory.c:238
 snd_seq_event_dup+0x15d/0xa00 sound/core/seq/seq_memory.c:309
 snd_seq_fifo_event_in+0xe3/0x420 sound/core/seq/seq_fifo.c:128
 snd_seq_deliver_single_event.constprop.12+0x814/0x980
sound/core/seq/seq_clientmgr.c:615
 snd_seq_deliver_event+0x12c/0x720 sound/core/seq/seq_clientmgr.c:818
 snd_seq_kernel_client_dispatch+0x131/0x160 sound/core/seq/seq_clientmgr.c:2319
 snd_seq_system_notify+0x11b/0x160 sound/core/seq/seq_system.c:112
 snd_seq_client_notify_subscription+0x16f/0x210
sound/core/seq/seq_clientmgr.c:1414
 subscribe_port sound/core/seq/seq_ports.c:434 [inline]
 check_and_subscribe_port+0x725/0x950 sound/core/seq/seq_ports.c:510
 snd_seq_port_connect+0x3e5/0x700 sound/core/seq/seq_ports.c:579
 snd_seq_ioctl_subscribe_port+0x24b/0x300 sound/core/seq/seq_clientmgr.c:1443
 snd_seq_kernel_client_ctl+0x122/0x160 sound/core/seq/seq_clientmgr.c:2350
 snd_seq_oss_midi_open+0x640/0x850 sound/core/seq/oss/seq_oss_midi.c:375
 snd_seq_oss_synth_setup_midi+0x109/0x4d0 sound/core/seq/oss/seq_oss_synth.c:281
 snd_seq_oss_open+0x70f/0x8b0 sound/core/seq/oss/seq_oss_init.c:274
 odev_open+0x6a/0x90 sound/core/seq/oss/seq_oss.c:138
 soundcore_open+0x321/0x630 sound/sound_core.c:639
 chrdev_open+0x257/0x730 fs/char_dev.c:392
 do_dentry_open+0x710/0xc80 fs/open.c:751
 vfs_open+0x105/0x220 fs/open.c:864
 do_last fs/namei.c:3349 [inline]
 path_openat+0x1151/0x35b0 fs/namei.c:3490
 do_filp_open+0x249/0x370 fs/namei.c:3525
 do_sys_open+0x502/0x6d0 fs/open.c:1051
 SYSC_openat fs/open.c:1078 [inline]
 SyS_openat+0x30/0x40 fs/open.c:1072
 entry_SYSCALL_64_fastpath+0x1f/0xc2
RIP: 0033:0x445b79
RSP: 002b:00007f02452a6858 EFLAGS: 00000292 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000708000 RCX: 0000000000445b79
RDX: 0000000000000000 RSI: 0000000020063ff0 RDI: ffffffffffffff9c
RBP: 0000000000000086 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 00000000006e0fe0
R13: 0000000000001000 R14: 0000000000000003 R15: 0000000020000000
Object at ffff8800495fb600, in cache kmalloc-192 size: 192
Allocated:
PID = 17260
 kmalloc include/linux/slab.h:490 [inline]
 kzalloc include/linux/slab.h:663 [inline]
 snd_seq_pool_new+0x93/0x2f0 sound/core/seq/seq_memory.c:470
 snd_seq_fifo_new+0xc3/0x360 sound/core/seq/seq_fifo.c:41
 snd_seq_open+0x404/0x520 sound/core/seq/seq_clientmgr.c:333
 snd_open+0x1fa/0x3f0 sound/core/sound.c:177
 chrdev_open+0x257/0x730 fs/char_dev.c:392
 do_dentry_open+0x710/0xc80 fs/open.c:751
 vfs_open+0x105/0x220 fs/open.c:864
 do_last fs/namei.c:3349 [inline]
 path_openat+0x1151/0x35b0 fs/namei.c:3490
 do_filp_open+0x249/0x370 fs/namei.c:3525
 do_sys_open+0x502/0x6d0 fs/open.c:1051
 SYSC_open fs/open.c:1069 [inline]
 SyS_open+0x2d/0x40 fs/open.c:1064
 entry_SYSCALL_64_fastpath+0x1f/0xc2
Freed:
PID = 17280
 kfree+0xd7/0x250 mm/slab.c:3831
 snd_seq_pool_delete+0x52/0x70 sound/core/seq/seq_memory.c:498
 snd_seq_fifo_resize+0x263/0x3e0 sound/core/seq/seq_fifo.c:275
 snd_seq_ioctl_set_client_pool+0x481/0x600 sound/core/seq/seq_clientmgr.c:1849
 snd_seq_ioctl+0x204/0x470 sound/core/seq/seq_clientmgr.c:2131
 vfs_ioctl fs/ioctl.c:45 [inline]
 do_vfs_ioctl+0x1af/0x16d0 fs/ioctl.c:685
 SYSC_ioctl fs/ioctl.c:700 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
 entry_SYSCALL_64_fastpath+0x1f/0xc2
Memory state around the buggy address:
 ffff8800495fb580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8800495fb600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8800495fb680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                               ^
 ffff8800495fb700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8800495fb780: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================
