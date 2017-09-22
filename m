From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/sounds: slab-out-of-bounds read in snd_usb_create_streams
Date: Fri, 22 Sep 2017 14:56:06 +0200
Message-ID: <CAAeHK+zNjunETPXqN5kYH3mzxoaKJjeYj8+LESKs0cFuQGs4ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

Hi!

I've got the following report while fuzzing the kernel with syzkaller.

On commit ebb2c2437d8008d46796902ff390653822af6cc4 (Sep 18).

It seems that there's no check that control_header has enough space
for uac1_ac_header_descriptor in snd_usb_create_streams().

==================================================================
BUG: KASAN: slab-out-of-bounds in usb_audio_probe+0x27b2/0x2ab0
Read of size 1 at addr ffff88006b83a9e8 by task kworker/0:1/24

CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted 4.14.0-rc1-42251-gebb2c2437d80 #224
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:16
 dump_stack+0x292/0x395 lib/dump_stack.c:52
 print_address_description+0x78/0x280 mm/kasan/report.c:252
 kasan_report_error mm/kasan/report.c:351
 kasan_report+0x22f/0x340 mm/kasan/report.c:409
 __asan_report_load1_noabort+0x19/0x20 mm/kasan/report.c:427
 snd_usb_create_streams sound/usb/card.c:248
 usb_audio_probe+0x27b2/0x2ab0 sound/usb/card.c:605
 usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
 really_probe drivers/base/dd.c:413
 driver_probe_device+0x610/0xa00 drivers/base/dd.c:557
 __device_attach_driver+0x230/0x290 drivers/base/dd.c:653
 bus_for_each_drv+0x161/0x210 drivers/base/bus.c:463
 __device_attach+0x26e/0x3d0 drivers/base/dd.c:710
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
 bus_probe_device+0x1eb/0x290 drivers/base/bus.c:523
 device_add+0xd0b/0x1660 drivers/base/core.c:1835
 usb_set_configuration+0x104e/0x1870 drivers/usb/core/message.c:1932
 generic_probe+0x73/0xe0 drivers/usb/core/generic.c:174
 usb_probe_device+0xaf/0xe0 drivers/usb/core/driver.c:266
 really_probe drivers/base/dd.c:413
 driver_probe_device+0x610/0xa00 drivers/base/dd.c:557
 __device_attach_driver+0x230/0x290 drivers/base/dd.c:653
 bus_for_each_drv+0x161/0x210 drivers/base/bus.c:463
 __device_attach+0x26e/0x3d0 drivers/base/dd.c:710
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
 bus_probe_device+0x1eb/0x290 drivers/base/bus.c:523
 device_add+0xd0b/0x1660 drivers/base/core.c:1835
 usb_new_device+0x7b8/0x1020 drivers/usb/core/hub.c:2457
 hub_port_connect drivers/usb/core/hub.c:4903
 hub_port_connect_change drivers/usb/core/hub.c:5009
 port_event drivers/usb/core/hub.c:5115
 hub_event+0x194d/0x3740 drivers/usb/core/hub.c:5195
 process_one_work+0xc7f/0x1db0 kernel/workqueue.c:2119
 worker_thread+0x221/0x1850 kernel/workqueue.c:2253
 kthread+0x3a1/0x470 kernel/kthread.c:231
 ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431

Allocated by task 24:
 save_stack_trace+0x1b/0x20 arch/x86/kernel/stacktrace.c:59
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459
 kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
 __kmalloc+0x14e/0x310 mm/slub.c:3782
 kmalloc ./include/linux/slab.h:498
 usb_get_configuration+0x372/0x2a60 drivers/usb/core/config.c:848
 usb_enumerate_device drivers/usb/core/hub.c:2290
 usb_new_device+0xaae/0x1020 drivers/usb/core/hub.c:2426
 hub_port_connect drivers/usb/core/hub.c:4903
 hub_port_connect_change drivers/usb/core/hub.c:5009
 port_event drivers/usb/core/hub.c:5115
 hub_event+0x194d/0x3740 drivers/usb/core/hub.c:5195
 process_one_work+0xc7f/0x1db0 kernel/workqueue.c:2119
 worker_thread+0x221/0x1850 kernel/workqueue.c:2253
 kthread+0x3a1/0x470 kernel/kthread.c:231
 ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431

Freed by task 4048:
 save_stack_trace+0x1b/0x20 arch/x86/kernel/stacktrace.c:59
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459
 kasan_slab_free+0x72/0xc0 mm/kasan/kasan.c:524
 slab_free_hook mm/slub.c:1390
 slab_free_freelist_hook mm/slub.c:1412
 slab_free mm/slub.c:2988
 kfree+0xf6/0x2f0 mm/slub.c:3919
 free_rb_tree_fname+0x8a/0xe0 fs/ext4/dir.c:402
 ext4_htree_free_dir_info fs/ext4/dir.c:424
 ext4_release_dir+0x49/0x70 fs/ext4/dir.c:622
 __fput+0x33e/0x800 fs/file_table.c:210
 ____fput+0x1a/0x20 fs/file_table.c:244
 task_work_run+0x1af/0x280 kernel/task_work.c:112
 tracehook_notify_resume ./include/linux/tracehook.h:191
 exit_to_usermode_loop+0x1e1/0x220 arch/x86/entry/common.c:162
 prepare_exit_to_usermode arch/x86/entry/common.c:197
 syscall_return_slowpath+0x414/0x480 arch/x86/entry/common.c:266
 entry_SYSCALL_64_fastpath+0xc0/0xc2 arch/x86/entry/entry_64.S:238

The buggy address belongs to the object at ffff88006b83a9c0
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 40 bytes inside of
 64-byte region [ffff88006b83a9c0, ffff88006b83aa00)
The buggy address belongs to the page:
page:ffffea0001ae0e80 count:1 mapcount:0 mapping:          (null) index:0x0
flags: 0x100000000000100(slab)
raw: 0100000000000100 0000000000000000 0000000000000000 00000001802a002a
raw: 0000000000000000 0000000100000001 ffff88006c403800 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88006b83a880: fc fc fc fc 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff88006b83a900: fb fb fb fb fb fb fb fb fc fc fc fc 00 00 00 00
>ffff88006b83a980: 00 00 fc fc fc fc fc fc 00 00 00 00 07 fc fc fc
                                                          ^
 ffff88006b83aa00: fc fc fc fc 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff88006b83aa80: 00 00 00 00 00 00 00 00 fc fc fc fc 00 00 00 00
==================================================================
