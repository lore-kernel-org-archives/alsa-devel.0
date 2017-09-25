From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/sound/line6: warning in line6_start_listen/usb_submit_urb
Date: Mon, 25 Sep 2017 14:40:03 +0200
Message-ID: <CAAeHK+w9Ntxc0nMAQVcYci=o6y3OrB_MAFNPdHsjoTxMoT8pkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Dan Carpenter <dan.carpenter@oracle.com>, Andrej Krutak <dev@andree.sk>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

Hi!

I've got the following report while fuzzing the kernel with syzkaller.

On commit e19b205be43d11bff638cad4487008c48d21c103 (4.14-rc2).

It seems there's no check on the actual endpoint type.

usb 1-1: BOGUS urb xfer, pipe 3 != type 1
------------[ cut here ]------------
WARNING: CPU: 0 PID: 24 at drivers/usb/core/urb.c:449
usb_submit_urb+0xf8a/0x11d0
Modules linked in:
CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted 4.14.0-rc2-42613-g1488251d1a98 #238
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
task: ffff88006befe300 task.stack: ffff88006bf78000
RIP: 0010:usb_submit_urb+0xf8a/0x11d0 drivers/usb/core/urb.c:448
RSP: 0018:ffff88006bf7e218 EFLAGS: 00010286
RAX: 0000000000000029 RBX: ffff88006a878200 RCX: 0000000000000000
RDX: 0000000000000029 RSI: ffffffff85876dc0 RDI: ffffed000d7efc35
RBP: ffff88006bf7e318 R08: 1ffff1000d7efadb R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000000 R12: 1ffff1000d7efc4a
R13: 0000000000000001 R14: 0000000000000003 R15: ffff88006902d7f8
FS:  0000000000000000(0000) GS:ffff88006c800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001904fa0 CR3: 0000000062019000 CR4: 00000000000006f0
Call Trace:
 line6_start_listen+0x55f/0x9e0 sound/usb/line6/driver.c:82
 line6_init_cap_control sound/usb/line6/driver.c:690
 line6_probe+0x7c9/0x1310 sound/usb/line6/driver.c:764
 podhd_probe+0x64/0x70 sound/usb/line6/podhd.c:474
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
Code: 48 8b 85 30 ff ff ff 48 8d b8 98 00 00 00 e8 6e 91 8b ff 45 89
e8 44 89 f1 4c 89 fa 48 89 c6 48 c7 c7 c0 5a c8 85 e8 10 50 dd fd <0f>
ff e9 9b f7 ff ff e8 ba cf 26 fe e9 80 f7 ff ff e8 a0 a5 f4
---[ end trace 29c2f0b769cf6f62 ]---
