From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: deadlock snd_rawmidi_kernel_open/check_and_subscribe_port
Date: Tue, 30 Aug 2016 16:05:38 +0200
Message-ID: <CACT4Y+YpKKonYZ8T8_xg39cdEZOQWxdq2cc2JcAs4XK3EKapiQ@mail.gmail.com>
References: <CACT4Y+Ykrc8kh9D1kqtvTZOi8agBXNUW3uaW+Kfhyu5vuqat2g@mail.gmail.com>
 <CACT4Y+bmb_qO608oS-TD8dmYo4y8xK5mchXfFmgQU5hr+_1wEA@mail.gmail.com>
 <s5hbn0lgnvp.wl-tiwai@suse.de> <s5hbn0ajrjj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hbn0ajrjj.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 30, 2016 at 3:49 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 22 Aug 2016 11:21:30 +0200,
> Takashi Iwai wrote:
>>
>> On Mon, 22 Aug 2016 02:15:48 +0200,
>> Dmitry Vyukov wrote:
>> >
>> > On Sat, Aug 13, 2016 at 2:43 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> > > Hello,
>> > >
>> > > While running syzkaller fuzzer on
>> > > f31494bd05b06b0cdb4da6aebe92eaafab970df6 (Aug 12), I've got the
>> > > following deadlock report:
> (snip)
>> >
>> > Ping. Still happens on HEAD.
>>
>> Sorry, I've been on vacation in the last week.
>> I'll take a look once after digesting the whole backlogs...
>
> Could you try the patch below?


Incorporated into my tree. I will notify if I see this again.


> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: rawmidi: Fix possible deadlock with virmidi
>  registration
>
> When a seq-virmidi driver is initialized, it registers a rawmidi
> instance with its callback to create an associated seq kernel client.
> Currently it's done throughly in rawmidi's register_mutex context,
> this may lead to a deadlock another rawmidi device that is attached
> with the sequencer is accessed, since it also opens with the
> register_mutex.  This was actually triggered by syzkaller, as Dmitry
> Vyukov reported:
>
> ======================================================
>  [ INFO: possible circular locking dependency detected ]
>  4.8.0-rc1+ #11 Not tainted
>  -------------------------------------------------------
>  syz-executor/7154 is trying to acquire lock:
>   (register_mutex#5){+.+.+.}, at: [<ffffffff84fd6d4b>] snd_rawmidi_kernel_open+0x4b/0x260 sound/core/rawmidi.c:341
>
>  but task is already holding lock:
>   (&grp->list_mutex){++++.+}, at: [<ffffffff850138bb>] check_and_subscribe_port+0x5b/0x5c0 sound/core/seq/seq_ports.c:495
>
>  which lock already depends on the new lock.
>
>  the existing dependency chain (in reverse order) is:
>
>  -> #1 (&grp->list_mutex){++++.+}:
>     [<ffffffff8147a3a8>] lock_acquire+0x208/0x430 kernel/locking/lockdep.c:3746
>     [<ffffffff863f6199>] down_read+0x49/0xc0 kernel/locking/rwsem.c:22
>     [<     inline     >] deliver_to_subscribers sound/core/seq/seq_clientmgr.c:681
>     [<ffffffff85005c5e>] snd_seq_deliver_event+0x35e/0x890 sound/core/seq/seq_clientmgr.c:822
>     [<ffffffff85006e96>] > snd_seq_kernel_client_dispatch+0x126/0x170 sound/core/seq/seq_clientmgr.c:2418
>     [<ffffffff85012c52>] snd_seq_system_broadcast+0xb2/0xf0 sound/core/seq/seq_system.c:101
>     [<ffffffff84fff70a>] snd_seq_create_kernel_client+0x24a/0x330 sound/core/seq/seq_clientmgr.c:2297
>     [<     inline     >] snd_virmidi_dev_attach_seq sound/core/seq/seq_virmidi.c:383
>     [<ffffffff8502d29f>] snd_virmidi_dev_register+0x29f/0x750 sound/core/seq/seq_virmidi.c:450
>     [<ffffffff84fd208c>] snd_rawmidi_dev_register+0x30c/0xd40 sound/core/rawmidi.c:1645
>     [<ffffffff84f816d3>] __snd_device_register.part.0+0x63/0xc0 sound/core/device.c:164
>     [<     inline     >] __snd_device_register sound/core/device.c:162
>     [<ffffffff84f8235d>] snd_device_register_all+0xad/0x110 sound/core/device.c:212
>     [<ffffffff84f7546f>] snd_card_register+0xef/0x6c0 sound/core/init.c:749
>     [<ffffffff85040b7f>] snd_virmidi_probe+0x3ef/0x590 sound/drivers/virmidi.c:123
>     [<ffffffff833ebf7b>] platform_drv_probe+0x8b/0x170 drivers/base/platform.c:564
>     ......
>
>  -> #0 (register_mutex#5){+.+.+.}:
>     [<     inline     >] check_prev_add kernel/locking/lockdep.c:1829
>     [<     inline     >] check_prevs_add kernel/locking/lockdep.c:1939
>     [<     inline     >] validate_chain kernel/locking/lockdep.c:2266
>     [<ffffffff814791f4>] __lock_acquire+0x4d44/0x4d80 kernel/locking/lockdep.c:3335
>     [<ffffffff8147a3a8>] lock_acquire+0x208/0x430 kernel/locking/lockdep.c:3746
>     [<     inline     >] __mutex_lock_common kernel/locking/mutex.c:521
>     [<ffffffff863f0ef1>] mutex_lock_nested+0xb1/0xa20 kernel/locking/mutex.c:621
>     [<ffffffff84fd6d4b>] snd_rawmidi_kernel_open+0x4b/0x260 sound/core/rawmidi.c:341
>     [<ffffffff8502e7c7>] midisynth_subscribe+0xf7/0x350 sound/core/seq/seq_midi.c:188
>     [<     inline     >] subscribe_port sound/core/seq/seq_ports.c:427
>     [<ffffffff85013cc7>] check_and_subscribe_port+0x467/0x5c0 sound/core/seq/seq_ports.c:510
>     [<ffffffff85015da9>] snd_seq_port_connect+0x2c9/0x500 sound/core/seq/seq_ports.c:579
>     [<ffffffff850079b8>] snd_seq_ioctl_subscribe_port+0x1d8/0x2b0 sound/core/seq/seq_clientmgr.c:1480
>     [<ffffffff84ffe9e4>] snd_seq_do_ioctl+0x184/0x1e0 sound/core/seq/seq_clientmgr.c:2225
>     [<ffffffff84ffeae8>] snd_seq_kernel_client_ctl+0xa8/0x110 sound/core/seq/seq_clientmgr.c:2440
>     [<ffffffff85027664>] snd_seq_oss_midi_open+0x3b4/0x610 sound/core/seq/oss/seq_oss_midi.c:375
>     [<ffffffff85023d67>] snd_seq_oss_synth_setup_midi+0x107/0x4c0 sound/core/seq/oss/seq_oss_synth.c:281
>     [<ffffffff8501b0a8>] snd_seq_oss_open+0x748/0x8d0 sound/core/seq/oss/seq_oss_init.c:274
>     [<ffffffff85019d8a>] odev_open+0x6a/0x90 sound/core/seq/oss/seq_oss.c:138
>     [<ffffffff84f7040f>] soundcore_open+0x30f/0x640 sound/sound_core.c:639
>     ......
>
>  other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&grp->list_mutex);
>                                 lock(register_mutex#5);
>                                 lock(&grp->list_mutex);
>    lock(register_mutex#5);
>
>  *** DEADLOCK ***
> ======================================================
>
> The fix is to simply move the registration parts in
> snd_rawmidi_dev_register() to the outside of the register_mutex lock.
> The lock is needed only to manage the linked list, and it's not
> necessarily to cover the whole initialization process.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/rawmidi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
> index 795437b10082..b450a27588c8 100644
> --- a/sound/core/rawmidi.c
> +++ b/sound/core/rawmidi.c
> @@ -1633,11 +1633,13 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
>                 return -EBUSY;
>         }
>         list_add_tail(&rmidi->list, &snd_rawmidi_devices);
> +       mutex_unlock(&register_mutex);
>         err = snd_register_device(SNDRV_DEVICE_TYPE_RAWMIDI,
>                                   rmidi->card, rmidi->device,
>                                   &snd_rawmidi_f_ops, rmidi, &rmidi->dev);
>         if (err < 0) {
>                 rmidi_err(rmidi, "unable to register\n");
> +               mutex_lock(&register_mutex);
>                 list_del(&rmidi->list);
>                 mutex_unlock(&register_mutex);
>                 return err;
> @@ -1645,6 +1647,7 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
>         if (rmidi->ops && rmidi->ops->dev_register &&
>             (err = rmidi->ops->dev_register(rmidi)) < 0) {
>                 snd_unregister_device(&rmidi->dev);
> +               mutex_lock(&register_mutex);
>                 list_del(&rmidi->list);
>                 mutex_unlock(&register_mutex);
>                 return err;
> @@ -1677,7 +1680,6 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
>                 }
>         }
>  #endif /* CONFIG_SND_OSSEMUL */
> -       mutex_unlock(&register_mutex);
>         sprintf(name, "midi%d", rmidi->device);
>         entry = snd_info_create_card_entry(rmidi->card, name, rmidi->card->proc_root);
>         if (entry) {
> --
> 2.9.3
>
