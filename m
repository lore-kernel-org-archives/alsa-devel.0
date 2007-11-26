From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: Re: POSIX clocks and ALSA
Date: Mon, 26 Nov 2007 12:10:51 +0200
Message-ID: <474A9BAB.9000601@cs.helsinki.fi>
References: <474A763E.7090001@cs.helsinki.fi>	<Pine.LNX.4.61.0711260848180.7571@tm8103.perex-int.cz>	<474A7CE1.7080904@cs.helsinki.fi>
	<s5h63zpph0s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh03.mail.saunalahti.fi (emh03.mail.saunalahti.fi
	[62.142.5.109]) by alsa0.perex.cz (Postfix) with ESMTP id AE22E247A8
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 11:10:54 +0100 (CET)
In-Reply-To: <s5h63zpph0s.wl%tiwai@suse.de>
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

Takashi Iwai kirjoitti:
> At Mon, 26 Nov 2007 09:59:29 +0200,
> Heikki Lindholm wrote:
>> Jaroslav Kysela kirjoitti:
>>> On Mon, 26 Nov 2007, Heikki Lindholm wrote:
>>>
>>>> Hello,
>>>>
>>>> Some years ago there was some talk about UST support in Linux, but the 
>>>> support never happened. With the hrtimers patch (and I'm not quite sure 
>>>> if even earlier?) CLOCK_MONOTONIC would seem like a fairly good UST time 
>>>> source. What I'd like to see, is a selectable clock for ALSA 
>>>> timestamping, e.g. something like snd_sw_params_clock(..., clockid_t 
>>>> clk). Would this seem plausible? I don't know that much about ALSA 
>>>> internals, so, no idea whether different clocks on different 
>>>> pcms/whatever would quickly turn into an unmanageable mess.
>>> We are aware about this extension and I already proposed an 
>>> implementation. I hope to implement it soon. Timestamps are not used in 
>>> driver internally.
>> I can't seem to google up the proposal. I'd like to read it; was it on 
>> the alsa ml?
> 
> Yes, it was on alsa-devel ML.  At that time I didn't like the proposal
> much because currently there was no real user of timestamps.

What do you mean by this? Aren't all applications that try to do 
playback/capture A/V sync or sync between two audio cards or latency 
measurement potential users? And those kind of apps have definitely been 
there before 2007-02 (Jaroslav's RFC's date.) If you mean _monotonic_ 
timestamps, not all users would probably care, though.

-- Heikki Lindholm
