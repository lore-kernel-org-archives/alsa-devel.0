From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Speaker burnout
Date: Tue, 07 Apr 2015 09:09:00 +0200
Message-ID: <5523828C.8060301@canonical.com>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <551A6A15.1070605@canonical.com>
 <1427796392.581386.247465613.43178C71@webmail.messagingengine.com>
 <551A7A4D.203@canonical.com> <55236B93.9070504@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 934E72605DF
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 09:08:58 +0200 (CEST)
In-Reply-To: <55236B93.9070504@blennerhassett.gen.nz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>, "Nikita N." <nikitan@operamail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org



On 2015-04-07 07:30, Eliot Blennerhassett wrote:
> On 31/03/15 23:43, David Henningsson wrote:
>>
>>
>> On 2015-03-31 12:06, Nikita N. wrote:
>>>> If you have any concrete examples (alsa-info please!) of speakers that
>>>> can be burned out, and you know a maximum speaker volume where this
>>> As we said, that is not our bug, we are not audio experts, nor any of us
>>> is interested in audio matters.
>>
>> Here's my suggestion how to move forward on this:
>>
>>   1) Gather consensus that limit the maximum volume on internal speakers
>> is the right way forward. Takashi, Clemens, anyone against that strategy?
>
> I'm not sure about this (though in the end it doesn't affect me).  Just
> running some experiments on my laptop. (HDA intel PCH sound)
>
> Playing some ordinary music, the level from the internal speakers is
> comfortable when master and PCM gains are set to maximum.
>
> At this setting, enabling the internal mic feedthrough with mic boost
> set to maximum,  feedback happens when mic playback gain is at -6dB
> (max=+12dB).
> The signal when recorded is 1325Hz rail to rail square wave.
>
> My point is that in this case for normal usage the maximum output is
> fine, I'd even say it is required.  So limiting output would not be a
> good idea.
> Also when using the mic for speech capture (with headphones for output),
> a gain greater than the 'feedback inducing' one is likely to be useful.
>
> So it is (only?) the pathological case of feeding mic direct to speakers
> that is problematic.
>
> Given that we can't fix the hardware or wacky user behaviour,
> My suggestion would be to either limit, or hide completely the various
> "Mic Playback" controls that enable direct feed from input to output.
> What is the use case for this anyway? - karaoke?
>
> Given that this goes against the "expose everything in the hardware",
> maybe have a module option that can unhide these controls if anybody
> actually wants to use them.

On one hand I find your arguments convincing, because limiting internal 
mic playback volume is far less of a limitation (almost no people use 
it), compared to limiting the internal speaker volume.

What bothers me is the following reasoning: If it is possible to burn 
your speakers out by having the speakers outputting some tone caused by 
feedback, would it not be possible to also burn your speakers out by 
simply having a wave file with the same tone and playing it back?

E g, imagine a malicious web page that starts playing this tone back as 
soon as you visit it. Would it be able to cause hardware damage to your 
speakers, if you happened to have the speaker volume at maximum when you 
visited that web page?
Or is there something that causes the feedback tone to be of a larger 
amplitude than could ever be produced by the wave file?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
