From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: Re: [PATCH] Two patches for Alsa-plugins (pulse)
Date: Sat, 10 Jul 2010 08:42:25 +0200
Message-ID: <4C381651.6060603@epost.diwic.se>
References: <4C22670D.8010104@epost.diwic.se>
	<s5h6319dj90.wl%tiwai@suse.de>	<4C2487EA.3090605@epost.diwic.se>
	<s5hzky6bgy2.wl%tiwai@suse.de>	<s5heifcsvom.wl%tiwai@suse.de>	<AANLkTimnfft0c_V9bTK-g8hX2ljc_IJoMliMEwcQTz5g@mail.gmail.com>	<s5hiq4or5cz.wl%tiwai@suse.de>
	<4C376182.5050807@epost.diwic.se>
	<AANLkTinIl5AyMZyJNabLzdfvGRjU8A6wikmoO4edGt9v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp02.sth.basefarm.net (ch-smtp02.sth.basefarm.net
	[80.76.149.213]) by alsa0.perex.cz (Postfix) with ESMTP id A457724551
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Jul 2010 08:42:41 +0200 (CEST)
Received: from c83-254-129-236.bredband.comhem.se ([83.254.129.236]:48474
	helo=[192.168.8.103])
	by ch-smtp02.sth.basefarm.net with esmtp (Exim 4.68)
	(envelope-from <launchpad.web@epost.diwic.se>) id 1OXTlc-0001Rx-75
	for alsa-devel@alsa-project.org; Sat, 10 Jul 2010 08:42:31 +0200
In-Reply-To: <AANLkTinIl5AyMZyJNabLzdfvGRjU8A6wikmoO4edGt9v@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010-07-10 00:58, Raymond Yau skrev:
> 2010/7/10 David Henningsson <launchpad.web@epost.diwic.se>
> 
>> 2010-07-09 18:23, Takashi Iwai skrev:
>>> At Fri, 9 Jul 2010 21:13:52 +0800,
>>> Raymond Yau wrote:
>>>>>>>>> The second one (Do not report underruns to the ALSA layer) is more
>> a
>>>>>>>>> change of behavior, which could be questioned. The arguments for
>>>>>>>>> removing that code are these:
>>>>>>>>>
>>>>>>>>>  * If pulseaudio gets an underrun, the normal way to end that
>>>>> underrun
>>>>>>>>> is to feed it with more buffers. This is different from the ALSA
>> way
>>>>> of
>>>>>>>>> dealing with underruns, which requires hardware buffer pointers to
>>>>> be reset.
>>>>>>>>>  * In addition, underrun signals are delivered asynchronously from
>>>>>>>>> pulseaudio. This means that there might be more buffers on the way
>>>>> to
>>>>>>>>> pulseaudio when the underrun is reported, making the underrun
>>>>> obsolete.
>>>>>>>>> Unfortunately, there is currently no known way to determine whether
>>>>> this
>>>>>>>>> is the case or not.
>>>>>>>>
>>>>>>>> I think this helps for normal use-cases, so it'd be good to apply.
>>>>>>>> But, I prefer having a runtime option for such a behavior change
>>>>>>>> (although the default value can be the new behavior).
>>>>>>>>
>>>>>>>> Care to add it?
>>>>>>>
>>>>>>> Sure, I can do that - it sounds like a good idea to have it
>>>>> configurable.
>>>>>>> Just so I understand you right, exactly how do you expect the user /
>>>>>>> application to configure it?
>>>>>>
>>>>>> I suppose it can be simply added as an alsa-lib plugin config, i.e.
>>>>>> in SND_PCM_PLUGIN_DEFINE_FUNC(pulse) of
>> alsa-plugins/pulse/pcm_pulse.c,
>>>>>> add the code like below:
>>>>>>
>>>>>>       int handle_underrun = 0;
>>>>>>       ...
>>>>>>
>>>>>>       snd_config_for_each(i, next, conf) {
>>>>>>               ...
>>>>>>               if (strcmp(id, "handle_underrun") == 0) {
>>>>>>                       handle_underrun = snd_config_get_bool(n);
>>>>>>                       if (handle_underrun < 0) {
>>>>>>                               SNDERR("Invalid value for %s", id);
>>>>>>                               return handle_underrun;
>>>>>>                       }
>>>>>>                       continue;
>>>>>>               }
>>>>>>       }
>>>>>
>>>>> FYI, I modified the patch and applied to git tree right now.
>>
>> Thanks! I've been on holiday this week but thought I would do it in the
>> following week. Only nice to see it being done :-)
>>
>>>> This behaviour is a little bit strange , using the same buffer size 128
>>>>
>>>> aplay -Dhw:0,0 --buffer-size=128 test.wav
>>>>
>>>> report underrun
>>>>
>>>>
>>>> aplay -D pulse --buffer-size=128 test.wav
>>>>
>>>> did not report underrun but the sound is distorted
>>>
>>> Other subsystem, other behavior.
>>> The detection of underrun is even unreliable on ALSA native, so user
>>> can't expect it'll get underrun.
>>
> 
> 
> Before this patch , using pulse device also report underrun
> 
> 
> When using hw device ,the sound is quite good , at least I cannot hear any
> distortion and the reported underrun  only appear a few times on the
> terminal
> 
> 
> underrun!!! (at least 0.210 ms long)
> 
> Did alsa-lib calculate 0.210 ms from hw_ptr , app_ptr and sample rate ?

Good question, I'm sure you can read that in the source :-)

http://git.alsa-project.org/?p=alsa-utils.git;a=blob;f=aplay/aplay.c;h=e1d8e6aab69642c2a57bd53b2d4ce9d2a24ad0b6;hb=HEAD

>>> The biggest drawback by this change is that whether the sound goes
>>> well or not isn't reported any more to the application layer.
>>> It's an unfortunate design, but it's life with PA.
>>
>> The question is - is there an application that detects the underrun
>> condition and actually acts on that condition? If so, this could be a
>> regression for that app. For other apps it's an improvement, for the
>> reasons originally stated.
> 
> You have to ask jackd user , they usually fine-tune(increase/decrease) the
> period-size of jackd manually based on the occurrence of underrun in order
> to achieve the lowest latency

Correct me if I'm wrong, but I think jackd users are not likely to run
jackd over the alsa-pulse bridge but rather run PA on top of jackd, so
that is not an issue.

> This give a false impression to the user that PA can provide low latency
> without under-run and pulse device is even perform better than hw device.

To complicate matters more, with PA in the stack you can have underruns
both on the client app <=> PA side, and on the PA <=> alsa-driver side.
So the false impression was there before, only it is slightly worse now.

>>>  Reporting underruns to ALSA seems to do more bad than good, for these
> reasons:
> 
>  * If pulseaudio gets an underrun, the normal way to end that underrun is to
>    feed it with more buffers. This is different from the ALSA way of dealing
>    with underruns, which requires hardware buffer pointers to be reset.
>  * In addition, underrun signals are delivered asynchronously from
> pulseaudio.
>    This means that there might be more buffers on the way to pulseaudio when
>    the underrun is reported, making the underrun obsolete. Unfortunately,
>    there is currently no known way to determine whether this is the case or
>    not.
> 
> Do you mean PA server get underrun from the sound driver when you mention
> that
> if pulseaudio get underrun, the normal way to end that underrun is to feed
> it with more buffers." ?

I'm talking about the client-app <=> PA underrun here. The PA <=> sound
driver underrun is handled by PA internally, and, IIRC, is never
reported to the client app (even before the patch).

> The normal way for ALSA application is to prevent underrun occur rather to
> let underrun occur be selecting a larger period size or wake up more
> frequently to feed data to the sound card

Do you know an ALSA application which actually does this automatically,
i e selects a larger period size when it detects an underrun?

> PA developer often complain the driver did not provide accurate playback
> position by the pcm_pointer callback
> 
> Did the pulse_pointer callback also provide accurate position of the pulse
> device ?

Yes, but it provides the pointer to the fake ring buffer (the alsa-lib
plugin system expects that all pcm plugins are ring buffers, which seems
to me like a design flaw).

// David
