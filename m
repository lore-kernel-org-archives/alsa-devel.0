From: Dmitry Vyukov <dvyukov@google.com>
Subject: sound: deadlock between
	snd_rawmidi_kernel_open/snd_seq_port_connect
Date: Sun, 24 Jan 2016 10:44:34 +0100
Message-ID: <CACT4Y+aKQXV7xkBW9hpQbzaDO7LrUvohxWh-UwMxXjDy-yBD=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 10CE8260631
 for <alsa-devel@alsa-project.org>; Sun, 24 Jan 2016 10:44:54 +0100 (CET)
Received: by mail-wm0-f44.google.com with SMTP id l65so31615363wmf.1
 for <alsa-devel@alsa-project.org>; Sun, 24 Jan 2016 01:44:54 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Sasha Levin <sasha.levin@oracle.com>, syzkaller <syzkaller@googlegroups.com>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>
List-Id: alsa-devel@alsa-project.org

Hello,

While running syzkaller fuzzer I've got the following lockdep report:

======================================================
[ INFO: possible circular locking dependency detected ]
4.4.0+ #276 Not tainted
-------------------------------------------------------
syz-executor/21025 is trying to acquire lock:
 (register_mutex#5){+.+.+.}, at: [<ffffffff84f889cb>]
snd_rawmidi_kernel_open+0x4b/0x260 sound/core/rawmidi.c:341

but task is already holding lock:
 (&grp->list_mutex/1){+.+...}, at: [<ffffffff84fc4afa>]
snd_seq_port_connect+0x1ba/0x840 sound/core/seq/seq_ports.c:506

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&grp->list_mutex/1){+.+...}:
       [<ffffffff8145ad8c>] lock_acquire+0x1dc/0x430
kernel/locking/lockdep.c:3585
       [<ffffffff8144851a>] down_write_nested+0x4a/0xa0
kernel/locking/rwsem.c:149
       [<ffffffff84fc4afa>] snd_seq_port_connect+0x1ba/0x840
sound/core/seq/seq_ports.c:506
       [<ffffffff84fb6f54>] snd_seq_ioctl_subscribe_port+0x1c4/0x290
sound/core/seq/seq_clientmgr.c:1464
       [<ffffffff84fb126d>] snd_seq_do_ioctl+0x19d/0x1c0
sound/core/seq/seq_clientmgr.c:2209
       [<ffffffff84fb2c2b>] snd_seq_kernel_client_ctl+0xdb/0x170
sound/core/seq/seq_clientmgr.c:2423
       [<ffffffff88413c20>] snd_seq_oss_create_client+0x253/0x2d5
sound/core/seq/oss/seq_oss_init.c:119
       [<ffffffff8841393e>] alsa_seq_oss_init+0x1af/0x23e
sound/core/seq/oss/seq_oss.c:89
       [<ffffffff81002259>] do_one_initcall+0x159/0x380 init/main.c:794
       [<     inline     >] do_initcall_level init/main.c:859
       [<     inline     >] do_initcalls init/main.c:867
       [<     inline     >] do_basic_setup init/main.c:885
       [<ffffffff88315c1a>] kernel_init_freeable+0x474/0x52d init/main.c:1010
       [<ffffffff86312683>] kernel_init+0x13/0x150 init/main.c:936
       [<ffffffff86336fef>] ret_from_fork+0x3f/0x70
arch/x86/entry/entry_64.S:468

-> #1 (&grp->list_mutex){++++.+}:
       [<ffffffff8145ad8c>] lock_acquire+0x1dc/0x430
kernel/locking/lockdep.c:3585
       [<ffffffff863323a7>] down_read+0x47/0x60 kernel/locking/rwsem.c:22
       [<     inline     >] deliver_to_subscribers
sound/core/seq/seq_clientmgr.c:679
       [<ffffffff84fb5509>] snd_seq_deliver_event+0x5a9/0x800
sound/core/seq/seq_clientmgr.c:817
       [<ffffffff84fb6466>] snd_seq_kernel_client_dispatch+0x126/0x170
sound/core/seq/seq_clientmgr.c:2401
       [<ffffffff84fc1e62>] snd_seq_system_broadcast+0xb2/0xf0
sound/core/seq/seq_system.c:101
       [<ffffffff84fb248e>] snd_seq_create_kernel_client+0x21e/0x300
sound/core/seq/seq_clientmgr.c:2280
       [<     inline     >] snd_virmidi_dev_attach_seq
sound/core/seq/seq_virmidi.c:372
       [<ffffffff84fdc55f>] snd_virmidi_dev_register+0x29f/0x750
sound/core/seq/seq_virmidi.c:439
       [<ffffffff84f824ec>] snd_rawmidi_dev_register+0x30c/0xd40
sound/core/rawmidi.c:1589
       [<ffffffff84f33583>] __snd_device_register.part.0+0x63/0xc0
sound/core/device.c:164
       [<     inline     >] __snd_device_register sound/core/device.c:162
       [<ffffffff84f341ed>] snd_device_register_all+0xad/0x110
sound/core/device.c:212
       [<ffffffff84f277cf>] snd_card_register+0xef/0x6a0 sound/core/init.c:749
       [<ffffffff84fefc0f>] snd_virmidi_probe+0x3ef/0x590
sound/drivers/virmidi.c:123
       [<ffffffff832feb6c>] platform_drv_probe+0x8c/0x160
drivers/base/platform.c:562
       [<     inline     >] really_probe drivers/base/dd.c:377
       [<ffffffff832f862e>] driver_probe_device+0x37e/0xc90
drivers/base/dd.c:499
       [<ffffffff832f926e>] __device_attach_driver+0x19e/0x250
drivers/base/dd.c:584
       [<ffffffff832f23df>] bus_for_each_drv+0x13f/0x1d0 drivers/base/bus.c:464
       [<ffffffff832f809f>] __device_attach+0x1ef/0x2e0 drivers/base/dd.c:641
       [<ffffffff832f93ba>] device_initial_probe+0x1a/0x20 drivers/base/dd.c:688
       [<ffffffff832f5939>] bus_probe_device+0x1e9/0x290 drivers/base/bus.c:558
       [<ffffffff832ef11b>] device_add+0x84b/0x1490 drivers/base/core.c:1120
       [<ffffffff832fe2c9>] platform_device_add+0x389/0x790
drivers/base/platform.c:403
       [<ffffffff832fff26>] platform_device_register_full+0x396/0x4c0
drivers/base/platform.c:535
       [<     inline     >] platform_device_register_resndata
include/linux/platform_device.h:111
       [<     inline     >] platform_device_register_simple
include/linux/platform_device.h:140
       [<ffffffff884146d1>] alsa_card_virmidi_init+0x104/0x1da
sound/drivers/virmidi.c:172
       [<ffffffff81002259>] do_one_initcall+0x159/0x380 init/main.c:794
       [<     inline     >] do_initcall_level init/main.c:859
       [<     inline     >] do_initcalls init/main.c:867
       [<     inline     >] do_basic_setup init/main.c:885
       [<ffffffff88315c1a>] kernel_init_freeable+0x474/0x52d init/main.c:1010
       [<ffffffff86312683>] kernel_init+0x13/0x150 init/main.c:936
       [<ffffffff86336fef>] ret_from_fork+0x3f/0x70
arch/x86/entry/entry_64.S:468

-> #0 (register_mutex#5){+.+.+.}:
       [<     inline     >] check_prev_add kernel/locking/lockdep.c:1853
       [<     inline     >] check_prevs_add kernel/locking/lockdep.c:1958
       [<     inline     >] validate_chain kernel/locking/lockdep.c:2144
       [<ffffffff8145742b>] __lock_acquire+0x31eb/0x4700
kernel/locking/lockdep.c:3206
       [<ffffffff8145ad8c>] lock_acquire+0x1dc/0x430
kernel/locking/lockdep.c:3585
       [<     inline     >] __mutex_lock_common kernel/locking/mutex.c:518
       [<ffffffff8632cf61>] mutex_lock_nested+0xb1/0xa50
kernel/locking/mutex.c:618
       [<ffffffff84f889cb>] snd_rawmidi_kernel_open+0x4b/0x260
sound/core/rawmidi.c:341
       [<ffffffff84fdda77>] midisynth_subscribe+0xf7/0x340
sound/core/seq/seq_midi.c:188
       [<ffffffff84fc2a4e>] subscribe_port.isra.2+0x14e/0x2b0
sound/core/seq/seq_ports.c:426
       [<ffffffff84fc4dd0>] snd_seq_port_connect+0x490/0x840
sound/core/seq/seq_ports.c:527
       [<ffffffff84fb6f54>] snd_seq_ioctl_subscribe_port+0x1c4/0x290
sound/core/seq/seq_clientmgr.c:1464
       [<ffffffff84fb126d>] snd_seq_do_ioctl+0x19d/0x1c0
sound/core/seq/seq_clientmgr.c:2209
       [<ffffffff84fb2c2b>] snd_seq_kernel_client_ctl+0xdb/0x170
sound/core/seq/seq_clientmgr.c:2423
       [<ffffffff84fd69e4>] snd_seq_oss_midi_open+0x3b4/0x610
sound/core/seq/oss/seq_oss_midi.c:375
       [<ffffffff84fd6ccb>] snd_seq_oss_midi_open_all+0x8b/0xd0
sound/core/seq/oss/seq_oss_midi.c:306
       [<ffffffff84fca1d5>] snd_seq_oss_open+0x5c5/0x8d0
sound/core/seq/oss/seq_oss_init.c:276
       [<ffffffff84fc903a>] odev_open+0x6a/0x90 sound/core/seq/oss/seq_oss.c:138
       [<ffffffff84f2279f>] soundcore_open+0x30f/0x640 sound/sound_core.c:639
       [<ffffffff817be1fa>] chrdev_open+0x22a/0x4c0 fs/char_dev.c:388
       [<ffffffff817a9c02>] do_dentry_open+0x6a2/0xcb0 fs/open.c:736
       [<ffffffff817ad2db>] vfs_open+0x17b/0x1f0 fs/open.c:853
       [<     inline     >] do_last fs/namei.c:3254
       [<ffffffff817e00d9>] path_openat+0xde9/0x5e30 fs/namei.c:3386
       [<ffffffff817e895e>] do_filp_open+0x18e/0x250 fs/namei.c:3421
       [<ffffffff817ada5c>] do_sys_open+0x1fc/0x420 fs/open.c:1022
       [<     inline     >] SYSC_open fs/open.c:1040
       [<ffffffff817adcad>] SyS_open+0x2d/0x40 fs/open.c:1035
       [<ffffffff86336c36>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185

other info that might help us debug this:

Chain exists of:
  register_mutex#5 --> &grp->list_mutex --> &grp->list_mutex/1

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&grp->list_mutex/1);
                               lock(&grp->list_mutex);
                               lock(&grp->list_mutex/1);
  lock(register_mutex#5);

 *** DEADLOCK ***

3 locks held by syz-executor/21025:
 #0:  (register_mutex#4){+.+.+.}, at: [<ffffffff84fc902f>]
odev_open+0x5f/0x90 sound/core/seq/oss/seq_oss.c:137
 #1:  (&grp->list_mutex){++++.+}, at: [<ffffffff84fc4ae2>]
snd_seq_port_connect+0x1a2/0x840 sound/core/seq/seq_ports.c:505
 #2:  (&grp->list_mutex/1){+.+...}, at: [<ffffffff84fc4afa>]
snd_seq_port_connect+0x1ba/0x840 sound/core/seq/seq_ports.c:506

stack backtrace:
CPU: 2 PID: 21025 Comm: syz-executor Not tainted 4.4.0+ #276
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
 00000000ffffffff ffff88006d0af0c0 ffffffff82999e2d ffffffff88fa1eb0
 ffffffff88fa2f90 ffffffff88fa2060 ffff88006d0af110 ffffffff81450658
 ffff880065c8df00 ffff880065c8e79a 0000000000000000 ffff880065c8e778
Call Trace:
 [<     inline     >] __dump_stack lib/dump_stack.c:15
 [<ffffffff82999e2d>] dump_stack+0x6f/0xa2 lib/dump_stack.c:50
 [<ffffffff81450658>] print_circular_bug+0x288/0x340
kernel/locking/lockdep.c:1226
 [<     inline     >] check_prev_add kernel/locking/lockdep.c:1853
 [<     inline     >] check_prevs_add kernel/locking/lockdep.c:1958
 [<     inline     >] validate_chain kernel/locking/lockdep.c:2144
 [<ffffffff8145742b>] __lock_acquire+0x31eb/0x4700 kernel/locking/lockdep.c:3206
 [<ffffffff8145ad8c>] lock_acquire+0x1dc/0x430 kernel/locking/lockdep.c:3585
 [<     inline     >] __mutex_lock_common kernel/locking/mutex.c:518
 [<ffffffff8632cf61>] mutex_lock_nested+0xb1/0xa50 kernel/locking/mutex.c:618
 [<ffffffff84f889cb>] snd_rawmidi_kernel_open+0x4b/0x260
sound/core/rawmidi.c:341
 [<ffffffff84fdda77>] midisynth_subscribe+0xf7/0x340
sound/core/seq/seq_midi.c:188
 [<ffffffff84fc2a4e>] subscribe_port.isra.2+0x14e/0x2b0
sound/core/seq/seq_ports.c:426
 [<ffffffff84fc4dd0>] snd_seq_port_connect+0x490/0x840
sound/core/seq/seq_ports.c:527
 [<ffffffff84fb6f54>] snd_seq_ioctl_subscribe_port+0x1c4/0x290
sound/core/seq/seq_clientmgr.c:1464
 [<ffffffff84fb126d>] snd_seq_do_ioctl+0x19d/0x1c0
sound/core/seq/seq_clientmgr.c:2209
 [<ffffffff84fb2c2b>] snd_seq_kernel_client_ctl+0xdb/0x170
sound/core/seq/seq_clientmgr.c:2423
 [<ffffffff84fd69e4>] snd_seq_oss_midi_open+0x3b4/0x610
sound/core/seq/oss/seq_oss_midi.c:375
 [<ffffffff84fd6ccb>] snd_seq_oss_midi_open_all+0x8b/0xd0
sound/core/seq/oss/seq_oss_midi.c:306
 [<ffffffff84fca1d5>] snd_seq_oss_open+0x5c5/0x8d0
sound/core/seq/oss/seq_oss_init.c:276
 [<ffffffff84fc903a>] odev_open+0x6a/0x90 sound/core/seq/oss/seq_oss.c:138
 [<ffffffff84f2279f>] soundcore_open+0x30f/0x640 sound/sound_core.c:639
 [<ffffffff817be1fa>] chrdev_open+0x22a/0x4c0 fs/char_dev.c:388
 [<ffffffff817a9c02>] do_dentry_open+0x6a2/0xcb0 fs/open.c:736
 [<ffffffff817ad2db>] vfs_open+0x17b/0x1f0 fs/open.c:853
 [<     inline     >] do_last fs/namei.c:3254
 [<ffffffff817e00d9>] path_openat+0xde9/0x5e30 fs/namei.c:3386
 [<ffffffff817e895e>] do_filp_open+0x18e/0x250 fs/namei.c:3421
 [<ffffffff817ada5c>] do_sys_open+0x1fc/0x420 fs/open.c:1022
 [<     inline     >] SYSC_open fs/open.c:1040
 [<ffffffff817adcad>] SyS_open+0x2d/0x40 fs/open.c:1035
 [<ffffffff86336c36>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185

On commit 30f05309bde49295e02e45c7e615f73aa4e0ccc2.
