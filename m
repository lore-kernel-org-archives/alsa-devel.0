From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/sound/line6: trying to register non-static key
	in podhd_disconnect
Date: Mon, 9 Oct 2017 12:58:59 +0200
Message-ID: <CAAeHK+ywu8dA5CvdhPP7FTGNxwC9rPjJ_-o0fRRXtKzYnGx6PA@mail.gmail.com>
References: <CAAeHK+xtqQRSmDa8ycdYGQrQ0zXBrTrwGVanWgQw7Z+Utc7csQ@mail.gmail.com>
 <s5hpoa4vfu1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 44FE9266B38
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 12:59:00 +0200 (CEST)
Received: by mail-oi0-f52.google.com with SMTP id w197so34449190oif.6
 for <alsa-devel@alsa-project.org>; Mon, 09 Oct 2017 03:59:00 -0700 (PDT)
In-Reply-To: <s5hpoa4vfu1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andrej Krutak <dev@andree.sk>, LKML <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, =?UTF-8?Q?Hans_P=2E_M=C3=B6ller_Ebner?= <hmoller@uc.cl>, Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 3, 2017 at 9:41 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 25 Sep 2017 14:40:08 +0200,
> Andrey Konovalov wrote:
>>
>> Hi!
>>
>> I've got the following report while fuzzing the kernel with syzkaller.
>>
>> On commit e19b205be43d11bff638cad4487008c48d21c103 (4.14-rc2).
>>
>> INFO: trying to register non-static key.
>> the code is fine but needs lockdep annotation.
>> turning off the locking correctness validator.
>> CPU: 1 PID: 1845 Comm: kworker/1:2 Not tainted
>> 4.14.0-rc2-42613-g1488251d1a98 #238
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>> Workqueue: usb_hub_wq hub_event
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:16
>>  dump_stack+0x292/0x395 lib/dump_stack.c:52
>>  register_lock_class+0x6c4/0x1a00 kernel/locking/lockdep.c:769
>>  __lock_acquire+0x27e/0x4550 kernel/locking/lockdep.c:3385
>>  lock_acquire+0x259/0x620 kernel/locking/lockdep.c:4002
>>  del_timer_sync+0x12c/0x280 kernel/time/timer.c:1237
>>  podhd_disconnect+0x8c/0x160 sound/usb/line6/podhd.c:299
>>  line6_probe+0x844/0x1310 sound/usb/line6/driver.c:783
>>  podhd_probe+0x64/0x70 sound/usb/line6/podhd.c:474
>>  usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
>>  really_probe drivers/base/dd.c:413
>>  driver_probe_device+0x610/0xa00 drivers/base/dd.c:557
>>  __device_attach_driver+0x230/0x290 drivers/base/dd.c:653
>>  bus_for_each_drv+0x161/0x210 drivers/base/bus.c:463
>>  __device_attach+0x26e/0x3d0 drivers/base/dd.c:710
>>  device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
>>  bus_probe_device+0x1eb/0x290 drivers/base/bus.c:523
>>  device_add+0xd0b/0x1660 drivers/base/core.c:1835
>>  usb_set_configuration+0x104e/0x1870 drivers/usb/core/message.c:1932
>>  generic_probe+0x73/0xe0 drivers/usb/core/generic.c:174
>>  usb_probe_device+0xaf/0xe0 drivers/usb/core/driver.c:266
>>  really_probe drivers/base/dd.c:413
>>  driver_probe_device+0x610/0xa00 drivers/base/dd.c:557
>>  __device_attach_driver+0x230/0x290 drivers/base/dd.c:653
>>  bus_for_each_drv+0x161/0x210 drivers/base/bus.c:463
>>  __device_attach+0x26e/0x3d0 drivers/base/dd.c:710
>>  device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
>>  bus_probe_device+0x1eb/0x290 drivers/base/bus.c:523
>>  device_add+0xd0b/0x1660 drivers/base/core.c:1835
>>  usb_new_device+0x7b8/0x1020 drivers/usb/core/hub.c:2457
>>  hub_port_connect drivers/usb/core/hub.c:4903
>>  hub_port_connect_change drivers/usb/core/hub.c:5009
>>  port_event drivers/usb/core/hub.c:5115
>>  hub_event+0x194d/0x3740 drivers/usb/core/hub.c:5195
>>  process_one_work+0xc7f/0x1db0 kernel/workqueue.c:2119
>>  worker_thread+0x221/0x1850 kernel/workqueue.c:2253
>>  kthread+0x3a1/0x470 kernel/kthread.c:231
>>  ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431
>
> This looks like an access to the uninitialized timer object.
> Could you check the patch below whether it fixes the issue?
> Thanks!
>
>
> Takashi

Hi Takashi,

I've applied your patch and now get GPF on
usb_driver_release_interface(&podhd_driver, intf):

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
Modules linked in:
CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted
4.14.0-rc3-42950-gf85437cba47c-dirty #367
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
task: ffff88006bb36300 task.stack: ffff88006bbb0000
RIP: 0010:usb_driver_release_interface+0x33/0x170 drivers/usb/core/driver.c:592
RSP: 0018:ffff88006bbb6448 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000025 RSI: 0000000000000000 RDI: ffffffff886cd140
RBP: ffff88006bbb6468 R08: 1ffff1000d776b66 R09: ffffed000d776bd9
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff886cd140
R13: ffff880060a04d78 R14: 0000000000000128 R15: ffff880066889a18
FS:  0000000000000000(0000) GS:ffff88006c400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001de1010 CR3: 00000000620fe000 CR4: 00000000000006f0
Call Trace:
 podhd_disconnect+0x10c/0x160 sound/usb/line6/podhd.c:304
 line6_probe+0x844/0x1310 sound/usb/line6/driver.c:783
 podhd_probe+0x64/0x70 sound/usb/line6/podhd.c:475
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
Code: e5 41 56 41 55 41 54 49 89 fc 53 48 89 f3 e8 d5 56 2c fd 4c 8d
b3 28 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80>
3c 02 00 0f 85 19 01 00 00 4c 8b ab 28 01 00 00 4d 85 ed 74
RIP: usb_driver_release_interface+0x33/0x170 RSP: ffff88006bbb6448
---[ end trace 3a12ec7f36acba6f ]---


>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: line6: Fix missing initialization before error path
>
> The error path in podhd_init() tries to clear the pending timer, while
> the timer object is initialized at the end of init sequence, thus it
> may hit the uninitialized object, as spotted by syzkaller:
>
>   INFO: trying to register non-static key.
>   the code is fine but needs lockdep annotation.
>   turning off the locking correctness validator.
>   CPU: 1 PID: 1845 Comm: kworker/1:2 Not tainted
>   4.14.0-rc2-42613-g1488251d1a98 #238
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>   Workqueue: usb_hub_wq hub_event
>   Call Trace:
>    __dump_stack lib/dump_stack.c:16
>    dump_stack+0x292/0x395 lib/dump_stack.c:52
>    register_lock_class+0x6c4/0x1a00 kernel/locking/lockdep.c:769
>    __lock_acquire+0x27e/0x4550 kernel/locking/lockdep.c:3385
>    lock_acquire+0x259/0x620 kernel/locking/lockdep.c:4002
>    del_timer_sync+0x12c/0x280 kernel/time/timer.c:1237
>    podhd_disconnect+0x8c/0x160 sound/usb/line6/podhd.c:299
>    line6_probe+0x844/0x1310 sound/usb/line6/driver.c:783
>    podhd_probe+0x64/0x70 sound/usb/line6/podhd.c:474
>    ....
>
> For addressing it, assure the initializations of timer and work by
> moving them to the beginning of podhd_init().
>
> Fixes: 790869dacc3d ("ALSA: line6: Add support for POD X3")
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/line6/podhd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
> index 956f847a96e4..14ab82ea7e82 100644
> --- a/sound/usb/line6/podhd.c
> +++ b/sound/usb/line6/podhd.c
> @@ -317,6 +317,9 @@ static int podhd_init(struct usb_line6 *line6,
>
>         line6->disconnect = podhd_disconnect;
>
> +       init_timer(&pod->startup_timer);
> +       INIT_WORK(&pod->startup_work, podhd_startup_workqueue);
> +
>         if (pod->line6.properties->capabilities & LINE6_CAP_CONTROL) {
>                 /* claim the data interface */
>                 intf = usb_ifnum_to_if(line6->usbdev,
> @@ -358,8 +361,6 @@ static int podhd_init(struct usb_line6 *line6,
>         }
>
>         /* init device and delay registering */
> -       init_timer(&pod->startup_timer);
> -       INIT_WORK(&pod->startup_work, podhd_startup_workqueue);
>         podhd_startup(pod);
>         return 0;
>  }
> --
> 2.14.2
>
