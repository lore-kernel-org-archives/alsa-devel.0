From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] Asynchronous audio USB chips: choppy playback since
 3.8-rc7
Date: Wed, 03 Apr 2013 17:37:16 +0200
Message-ID: <515C4CAC.5020702@gmail.com>
References: <515C013D.8090909@canonical.com> <515C0312.1090507@gmail.com> <515C34E5.3030306@amarulasolutions.com> <515C389B.80506@amarulasolutions.com> <515C4410.4030904@gmail.com> <515C4879.8090208@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <515C4879.8090208-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: David Henningsson <david.henningsson-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, 1136110-T8XWwAfLipRB/Vz2p19nDaxOck334EZe@public.gmane.org, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 03.04.2013 17:19, Michael Trimarchi wrote:
> Hi Daniel
> 
> On 03/04/13 17:00, Daniel Mack wrote:
>> Hi Michael,
>>
>> On 03.04.2013 16:11, Michael Trimarchi wrote:
>>> On 03/04/13 15:55, Michael Trimarchi wrote:
>>>> On 03/04/13 12:23, Daniel Mack wrote:
>>>>> Hi David,
>>>>>
>>>>> On 03.04.2013 12:15, David Henningsson wrote:
>>>>>> Just to get your attention here on what seems to be an USB audio 
>>>>>> regression.
>>>>>>
>>>>>> The bug is described in detail here:
>>>>>>
>>>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1136110?comments=all
>>>>>>
>>>>>> Quoting the bug:
>>>>>>
>>>>>> "
>>>>>> This bug seems to affect only a certain kind of hardware, which is 
>>>>>> called "Asynchronous USB Digital Audio Codec (DAC)". It's said that such 
>>>>>> a DAC hosts the clock itself (USB Device Host). An ordinary DAC, so 
>>>>>> called "Synchronous USB DAC", uses the clock hosted by the mother board, 
>>>>>> which is not affected by this bug.
>>>>>>
>>>>>> When this bug affects an asynchronous USB DAC, the audio played by the 
>>>>>> DAC is constantly interrupted. The playback itself does not stop, but 
>>>>>> the output becomes discontinous, filling with constant crackling noises, 
>>>>>> destroying everything the DAC plays.
>>>>>> "
>>>>>>
>>>>>> According to the bug reporter, which seems to have done quite a bit of 
>>>>>> research, this started between 3.8-rc6 and 3.8-rc7 as well as stable 
>>>>>> kernels and the bug also lists a few commits which could be the cause, 
>>>>>> none under sound/usb though.
>>>>>
>>>>> There were no relevant changes for snd-usb between the two versions
>>>>> mentioned. The only patches that come in mind in this time window are:
>>>>>
>>>>>  3e619d041 "USB: EHCI: fix bug in scheduling periodic split transfers"
>>>>>  b09a61cc0 "USB: EHCI: fix for leaking isochronous data"
>>>>
>>>> This last one, doesn't give me any problem, just a memory leak and not a choppy
>>>> playback (tested on 48Khz, 96Khz, 192Khz 32bit on OMAP3 device) and I don't
>>>> think that it can be the reason of the problem.
>>
>> Is OMAP3 at all a platform that is affected by the bug? It seems the
>> effect is only seen on some special host controller hardware anyway.
>>
> 
> Yes, omap3 ehci and m2tech products is not affected and I'm testing a dac with internal clock.
> 
>>> Sorry the comment was for a bug that is not included in this list and recently fixed.
>>> USB: EHCI: fix bug in iTD/siTD DMA pool allocation
>>
>> Sorry, you lost me. So what's the status of this issue now? Does "USB:
>> EHCI: fix bug in iTD/siTD DMA pool allocation" fix it?
> 
> With or without it, I don't have any choppy audio and this is not a fix
> of this bug.

If you cannot reproduce the bug, how can you reproduce a fix then?

Also, if all users of snd-usb would be affected since 3.8-rc7, I'm sure
this mailing list would be full of reports.

The bug is only triggered by some sort of hardware (appearantly such
with an internal clock), and only with some patch applied that went in
between 3.8-rc6 and 3.8-rc7.

Someone with hardware that shows the bug has to bisect between these two
tags please. Given the number of patches between them (230), that
shouldn't take long.

ALSA is certainly not the culprit here, as there where only ASoC patches
in that range. I'm copying the linux-usb ML.


Thanks,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
