From: Zoilo Gomez <zoilo@xs4all.nl>
Subject: Re: [Alsa-user] Jetway j7f2 via82xx volume problem:
 sound suddenly stops when increasing volume: "SOLVED" (well ... sort of)
Date: Tue, 29 Apr 2008 15:25:57 +0200
Message-ID: <481721E5.50608@xs4all.nl>
References: <48063E0E.7010305@xs4all.nl>	<48111B88.80700@xs4all.nl>	<481643F8.1000401@xs4all.nl>
	<s5hzlrcvn3n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr6.xs4all.nl (smtp-vbr6.xs4all.nl [194.109.24.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A716247A6
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Apr 2008 15:26:06 +0200 (CEST)
In-Reply-To: <s5hzlrcvn3n.wl%tiwai@suse.de>
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
> At Mon, 28 Apr 2008 23:39:04 +0200,
> Zoilo Gomez wrote:
>   
>> (Sorry for cross-posting from alsa-user; however, on 2nd thought I think
>> this really belongs in alsa-devel):
>>
>> ===
>>
>> I think I have found what is causing this problem: in ac97_patch.c / int
>> patch_vt1617a(...)  there is a line of code:
>>
>>     
>>>>> snd_ac97_write_cache(a97, 0x5c, 0x20);
>>>>>           
>> According to a comment, this code is supposed to "bring the analog power
>> consumption to normal, like WinXP driver for EPIA SP".
>>
>> If I comment out this line, the problem appears to be solved ... I can
>> now put all volume controls to maximum values and the sound will keep
>> playing.
>>     
>
> Appreciated that you hunted it out.
> Added Cc to the patch author.
>   

Thank you for your response, Takashi!

>> This is consistent with the apparent introduction of this bug in kernel
>> 2.6.19 (includes alsa-driver version 1.0.12rc1): no such problem
>> occurred until 2.6.18, but all kernels since 2.6.19 do suffer from this
>> problem. The line of code above first shows up in linux-2.6.19.
>>
>> Unfortunately, since I do not have a datasheet for the VT1617A chip set,
>> I cannot verify the exact semantics, or suggest an improvement.
>>
>> Can anyone with a datasheet please suggest a proper patch to this line
>> of code?
>>     
>
> The register 0x5c is the VIA specific one.  I have a VT1617 (without
> A) datasheet, and it suggests that the bit corresponds to the
> "headphone amplifier temperature sensing control".  And setting this
> bit means to _disable_ the temperature sensing control.  This sounds
> rather the correct to set.
>
> However, I don't know whether any difference exists betweeen VIA1617
> and 1617A although the codec id of both are identical.
>
> Andrey, any comments about your patch?
>
>
> In anyway, it'd be helpful if we can know which ac97 registers work
> and wich not.  Please take /proc/asound/card0/codec97#*/ac97#*-regs
> file in both working and non-working cases to compare.  Especially,
> the registers 0x5a and 0x5c look interesting.
>   

Code containing "snd_ac97_write_cache(a97, 0x5c, 0x20)":
0x5a = 8300
0x5c = 0000

Code with "snd_ac97_write_cache(a97, 0x5c, 0x20)" commented out:
0x5a = 8301
0x5c = 0020

Quite a surprise to me, I would have expected exactly the opposite .....!?


Can you explain this? /proc/asound/card0/codec97#0/ac97#0-0+regs does 
dump current registers, correct? Or is it a toggling bit?

Thank you,

Zoilo.




>
> Thanks,
>
> Takashi
>
>
>
>   
>> TIA,
>>
>> Z.
>>
>> ======
>>
>> Zoilo Gomez wrote:
>>     
>>> In the mean time I have found that kernels 2.6.15 and 2.6.16 do not 
>>> suffer from this problem, whereas 2.6.22 till 2.6.25 do.
>>>
>>> Testing for kernels 2.6.17 till 2.6.21 is somewhat complicated in my 
>>> setup, because there are other problems (NFS-related) which I need to 
>>> sort out.
>>>
>>> So it looks like there is a bug somehow.
>>>
>>> Providing the dxs_support parameter does not make any difference, no 
>>> matter what value I set it to.
>>>
>>> Z.
>>>
>>>
>>> Zoilo Gomez wrote:
>>>       
>>>> I have several J7F2 boards from Jetway, containing a 8237 via sound 
>>>> device on the south bridge.
>>>>
>>>> Using the alsa-driver, when I increase the volume then at some point 
>>>> all over sudden the sound stops. On some boards this happens at 75%, 
>>>> on others already at 60%, or 90%. Bringing the volume down again does 
>>>> not bring the audio back ...
>>>>
>>>> I am using the alsa-drivers with MPlayer.
>>>>
>>>> Although to me this smells like a hardware problem, I understand from 
>>>> googling around that this can be fixed with software, but I cannot 
>>>> find the correct solution anywhere. I have tested with gentoo kernels 
>>>> 2.6.22 and 2.6.24.
>>>>
>>>> AFAIK there are only 2 ways to get the sound back once it has stopped:
>>>>
>>>> 1) reset the mobo
>>>> 2) rmmod snd-via82xx, followed by modprobe snd-via82xx
>>>>
>>>> The strange thing is that in option 2), the problem seems to be gone 
>>>> once the driver has been reloaded; from that moment on it is working 
>>>> fine ....!
>>>>
>>>> There is a driver from Via Arena (viaudiocombo) that seems to work 
>>>> fine, but it is OSS i.o. ALSA, and also a development by Via Arena 
>>>> i.o. the Linux community. Besides, I need synchronization features 
>>>> from the audio driver, and I do not think that OSS support this (not 
>>>> 100% sure).
>>>>
>>>>
>>>> Can anyone help me and shed light on this?
>>>>
>>>>
>>>> TIA!
>>>>
>>>> Zoilo.
>>>>
>>>> ------------------------------------------------------------------------- 
>>>>
>>>> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
>>>> Don't miss this year's exciting event. There's still time to save 
>>>> $100. Use priority code J8TL2D2. 
>>>> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone 
>>>>
>>>> _______________________________________________
>>>> Alsa-user mailing list
>>>> Alsa-user@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/alsa-user
>>>>
>>>>
>>>>   
>>>>         
>>>
>>>       
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>     
>
>
>   
