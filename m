From: Mauro Santos <registo.mailling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Mixer regression with usb soundcard
Date: Mon, 18 Dec 2017 19:10:44 +0000
Message-ID: <cd84d03e-ba85-d43b-684f-90d1fcfaac9d@gmail.com>
References: <0f95a1cc-c438-ca4e-cc5f-d311e33a496e@gmail.com>
 <20171218134444.GA18133@kroah.com> <s5hy3m0dtw0.wl-tiwai@suse.de>
 <bd3f1487-d703-77b4-aca3-c6e15f0e18a8@gmail.com>
 <s5ha7ygdoqb.wl-tiwai@suse.de>
 <9dff0299-5621-2670-50b6-ee1851bb40f4@gmail.com>
 <s5htvwoc63f.wl-tiwai@suse.de>
 <CAL6iAaJVVVow45P=+whSnog+THH0CqW7ZdAYmegbd7byqCFUxg@mail.gmail.com>
 <CAL6iAaJVwWRpdGMXKTRYBN8gTD9vUS5C7cjN6SBsN1UBMxYcPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL6iAaJVwWRpdGMXKTRYBN8gTD9vUS5C7cjN6SBsN1UBMxYcPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 18-12-2017 17:50, Jaejoong Kim wrote:
> Mauro,
> 
> Could you please try debug patch(I also attach the patch file)?

With the attached patch I get the following when plugging in the usb dac
directly to a usb3 port:
[   54.391539] usb 1-2: new full-speed USB device number 7 using xhci_hcd
[   54.514996] usb 1-2: device descriptor read/64, error -71
[   54.849808] input: HiFimeDIY Audio HiFimeDIY DAC as
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:1852:7022.0003/input/input20
[   54.850168] hid-generic 0003:1852:7022.0003: input,hidraw2: USB HID
v1.00 Device [HiFimeDIY Audio HiFimeDIY DAC] on usb-0000:00:14.0-2/input0
[   54.950421] usb 1-2: [DEBUG] nameid:0, len:0
[   54.950426] usb 1-2: [DEBUG] len:3, get_term_name:PCM
[   54.950429] usb 1-2: [11] SU [PCM] items = 2
[   54.950985] usbcore: registered new interface driver snd-usb-audio

> 
> And can you share your usb audio dac? Is this same device with yours?
> https://hifimediy.com/index.php?route=product/product&product_id=83
> 

It is similar to that but I bought mine in August of 2013.

The description of my device when I bought it was:
HifiMeDiy Sabre USB DAC. Digital to Audio Converter 96khz/24bit (incl
USB to optical converter feature).

I have opened the box and on the PCB mine says UAE23 v1.3A.
It uses a tenor te7022l usb receiver plus a sabre es9032p dac if it matters.

> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 84b9f9c..6200aa2 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -595,7 +595,7 @@ int snd_usb_mixer_add_control(struct
> usb_mixer_elem_list *list,
>   while (snd_ctl_find_id(mixer->chip->card, &kctl->id))
>   kctl->id.index++;
>   if ((err = snd_ctl_add(mixer->chip->card, kctl)) < 0) {
> - usb_audio_dbg(mixer->chip, "cannot add control (err = %d)\n",
> + usb_audio_err(mixer->chip, "[DEBUG] cannot add control (err = %d)\n",
>         err);
>   return err;
>   }
> @@ -656,10 +656,14 @@ static int get_term_name(struct mixer_build
> *state, struct usb_audio_term *iterm
>   unsigned char *name, int maxlen, int term_only)
>  {
>   struct iterm_name_combo *names;
> + int len;
> 
> - if (iterm->name)
> - return snd_usb_copy_string_desc(state, iterm->name,
> + if (iterm->name) {
> + len = snd_usb_copy_string_desc(state, iterm->name,
>   name, maxlen);
> + usb_audio_err(state->chip, "[DEBUG] len:%d, iterm->name:%d\n", len,
> iterm->name);
> + return len;
> + }
> 
>   /* virtual type - not a real terminal */
>   if (iterm->type >> 16) {
> @@ -2162,14 +2166,23 @@ static int parse_audio_selector_unit(struct
> mixer_build *state, int unitid,
> 
>   nameid = uac_selector_unit_iSelector(desc);
>   len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
> +
> + usb_audio_err(state->chip, "[DEBUG] nameid:%d, len:%d\n", nameid, len);
> +
>   if (len)
>   ;
> - else if (nameid)
> + else if (nameid) {
>   len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
>   sizeof(kctl->id.name));
> - else
> + usb_audio_err(state->chip, "[DEBUG] len:%d, copy_string id.name:%s\n",
> + len, (len > 0) ? kctl->id.name : " ");
> + }
> + else {
>   len = get_term_name(state, &state->oterm,
>       kctl->id.name, sizeof(kctl->id.name), 0);
> + usb_audio_err(state->chip, "[DEBUG] len:%d, get_term_name:%s\n",
> + len, (len > 0) ? kctl->id.name : " ");
> + }
> 
>   if (!len) {
>   strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
> @@ -2182,7 +2195,7 @@ static int parse_audio_selector_unit(struct
> mixer_build *state, int unitid,
>   append_ctl_name(kctl, " Playback Source");
>   }
> 
> - usb_audio_dbg(state->chip, "[%d] SU [%s] items = %d\n",
> + usb_audio_err(state->chip, "[%d] SU [%s] items = %d\n",
>       cval->head.id, kctl->id.name, desc->bNrInPins);
>   return snd_usb_mixer_add_control(&cval->head, kctl);
>  }
> 
> 
> 2017-12-19 2:19 GMT+09:00 Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> 2017-12-19 2:13 GMT+09:00 Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>:
>>> On Mon, 18 Dec 2017 18:05:18 +0100,
>>> Mauro Santos wrote:
>>>>
>>>> On 18-12-2017 15:45, Takashi Iwai wrote:
>>>>> On Mon, 18 Dec 2017 16:30:13 +0100,
>>>>> Mauro Santos wrote:
>>>>>>
>>>>>> On 18-12-2017 13:53, Takashi Iwai wrote:
>>>>>>> On Mon, 18 Dec 2017 14:44:44 +0100,
>>>>>>> Greg KH wrote:
>>>>>>>>
>>>>>>>> On Sun, Dec 17, 2017 at 06:56:05PM +0000, Mauro Santos wrote:
>>>>>>>>> I believe this is the right place to report this problem, but if it
>>>>>>>>> isn't please point me in the right direction.
>>>>>>>>
>>>>>>>> Adding the developer of that patch, and the sound maintainer and
>>>>>>>> developers to the thread.
>>>>>>>>
>>>>>>>>> I have noticed that after the update from kernel 4.14.5 to 4.14.6
>>>>>>>>> alsamixer does not show the usual volume controls for my usb soundcard.
>>>>>>>>>
>>>>>>>>> Reverting 3884d12e17ab770aa0f5d4bc65bfbfd006f417fa ALSA: usb-audio: Add
>>>>>>>>> check return value for usb_string() (from linux-stable) makes the
>>>>>>>>> controls come back again with kernel 4.14.6.
>>>>>>> (snip)
>>>>>>>>
>>>>>>>> This is odd, Takashi, I thought we fixed up the problem that if the
>>>>>>>> string was invalid, the code would continue to go on, it's not a "real"
>>>>>>>> error.  Did that not get marked for the stable trees?
>>>>>>>
>>>>>>> Yes, it was marked as stable, and it's odd that the revert of the
>>>>>>> given commit changes the behavior in that way.
>>>>>>>
>>>>>>> Mauro, could you double-check whether reverting the commit really does
>>>>>>> fix it as expected?  If yes, could you put some debug print at the
>>>>>>> part the patch touches, and check which unit id gives len=0 from
>>>>>>> snd_usb_copy_string_desc()?
>>>>>>
>>>>>> I'm sure reverting that patch makes things work as expected. I noticed
>>>>>> the problem after an update and that is the only thing I revert on top
>>>>>> of the kernel provided by the distro (Arch Linux).
>>>>>
>>>>> Did you revert only one patch, not both patches?
>>>>> Just to be sure.
>>>>
>>>> I have reverted only one patch.
>>>>
>>>>>> Alsamixer works fine for the built in soundcard in my laptop, but the
>>>>>> mixer for the usb soundcard was not working so it's specific to usb and
>>>>>> only 2 patches touch the mixer.c file between 4.14.5 and 4.14.6. I've
>>>>>> tried reversing both, one at a time, and only reverting this one
>>>>>> restored the expected behavior.
>>>>>>
>>>>>> Regarding adding the debug print I'm going to need guidance. Without
>>>>>> reverting anything, would adding at line 2178 of sound/usb/mixer.c the
>>>>>> following be enough?
>>>>>>
>>>>>> printk("usbmixdbg: nameid=%d len=%d id.name=%s\n",nameid,len,kctl->id.name);
>>>>>>
>>>>>> It would then look like this (minus the line wrapping):
>>>>>> len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
>>>>>> printk("usbmixdbg: nameid=%d len=%d id.name=%s\n",nameid,len,kctl->id.name);
>>>>>> if (len)
>>>>>
>>>>> Well, at that point, there should be no difference.
>>>>> The difference is after that, so what I'd like to see is something
>>>>> like:
>>>>>
>>>>> --- a/sound/usb/mixer.c
>>>>> +++ b/sound/usb/mixer.c
>>>>> @@ -2175,14 +2175,18 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
>>>>>
>>>>>     nameid = uac_selector_unit_iSelector(desc);
>>>>>     len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
>>>>> +   pr_info("XXX id=%d, check_mapped_name=%d\n", id, len);
>>>>>     if (len)
>>>>>             ;
>>>>> -   else if (nameid)
>>>>> +   else if (nameid) {
>>>>>             len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
>>>>>                                      sizeof(kctl->id.name));
>>>>> -   else
>>>>> +           pr_info("XXX id=%d, copy_string=%d\n", len);
>>>>> +   } else {
>>>>>             len = get_term_name(state, &state->oterm,
>>>>>                                 kctl->id.name, sizeof(kctl->id.name), 0);
>>>>> +           pr_info("XXX id=%d, get_term_name=%d\n", len);
>>>>> +   }
>>>>>
>>>>>     if (!len) {
>>>>>             strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
>>>>>
>>>>>
>>>>> If you see copy_string=0, it means that your hardware reports a bogus
>>>>> entry, and the driver does it correctly.  If ignoring that error
>>>>> really restores the old behavior back, it essentially means that it
>>>>> worked casually in the past...
>>>>
>>>> I have applied your patch on top of 4.14.7 without reverting anything
>>>> and I was planning to reply only after I had some result but building
>>>> failed (without any errors strangely).
>>>>
>>>> I took a second look at your patch and I have a (maybe silly/naive)
>>>> question, don't the second and third pr_info calls need an extra
>>>> argument? There are two %d in the string but only one variable (len).
>>>
>>> Yeah, sure, of course you need them :)
>>> I haven't tested the patch, but just to give you an idea.
>>> Sorry if you wasted your time due to that.
>>
>> OK. I will make a debug patch with you last debug code.
>>
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -656,10 +656,14 @@ static int get_term_name(struct mixer_build
>> *state, struct usb_audio_term *iterm
>>                          unsigned char *name, int maxlen, int term_only)
>>  {
>>         struct iterm_name_combo *names;
>> +       int len;
>>
>> -       if (iterm->name)
>> -               return snd_usb_copy_string_desc(state, iterm->name,
>> +       if (iterm->name) {
>> +               len = snd_usb_copy_string_desc(state, iterm->name,
>>                                                 name, maxlen);
>> +               if (len)
>> +                       return len;
>> +       }
> 
> This is your potential patch not debug. To verify your potential fix,
> I add more debug code in get_term_name().
> I am going to bed. It's 2:46AM..
> 
>>
>> I will come back soon.
>>
>>>
>>>
>>> Takashi


-- 
Mauro Santos
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
