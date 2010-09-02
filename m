From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: alsactl adds volume controls?
Date: Thu, 02 Sep 2010 11:24:45 +0200
Message-ID: <4C7F6D5D.7020101@canonical.com>
References: <4C77CE1D.2070501@canonical.com>
	<4C77DD09.3060909@ladisch.de>	<4C78059B.50801@canonical.com>	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>	<s5h4oec8r6f.wl%tiwai@suse.de>
	<4C7BABA9.1010100@canonical.com>	<s5hlj7ont8e.wl%tiwai@suse.de>
	<4C7E549E.4080505@canonical.com> <s5hr5hczi06.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 9606324624
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 11:24:45 +0200 (CEST)
In-Reply-To: <s5hr5hczi06.wl%tiwai@suse.de>
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

2010-09-02 10:06, Takashi Iwai skrev:
> At Wed, 01 Sep 2010 15:26:54 +0200,
> David Henningsson wrote:
>>
>> 2010-08-30 15:08, Takashi Iwai skrev:
>>> At Mon, 30 Aug 2010 15:01:29 +0200,
>>> David Henningsson wrote:
>>>>
>>>> 2010-08-30 10:01, Takashi Iwai skrev:
>>>>> At Sat, 28 Aug 2010 06:58:20 +0800,
>>>>> Raymond Yau wrote:
>>>>>>
>>>>>> 2010/8/28 David Henningsson <david.henningsson@canonical.com>
>>>>>>
>>>>>>> 2010-08-27 17:43, Clemens Ladisch skrev:
>>>>>>>> David Henningsson wrote:
>>>>>>>>> So I've discovered that my sound card has a "PCM Playback Volume"
>>>>>>>>> control, but changing that control does not alter the volume.
>>>>>>>>>
>>>>>>>>> Interestingly enough, this control does not come from the HDA parser, it
>>>>>>>>> is added by alsactl at boot time...!
>>>>>>>>
>>>>>>>> This control was created by the software volume plugin.  When not using
>>>>>>>> this plugin, the control does not have any effect.
>>>>>>>>
>>>>>>>> To get rid of it, delete its entry from /etc/asound.state.
>>>>>>>
>>>>>>> Hmm, I wonder if this is an Ubuntu-specific bug then? Because when I run
>>>>>>> Maverick (the upcoming Ubuntu release) from a Live-CD, the "PCM Playback
>>>>>>> Volume" control is still there (and there is no asound.state, neither in
>>>>>>> /etc or in /var/lib/alsa).
>>>>>>> When I use the plughw interface, the "PCM Playback Volume" does not
>>>>>>> affect volume output. Should I use another device string to test the
>>>>>>> softvol plugin, to see if it's there or not?
>>>>>>
>>>>>> The softvol plugin it is defined in "front" device in
>>>>>> /usr/share/alsa/cards/HDA-Intel.conf
>>>>>>
>>>>>> reason is some HDA codec does not has any hardware volume control (analog)
>>>>>>
>>>>>> this user-defined control only effective when the application use "front"
>>>>>> device
>>>>>
>>>>> Hm, but if PA opens the device with SND_PCM_NO_SOFTVOL flag, the
>>>>> softvol should be skipped.
>>>>
>>>> But that does not apply to the mixer controls as well, does it?
>>>
>>> It does.  The mixer element is created when this kind of PCM stream is
>>> opened without SND_PCM_NO_SOFTVOL flag.  Then it leaves the control
>>> for the later use, and alsactl saves/restores it.  So, it's a chicken-
>>> and-egg problem.
>>
>> Sounds a little strange to me. Thinking in general, if something is
>> created when a stream is opened, that something should be destroyed when
>> the stream is closed.
> 
> It's not about the stream-level volume.  It's about the global volume.
> There have been bunch of machines that have no h/w volume control.
> This is the mechanism for such environment.  You certainly don't want
> to reset the system-level volume at each time you close the stream.

So if it's about the global volume it should be created on startup
rather than when the stream is opened for the first time.

>>> Of course, it's possible that it wasn't PA who opened the PCM stream.
>>> But, something opened the stream and it created the mixer element.
>>> This is the correct behavior.
>>
>> And once created, it stays there forever...
> 
> Not necessarily forever.  It's alsactl who saves/restores the element
> 
>> So even if PA does not
>> create it, we'll just transform a persistent problem to an suddenly
>> appearing problem?
> 
> Yes, it's just because you started an app that doesn't cope with PA.
> And, it's PA who doesn't cope with softvol setup.  This is the
> conflicting situation.

So as I understand it PA should call snd_pcm_open with the
SND_PCM_NO_SOFTVOL, which it currently does not. It still puzzles me
however how PA manages to open without that flag, which creates a mixer
control, and later on that softvol control has no effect.

> Now the system doesn't know whether you'll start the non-PA app
> again.  So, the volume has to be retained.
> 
>> Anyway, do we want softvol at all for HDA? Wouldn't that be such an
>> unusual use case, that those people that can't adjust volume any other
>> way, can add that softvol themselves in .asoundrc?
> 
> The softvol itself does nothing if the corresponding h/w volume
> control exists.  It's activated only when the corresponding volume
> element is unavailable.

Right, but I have a "Master" volume, a "Front" volume, "Headphone"
volume and so on, so I have all the HW volumes I need, it's just that
none of them happen to be labeled "PCM".

>>>> I think
>>>> we still have a problem with PA assuming that it can change the PCM
>>>> volume control to change the output volume.
>>>
>>> PA can check whether it's a user-defined control or not.
>>
>> Would that be safe - I mean, can't there be user-defined controls PA
>> *should* care about?
> 
> It depends on the driver implementation, but as long as PA does
> software volume control by itself, and as long as the control elements
> are mixer elements, they can be ignored.

Interesting. I went looking into the snd_mixer_selem_* documentation (PA
uses the simple mixer interface), but I couldn't find a function for
determining whether a control is user-defined or not, would you mind
pointing me to it? Thanks!

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
