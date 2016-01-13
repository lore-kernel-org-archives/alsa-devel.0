From: Dmitry Vyukov <dvyukov@google.com>
Subject: sound: use-after-free in snd_timer_user_ioctl
Date: Wed, 13 Jan 2016 15:48:34 +0100
Message-ID: <CACT4Y+akV9XyDC_kmBQZV-26Py13E6sYASXaP4GKLNbRh6nZnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@intel.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>, Eric Dumazet <edumazet@google.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The following syzkaller-generated program triggers use-after-free in
snd_timer_user_ioctl:
https://gist.githubusercontent.com/dvyukov/e833610757b098956b50/raw/d819cd13b466e4adbe3dd825ee481e4512e77633/gistfile1.txt

------------[ cut here ]------------
WARNING: CPU: 1 PID: 2066 at lib/list_debug.c:53 __list_del_entry+0x10b/0x1e0()
list_del corruption, ffff8800359fd740->next is LIST_POISON1 (dead000000000100)
Modules linked in:
CPU: 1 PID: 2066 Comm: syz-executor Not tainted 4.4.0+ #240
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
 00000000ffffffff ffff880034b67938 ffffffff82926eed ffff880034b679a8
 ffff880034a00000 ffffffff8660b640 ffff880034b67978 ffffffff81350c89
 ffffffff8298e77b ffffed000696cf31 ffffffff8660b640 0000000000000035
Call Trace:
 [<     inline     >] __dump_stack lib/dump_stack.c:15
 [<ffffffff82926eed>] dump_stack+0x6f/0xa2 lib/dump_stack.c:50
 [<ffffffff81350c89>] warn_slowpath_common+0xd9/0x140 kernel/panic.c:483
 [<ffffffff81350d99>] warn_slowpath_fmt+0xa9/0xd0 kernel/panic.c:495
 [<ffffffff8298e77b>] __list_del_entry+0x10b/0x1e0 lib/list_debug.c:51
 [<     inline     >] list_move_tail include/linux/list.h:168
 [<ffffffff84ec0411>] snd_timer_start1+0x31/0x2b0 sound/core/timer.c:421
 [<ffffffff84ec07b0>] snd_timer_continue+0x120/0x1b0 sound/core/timer.c:568
 [<     inline     >] snd_timer_user_continue sound/core/timer.c:1751
 [<ffffffff84ec493b>] snd_timer_user_ioctl+0xdab/0x2540 sound/core/timer.c:1824
 [<     inline     >] vfs_ioctl fs/ioctl.c:43
 [<ffffffff817cbd3c>] do_vfs_ioctl+0x18c/0xfa0 fs/ioctl.c:674
 [<     inline     >] SYSC_ioctl fs/ioctl.c:689
 [<ffffffff817ccbdf>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:680
 [<ffffffff86272ff6>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185
---[ end trace 384a7ce57530be36 ]---
------------[ cut here ]------------

On commit 67990608c8b95d2b8ccc29932376ae73d5818727 (Jan 12).
