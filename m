From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Bug in alsa-lib or alsamixer and amixer
Date: Wed, 16 Jun 2010 00:07:52 +0100
Message-ID: <hv912l$j53$1@dough.gmane.org>
References: <AANLkTikawWMIPuuahzJuqnqHTW0MsRZWaP1c3O4pY8N7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 6442510382F
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 01:07:17 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OOfDt-0002be-1b
	for alsa-devel@alsa-project.org; Wed, 16 Jun 2010 01:07:13 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2010 01:07:13 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2010 01:07:13 +0200
In-Reply-To: <AANLkTikawWMIPuuahzJuqnqHTW0MsRZWaP1c3O4pY8N7@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 15/06/10 23:29 did gyre and gimble:
> 2010/6/16 Colin Guthrie <gmane@colin.guthr.ie>
> 
>> 'Twas brillig, and Raymond Yau at 15/06/10 00:43 did gyre and gimble:
>>> +12dB(400%) is even larger than the software gain 150% of PA
>>
>> Software gain of PA 150% = ~+11dB, so not as different as you imply.
>>
>> I've explained the cubic mapping already, so please don't use arbitrary,
>> differently calculated percentages when comparing things. It's like
>> comparing apples to oranges.
>>
>> Col
>>
>>
> When I changed the volume slider of the gnome sound applet ( select
> perference ) in Fedora 13 to maximum (i.e. PA 150% )
> 
> Seem to be bug in amixer and alsamixer
> 
> alsamixer also change to 150% but press any key change back to 100%

The fact that any key changes it back to 100% is kinda expected. It's
not designed to handle values >100% so it makes sense that it clamps it.
Annoying, but it makes sense.

> The volume range is only from 0 to  65536
> 
> why did alsa-lib allow alsa-pulse plugin to set it outside the range ,
> alsamixer and amixer also display 150% ?
> 
> amixer -D pulse
> Simple mixer control 'Master',0
>   Capabilities: pvolume pswitch pswitch-joined
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 65536
>   Mono:
>   Front Left: Playback 98304 [150%] [on]
>   Front Right: Playback 98304 [150%] [on]


While I agree this could be thought of as a bug, it's actually the
nicest possible display for a system that has no concept of volumes > 100%.

That said, the correct fix would be a nice mechanism for marking the
100% mark. e.g. specifying the limits as a triplet, lower, normal (aka
100%) and max.

AFAIK, no such system is currently in place.

An alternative would be to scale the alsa volume control to the full
range, e.g. make 0 - 98304[1] the range it accepts. But this sucks as
the percentage shown in alsa is not the same as the percentage shown in
other GUIs.

In a practical sense, the current setup is probably less problematic
than the latter suggestion.

Col

[1] FWIW, this precice value will likely change. I've not yet actioned
it but it's likely to be fixed at +11dB which IIRC is slightly above
150%. 11dB is just a figure that we felt was "sensible" with regards to
GUI consistency and I'll try and push this out ot all the UIs I can.


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
