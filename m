From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/sound: use-after-free in snd_usb_mixer_interrupt
Date: Tue, 10 Oct 2017 13:20:14 +0200
Message-ID: <CAAeHK+yG50hAa=MA6st516GGj=cM+SD6PtFrnz4m8Fba5ARu+g@mail.gmail.com>
References: <CAAeHK+zfyd8wkBfkg2huCp49BkSdFgO6v1Zd_eS_YOMoZ1X3_Q@mail.gmail.com>
 <s5ho9pgj7lk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ho9pgj7lk.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Stephen Barber <smbarber@chromium.org>, Bhumika Goyal <bhumirks@gmail.com>, Con Kolivas <con@kolivas.org>, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 10, 2017 at 12:10 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 09 Oct 2017 19:50:39 +0200,
> Andrey Konovalov wrote:
>>
>> Hi!
>>
>> I've got the following report while fuzzing the kernel with syzkaller.
>>
>> On commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f (4.14-rc4).
>>
>> gadgetfs: bound to dummy_udc driver
>> usb 1-1: new full-speed USB device number 2 using dummy_hcd
>> gadgetfs: connected
>> gadgetfs: disconnected
>> gadgetfs: connected
>> usb 1-1: config 1 has an invalid interface number: 1 but max is 0
>> usb 1-1: config 1 has 2 interfaces, different from the descriptor's value: 1
>> usb 1-1: config 1 interface 0 altsetting 0 endpoint 0x81 has an
>> invalid bInterval 0, changing to 10
>> usb 1-1: too many endpoints for config 1 interface 1 altsetting 174:
>> 131, using maximum allowed: 30
>> usb 1-1: config 1 interface 1 altsetting 174 has 0 endpoint
>> descriptors, different from the interface de
>> scriptor's value: 131
>> usb 1-1: config 1 interface 1 has no altsetting 0
>> usb 1-1: New USB device found, idVendor=0dba, idProduct=1000
>> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=252
>> usb 1-1: SerialNumber: a
>> gadgetfs: configuration #1
>> hub 1-1:1.0: USB hub found
>> hub 1-1:1.0: config failed, can't read hub descriptor (err -22)
>> snd-usb-audio: probe of 1-1:1.0 failed with error -22
>> ==================================================================
>> BUG: KASAN: use-after-free in snd_usb_mixer_interrupt+0x604/0x6f0
>> Read of size 8 at addr ffff8800636f8900 by task swapper/1/0
>
> A bad news for a sleepless night...
>
> It's a stray URB that isn't properly killed when the usb-audio mixer
> interface gets the error at probe.  The patch below should fix it.
> I'm going to wrap up with a proper description later.

This fixes the crash.

Thanks!

Tested-by: Andrey Konovalov <andreyknvl@google.com>

>
>
> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 9732edf77f86..91bc8f18791e 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -2234,6 +2234,9 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
>
>  static void snd_usb_mixer_free(struct usb_mixer_interface *mixer)
>  {
> +       /* kill pending URBs */
> +       snd_usb_mixer_disconnect(mixer);
> +
>         kfree(mixer->id_elems);
>         if (mixer->urb) {
>                 kfree(mixer->urb->transfer_buffer);
> @@ -2584,8 +2587,13 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
>
>  void snd_usb_mixer_disconnect(struct usb_mixer_interface *mixer)
>  {
> -       usb_kill_urb(mixer->urb);
> -       usb_kill_urb(mixer->rc_urb);
> +       if (mixer->disconnected)
> +               return;
> +       if (mixer->urb)
> +               usb_kill_urb(mixer->urb);
> +       if (mixer->rc_urb)
> +               usb_kill_urb(mixer->rc_urb);
> +       mixer->disconnected = true;
>  }
>
>  #ifdef CONFIG_PM
> diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
> index 2b4b067646ab..545d99b09706 100644
> --- a/sound/usb/mixer.h
> +++ b/sound/usb/mixer.h
> @@ -22,6 +22,8 @@ struct usb_mixer_interface {
>         struct urb *rc_urb;
>         struct usb_ctrlrequest *rc_setup_packet;
>         u8 rc_buffer[6];
> +
> +       bool disconnected;
>  };
>
>  #define MAX_CHANNELS   16      /* max logical channels */
