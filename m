From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/sound/usx2y: WARNING in usb_stream_start
Date: Fri, 3 Nov 2017 15:44:59 +0100
Message-ID: <CAAeHK+xoNQv3wVyqEdNEuk2hKwyoUrJ+uHFMLJ7VJVJAAuWeAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Dave Jiang <dave.jiang@intel.com>, Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Markus Elfring <elfring@users.sourceforge.net>, Johan Hovold <johan@kernel.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

Hi!

I've got the following report while fuzzing the kernel with syzkaller.

On commit 3a99df9a3d14cd866b5516f8cba515a3bfd554ab (4.14-rc7+).

Looks like there's no check for the actual endpoint types.

usb 1-1: BOGUS urb xfer, pipe 0 != type 3
------------[ cut here ]------------
WARNING: CPU: 0 PID: 24 at drivers/usb/core/urb.c:471
usb_submit_urb+0x113e/0x1400
Modules linked in:
CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted
4.14.0-rc7-44290-gf28444df2601-dirty #52
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
task: ffff88006bef5c00 task.stack: ffff88006bf60000
RIP: 0010:usb_submit_urb+0x113e/0x1400 drivers/usb/core/urb.c:470
RSP: 0018:ffff88006bf67440 EFLAGS: 00010286
RAX: 0000000000000029 RBX: ffff880064698c80 RCX: ffffffff812495b5
RDX: 0000000000000000 RSI: ffffffff8124d76a RDI: 0000000000000005
RBP: ffff88006bf674b0 R08: ffff88006bef5c00 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000003 R14: ffff880069a25a20 R15: ffff880064698d04
FS:  0000000000000000(0000) GS:ffff88006ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe6fdba3000 CR3: 0000000068470000 CR4: 00000000000006f0
Call Trace:
 usb_stream_start+0x48a/0x9f0 sound/usb/usx2y/usb_stream.c:690
 us122l_start+0x116/0x290 sound/usb/usx2y/us122l.c:365
 us122l_create_card sound/usb/usx2y/us122l.c:502
 us122l_usb_probe sound/usb/usx2y/us122l.c:588
 snd_us122l_probe+0x7de/0x10a0 sound/usb/usx2y/us122l.c:623
 usb_probe_interface+0x324/0x940 drivers/usb/core/driver.c:361
 really_probe drivers/base/dd.c:413
 driver_probe_device+0x522/0x740 drivers/base/dd.c:557
 __device_attach_driver+0x25d/0x2d0 drivers/base/dd.c:653
 bus_for_each_drv+0xff/0x160 drivers/base/bus.c:463
 __device_attach+0x1a8/0x2a0 drivers/base/dd.c:710
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
 bus_probe_device+0x1fc/0x2a0 drivers/base/bus.c:523
 device_add+0xc27/0x15a0 drivers/base/core.c:1835
 usb_set_configuration+0xd4f/0x17a0 drivers/usb/core/message.c:1932
 generic_probe+0xbb/0x120 drivers/usb/core/generic.c:174
 usb_probe_device+0xab/0x100 drivers/usb/core/driver.c:266
 really_probe drivers/base/dd.c:413
 driver_probe_device+0x522/0x740 drivers/base/dd.c:557
 __device_attach_driver+0x25d/0x2d0 drivers/base/dd.c:653
 bus_for_each_drv+0xff/0x160 drivers/base/bus.c:463
 __device_attach+0x1a8/0x2a0 drivers/base/dd.c:710
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
 bus_probe_device+0x1fc/0x2a0 drivers/base/bus.c:523
 device_add+0xc27/0x15a0 drivers/base/core.c:1835
 usb_new_device+0x7fa/0x1090 drivers/usb/core/hub.c:2538
 hub_port_connect drivers/usb/core/hub.c:4987
 hub_port_connect_change drivers/usb/core/hub.c:5093
 port_event drivers/usb/core/hub.c:5199
 hub_event_impl+0x17b8/0x3440 drivers/usb/core/hub.c:5311
 hub_event+0x38/0x50 drivers/usb/core/hub.c:5209
 process_one_work+0x925/0x15d0 kernel/workqueue.c:2113
 worker_thread+0xef/0x10d0 kernel/workqueue.c:2247
 kthread+0x346/0x410 kernel/kthread.c:231
 ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431
Code: 75 aa fd 48 8b 45 d0 48 8d b8 98 00 00 00 e8 4a cf f4 fe 45 89
e8 44 89 e1 4c 89 f2 48 89 c6 48 c7 c7 10 62 20 86 e8 8c 3e 99 fd <0f>
ff e9 ce f4 ff ff e8 c6 75 aa fd 48 8b 45 d0 48 8d b8 e8 00
---[ end trace bcf7836f85bb5e85 ]---
