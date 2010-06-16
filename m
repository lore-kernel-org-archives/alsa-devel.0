From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Bug in alsa-lib or alsamixer and amixer
Date: Wed, 16 Jun 2010 22:47:38 +0100
Message-ID: <hvbgo6$3fg$1@dough.gmane.org>
References: <AANLkTikawWMIPuuahzJuqnqHTW0MsRZWaP1c3O4pY8N7@mail.gmail.com>	<hv912l$j53$1@dough.gmane.org>
	<AANLkTimeqs9dKkCemPzmrdYCboH-uxW5FkfLgiWFZEPl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id DB7471038F7
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 23:46:55 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OP0Rj-0007lP-2N
	for alsa-devel@alsa-project.org; Wed, 16 Jun 2010 23:46:55 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2010 23:46:55 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2010 23:46:55 +0200
In-Reply-To: <AANLkTimeqs9dKkCemPzmrdYCboH-uxW5FkfLgiWFZEPl@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 16/06/10 07:33 did gyre and gimble:
> 2010/6/16 Colin Guthrie <gmane@colin.guthr.ie>
> 
>> The fact that any key changes it back to 100% is kinda expected. It's
>> not designed to handle values >100% so it makes sense that it clamps it.
>> Annoying, but it makes sense.
>>
>>> The volume range is only from 0 to  65536
>>>
>>> why did alsa-lib allow alsa-pulse plugin to set it outside the range ,
>>> alsamixer and amixer also display 150% ?
>>>
>>> amixer -D pulse
>>> Simple mixer control 'Master',0
>>>   Capabilities: pvolume pswitch pswitch-joined
>>>   Playback channels: Front Left - Front Right
>>>   Limits: Playback 0 - 65536
>>>   Mono:
>>>   Front Left: Playback 98304 [150%] [on]
>>>   Front Right: Playback 98304 [150%] [on]
>>
>>
>> While I agree this could be thought of as a bug, it's actually the
>> nicest possible display for a system that has no concept of volumes > 100%.
>>
>> That said, the correct fix would be a nice mechanism for marking the
>> 100% mark. e.g. specifying the limits as a triplet, lower, normal (aka
>> 100%) and max.
>>
>> AFAIK, no such system is currently in place.
>>
>> An alternative would be to scale the alsa volume control to the full
>> range, e.g. make 0 - 98304[1] the range it accepts. But this sucks as
>> the percentage shown in alsa is not the same as the percentage shown in
>> other GUIs.
>>
>> In a practical sense, the current setup is probably less problematic
>> than the latter suggestion.
>>
>> Col
>>
>> [1] FWIW, this precice value will likely change. I've not yet actioned
>> it but it's likely to be fixed at +11dB which IIRC is slightly above
>> 150%. 11dB is just a figure that we felt was "sensible" with regards to
>> GUI consistency and I'll try and push this out ot all the UIs I can.
>>
>>
>>
> You have made a big mistake , please study the source code of alsamixer and
> amixer

I don't see my "big mistake" to be honest. I'm just describing the
behaviour and stating the fact that I think it's preferable to the
alternatives.

> Simple mixer control 'PCM',0
>   Capabilities: pvolume pswitch pswitch-joined
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 31
>   Mono:
>   Front Left: Playback 31 [100%] [12.00dB] [on]
>   Front Right: Playback 31 [100%] [12.00dB] [on]
> 
> 
>     control.39 {
>         comment.access 'read write'
>         comment.type INTEGER
>         comment.count 2
>         comment.range '0 - 31'
>         comment.dbmin -3450
>         comment.dbmax 1200
>         iface MIXER
>         name 'PCM Playback Volume'
>         value.0 31
>         value.1 31
>     }
> 
> ---------------------------------------------------------------------
> 
> Simple mixer control 'PCM',0
>   Capabilities: pvolume pswitch pswitch-joined
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 31
>   Mono:
>   Front Left: Playback 23 [74%] [0.00dB] [on]
>   Front Right: Playback 23 [74%] [0.00dB] [on]
> 
> 
>     control.39 {
>         comment.access 'read write'
>         comment.type INTEGER
>         comment.count 2
>         comment.range '0 - 31'
>         comment.dbmin -3450
>         comment.dbmax 1200
>         iface MIXER
>         name 'PCM Playback Volume'
>         value.0 23
>         value.1 23
>     }

Like much of the content in many of your posts I don't really see why
the above is especially needed but hey....

> The percentage displayed below the vertical slider in alsamixer and the
> percentage after the dB values are the percentage of the current step / the
> total number of step

Right, so the standard definition of a percentage....

> so you cannot get any percentage > 100% in alsamixer and amixer

I know, that's what I said.

> snd_mixer_selem_get_playback_volume_range()  of PCM return min =0 and max=
> 31
> at 0dB the percentage is 23/32  about 74%  since 0dB is step 23 in  step 0
> -34.5dB , step31 is 12dB (the difference between step is 1.5dB

OK, so in short, you'd be of the opinon that we should scale things so
that the alsa mixer %age display is different to that in PA clients.
That's fine, that's your opinion. Personally, I'm off the opposite
opinion but hey.

> This percentage in alsamixer and amixer is not those volume scale which you
> described  BASE_VOLUME  or PA_NORM

It is PA_VOLUME_NORM. When the value is PA_VOLUME_NORM, the alsamixer is
at 100%. When you go above that, alsa cannot handle it (which is fine,
it wasn't designed to).

So as I said in my original mail there two approaches to this. Scale the
full range of PA volumes to the 100% scale and be done with it (tho' PA
allows a significant amount > PA_VOLUME_NORM (although sensible values
are of course limited - like I said before about +11dB/~150% is about as
much as you'd likely want to go) so that PA_VOUME_NORM in alsa != 100%
unlike in PA clients.... or you add the ability to define different
points on the scale in alsa (e.g. min, base, norm, max) where base ==
norm = max when only two are given for backwards compatibility.

That said, I doubt very much it's worth the effort just to maintain
compatibility with the PA plugin... doesn't really seem worth it to me
as it's just a compatibility layer really and most mixer GUIs that care
about pulse (i.e. the ones you should be using on a system that has
pulse enabled) wont use this layer for their mixer functionality anyway.
I certainly wouldn't loose much sleep over it.


Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
