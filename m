From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/sound/line6: trying to register non-static key
	in podhd_disconnect
Date: Mon, 9 Oct 2017 16:11:00 +0200
Message-ID: <CAAeHK+wvT7XBr0emhK9rf7OsvH-j55DrpFwRYc3KJtgpW=+hjg@mail.gmail.com>
References: <CAAeHK+xtqQRSmDa8ycdYGQrQ0zXBrTrwGVanWgQw7Z+Utc7csQ@mail.gmail.com>
 <s5hpoa4vfu1.wl-tiwai@suse.de>
 <CAAeHK+ywu8dA5CvdhPP7FTGNxwC9rPjJ_-o0fRRXtKzYnGx6PA@mail.gmail.com>
 <s5hbmlg4i4h.wl-tiwai@suse.de>
 <CAAeHK+ynE5ndXEDZO_Hp4OY-99yPFsJ6Ty0xCpkezhU9jDrsiw@mail.gmail.com>
 <s5h7ew44gtz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 by alsa0.perex.cz (Postfix) with ESMTP id CBA02267227
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 16:11:02 +0200 (CEST)
Received: by mail-oi0-f54.google.com with SMTP id j126so16390241oib.8
 for <alsa-devel@alsa-project.org>; Mon, 09 Oct 2017 07:11:02 -0700 (PDT)
In-Reply-To: <s5h7ew44gtz.wl-tiwai@suse.de>
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

On Mon, Oct 9, 2017 at 2:59 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 09 Oct 2017 14:39:44 +0200,
> Andrey Konovalov wrote:
>>
>> On Mon, Oct 9, 2017 at 2:31 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Mon, 09 Oct 2017 12:58:59 +0200,
>> > Andrey Konovalov wrote:
>> >>
>> >> On Tue, Oct 3, 2017 at 9:41 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> > On Mon, 25 Sep 2017 14:40:08 +0200,
>> >> > Andrey Konovalov wrote:
>> >> >>
>> >> >> Hi!
>> >> >>
>> >> >> I've got the following report while fuzzing the kernel with syzkaller.
>> >> >>
>> >> >> On commit e19b205be43d11bff638cad4487008c48d21c103 (4.14-rc2).
>> >> >>
>> >> >> INFO: trying to register non-static key.
>> >> >> the code is fine but needs lockdep annotation.
>> >> >> turning off the locking correctness validator.
>> >> >> CPU: 1 PID: 1845 Comm: kworker/1:2 Not tainted
>> >> >> 4.14.0-rc2-42613-g1488251d1a98 #238
>> >> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>> >> >> Workqueue: usb_hub_wq hub_event
>> >> >> Call Trace:
>> >> >>  __dump_stack lib/dump_stack.c:16
>> >> >>  dump_stack+0x292/0x395 lib/dump_stack.c:52
>> >> >>  register_lock_class+0x6c4/0x1a00 kernel/locking/lockdep.c:769
>> >> >>  __lock_acquire+0x27e/0x4550 kernel/locking/lockdep.c:3385
>> >> >>  lock_acquire+0x259/0x620 kernel/locking/lockdep.c:4002
>> >> >>  del_timer_sync+0x12c/0x280 kernel/time/timer.c:1237
>> >> >>  podhd_disconnect+0x8c/0x160 sound/usb/line6/podhd.c:299
>> >> >>  line6_probe+0x844/0x1310 sound/usb/line6/driver.c:783
>> >> >>  podhd_probe+0x64/0x70 sound/usb/line6/podhd.c:474
>> >> >>  usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
>> >> >>  really_probe drivers/base/dd.c:413
>> >> >>  driver_probe_device+0x610/0xa00 drivers/base/dd.c:557
>> >> >>  __device_attach_driver+0x230/0x290 drivers/base/dd.c:653
>> >> >>  bus_for_each_drv+0x161/0x210 drivers/base/bus.c:463
>> >> >>  __device_attach+0x26e/0x3d0 drivers/base/dd.c:710
>> >> >>  device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
>> >> >>  bus_probe_device+0x1eb/0x290 drivers/base/bus.c:523
>> >> >>  device_add+0xd0b/0x1660 drivers/base/core.c:1835
>> >> >>  usb_set_configuration+0x104e/0x1870 drivers/usb/core/message.c:1932
>> >> >>  generic_probe+0x73/0xe0 drivers/usb/core/generic.c:174
>> >> >>  usb_probe_device+0xaf/0xe0 drivers/usb/core/driver.c:266
>> >> >>  really_probe drivers/base/dd.c:413
>> >> >>  driver_probe_device+0x610/0xa00 drivers/base/dd.c:557
>> >> >>  __device_attach_driver+0x230/0x290 drivers/base/dd.c:653
>> >> >>  bus_for_each_drv+0x161/0x210 drivers/base/bus.c:463
>> >> >>  __device_attach+0x26e/0x3d0 drivers/base/dd.c:710
>> >> >>  device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
>> >> >>  bus_probe_device+0x1eb/0x290 drivers/base/bus.c:523
>> >> >>  device_add+0xd0b/0x1660 drivers/base/core.c:1835
>> >> >>  usb_new_device+0x7b8/0x1020 drivers/usb/core/hub.c:2457
>> >> >>  hub_port_connect drivers/usb/core/hub.c:4903
>> >> >>  hub_port_connect_change drivers/usb/core/hub.c:5009
>> >> >>  port_event drivers/usb/core/hub.c:5115
>> >> >>  hub_event+0x194d/0x3740 drivers/usb/core/hub.c:5195
>> >> >>  process_one_work+0xc7f/0x1db0 kernel/workqueue.c:2119
>> >> >>  worker_thread+0x221/0x1850 kernel/workqueue.c:2253
>> >> >>  kthread+0x3a1/0x470 kernel/kthread.c:231
>> >> >>  ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431
>> >> >
>> >> > This looks like an access to the uninitialized timer object.
>> >> > Could you check the patch below whether it fixes the issue?
>> >> > Thanks!
>> >> >
>> >> >
>> >> > Takashi
>> >>
>> >> Hi Takashi,
>> >>
>> >> I've applied your patch and now get GPF on
>> >> usb_driver_release_interface(&podhd_driver, intf):
>> >
>> > Another day, another Oops...  The patch below should cover it.
>> > I'm going to queue both now.
>>
>> With these two patches I get:
>>
>> kasan: CONFIG_KASAN_INLINE enabled
>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>> general protection fault: 0000 [#1] PREEMPT SMP KASAN
>> Modules linked in:
>> CPU: 1 PID: 0 Comm: swapper/1 Not tainted
>> 4.14.0-rc4-43414-g3c9155515146-dirty #372
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>> task: ffff88006baa3180 task.stack: ffff88006bac0000
>> RIP: 0010:usb_fill_bulk_urb ./include/linux/usb.h:1619
>> RIP: 0010:line6_start_listen+0x3fe/0x9e0 sound/usb/line6/driver.c:76
>
> Sight, is tonight a full-moon?
> This is another bug, an overlook in the error handling.
> The fix patch is below.

The 3 patches together fix the crash with my reproducer =)

Thanks a lot!

Tested-by: Andrey Konovalov <andreyknvl@google.com>

>
>
> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: line6: Fix leftover URB at error-path during probe
>
> While line6_probe() may kick off URB for a control MIDI endpoint, the
> function doesn't clean up it properly at its error path.  This results
> in a leftover URB action that is eventually triggered later and causes
> an Oops like:
>   general protection fault: 0000 [#1] PREEMPT SMP KASAN
>   CPU: 1 PID: 0 Comm: swapper/1 Not tainted
>   RIP: 0010:usb_fill_bulk_urb ./include/linux/usb.h:1619
>   RIP: 0010:line6_start_listen+0x3fe/0x9e0 sound/usb/line6/driver.c:76
>   Call Trace:
>    <IRQ>
>    line6_data_received+0x1f7/0x470 sound/usb/line6/driver.c:326
>    __usb_hcd_giveback_urb+0x2e0/0x650 drivers/usb/core/hcd.c:1779
>    usb_hcd_giveback_urb+0x337/0x420 drivers/usb/core/hcd.c:1845
>    dummy_timer+0xba9/0x39f0 drivers/usb/gadget/udc/dummy_hcd.c:1965
>    call_timer_fn+0x2a2/0x940 kernel/time/timer.c:1281
>    ....
>
> Since the whole clean-up procedure is done in line6_disconnect()
> callback, we can simply call it in the error path instead of
> open-coding the whole again.  It'll fix such an issue automagically.
>
> The bug was spotted by syzkaller.
>
> Fixes: eedd0e95d355 ("ALSA: line6: Don't forget to call driver's destructor at error path")
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/line6/driver.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
> index 0ff5a7d2e19f..c8f723c3a033 100644
> --- a/sound/usb/line6/driver.c
> +++ b/sound/usb/line6/driver.c
> @@ -779,9 +779,10 @@ int line6_probe(struct usb_interface *interface,
>         return 0;
>
>   error:
> -       if (line6->disconnect)
> -               line6->disconnect(line6);
> -       snd_card_free(card);
> +       /* we can call disconnect callback here because no close-sync is
> +        * needed yet at this point
> +        */
> +       line6_disconnect(interface);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(line6_probe);
> --
> 2.14.2
>
>
