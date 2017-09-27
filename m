From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/sound/caiaq: warning in init_card/usb_submit_urb
Date: Wed, 27 Sep 2017 16:35:59 +0200
Message-ID: <CAAeHK+xCQUqTJG278jRtUhYWE9Sku5bx56mUZaLK5HpGR1XOkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
 [209.85.218.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 676452671E3
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 16:36:01 +0200 (CEST)
Received: by mail-oi0-f47.google.com with SMTP id n82so11990949oib.8
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 07:36:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

Hi!

I've got the following report while fuzzing the kernel with syzkaller.

On commit e19b205be43d11bff638cad4487008c48d21c103 (4.14-rc2).

It seems that there's no check on the actual type of the endpoint.

usb 1-1: BOGUS urb xfer, pipe 3 != type 1
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1150 at drivers/usb/core/urb.c:449
usb_submit_urb+0xf8a/0x11d0
Modules linked in:
CPU: 1 PID: 1150 Comm: kworker/1:1 Not tainted
4.14.0-rc2-42660-g24b7bd59eec0 #277
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
task: ffff880069428000 task.stack: ffff880069440000
RIP: 0010:usb_submit_urb+0xf8a/0x11d0 drivers/usb/core/urb.c:448
RSP: 0018:ffff8800694462e8 EFLAGS: 00010282
RAX: 0000000000000029 RBX: ffff88006a570ef0 RCX: 0000000000000000
RDX: 0000000000000029 RSI: ffffffff85876dc0 RDI: ffffed000d288c4f
RBP: ffff8800694463e8 R08: 1ffff1000d288af5 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1000d288c64
R13: 0000000000000001 R14: 0000000000000003 R15: ffff8800697c4288
FS:  0000000000000000(0000) GS:ffff88006c900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007facf21b4000 CR3: 000000006a6d4000 CR4: 00000000000006e0
Call Trace:
 init_card sound/usb/caiaq/device.c:467
 snd_probe+0x81c/0x1150 sound/usb/caiaq/device.c:525
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
Code: 48 8b 85 30 ff ff ff 48 8d b8 98 00 00 00 e8 4e 92 8b ff 45 89
e8 44 89 f1 4c 89 fa 48 89 c6 48 c7 c7 c0 5a c8 85 e8 f0 4a dd fd <0f>
ff e9 9b f7 ff ff e8 da cb 26 fe e9 80 f7 ff ff e8 70 a1 f4
---[ end trace 1d323f93391df1ca ]---
