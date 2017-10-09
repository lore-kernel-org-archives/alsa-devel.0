From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/sound: use-after-free in snd_usb_mixer_interrupt
Date: Mon, 9 Oct 2017 19:50:39 +0200
Message-ID: <CAAeHK+zfyd8wkBfkg2huCp49BkSdFgO6v1Zd_eS_YOMoZ1X3_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, Con Kolivas <con@kolivas.org>, Stephen Barber <smbarber@chromium.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

Hi!

I've got the following report while fuzzing the kernel with syzkaller.

On commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f (4.14-rc4).

gadgetfs: bound to dummy_udc driver
usb 1-1: new full-speed USB device number 2 using dummy_hcd
gadgetfs: connected
gadgetfs: disconnected
gadgetfs: connected
usb 1-1: config 1 has an invalid interface number: 1 but max is 0
usb 1-1: config 1 has 2 interfaces, different from the descriptor's value: 1
usb 1-1: config 1 interface 0 altsetting 0 endpoint 0x81 has an
invalid bInterval 0, changing to 10
usb 1-1: too many endpoints for config 1 interface 1 altsetting 174:
131, using maximum allowed: 30
usb 1-1: config 1 interface 1 altsetting 174 has 0 endpoint
descriptors, different from the interface de
scriptor's value: 131
usb 1-1: config 1 interface 1 has no altsetting 0
usb 1-1: New USB device found, idVendor=0dba, idProduct=1000
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=252
usb 1-1: SerialNumber: a
gadgetfs: configuration #1
hub 1-1:1.0: USB hub found
hub 1-1:1.0: config failed, can't read hub descriptor (err -22)
snd-usb-audio: probe of 1-1:1.0 failed with error -22
==================================================================
BUG: KASAN: use-after-free in snd_usb_mixer_interrupt+0x604/0x6f0
Read of size 8 at addr ffff8800636f8900 by task swapper/1/0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted
4.14.0-rc4-43418-g43a3f84d2109-dirty #391
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:16
 dump_stack+0x292/0x395 lib/dump_stack.c:52
 print_address_description+0x78/0x280 mm/kasan/report.c:252
 kasan_report_error mm/kasan/report.c:351
 kasan_report+0x23d/0x350 mm/kasan/report.c:409
 __asan_report_load8_noabort+0x19/0x20 mm/kasan/report.c:430
 snd_usb_mixer_interrupt+0x604/0x6f0 sound/usb/mixer.c:2490
 __usb_hcd_giveback_urb+0x2e0/0x650 drivers/usb/core/hcd.c:1779
 usb_hcd_giveback_urb+0x337/0x420 drivers/usb/core/hcd.c:1845
 dummy_timer+0xba9/0x39f0 drivers/usb/gadget/udc/dummy_hcd.c:1965
 call_timer_fn+0x2a2/0x940 kernel/time/timer.c:1281
 expire_timers kernel/time/timer.c:1320
 __run_timers+0x87f/0xd40 kernel/time/timer.c:1620
 run_timer_softirq+0x83/0x140 kernel/time/timer.c:1646
 __do_softirq+0x2ee/0xc0f kernel/softirq.c:284
 invoke_softirq kernel/softirq.c:364
 irq_exit+0x171/0x1a0 kernel/softirq.c:405
 exiting_irq ./arch/x86/include/asm/apic.h:638
 smp_apic_timer_interrupt+0x2b9/0x8d0 arch/x86/kernel/apic/apic.c:1048
 apic_timer_interrupt+0x9d/0xb0
 </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 ./arch/x86/include/asm/irqflags.h:53
RSP: 0018:ffff88006bac7b90 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff10
RAX: dffffc0000000020 RBX: 1ffff1000d758f76 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88006baa3a64
RBP: ffff88006bac7b90 R08: ffffffff813d5301 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1000d758f82
R13: ffff88006bac7cd0 R14: ffffffff8881ecc8 R15: 0000000000000000
 arch_safe_halt ./arch/x86/include/asm/paravirt.h:93
 default_idle+0x127/0x690 arch/x86/kernel/process.c:341
 arch_cpu_idle+0xf/0x20 arch/x86/kernel/process.c:332
 default_idle_call+0x3b/0x60 kernel/sched/idle.c:98
 cpuidle_idle_call kernel/sched/idle.c:156
 do_idle+0x33a/0x410 kernel/sched/idle.c:246
 cpu_startup_entry+0x1d/0x20 kernel/sched/idle.c:351
 start_secondary+0x3de/0x500 arch/x86/kernel/smpboot.c:278
 secondary_startup_64+0xa5/0xa5 arch/x86/kernel/head_64.S:235

Allocated by task 1484:
 save_stack_trace+0x1b/0x20 arch/x86/kernel/stacktrace.c:59
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459
 kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
 kmem_cache_alloc_trace+0x11e/0x2d0 mm/slub.c:2772
 kmalloc ./include/linux/slab.h:493
 kzalloc ./include/linux/slab.h:666
 snd_usb_create_mixer+0x145/0x1010 sound/usb/mixer.c:2540
 create_standard_mixer_quirk+0x58/0x80 sound/usb/quirks.c:516
 snd_usb_create_quirk+0x92/0x100 sound/usb/quirks.c:560
 create_composite_quirk+0x1c4/0x3e0 sound/usb/quirks.c:59
 snd_usb_create_quirk+0x92/0x100 sound/usb/quirks.c:560
 usb_audio_probe+0x1040/0x2c10 sound/usb/card.c:618
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

Freed by task 1484:
 save_stack_trace+0x1b/0x20 arch/x86/kernel/stacktrace.c:59
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459
 kasan_slab_free+0x72/0xc0 mm/kasan/kasan.c:524
 slab_free_hook mm/slub.c:1390
 slab_free_freelist_hook mm/slub.c:1412
 slab_free mm/slub.c:2988
 kfree+0xf6/0x2f0 mm/slub.c:3919
 snd_usb_mixer_free+0x11a/0x160 sound/usb/mixer.c:2244
 snd_usb_mixer_dev_free+0x36/0x50 sound/usb/mixer.c:2250
 __snd_device_free+0x1ff/0x380 sound/core/device.c:91
 snd_device_free_all+0x8f/0xe0 sound/core/device.c:244
 snd_card_do_free sound/core/init.c:461
 release_card_device+0x47/0x170 sound/core/init.c:181
 device_release+0x13f/0x210 drivers/base/core.c:814
 kobject_cleanup lib/kobject.c:648
 kobject_release lib/kobject.c:677
 kref_put ./include/linux/kref.h:70
 kobject_put+0x145/0x240 lib/kobject.c:694
 put_device+0x25/0x30 drivers/base/core.c:1931
 snd_card_free_when_closed sound/core/init.c:489
 snd_card_free+0x156/0x220 sound/core/init.c:514
 usb_audio_probe+0x1e36/0x2c10 sound/usb/card.c:648
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

The buggy address belongs to the object at ffff8800636f8900
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 192-byte region [ffff8800636f8900, ffff8800636f89c0)
The buggy address belongs to the page:
page:ffffea00018dbe00 count:1 mapcount:0 mapping:          (null) index:0x0
flags: 0x100000000000100(slab)
raw: 0100000000000100 0000000000000000 0000000000000000 0000000180100010
raw: ffffea00018dbc00 0000000400000004 ffff88006c003380 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8800636f8800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8800636f8880: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff8800636f8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8800636f8980: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8800636f8a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
