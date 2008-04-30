From: Zoilo Gomez <zoilo@xs4all.nl>
Subject: Re: [Alsa-user] Jetway j7f2 via82xx volume problem:
 sound suddenly stops when increasing volume: "SOLVED" (well	... sort of)
Date: Wed, 30 Apr 2008 18:49:52 +0200
Message-ID: <4818A330.4080000@xs4all.nl>
References: <48063E0E.7010305@xs4all.nl>
	<48111B88.80700@xs4all.nl>	<481643F8.1000401@xs4all.nl>
	<s5hzlrcvn3n.wl%tiwai@suse.de>	<481721E5.50608@xs4all.nl>
	<s5hve20vl40.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr14.xs4all.nl (smtp-vbr14.xs4all.nl [194.109.24.34])
	by alsa0.perex.cz (Postfix) with ESMTP id EF288246C2
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 18:49:58 +0200 (CEST)
In-Reply-To: <s5hve20vl40.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 29 Apr 2008 15:25:57 +0200,
> Zoilo Gomez wrote:
>   
>>>> This is consistent with the apparent introduction of this bug in kernel
>>>> 2.6.19 (includes alsa-driver version 1.0.12rc1): no such problem
>>>> occurred until 2.6.18, but all kernels since 2.6.19 do suffer from this
>>>> problem. The line of code above first shows up in linux-2.6.19.
>>>>
>>>> Unfortunately, since I do not have a datasheet for the VT1617A chip set,
>>>> I cannot verify the exact semantics, or suggest an improvement.
>>>>
>>>> Can anyone with a datasheet please suggest a proper patch to this line
>>>> of code?
>>>>     
>>>>         
>>> The register 0x5c is the VIA specific one.  I have a VT1617 (without
>>> A) datasheet, and it suggests that the bit corresponds to the
>>> "headphone amplifier temperature sensing control".  And setting this
>>> bit means to _disable_ the temperature sensing control.  This sounds
>>> rather the correct to set.
>>>
>>> However, I don't know whether any difference exists betweeen VIA1617
>>> and 1617A although the codec id of both are identical.
>>>
>>> Andrey, any comments about your patch?
>>>
>>>
>>> In anyway, it'd be helpful if we can know which ac97 registers work
>>> and wich not.  Please take /proc/asound/card0/codec97#*/ac97#*-regs
>>> file in both working and non-working cases to compare.  Especially,
>>> the registers 0x5a and 0x5c look interesting.
>>>   
>>>       
>> Code containing "snd_ac97_write_cache(a97, 0x5c, 0x20)":
>> 0x5a = 8300
>> 0x5c = 0000
>>
>> Code with "snd_ac97_write_cache(a97, 0x5c, 0x20)" commented out:
>> 0x5a = 8301
>> 0x5c = 0020
>>
>> Quite a surprise to me, I would have expected exactly the opposite .....!?
>>     
>
> I would, too.  Could you double-check, e.g. by adding a printk?
>   

I modified the driver code to:

> int patch_vt1617a(struct snd_ac97 * ac97)
> {
>     int err = 0;
>
>     /* we choose to not fail out at this point, but we tell the
>        caller when we return */
>
>     err = patch_build_controls(ac97, &snd_ac97_controls_vt1617a[0],
>                    ARRAY_SIZE(snd_ac97_controls_vt1617a));
>
>     /* bring analog power consumption to normal by turning off the
>      * headphone amplifier, like WinXP driver for EPIA SP
>      */
> printk("before: snd_ac97_read(ac97, 0x5c) = %04x\n", 
> snd_ac97_read(ac97, 0x5c));
>     snd_ac97_write_cache(ac97, 0x5c, 0x20);
> printk("after: snd_ac97_read(ac97, 0x5c) = %04x\n", 
> snd_ac97_read(ac97, 0x5c));
>     ac97->ext_id |= AC97_EI_SPDIF;    /* force the detection of spdif */
>     ac97->rates[AC97_RATES_SPDIF] = SNDRV_PCM_RATE_44100 | 
> SNDRV_PCM_RATE_48000;
>     ac97->build_ops = &patch_vt1616_ops;
>
>     return err;
> }

Surprise surprise ... the printk output in dmesg reads:

> before: snd_ac97_read(ac97, 0x5c) = 0020
> after: snd_ac97_read(ac97, 0x5c) = 0000

If I write 0x00 (i.o. 0x20) into 0x5c, then the register content remains 
unchanged, and returns: 0x20.
If I write 0x20 into 0x5c twice, then the register content is also 0x00, 
so no toggling.

So it seems that the bit-value is inverted: write "1" clears the bit, 
whereas writing "0" sets the bit.

And the code is trying to set the bit (with good intentions), but the 
result is in fact the opposite.

What do you think?

Thanks and regards,

Z.
