From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: Fw: writing audiowerk driver (philips saa7146a), some questions
Date: Fri, 31 May 2002 19:11:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <007b01c208ce$bcc5a5b0$0400a8c0@martijn>
References: <001801c2088f$71693120$0400a8c0@martijn><s5hg008h829.wl@alsa2.suse.de><003201c208a3$d8e06030$0400a8c0@martijn><s5helfsh319.wl@alsa2.suse.de><000c01c208b0$a18fd720$0400a8c0@martijn> <s5h7klkh1ba.wl@alsa2.suse.de>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA03968
	for <alsa-devel@alsa-project.org>; Fri, 31 May 2002 19:12:52 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > i don't think the audiowerk is the only card capable of varipitch,
though
> > most cards don't support it, but it is a nice feature and since alsa is
> > supposed to be advanced... :)
>
> many consumer chips support in fact, too, such as emu10k1, ymfpci,
> cs46xx (also trident?)  sbawe and gus have pcms using synth

so it will be added? the best would be to have a pitch range for every
nominal sample rate as in EASI
 http://www.emagic.de/english/support/easi/index.html )


> > > alsa pcm engine invokes a timer interrupt to update the "tick", and
> > > this tick is determined using the rate of the runtime instance.
> > > if you change the rate value dynamically during playback, then the
> > > tick interrupt will be wrongly scheduled, and leads to wrong detection
> > > of under/overrun.
> >
> > shouldn't the driver detect under/overrun?
>
> yes.  that's why i mentioned above.  if you don't change rate
> value in runtime instance, then the alsa driver tries to schedule tick
> interval as if it's not changed.  and this causes inconsistency
> between the real-playback and tick time, eventually leading to a bogus
> detection of under/overrun.

i am lost. a under/overrun could (should) be detected from the interrupt
handler
for the card dma channel (period interrupt), right? that would never fail.

> > would a soundcard with a bad dac (as in not accurate) also cause
> > problems?
>
> if the hardware is too inaccurate (e.g. accumulated error over more
> than HZ), then, yes.   but i don't think this may happen.

i am afraid i don't understand this and i don't now where i can find
documentation
on it. how do other driver writers do this? read the source? or an API
reference?
is there no overview on the architecture? reading driver source code is not
the
easiest or fastest way to understand what's going on, if it is at all
possible to
understand without knowledge of the specific hardware.

does hardware allow to have a device specific kernel driver with an
associated
device specific user-space part? this would be much easier to implement for
me
than an alsa kernel driver i think.

--martijn





_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
