From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Radeon unconnected HDMI eats samples at 280 kHz
Date: Thu, 18 Sep 2014 09:54:10 +0200
Message-ID: <541A8FA2.7090406@canonical.com>
References: <54198F38.30002@canonical.com>	<5419FC9E.9010302@iki.fi>	<541A5BCD.2040105@canonical.com>
 <s5hlhph8jt5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 73DEF260824
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 09:54:12 +0200 (CEST)
In-Reply-To: <s5hlhph8jt5.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, Anssi Hannula <anssi.hannula@iki.fi>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 2014-09-18 09:33, Takashi Iwai wrote:
> At Thu, 18 Sep 2014 06:13:01 +0200,
> David Henningsson wrote:
>>
>>
>>
>> On 2014-09-17 23:26, Anssi Hannula wrote:
>>> 17.09.2014, 16:40, David Henningsson kirjoitti:
>>>> Hi,
>>>
>>> Hi,
>>>
>>>> While investigating some interesting debug output from PulseAudio, I
>>>> tried to figure out the cause.
>>>>
>>>>    From what I can tell, my Radeon seems to ask for new samples at a very
>>>> high rate, which I estimate to be around 280 kHz. My radeon card has
>>>> DVI, HDMI and VGA connectors, and the only thing connected is my screen
>>>> over DVI.
>>>>
>>>> I'm currently running the 3.13 kernel with updated hda directory from
>>>> Takashi's tree, but I think it's been this way for a long time.
>>>>
>>>> Note that if a screen is connected to the HDMI card, the problem
>>>> disappears and sample rates are normal.
>>>> In short, do you think this is a driver bug, or just something we have
>>>> to live with as some sort of hw anomaly?
>>>> Since nothing is connected, it does not really hurt, except PulseAudio
>>>> gets confused (in a way that could potentially cause problems for
>>>> low-latency output, should something be connected later on).
>>>
>>> Not sure.
>>> IIRC, unlike the other gpus, on radeon the video driver needs to
>>> "manually" set sample rate dividers/etc based on the pixel clock rate,
>>> so I guess this might mean we can't have a proper audio clock without
>>> enabled video...
>>>
>>> Alex, any thoughts/info?
>>>
>>>
>>> If this is the case, it would probably be best if we prevented opening
>>> the device when output is not active (unless this causes some other
>>> issues), but I guess there is currently no easy way for the _audio_
>>> driver to know that...
>>
>> Well, if jack detection (get pin sense) works, there is.
>
> Does it react if we turn off the HDMI output via xrandr, too?
> I'm not sure whether we need reprogram things in that case, though...

xrandr correctly reports that "HDMI-0" is disconnected.

I'm not sure how to turn the HDMI output via xrandr, but I tried "xrandr 
--output HDMI-0 --off" and it made no difference in either xrandr 
output, nor in codec/eld output.

What I'm thinking is that it could be that the monitor_present is 
indicating the presence of my DVI monitor, as some cards are capable of 
outputting HDMI audio on their DVI outputs (through a passive DVI->HDMI 
adapter). This is just a guess though.

>> There are two
>> major problems with that though:
>>
>> 1) When I look right here and now, it seems like jack detection returns
>> "plugged in" status, and ELD info reports monitor_present=1,
>> eld_valid=0. So pin sense isn't really working (or maybe it reports that
>> my DVI monitor is plugged in, which isn't helpful here). I'm attaching
>> codec proc info in case it's helpful.
>>
>> 2) It requires major work in PulseAudio to make sure we re-probe the
>> HDMI device when it is plugged in. We should do that anyway, it's just
>> that it is quite some work to do, and noone has done it yet.
>
> Would it make easier if we create/delete HDMI PCM on the fly?  Or it's
> rather confusing?

I don't think that would make it any easier for PulseAudio, if anything 
it would be more complicated - we would then have to listen to PCM 
devices appearing and disappearing and reprobe, instead of listening to 
jack detection events and reprobe based on that.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
