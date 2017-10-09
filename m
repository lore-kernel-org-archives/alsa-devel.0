From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/sound/line6: trying to register non-static key
	in podhd_disconnect
Date: Mon, 9 Oct 2017 14:39:44 +0200
Message-ID: <CAAeHK+ynE5ndXEDZO_Hp4OY-99yPFsJ6Ty0xCpkezhU9jDrsiw@mail.gmail.com>
References: <CAAeHK+xtqQRSmDa8ycdYGQrQ0zXBrTrwGVanWgQw7Z+Utc7csQ@mail.gmail.com>
 <s5hpoa4vfu1.wl-tiwai@suse.de>
 <CAAeHK+ywu8dA5CvdhPP7FTGNxwC9rPjJ_-o0fRRXtKzYnGx6PA@mail.gmail.com>
 <s5hbmlg4i4h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A4022670BC
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 14:39:45 +0200 (CEST)
Received: by mail-oi0-f44.google.com with SMTP id j126so39542620oia.10
 for <alsa-devel@alsa-project.org>; Mon, 09 Oct 2017 05:39:45 -0700 (PDT)
In-Reply-To: <s5hbmlg4i4h.wl-tiwai@suse.de>
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

On Mon, Oct 9, 2017 at 2:31 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 09 Oct 2017 12:58:59 +0200,
> Andrey Konovalov wrote:
>>
>> On Tue, Oct 3, 2017 at 9:41 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Mon, 25 Sep 2017 14:40:08 +0200,
>> > Andrey Konovalov wrote:
>> >>
>> >> Hi!
>> >>
>> >> I've got the following report while fuzzing the kernel with syzkaller.
>> >>
>> >> On commit e19b205be43d11bff638cad4487008c48d21c103 (4.14-rc2).
>> >>
>> >> INFO: trying to register non-static key.
>> >> the code is fine but needs lockdep annotation.
>> >> turning off the locking correctness validator.
>> >> CPU: 1 PID: 1845 Comm: kworker/1:2 Not tainted
>> >> 4.14.0-rc2-42613-g1488251d1a98 #238
>> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>> >> Workqueue: usb_hub_wq hub_event
>> >> Call Trace:
>> >>  __dump_stack lib/dump_stack.c:16
>> >>  dump_stack+0x292/0x395 lib/dump_stack.c:52
>> >>  register_lock_class+0x6c4/0x1a00 kernel/locking/lockdep.c:769
>> >>  __lock_acquire+0x27e/0x4550 kernel/locking/lockdep.c:3385
>> >>  lock_acquire+0x259/0x620 kernel/locking/lockdep.c:4002
>> >>  del_timer_sync+0x12c/0x280 kernel/time/timer.c:1237
>> >>  podhd_disconnect+0x8c/0x160 sound/usb/line6/podhd.c:299
>> >>  line6_probe+0x844/0x1310 sound/usb/line6/driver.c:783
>> >>  podhd_probe+0x64/0x70 sound/usb/line6/podhd.c:474
>> >>  usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
>> >>  really_probe drivers/base/dd.c:413
>> >>  driver_probe_device+0x610/0xa00 drivers/base/dd.c:557
>> >>  __device_attach_driver+0x230/0x290 drivers/base/dd.c:653
>> >>  bus_for_each_drv+0x161/0x210 drivers/base/bus.c:463
>> >>  __device_attach+0x26e/0x3d0 drivers/base/dd.c:710
>> >>  device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
>> >>  bus_probe_device+0x1eb/0x290 drivers/base/bus.c:523
>> >>  device_add+0xd0b/0x1660 drivers/base/core.c:1835
>> >>  usb_set_configuration+0x104e/0x1870 drivers/usb/core/message.c:1932
>> >>  generic_probe+0x73/0xe0 drivers/usb/core/generic.c:174
>> >>  usb_probe_device+0xaf/0xe0 drivers/usb/core/driver.c:266
>> >>  really_probe drivers/base/dd.c:413
>> >>  driver_probe_device+0x610/0xa00 drivers/base/dd.c:557
>> >>  __device_attach_driver+0x230/0x290 drivers/base/dd.c:653
>> >>  bus_for_each_drv+0x161/0x210 drivers/base/bus.c:463
>> >>  __device_attach+0x26e/0x3d0 drivers/base/dd.c:710
>> >>  device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
>> >>  bus_probe_device+0x1eb/0x290 drivers/base/bus.c:523
>> >>  device_add+0xd0b/0x1660 drivers/base/core.c:1835
>> >>  usb_new_device+0x7b8/0x1020 drivers/usb/core/hub.c:2457
>> >>  hub_port_connect drivers/usb/core/hub.c:4903
>> >>  hub_port_connect_change drivers/usb/core/hub.c:5009
>> >>  port_event drivers/usb/core/hub.c:5115
>> >>  hub_event+0x194d/0x3740 drivers/usb/core/hub.c:5195
>> >>  process_one_work+0xc7f/0x1db0 kernel/workqueue.c:2119
>> >>  worker_thread+0x221/0x1850 kernel/workqueue.c:2253
>> >>  kthread+0x3a1/0x470 kernel/kthread.c:231
>> >>  ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431
>> >
>> > This looks like an access to the uninitialized timer object.
>> > Could you check the patch below whether it fixes the issue?
>> > Thanks!
>> >
>> >
>> > Takashi
>>
>> Hi Takashi,
>>
>> I've applied your patch and now get GPF on
>> usb_driver_release_interface(&podhd_driver, intf):
>
> Another day, another Oops...  The patch below should cover it.
> I'm going to queue both now.

With these two patches I get:

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted
4.14.0-rc4-43414-g3c9155515146-dirty #372
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
task: ffff88006baa3180 task.stack: ffff88006bac0000
RIP: 0010:usb_fill_bulk_urb ./include/linux/usb.h:1619
RIP: 0010:line6_start_listen+0x3fe/0x9e0 sound/usb/line6/driver.c:76
RSP: 0018:ffff88006c506548 EFLAGS: 00010006
RAX: ffff88006baa3180 RBX: 1ffff1000d8a0cae RCX: ffff880063b10880
RDX: 0000000000000100 RSI: dffffc0000000000 RDI: 0000000000000048
RBP: ffff88006c5066b8 R08: 0000000000000009 R09: 0000000000000000
R10: ffff88006baa3180 R11: 0000000000000001 R12: 00000000c0408080
R13: 00000000c0408280 R14: 0000000000000000 R15: ffff88006ad10d70
FS:  0000000000000000(0000) GS:ffff88006c500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fda4a208000 CR3: 00000000696a5000 CR4: 00000000000006e0
Call Trace:
 <IRQ>
 line6_data_received+0x1f7/0x470 sound/usb/line6/driver.c:326
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
Code: 41 81 cc 80 00 00 c0 e8 b1 f4 cc fb 49 8d 7e 48 45 09 e5 48 be
00 00 00 00 00 fc ff df 49 89 f8 48 8b 8d a0 fe ff ff 49 c1 e8 03 <41>
80 3c 30 00 0f 85 81 03 00 00 49 8d 7e 58 49 89 4e 48 48 b9
RIP: line6_start_listen+0x3fe/0x9e0 RSP: ffff88006c506548
---[ end trace 70d8818506ef6697 ]---

>
>
> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: line6: Fix NULL dereference at podhd_disconnect()
>
> When podhd_init() failed with the acquiring a ctrl i/f, the line6
> helper still calls the disconnect callback that eventually calls again
> usb_driver_release_interface() with the NULL intf.
>
> Put the proper NULL check before calling it for avoiding an Oops.
>
> Fixes: fc90172ba283 ("ALSA: line6: Claim pod x3 usb data interface")
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/line6/podhd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
> index 956f847a96e4..cfcd80092a54 100644
> --- a/sound/usb/line6/podhd.c
> +++ b/sound/usb/line6/podhd.c
> @@ -301,7 +301,8 @@ static void podhd_disconnect(struct usb_line6 *line6)
>
>                 intf = usb_ifnum_to_if(line6->usbdev,
>                                         pod->line6.properties->ctrl_if);
> -               usb_driver_release_interface(&podhd_driver, intf);
> +               if (intf)
> +                       usb_driver_release_interface(&podhd_driver, intf);
>         }
>  }
>
> --
> 2.14.2
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
