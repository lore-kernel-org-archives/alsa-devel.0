From: rct@frus.com (Bob Tracy)
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Tue, 11 Mar 2008 13:08:31 -0500 (CDT)
Message-ID: <20080311180831.8CE90DBA3@gherkin.frus.com>
References: <47D6A28C.4060804@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 597B02454D
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 19:08:40 +0100 (CET)
In-Reply-To: <47D6A28C.4060804@keyaccess.nl> "from Rene Herman at Mar 11, 2008
	04:17:32 pm"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Bob Tracy <rct@frus.com>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> This is behaviour consistent with the IRQ being dead ...
>
> I suppose it used to work and I suppose the behaviour 
> you are describing above is 100% repeatable?

I can't tell you exactly *when* it used to work, or even *if* it did
with 2.6 kernels.  I'll try to explain...

Sometime back in the 2.6.14 to 2.6.16 timeframe there was an issue with
the ALSA driver not recognizing interrupts (causing looping).  Tyson
Whitehead had put together a patch for the interrupt problem that worked
for him, but not for me or Michael.  One workaround back then was using
the snd-sb8 driver that supports only one DMA channel (half-duplex
operation) anyway: that was a reliable workaround, and may be what I'm
remembering for the "it used to work" case.  I can't find any reliable
evidence that I've *ever* been able to use the ES1888 with its proper
driver under ALSA with 2.6 kernels.  As far as Tyson's patch, I know
he reported it upstream to the ALSA developers, but I saw no followup
communication from either Tyson or the developers.

> Given that you can use aplay -- probably no difference with "aplay -M" ?

I'll give it a shot.

> To get to the bottom of this we might need to get a specific failed version 
> (for readers, it's not been verified that this is a regression since 2.6.24) 
> but we can try to get lucky first.

I'm beginning to think this is *not* a regression, but merely a long-
standing ALSA issue that was never addressed.  I would be fine with
reclassifying this as an ALSA bug and dropping linux-kernel from the
discussion.

> Okay. (tests) seem to at least confirm it's not the 16-bit DMA.

As far as how to proceed from here, I'm certain things were broken in
2.6.1[4-6].  I could try various later releases between .16 and .24 to
see if snd-es18xx worked for any of those, but I think the answer will
be "no."  I think a useful test would be to see if "snd-sb8" works in
2.6.25-rcX, which would at least narrow things down a bit.

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
