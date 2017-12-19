From: Mauro Santos <registo.mailling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Mixer regression with usb soundcard
Date: Tue, 19 Dec 2017 01:04:51 +0000
Message-ID: <ff8ed1b1-7ced-9e7a-3661-7422462b6038@gmail.com>
References: <0f95a1cc-c438-ca4e-cc5f-d311e33a496e@gmail.com>
 <20171218134444.GA18133@kroah.com> <s5hy3m0dtw0.wl-tiwai@suse.de>
 <bd3f1487-d703-77b4-aca3-c6e15f0e18a8@gmail.com>
 <s5ha7ygdoqb.wl-tiwai@suse.de>
 <9dff0299-5621-2670-50b6-ee1851bb40f4@gmail.com>
 <s5htvwoc63f.wl-tiwai@suse.de>
 <CAL6iAaJVVVow45P=+whSnog+THH0CqW7ZdAYmegbd7byqCFUxg@mail.gmail.com>
 <CAL6iAaJVwWRpdGMXKTRYBN8gTD9vUS5C7cjN6SBsN1UBMxYcPw@mail.gmail.com>
 <cd84d03e-ba85-d43b-684f-90d1fcfaac9d@gmail.com>
 <s5htvwn6dg4.wl-tiwai@suse.de>
 <ec393c6b-a960-5fb3-f98c-cb2120961d45@gmail.com>
 <s5ho9mv649x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5ho9mv649x.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 18-12-2017 22:48, Takashi Iwai wrote:
> On Mon, 18 Dec 2017 22:56:07 +0100,
> Mauro Santos wrote:
>>
>> On 18-12-2017 19:30, Takashi Iwai wrote:
>>> On Mon, 18 Dec 2017 20:10:44 +0100,
>>> Mauro Santos wrote:
>>>>
>>>> On 18-12-2017 17:50, Jaejoong Kim wrote:
>>>>> Mauro,
>>>>>
>>>>> Could you please try debug patch(I also attach the patch file)?
>>>>
>>>> With the attached patch I get the following when plugging in the usb dac
>>>> directly to a usb3 port:
>>>> [   54.391539] usb 1-2: new full-speed USB device number 7 using xhci_hcd
>>>> [   54.514996] usb 1-2: device descriptor read/64, error -71
>>>> [   54.849808] input: HiFimeDIY Audio HiFimeDIY DAC as
>>>> /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:1852:7022.0003/input/input20
>>>> [   54.850168] hid-generic 0003:1852:7022.0003: input,hidraw2: USB HID
>>>> v1.00 Device [HiFimeDIY Audio HiFimeDIY DAC] on usb-0000:00:14.0-2/input0
>>>> [   54.950421] usb 1-2: [DEBUG] nameid:0, len:0
>>>> [   54.950426] usb 1-2: [DEBUG] len:3, get_term_name:PCM
>>>> [   54.950429] usb 1-2: [11] SU [PCM] items = 2
>>>> [   54.950985] usbcore: registered new interface driver snd-usb-audio
>>>
>>> Hmm, the driver get the supposedly correct name string here, so I see
>>> no flaw, so far.
>>>
>>> Could you put the similar debug prints after reverting the commit and
>>> compare?  Or, at minimum, you can enable simply the kernel debug
>>> prints like below:
>>>
>>>   % echo "file sound/usb/mixer.c +p" > /sys/kernel/debug/dynamic_debug_control
>>>
>>> and re-plug the device.
>>>
>>> Also, could you attach the output of "amixer contents" on both working
>>> and non-working kernels?
>>>
>>
>> I have compiled a new kernel where I have reverted the commit and I've
>> added the debug output based on your last debug patch. I attach the
>> patch that reverts the changes and adds the debug output just in case
>> anyone wants to do a sanity check on it (don't mind the indentation I
>> think I botched that).
>>
>> With the debug patches I get no extra output when echoing to the
>> dynamic_debug/control file, I guess that's expected.
>>
>> I attach the dmesg and amixer outputs for the case without revert plus
>> debug (bad) and revert plus debug (good).
>>
>> One change does jump out:
>>
>> bad:  usb 1-2: [11] SU [PCM] items = 2
>> good: usb 1-2: [11] SU [PCM Capture Source] items = 2
> 
> Thanks, that explains what went wrong.  The commit dropped the brace
> at the if-line, and it ended up with the lack of suffix unless
> get_term_name() fails.
> 
> The fix patch is below.  Could you check whether it cures the issue?

This patch does seem to work fine for me, I can see all the mixer
controls for the usb soundcard/dac.

For good measure I have also tested with a couple of usb headsets and I
didn't see anything amiss (they don't have any "Capture Source" controls
though).

Thank you for looking into this and fixing it.

> Also, Jaejoong, could you check whether it doesn't your device,
> either?  I believe it should keep working, but just to be sure.
> 
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
> Subject: [PATCH] ALSA: usb-audio: Fix the missing ctl name suffix at parsing
>  SU
> 
> The commit 89b89d121ffc ("ALSA: usb-audio: Add check return value for
> usb_string()") added the check of the return value from
> snd_usb_copy_string_desc(), which is correct per se, but it introduced
> a regression.  In the original code, either the "Clock Source",
> "Playback Source" or "Capture Source" suffix is added after the
> terminal string, while the commit changed it to add the suffix only
> when get_term_name() is failing.  It ended up with an incorrect ctl
> name like "PCM" instead of "PCM Capture Source".
> 
> Also, even the original code has a similar bug: when the ctl name is
> generated from snd_usb_copy_string_desc() for the given iSelector, it
> also doesn't put the suffix.
> 
> This patch addresses these issues: the suffix is added always when no
> static mapping is found.  Also the patch tries to put more comments
> and cleans up the if/else block for better readability in order to
> avoid the same pitfall again.
> 
> Fixes: 89b89d121ffc ("ALSA: usb-audio: Add check return value for usb_string()")
> Reported-by: Mauro Santos <registo.mailling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
> ---
>  sound/usb/mixer.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index afc208e1c756..60ebc99ae323 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -2173,20 +2173,25 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
>  	kctl->private_value = (unsigned long)namelist;
>  	kctl->private_free = usb_mixer_selector_elem_free;
>  
> -	nameid = uac_selector_unit_iSelector(desc);
> +	/* check the static mapping table at first */
>  	len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
> -	if (len)
> -		;
> -	else if (nameid)
> -		len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
> -					 sizeof(kctl->id.name));
> -	else
> -		len = get_term_name(state, &state->oterm,
> -				    kctl->id.name, sizeof(kctl->id.name), 0);
> -
>  	if (!len) {
> -		strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
> +		/* no mapping ? */
> +		/* if iSelector is given, use it */
> +		nameid = uac_selector_unit_iSelector(desc);
> +		if (nameid)
> +			len = snd_usb_copy_string_desc(state, nameid,
> +						       kctl->id.name,
> +						       sizeof(kctl->id.name));
> +		/* ... or pick up the terminal name at next */
> +		if (!len)
> +			len = get_term_name(state, &state->oterm,
> +				    kctl->id.name, sizeof(kctl->id.name), 0);
> +		/* ... or use the fixed string "USB" as the last resort */
> +		if (!len)
> +			strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
>  
> +		/* and add the proper suffix */
>  		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR)
>  			append_ctl_name(kctl, " Clock Source");
>  		else if ((state->oterm.type & 0xff00) == 0x0100)
> 


-- 
Mauro Santos
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
