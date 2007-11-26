From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: Re: POSIX clocks and ALSA
Date: Mon, 26 Nov 2007 18:18:42 +0200
Message-ID: <474AF1E2.4000405@cs.helsinki.fi>
References: <474A763E.7090001@cs.helsinki.fi>
	<Pine.LNX.4.61.0711260848180.7571@tm8103.perex-int.cz>
	<474A7CE1.7080904@cs.helsinki.fi> <s5h63zpph0s.wl%tiwai@suse.de>
	<474A8706.1070102@cs.helsinki.fi>
	<Pine.LNX.4.61.0711261356480.9577@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh05.mail.saunalahti.fi (emh05.mail.saunalahti.fi
	[62.142.5.111]) by alsa0.perex.cz (Postfix) with ESMTP id 484C324841
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 17:18:48 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0711261356480.9577@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela kirjoitti:
> On Mon, 26 Nov 2007, Heikki Lindholm wrote:
> 
>> Takashi Iwai kirjoitti:
>>> At Mon, 26 Nov 2007 09:59:29 +0200,
>>> Heikki Lindholm wrote:
>>>> Jaroslav Kysela kirjoitti:
>>>>> On Mon, 26 Nov 2007, Heikki Lindholm wrote:
>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> Some years ago there was some talk about UST support in
>>>>>> Linux, but the support never happened. With the hrtimers
>>>>>> patch (and I'm not quite sure if even earlier?)
>>>>>> CLOCK_MONOTONIC would seem like a fairly good UST time
>>>>>> source. What I'd like to see, is a selectable clock for ALSA
>>>>>> timestamping, e.g. something like snd_sw_params_clock(...,
>>>>>> clockid_t clk). Would this seem plausible? I don't know that
>>>>>> much about ALSA internals, so, no idea whether different
>>>>>> clocks on different pcms/whatever would quickly turn into an
>>>>>> unmanageable mess.
>>>>> We are aware about this extension and I already proposed an
>>>>> implementation. I hope to implement it soon. Timestamps are not
>>>>> used in driver internally.
>>>> I can't seem to google up the proposal. I'd like to read it; was it
>>>> on the alsa ml?
>>> Yes, it was on alsa-devel ML.  At that time I didn't like the proposal
>>> much because currently there was no real user of timestamps.
>>>
>>> The addition of monolithc clock isn't hard, but it's an API change
>>> that involves with the kernel-side change.  So let's do it carefully.
>>>
>>> But, honestly, I'm still concerned what to be done first.  Shouldn't
>>> we discuss about the usefulness of the timestamp at first?  That is,
>>> whether the current form (API, implementation) is the best or not,
>>> what kind of user would be, and how it's used.  So far, this feature
>>> is "simply there"...
>> IMHO the current API definitely isn't the best possible, but nothing 
>> better has been available on Linux, so it's a make-do situation. My 
>> ideal would be something resembling or even 1:1 copying SGI's media 
>> libraries where every media fragment is timestamped with the UST, and 
>> the timestamps are the starting time of the media chunk in question 
>> instead of ending/sometime after time. The problem with implementing the 
>> SGI API on Linux is that AFAICT no Linux supported/available hardware 
>> supports such timestamping.
> 
> Unfortunately, we are not using audio "packets" at the moment, but 
> basically, it shouldn't be difficult to implement - think one period == 
> one packet.

Exactly what I was thinking. Maybe extend the mmap interface so that 
timestamps for every period are saved and can be queried. Then create 
(swipe from v4l2) a packet interface on top of the mmap code. Having the 
timestamp telling the buffer start time instead of end would be nice, 
too, and shouldn't be too problematic - periods are small enough, so 
that a constant offset can be used without causing much theoretical drift.
One nice thing about the SGI API is that it works for playback, too. 
When you send a packet for playback, on return, it fills in the actual 
playback time. This can/could be much more accurate than the usual 
get_delay / gettimeofday pair that's used in applications now.

>> Additionally, it might be nice to be able to add audio clocks as system 
>> wide clocks, so, that for example I could tell v4l to use timestamps 
>> from an audio clock instead of the system clock.
> 
> It's something I don't like. If you have multiple soundcards, it might be 
> problematic to select a proper audio device for sync.

Not to speak of trying to invade outside of sound/ with new clocks.. But 
that's just an idea.

-- Heikki Lindholm
