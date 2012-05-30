From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Internal Mics and Speakers not visible in
	PulseAudio
Date: Wed, 30 May 2012 21:53:58 +0200
Message-ID: <4FC67AD6.8020001@canonical.com>
References: <4FC616B8.3090608@canonical.com> <s5hehq1lnt9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FA661043B2
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 21:53:56 +0200 (CEST)
In-Reply-To: <s5hehq1lnt9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

On 05/30/2012 04:56 PM, Takashi Iwai wrote:
> At Wed, 30 May 2012 14:46:48 +0200,
> David Henningsson wrote:
>>
>> Posted to both alsa-devel and pulseaudio-discuss lists, as this is a
>> cross issue.
>>
>> PulseAudio tries to figure out what equipment is present on the machine
>> using the mixer. If it finds e g "Headphone Playback Volume", "Headphone
>> Playback Switch", or "Headphone Jack", it assumes that a headphone is
>> present and creates a headphone port. If it finds no ports, it creates a
>> fallback "Analog Output" port.
>>
>> Now assume that we have a laptop with speakers and a headphone jack, but
>> with only a "Master Playback Volume", and a "Headphone Jack" for the
>> jack detection.
>> PulseAudio will take the "Headphone Jack", and create a headphone port.
>> Now, if this port is currently unconnected/unavailable, it will not show
>> up at all [1]. As a result, the internal speakers - for which no port
>> was created - will be essentially unusable.
>>
>> Now, I thought this was a problem with a pair of machines only, that we
>> could easily quirk on the PulseAudio side. But after looking through
>> Ubuntu bugs and posting a blog post [2] about the issue, I have now
>> collected 21 different machines affected, mostly on the input side.
>> Several Realtek chips are affected on the dmic side, and some older
>> STAC92xx chips have problems in both directions.
>> So it becomes evident to me, that this is something that needs to be
>> fixed pretty fast.
>>
>> So, to move forward, we need to expose these speakers and internal mics
>> to userspace. A very simple (untested) patch is attached. This would
>> make "Internal Mic Jack" and "Speaker Jack" show up. Note that the
>> actual status can be overridden/ignored on the PulseAudio side - the
>> importance here is the sign that there are internal mics and speakers,
>> so that the PulseAudio ports get created.
>>
>> I could develop it a little to make sure we don't actually do any jack
>> detection for these pins but always return them as being true/present.
>> That is, if you approve the idea? I admit that the "Internal Mic Jack"
>> is somewhat misleading/hacky as the internal mic is not connected to any
>> physical jack, but it seems like the simplest way of resolving the
>> problem currently.
>
> I've thought of a similar change, but I postponed it because of some
> concerns:
> - the control actually is no-op as it's a fixed pin;
>    IOW, should we really perform the jack-detection verb on such a pin?

I don't think we should perform the actual verb on these devices.

> - as you mentioned, should it be really named as "Jack"?
>
> The second point is just a matter of formality.  We can regard "Jack"
> as the suffix to indicate the pin information.  But the behavior jack
> ctl of such fixed pins should be defined exactly.

I would like us to be able to distinguish the "phantom" Jacks from the 
real ones. We can do this either by
  1) Adding a third state - this might require us to change the type 
from BOOLEAN to something else, I don't know how backwards compatible 
such a change could be, or
  2) Instead of calling them "Jack", we could have another suffix [1]. 
We could still have them as BOOLEAN and always return TRUE.

  3) This is probably a bit overkill, as PulseAudio can do without that 
functionality anyway, but one could consider the speaker presence 
turning to FALSE when headphones are plugged in and then back to TRUE 
when headphones are unplugged - but only if "Automute mode" is enabled.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] s/J/H ;-)
