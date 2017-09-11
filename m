From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/midi: use-after-free in snd_rawmidi_dev_seq_free
Date: Mon, 11 Sep 2017 13:17:39 +0200
Message-ID: <CAAeHK+yXrm5MnkodE1GNj4EKr=ydq2T8kr5SKPB_fnYBO7fh9w@mail.gmail.com>
References: <CAAeHK+ygnu48z2JcmtCOvSUTFQFNqEvavj+UGo2wkG67i3u9rQ@mail.gmail.com>
 <s5hzia9ku1g.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hzia9ku1g.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Ingo Molnar <mingo@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Fabian Frederick <fabf@skynet.be>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 5, 2017 at 6:08 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 05 Sep 2017 13:12:14 +0200,
> Andrey Konovalov wrote:
>>
>> Hi!
>>
>> While working on adding USB fuzzing support to syzkaller, I got the
>> following crash.
>>
>> On commit 81a84ad3cb5711cec79f4dd53a4ce026b092c432 (4.13+).
>>
>> My .config is attached. I don't have a reproducer for this bug.
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in snd_rawmidi_dev_seq_free+0x69/0x70
>> sound/core/rawmidi.c:1617
>> Write of size 8 at addr ffff88006c611d90 by task kworker/2:1/567
>>
>> CPU: 2 PID: 567 Comm: kworker/2:1 Not tainted 4.13.0+ #29
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>> Workqueue: events autoload_drivers
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:16 [inline]
>>  dump_stack+0x192/0x22c lib/dump_stack.c:52
>>  print_address_description+0x78/0x280 mm/kasan/report.c:252
>>  kasan_report_error mm/kasan/report.c:351 [inline]
>>  kasan_report+0x230/0x340 mm/kasan/report.c:409
>>  __asan_report_store8_noabort+0x1c/0x20 mm/kasan/report.c:435
>>  snd_rawmidi_dev_seq_free+0x69/0x70 sound/core/rawmidi.c:1617
>>  snd_seq_dev_release+0x4f/0x70 sound/core/seq_device.c:192
>>  device_release+0x13f/0x210 drivers/base/core.c:814
>>  kobject_cleanup lib/kobject.c:648 [inline]
>>  kobject_release lib/kobject.c:677 [inline]
>>  kref_put include/linux/kref.h:70 [inline]
>>  kobject_put+0x145/0x240 lib/kobject.c:694
>>  put_device+0x25/0x30 drivers/base/core.c:1799
>>  klist_devices_put+0x36/0x40 drivers/base/bus.c:827
>>  klist_next+0x264/0x4a0 lib/klist.c:403
>>  next_device drivers/base/bus.c:270 [inline]
>>  bus_for_each_dev+0x17e/0x210 drivers/base/bus.c:312
>>  autoload_drivers+0x3b/0x50 sound/core/seq_device.c:117
>>  process_one_work+0x9fb/0x1570 kernel/workqueue.c:2097
>>  worker_thread+0x1e4/0x1350 kernel/workqueue.c:2231
>>  kthread+0x324/0x3f0 kernel/kthread.c:231
>>  ret_from_fork+0x25/0x30 arch/x86/entry/entry_64.S:425
>
> So this looks like a pending work triggering the issue when performed
> during the card free.  What about the patch below as a quick band-aid
> fix?
>
>
> thanks,
>
> Takashi

Hi Takashi,

I've been running syzkaller with your patch for a few days and didn't
see any more of those reports.

Tested-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!

>
> ---
> diff --git a/sound/core/seq_device.c b/sound/core/seq_device.c
> --- a/sound/core/seq_device.c
> +++ b/sound/core/seq_device.c
> @@ -148,8 +148,10 @@ void snd_seq_device_load_drivers(void)
>         flush_work(&autoload_work);
>  }
>  EXPORT_SYMBOL(snd_seq_device_load_drivers);
> +#define cancel_autoload_drivers()      cancel_work_sync(&autoload_work)
>  #else
>  #define queue_autoload_drivers() /* NOP */
> +#define cancel_autoload_drivers() /* NOP */
>  #endif
>
>  /*
> @@ -159,6 +161,7 @@ static int snd_seq_device_dev_free(struct snd_device *device)
>  {
>         struct snd_seq_device *dev = device->device_data;
>
> +       cancel_autoload_drivers();
>         put_device(&dev->dev);
>         return 0;
>  }
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
