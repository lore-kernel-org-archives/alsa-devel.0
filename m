From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA firewire kernel branch: snd_dice enhancements
Date: Fri, 04 Nov 2011 09:17:50 +0100
Message-ID: <4EB39FAE.40309@ladisch.de>
References: <9C332D0B-5292-498F-B0EE-2A753C36C989@weiss.ch>
	<4EB3346A.1030704@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id EA09B2475D
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 09:16:54 +0100 (CET)
In-Reply-To: <4EB3346A.1030704@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rolf Anderegg <rolf.anderegg@weiss.ch>
Cc: Uli Franke <Uli.Franke@weiss.ch>, Brian Karr <briank@tctechnologies.tc>, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Rolf Anderegg wrote:
> On 02.11.2011, at 21:19, Clemens Ladisch <clemens@ladisch.de> wrote:
>> On the DICE, the playback and capture streams must use a common rate, so
>> I thought I'd avoid handling this in the driver and just use whatever
>> was configured.
> 
> Isn't common rate for playback & capture stream often required?

Yes (but not on consumer chips, where it's normal to have independent
clocks for all I/Os).

> This could be guaranteed by adapting the pcm rate constraints when
> acquiring one or the other stream.

Yes, and many ALSA drivers already do this.  I just wanted to be lazy
and put the sample rate selection into a control panel, where other
similar settings already have to be handled.

Putting rate and clock selection in the driver also has the benefit of
making it mostly usable even without a control panel.

>> The timing of the stream from the computer to the DICE is synthesized
>> according to the rules in the AMDTP spec (I hope); this was originally
>> written for devices based on the OXFW970 chip.  (It's synchronized to
>> the FireWire bus clock.)

This parenthesis is very misleading; what I should have said is that the
driver computes the SYT timestamps so that the stream's sample clock is
effectively synchronized to the bus clock.  These OXFW970-based devices
are playback-only and work the same as DICEs with AVS-SYT clock source,
i.e., they should also be able to be synchronized to any other device.

>> ARX1 appears to work fine with my DesktopKonnekt6, but I've never looked
>> at the error counters.
> 
> Right, hmm, having scanned the AMDTP (IEC 61883-6) in detail raises some
> confusion now. Up till now I was under the impression that using AVS-SYT
> as DICE's clock source is only an option to sync firewire bus slave
> devices to a clock master device on the same bus.

And this clock master could be either another device that generates SYT
timestamps based on its own internal clock, or a computer that just
computes the SYTs.  (AFAICT the Windows/OSX DICE drivers don't implement
the second case.  An 'invented' clock isn't useful except for the
playback-only devices mentioned above where there just isn't any other
clock.)


Regards,
Clemens
