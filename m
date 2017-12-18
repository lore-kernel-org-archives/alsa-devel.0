From: Mauro Santos <registo.mailling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Mixer regression with usb soundcard
Date: Mon, 18 Dec 2017 18:18:53 +0000
Message-ID: <1022b04b-e07a-0bb0-be2a-72e6b280279b@gmail.com>
References: <0f95a1cc-c438-ca4e-cc5f-d311e33a496e@gmail.com>
 <20171218134444.GA18133@kroah.com> <s5hy3m0dtw0.wl-tiwai@suse.de>
 <bd3f1487-d703-77b4-aca3-c6e15f0e18a8@gmail.com>
 <s5ha7ygdoqb.wl-tiwai@suse.de>
 <CAL6iAa+eX_3fs2bQp-SquuU6PAOGqeBfjmkYhraz=99CTKUEpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL6iAa+eX_3fs2bQp-SquuU6PAOGqeBfjmkYhraz=99CTKUEpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 18-12-2017 16:59, Jaejoong Kim wrote:
> Mauro,
> thanks for the report and sorry for the make problem.
> 
> Could you try below debug patch? I add more debug code with Takashi's guideline.
> 

I get this when I plug the device directly to a usb3 port:
[   63.643706] usb 1-2: new full-speed USB device number 7 using xhci_hcd
[   63.767089] usb 1-2: device descriptor read/64, error -71
[   64.100906] input: HiFimeDIY Audio HiFimeDIY DAC as
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:1852:7022.0003/input/input20
[   64.101208] hid-generic 0003:1852:7022.0003: input,hidraw2: USB HID
v1.00 Device [HiFimeDIY Audio HiFimeDIY DAC] on usb-0000:00:14.0-2/input0
[   64.208385] usb 1-2: [DEBUG] nameid:0, len:0
[   64.208390] usb 1-2: [DEBUG] len:3, get_term_name:PCM
[   64.208393] usb 1-2: [11] SU [PCM] items = 2
[   64.208881] usbcore: registered new interface driver snd-usb-audio

If I plug it to a usb2 hub where I usually have it connected the output
is almost the same:
[  129.159898] usb 1-3.3: new full-speed USB device number 8 using xhci_hcd
[  129.246587] usb 1-3.3: device descriptor read/64, error -32
[  129.532552] input: HiFimeDIY Audio HiFimeDIY DAC as
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.3/1-3.3:1.0/0003:1852:7022.0004/input/input21
[  129.532790] hid-generic 0003:1852:7022.0004: input,hidraw2: USB HID
v1.00 Device [HiFimeDIY Audio HiFimeDIY DAC] on usb-0000:00:14.0-3.3/input0
[  129.560090] usb 1-3.3: [DEBUG] nameid:0, len:0
[  129.560096] usb 1-3.3: [DEBUG] len:3, get_term_name:PCM
[  129.560100] usb 1-3.3: [11] SU [PCM] items = 2

I'm compiling now a kernel with your other patch, I'll get back to you
with all the information I can gather on the device once I test with the
other patch.

> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 84b9f9c..0233425 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -595,7 +595,7 @@ int snd_usb_mixer_add_control(struct
> usb_mixer_elem_list *list,
>         while (snd_ctl_find_id(mixer->chip->card, &kctl->id))
>                 kctl->id.index++;
>         if ((err = snd_ctl_add(mixer->chip->card, kctl)) < 0) {
> -               usb_audio_dbg(mixer->chip, "cannot add control (err = %d)\n",
> +               usb_audio_err(mixer->chip, "[DEBUG] cannot add control
> (err = %d)\n",
>                               err);
>                 return err;
>         }
> @@ -2162,14 +2162,23 @@ static int parse_audio_selector_unit(struct
> mixer_build *state, int unitid,
> 
>         nameid = uac_selector_unit_iSelector(desc);
>         len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
> +
> +       usb_audio_err(state->chip, "[DEBUG] nameid:%d, len:%d\n", nameid, len);
> +
>         if (len)
>                 ;
> -       else if (nameid)
> +       else if (nameid) {
>                 len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
>                                          sizeof(kctl->id.name));
> -       else
> +               usb_audio_err(state->chip, "[DEBUG] len:%d,
> copy_string id.name:%s\n",
> +                                       len, (len > 0) ? kctl->id.name : " ");
> +       }
> +       else {
>                 len = get_term_name(state, &state->oterm,
>                                     kctl->id.name, sizeof(kctl->id.name), 0);
> +               usb_audio_err(state->chip, "[DEBUG] len:%d, get_term_name:%s\n",
> +                                       len, (len > 0) ? kctl->id.name : " ");
> +       }
> 
>         if (!len) {
>                 strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
> @@ -2182,7 +2191,7 @@ static int parse_audio_selector_unit(struct
> mixer_build *state, int unitid,
>                         append_ctl_name(kctl, " Playback Source");
>         }
> 
> -       usb_audio_dbg(state->chip, "[%d] SU [%s] items = %d\n",
> +       usb_audio_err(state->chip, "[%d] SU [%s] items = %d\n",
>                     cval->head.id, kctl->id.name, desc->bNrInPins);
>         return snd_usb_mixer_add_control(&cval->head, kctl);
>  }
> 
> 
> 2017-12-19 0:45 GMT+09:00 Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>:
>> On Mon, 18 Dec 2017 16:30:13 +0100,
>> Mauro Santos wrote:
>>>
>>> On 18-12-2017 13:53, Takashi Iwai wrote:
>>>> On Mon, 18 Dec 2017 14:44:44 +0100,
>>>> Greg KH wrote:
>>>>>
>>>>> On Sun, Dec 17, 2017 at 06:56:05PM +0000, Mauro Santos wrote:
>>>>>> I believe this is the right place to report this problem, but if it
>>>>>> isn't please point me in the right direction.
>>>>>
>>>>> Adding the developer of that patch, and the sound maintainer and
>>>>> developers to the thread.
>>>>>
>>>>>> I have noticed that after the update from kernel 4.14.5 to 4.14.6
>>>>>> alsamixer does not show the usual volume controls for my usb soundcard.
>>>>>>
>>>>>> Reverting 3884d12e17ab770aa0f5d4bc65bfbfd006f417fa ALSA: usb-audio: Add
>>>>>> check return value for usb_string() (from linux-stable) makes the
>>>>>> controls come back again with kernel 4.14.6.
>>>> (snip)
>>>>>
>>>>> This is odd, Takashi, I thought we fixed up the problem that if the
>>>>> string was invalid, the code would continue to go on, it's not a "real"
>>>>> error.  Did that not get marked for the stable trees?
>>>>
>>>> Yes, it was marked as stable, and it's odd that the revert of the
>>>> given commit changes the behavior in that way.
>>>>
>>>> Mauro, could you double-check whether reverting the commit really does
>>>> fix it as expected?  If yes, could you put some debug print at the
>>>> part the patch touches, and check which unit id gives len=0 from
>>>> snd_usb_copy_string_desc()?
>>>
>>> I'm sure reverting that patch makes things work as expected. I noticed
>>> the problem after an update and that is the only thing I revert on top
>>> of the kernel provided by the distro (Arch Linux).
>>
>> Did you revert only one patch, not both patches?
>> Just to be sure.
>>
>>> Alsamixer works fine for the built in soundcard in my laptop, but the
>>> mixer for the usb soundcard was not working so it's specific to usb and
>>> only 2 patches touch the mixer.c file between 4.14.5 and 4.14.6. I've
>>> tried reversing both, one at a time, and only reverting this one
>>> restored the expected behavior.
>>>
>>> Regarding adding the debug print I'm going to need guidance. Without
>>> reverting anything, would adding at line 2178 of sound/usb/mixer.c the
>>> following be enough?
>>>
>>> printk("usbmixdbg: nameid=%d len=%d id.name=%s\n",nameid,len,kctl->id.name);
>>>
>>> It would then look like this (minus the line wrapping):
>>> len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
>>> printk("usbmixdbg: nameid=%d len=%d id.name=%s\n",nameid,len,kctl->id.name);
>>> if (len)
>>
>> Well, at that point, there should be no difference.
>> The difference is after that, so what I'd like to see is something
>> like:
>>
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -2175,14 +2175,18 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
>>
>>         nameid = uac_selector_unit_iSelector(desc);
>>         len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
>> +       pr_info("XXX id=%d, check_mapped_name=%d\n", id, len);
>>         if (len)
>>                 ;
>> -       else if (nameid)
>> +       else if (nameid) {
>>                 len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
>>                                          sizeof(kctl->id.name));
>> -       else
>> +               pr_info("XXX id=%d, copy_string=%d\n", len);
>> +       } else {
>>                 len = get_term_name(state, &state->oterm,
>>                                     kctl->id.name, sizeof(kctl->id.name), 0);
>> +               pr_info("XXX id=%d, get_term_name=%d\n", len);
>> +       }
>>
>>         if (!len) {
>>                 strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
>>
>>
>> If you see copy_string=0, it means that your hardware reports a bogus
>> entry, and the driver does it correctly.  If ignoring that error
>> really restores the old behavior back, it essentially means that it
>> worked casually in the past...
> 
> AudioControl Interface Descriptor:
>         bLength                 8
>         bDescriptorType        36
>         bDescriptorSubtype      5 (SELECTOR_UNIT)
>         bUnitID                11
>         bNrInPins               2
>         baSource( 0)           14
>         baSource( 1)            5
>         iSelector               0
>         ^^^^^^^^^
> 
>>From the lsusb.txt, iSelector is '0' which means
> uac_selector_unit_iSelector() return zero I think.
> 
> Thanks, jaejoong
> 
>>
>>
>> thanks,
>>
>> Takashi


-- 
Mauro Santos
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
