From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/sound/usx2y: warning in usb_stream_new/__alloc_pages_slowpath
Date: Thu, 21 Sep 2017 17:38:53 +0200
Message-ID: <CAAeHK+x4EKXVmeiRK1ih+DfWKG9Q1Ver8z=r26sTWQAepESvFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Markus Elfring <elfring@users.sourceforge.net>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

Hi!

I've got the following report while fuzzing the kernel with syzkaller.

On commit ebb2c2437d8008d46796902ff390653822af6cc4 (Sep 18).

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1846 at mm/page_alloc.c:3883
__alloc_pages_slowpath+0x1ef2/0x2d70
Modules linked in:
CPU: 1 PID: 1846 Comm: kworker/1:2 Not tainted
4.14.0-rc1-42251-gebb2c2437d80 #215
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
task: ffff8800643c18c0 task.stack: ffff88006b658000
RIP: 0010:trace_reclaim_retry_zone ./include/trace/events/oom.h:31
RIP: 0010:should_reclaim_retry mm/page_alloc.c:3783
RIP: 0010:__alloc_pages_slowpath+0x1ef2/0x2d70 mm/page_alloc.c:4039
RSP: 0018:ffff88006b65d938 EFLAGS: 00010246
RAX: 00000000ffffa666 RBX: 00000000014000c0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000034 RDI: 000000000140c0c0
RBP: ffff88006b65e088 R08: 0000000000000000 R09: fffffffffff00f88
R10: 0000000000000000 R11: 0000000000000085 R12: ffff88006b65e130
R13: ffff88006b65e270 R14: ffff88006b65e0f0 R15: 000000000140c0c0
FS:  0000000000000000(0000) GS:ffff88006c900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020829000 CR3: 0000000063cce000 CR4: 00000000000006e0
Call Trace:
 __alloc_pages_nodemask+0x921/0xf70 mm/page_alloc.c:4217
 alloc_pages_current+0xbb/0x1f0 mm/mempolicy.c:2035
 alloc_pages ./include/linux/gfp.h:505
 __get_free_pages+0x14/0x50 mm/page_alloc.c:4248
 usb_stream_new+0x50f/0x9f0 sound/usb/usx2y/usb_stream.c:214
 us122l_start+0xb0/0x250 sound/usb/usx2y/us122l.c:355
 us122l_create_card sound/usb/usx2y/us122l.c:502
 us122l_usb_probe sound/usb/usx2y/us122l.c:588
 snd_us122l_probe+0xa62/0x15d0 sound/usb/usx2y/us122l.c:623
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
Code: be 47 00 00 00 48 c7 c7 20 42 8b 85 c6 05 5e 35 99 05 01 e8 91
1f cb ff 48 8b 8d d8 f8 ff ff 44 8b 9d 50 f9 ff ff e9 57 fc ff ff <0f>
ff e9 79 e3 ff ff 0f ff c7 85 e8 f8 ff ff 00 00 00 00 89 d8
---[ end trace 78800971cbd5f94f ]---
