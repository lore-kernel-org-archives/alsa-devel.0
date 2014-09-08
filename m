From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Master Plan on rewinding
Date: Mon, 08 Sep 2014 09:59:00 +0200
Message-ID: <540D61C4.90206@canonical.com>
References: <540C76E0.9050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 534512619DD
 for <alsa-devel@alsa-project.org>; Mon,  8 Sep 2014 09:58:50 +0200 (CEST)
In-Reply-To: <540C76E0.9050808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org



On 2014-09-07 17:16, Alexander E. Patrakov wrote:
> Hello.
>
> (TL;DR: nothing really new except the strawman proposal about threads
> and the note about interaction of variable sample rate with rewindability)

So, having looked this through another time, it looks like we have three 
categories of ALSA devices, from rewindability point of view:

  1) Not rewindable at all.

  2) Rewindable down to the period size.

  3) Rewindable even further than the nearest period, down to DMA 
transfer sizes or something else. This also requires the .pointer to 
have better granularity than the period size.

So I think any is_seekable() call or flag should indicate whether the 
device is case 1), 2) or 3). And for case 3) perhaps also some indicator 
of the actual rewind granularity and/or safeguard. This should be enough 
for PA to be able to pick a suitable default latency.

Case 1) is simple. Just let snd_pcm_rewindable return 0 and 
snd_pcm_rewind fail. If it doesn't, just fix it. (The extplug problem 
could be solved by PA having ifdefs depending on alsa-lib version, 
rather than making snd_pcm_rewind and snd_pcm_rewindable behave 
inconsistent.)

For case 2) you seem to suggest to emulate case 3) by using either a 
low-latency thread, or by increasing the number of interrupts from the 
hardware. Either method will inevitably increase power consumption, and 
the former might also increase the risk of glitches. Therefore I think 
this is replacing something bad with something worse, because I would 
value low power consumption higher than better rewinding.

Could we enable this functionality by explicit request by the 
application? Probably. E g, if the application sets a low period size 
but also sets the "disable period interrupts" flag, that could be an 
indicator that it wants lots of interrupts just to update the pointer, 
but nothing else. Maybe that's even the behaviour today (haven't checked).

The low-latency thread approach could be implemented by a separate 
ioplug layer, so that people who want it could open 
"flexiblerewind:plug:hw:0" instead of "plug:hw:0".

However, with my PA hat on, I would still say no to having PA use either 
of those by default, for power consumption reasons.

With that in mind I suggest, just as you, that we add 
.rewind/.rewindable callbacks to the ioplug layer. Any ioplug using 
.transfer needs to implement that if it wants to support rewinding, 
otherwise that ioplug would fall into category 1).

Does that make sense? It was a long email, so I might have missed 
something. :-)

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
