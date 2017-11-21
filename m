From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/sound: slab-out-of-bounds in parse_audio_unit
Date: Tue, 21 Nov 2017 14:51:56 +0100
Message-ID: <CAAeHK+wr2ka_B6RAw+0ygzb_YRoATOZF89HDNoOCVj+4Wm0j1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Con Kolivas <con@kolivas.org>, Bhumika Goyal <bhumirks@gmail.com>, Stephen Barber <smbarber@chromium.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

Hi!

I've got the following report while fuzzing the kernel with syzkaller.

On commit e1d1ea549b57790a3d8cf6300e6ef86118d692a3 (4.15-rc1).

==================================================================
BUG: KASAN: slab-out-of-bounds in parse_audio_unit+0x2e08/0x31d0
Read of size 1 at addr ffff88006998ff20 by task kworker/1:1/1495

CPU: 1 PID: 1495 Comm: kworker/1:1 Not tainted 4.14.0-57501-g9284d204d604 #119
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:17
 dump_stack+0xe1/0x157 lib/dump_stack.c:53
 print_address_description+0x71/0x234 mm/kasan/report.c:252
 kasan_report_error mm/kasan/report.c:351
 kasan_report+0x173/0x270 mm/kasan/report.c:409
 __asan_report_load1_noabort+0x19/0x20 mm/kasan/report.c:427
 parse_audio_feature_unit sound/usb/mixer.c:1472
 parse_audio_unit+0x2e08/0x31d0 sound/usb/mixer.c:2213
 snd_usb_mixer_controls+0x2ec/0x750 sound/usb/mixer.c:2320
 snd_usb_create_mixer+0x209/0xbe0 sound/usb/mixer.c:2566
 create_standard_mixer_quirk+0x61/0x80 sound/usb/quirks.c:516
 snd_usb_create_quirk+0xa6/0x120 sound/usb/quirks.c:560
 create_composite_quirk+0x1e0/0x420 sound/usb/quirks.c:59
 snd_usb_create_quirk+0xa6/0x120 sound/usb/quirks.c:560
 usb_audio_probe+0x1220/0x1f70 sound/usb/card.c:618
 usb_probe_interface+0x324/0x940 drivers/usb/core/driver.c:361
 really_probe drivers/base/dd.c:424
 driver_probe_device+0x564/0x820 drivers/base/dd.c:566
 __device_attach_driver+0x25d/0x2d0 drivers/base/dd.c:662
 bus_for_each_drv+0xff/0x160 drivers/base/bus.c:463
 __device_attach+0x1ab/0x2a0 drivers/base/dd.c:719
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:766
 bus_probe_device+0x1fc/0x2a0 drivers/base/bus.c:523
 device_add+0xc27/0x15a0 drivers/base/core.c:1835
 usb_set_configuration+0xd55/0x17a0 drivers/usb/core/message.c:1967
 generic_probe+0xbb/0x120 drivers/usb/core/generic.c:174
 usb_probe_device+0xab/0x100 drivers/usb/core/driver.c:266
 really_probe drivers/base/dd.c:424
 driver_probe_device+0x564/0x820 drivers/base/dd.c:566
 __device_attach_driver+0x25d/0x2d0 drivers/base/dd.c:662
 bus_for_each_drv+0xff/0x160 drivers/base/bus.c:463
 __device_attach+0x1ab/0x2a0 drivers/base/dd.c:719
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:766
 bus_probe_device+0x1fc/0x2a0 drivers/base/bus.c:523
 device_add+0xc27/0x15a0 drivers/base/core.c:1835
 usb_new_device+0x7fa/0x1090 drivers/usb/core/hub.c:2538
 hub_port_connect drivers/usb/core/hub.c:5000
 hub_port_connect_change drivers/usb/core/hub.c:5106
 port_event drivers/usb/core/hub.c:5212
 hub_event_impl+0x17bc/0x3440 drivers/usb/core/hub.c:5324
 hub_event+0x38/0x50 drivers/usb/core/hub.c:5222
 process_one_work+0x944/0x15f0 kernel/workqueue.c:2112
 worker_thread+0xef/0x10d0 kernel/workqueue.c:2246
 kthread+0x367/0x420 kernel/kthread.c:238
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:437

Allocated by task 1495:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459
 kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:551
 __kmalloc+0x1bc/0x300 mm/slub.c:3762
 kmalloc ./include/linux/slab.h:504
 usb_get_configuration+0x299/0x4e60 drivers/usb/core/config.c:856
 usb_enumerate_device drivers/usb/core/hub.c:2371
 usb_new_device+0xab1/0x1090 drivers/usb/core/hub.c:2507
 hub_port_connect drivers/usb/core/hub.c:5000
 hub_port_connect_change drivers/usb/core/hub.c:5106
 port_event drivers/usb/core/hub.c:5212
 hub_event_impl+0x17bc/0x3440 drivers/usb/core/hub.c:5324
 hub_event+0x38/0x50 drivers/usb/core/hub.c:5222
 process_one_work+0x944/0x15f0 kernel/workqueue.c:2112
 worker_thread+0xef/0x10d0 kernel/workqueue.c:2246
 kthread+0x367/0x420 kernel/kthread.c:238
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:437

Freed by task 5251:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459
 kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
 slab_free_hook mm/slub.c:1391
 slab_free_freelist_hook mm/slub.c:1412
 slab_free mm/slub.c:2968
 kfree+0xf2/0x2e0 mm/slub.c:3899
 kzfree+0x2d/0x40 mm/slab_common.c:1482
 aa_free_task_context+0x13a/0x170 security/apparmor/context.c:54
 apparmor_cred_free+0x38/0x70 security/apparmor/lsm.c:58
 security_cred_free+0x4d/0x90 security/security.c:995
 put_cred_rcu+0x72/0x2a0 kernel/cred.c:117
 __rcu_reclaim kernel/rcu/rcu.h:195
 rcu_do_batch kernel/rcu/tree.c:2758
 invoke_rcu_callbacks kernel/rcu/tree.c:3012
 __rcu_process_callbacks kernel/rcu/tree.c:2979
 rcu_process_callbacks+0x4df/0xcf0 kernel/rcu/tree.c:2996
 __do_softirq+0x2e0/0x88e kernel/softirq.c:285

The buggy address belongs to the object at ffff88006998ff00
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes to the right of
 32-byte region [ffff88006998ff00, ffff88006998ff20)
The buggy address belongs to the page:
page:ffffea0001a663c0 count:1 mapcount:0 mapping:          (null) index:0x0
flags: 0x100000000000100(slab)
raw: 0100000000000100 0000000000000000 0000000000000000 0000000180550055
raw: ffffea0001aea900 0000000200000002 ffff88006c803980 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88006998fe00: fc fc fb fb fb fb fc fc 00 00 00 fc fc fc fb fb
 ffff88006998fe80: fb fb fc fc fb fb fb fb fc fc fb fb fb fb fc fc
>ffff88006998ff00: 00 00 00 00 fc fc fb fb fb fb fc fc fb fb fb fb
                               ^
 ffff88006998ff80: fc fc 00 00 00 00 fc fc fb fb fb fb fc fc fc fc
 ffff880069990000: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
==================================================================
