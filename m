From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: hdspmixer segfault (1.0.24+)
Date: Mon, 28 Feb 2011 22:21:56 +0100
Message-ID: <4D6C11F4.6000408@drcomp.erfurt.thur.de>
References: <4D69A0FC.60400@localhost>	<20110227111708.GK15327@ltw.loris.tv>	<4D6AA448.7050401@localhost>	<4D6AE436.6000201@localhost>	<4D6BCB59.30709@drcomp.erfurt.thur.de>
	<AANLkTikr=sBcis_2V=qm9jgWha3P6QR2-xiY9WpXw+vH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 2587E2437E
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 22:22:17 +0100 (CET)
In-Reply-To: <AANLkTikr=sBcis_2V=qm9jgWha3P6QR2-xiY9WpXw+vH@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Craig Bourne <craigbourne@gmail.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/28/11 18:23, Craig Bourne wrote:

> PCI Busmaster Digital I/O System
> 2 + 24 Channels SPDIF / ADAT Interface

I've digged into the driver source. Your H9652 is more or less a
Digiface. The channel *count* was never a question, this is defined by
the driver anyway. The remaining question simply was how to label the
output destinations.

>From the manual, the answer is pretty obvious: ADAT-1.1 to ADAT-1.8,
followed by ADAT-2.1 to ADAT-2.8 and ADAT 3.1-to 3.8, last is S/PDIF.

In double-speed mode (everything above 48kHz), the ADAT channels are cut
in half, so ADAT 1.1 to ADAT 1.4, ADAT 2.1 to 2.4 and so on. S/PDIF
remains unchanged as it supports higher sample rates at static channel
counts (like AES/EBU).


> At various times in the past when one was required to specify (e.g.,
> Input/Output) channels to an ALSA tool (or a program that relied on
> the ALSA sound architecture) a mismatch in this number (presumably of
> pcm channels) had less than desirable consequences.

We're not talking driver here, the critical parts remain unchanged in
the kernel.


> All of this leads me to the conjecture that fudging an arbitrary
> number that stands in for "channels" is perhaps not the best course
> (not to forget that, at the end of our testing, I would hope that this
> sound card that costs as much as the computer that houses it will not
> have suffered any damage).

Of course, this is open source. It comes without any warranty and you're
free to avoid it, but to the best of my knowledge, you must not be
afraid.

Firstly, it's userspace, so nothing can really kill your card. Second,
the whole logic is an FPGA, so it can always be flashed to a working
state if something goes wrong (it cannot go wrong, as you cannot
accidentally flash your card). Last but not least: the channel count has
always been correct, 26 all the time, only the name array was missing.

So we have this "read 26 channel names from the naming array", and it's
now a question which names to write in there. I've given the answer
above, but want to stress again that we're talking pure C pure userland
here, so it's close to a hello world program:

   printf("Channel name is %s\n", name_array[channel_number]);

with name_array being something like { "ADAT-1.1", "ADAT-1.2", .. } and
so on. Right now, with the package prepared by Fernando, you'll simply
see "1", "2", .. "26" instead of "ADAT-1.1", but this will change in a
minute.


HTH
