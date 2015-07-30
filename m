From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [RFC PATCH 1/4] ALSA: core: let low-level driver
 or userspace disable rewinds
Date: Thu, 30 Jul 2015 11:11:22 +0500
Message-ID: <55B9C00A.4080507@gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <55A14D23.3070600@gmail.com> <55B78F74.1020601@linux.intel.com>
 <55B7A311.5070905@gmail.com> <55B91171.2060809@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B086265A6F
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 08:11:25 +0200 (CEST)
Received: by wibxm9 with SMTP id xm9so229311337wib.0
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 23:11:25 -0700 (PDT)
In-Reply-To: <55B91171.2060809@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

29.07.2015 22:46, Pierre-Louis Bossart wrote:
> On 7/28/15 10:43 AM, Alexander E. Patrakov wrote:
>> 28.07.2015 19:19, Pierre-Louis Bossart wrote:
>>> On 7/11/15 12:06 PM, Alexander E. Patrakov wrote:
>>
>>>> 3. I have not seen any justification for the drastic measure of
>>>> making a
>>>> DMA-based device completely unrewindable. Maybe a more polite "please
>>>> make this a batch/blocktransfer card" request, thus disallowing only
>>>> sub-period rewinds, would still be useful for powersaving, without
>>>> killing dmix.
>>>>
>>>> 4. If this "no rewinds" mode is not made the default, then exactly
>>>> nobody will use it. Everyone except sound servers opens the default
>>>> device with the default flags. I understand the potential to break
>>>> existing userspace, especially PulseAudio, but we really need to think
>>>> more here.
>>>
>>> Not sure I understand the issue. when a new functionality is added it
>>> takes time to be adopted. If we can push it in sound servers first then
>>> it creates a wide pool of users from day1.
>>
>> The issue is that the proposed functionality, in the currently proposed
>> "I promise to never rewind" form, is nearly useless by its very nature
>> for any sound server that cares about power consumption significantly
>> more than dmix does. It is indeed usable by JACK (by its design, it
>> doesn't rewind, and uses low latency) and CRAS (which currently doesn't
>> rewind, but I am not sure whether this is a bug or a deliberate decision
>> based on non-public measurements of extra power savings that "rewinds +
>> high latency" would allow).
>>
>> As I have already explained, dmix, when mixing, writes to the hardware
>> buffer multiple times, which is equivalent to rewinding. PulseAudio uses
>> rewinds for a very specific purpose - to avoid CPU wakeups in the common
>> "nothing unexpected happened" case, i.e. to allow very high average
>> latency while keeping the latency of reaction to unexpected events low.
>> So, by convincing PulseAudio to never rewind and to tell the driver
>> about this fact, you can save some power in the card, but (if the
>> proponents of rewinds are right - see my earlier request for non-public
>> information) will waste way more power due to the need for much more
>> frequent CPU wakeups ("cannot rewind but have to react to unexpected
>> events within 20 ms" = "must wake up every 20 ms").
>>
>> The only cases where this flag can be useful for sound servers are:
>>
>> 1. Sound servers that already, by design, always waste CPU power by
>> running at low latency;
>
> Your classification is not exhaustive enough. You need to take into
> account sound servers that have two outputs per endpoint, one for
> low-latency and one for low-power/deep-buffer with a DSP/hardware mixer.
> Power is also no longer directly linked to wakeup rates only but also to
> DDR access patterns.
> When a larger on-chip buffer is available, disabling rewinds does let
> the hardware know it can safely fetch data in bigger chunks rather than
> use small data bursts.
> This sort of capabilities is becoming prevalent these days, and not just
> on Intel platforms - see e.g. Nexus5/9 devices -, and maybe PulseAudio
> and friends need to evolve to make use of these resources rather than
> stay the course with single output and rewind mechanisms that prevent
> power optimizations on newer platforms.

OK, I see some new points there, but still no full picture. My point 
still is: deep (>= 30-40 ms) buffer without rewinds or without any other 
means to seamlessly cancel and replace what's there (up to a certain 
unrewindable latency, i.e. the same 30-40 ms, that a human won't object 
to) is absolutely useless to any current or future sound server.

So, in your example, "I promise to never rewind" flag can definitely be 
set for a low-latency endpoint, but not for the other one. That other 
endpoint would benefit from a way to say "I promise to never rewind 
closer than X samples to the hardware pointer" API, which you have 
flagged as a separate discussion. I would also not object to that 
endpoint becoming a batch/blocktransfer PCM.

Well, there is a hackish way to say "I promise to never rewind" on both 
endpoints even with a deep buffer on a low-power endpoint. The way is: 
instead of rewinding, open the low-latency endpoint and play a 
correction signal (i.e. the difference between the actual and the wanted 
contents of the deep buffer) through it, with low latency, and let the 
hardware mix. But I don't like this, for purely subjective reasons and 
for the need for that endpoint to have twice as much output amplitude 
than one would normally need. What do you propose instead?

Still, I think that a more general API that says "I promise to never 
rewind closer than X samples to the hardware pointer" would be more 
useful than the black-and-white "I promise to never rewind" call - 
assuming that it can be expressed to the hardware.

-- 
Alexander E. Patrakov
