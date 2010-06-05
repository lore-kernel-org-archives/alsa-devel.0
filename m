From: Alex Lee <alexlee188@gmail.com>
Subject: Re: External samplerate changes, UAC2 clock topologies
Date: Sat, 5 Jun 2010 07:21:15 +0000 (UTC)
Message-ID: <loom.20100605T092038-9@post.gmane.org>
References: <20100604124635.GL2698@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id CA8C5244BE
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Jun 2010 09:25:04 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OKnkd-0007K6-Pn
	for alsa-devel@alsa-project.org; Sat, 05 Jun 2010 09:25:03 +0200
Received: from 220.255.7.246 ([220.255.7.246])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 05 Jun 2010 09:25:03 +0200
Received: from alexlee188 by 220.255.7.246 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 05 Jun 2010 09:25:03 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack <daniel <at> caiaq.de> writes:

> 
> Hi,
> 
> when I implemented the basics for parsing the UAC2 clock functions, I
> came across some principal questions I would like to discuss.
> 
> As I wrote in the commit log, UAC2 supports a number of clock units
> which can be combined to complex topologies. The single unit types are
> 
>  - clock sources (can be fixed, variable, programmable and synced to the
>    USB clock)
>  - clock switches, which let the host decide which one out of many input
>    pins appears on its output pin
>  - clock multipliers, which have a numerator and a denominator, and both
>    can be read-only or read-write, respectively
> 
> A clock source has controls for its frequency and its validity,
> a clock selector has a control to control its current state, and
> a clock multiplier has controls for its numerator and denominator
> 
> The driver is currently able to walk the graph of connected units in
> order to find CLOCK_SOURCE descriptors as end-leafs. This is mandatory
> as all requests for sample rate queries have to be sent to this unit
> type.
> 
> This raises the first question, as the driver can only know which sample
> rates are supported in the currently selected combination of selectors.
> Once the user changes any of them (which is currently already possible
> as clock selectors are exported as mixer controls), everything can
> change. And this can even happen while the stream is active, because
> there's currently no check about whether the clock selector is part of
> the actively used path.
> 
> The second issue I see is that a clock can lose its validity. A
> real-life example is an external S/PDIF connected device which provides
> a clock and which is suddenly disconnected. Firmwares are expected to
> notify the host about such cases, and these messages are trivial to
> dispatch. However, I wonder how the driver should react on this. From
> a user's perspective, it would be best to just make the driver find
> another clock path which reports a valid clock source endpoint, changes
> the sample rate accordingly and continues streaming. There would be
> a gap in the stream of course, but at least it would not kill the
> applications or require major exception handling in userspace.
> 
> I wonder which approaches are actually possible to implement, which
> details in the ALSA core would need to be extended, and so on.
> 
> Any oppinions? Has this been done before for any other audio hardware
> supported by ALSA?
> 
> Thanks,
> Daniel
> 

Hi Daniel et al,

In Software Defined Radio (SDR) applications, the user and user programs expect
the audio stream to continue after a samplerate change.  The samplerate change
can be initiated by hardware (ie button pressed, SPDIF cable unplugged/plugged
etc.) or by another user program - eg mixer.

When the driver is notified of an external samplerate change, ideally it should
go through the UAC2 clock topology and figure out what has changed and what is
the current clock source, clock selector position, and clock multiplier being
used.  It may have to trace from the USB output terminal backwards.

I wonder whether there is a converse scenario, whereby a user program wants to
change the samplerate, and passes that request to the driver.  The driver then
have to go through the topology and figure out the 1st valid or the "best" way
to effect the new samplerate.  It can get quite involved as the same samplerate
can be implemented by different settings of the clock source(s), clock
selector(s) and clock multiplier(s) :-)  I suspect this happens when we do a 

> arecord -r 96000 ...

and the UAC2 driver will have to figure out how this should be supported.

Alex
