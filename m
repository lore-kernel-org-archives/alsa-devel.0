From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Disabling onboard codec
Date: Fri, 02 Apr 2004 17:40:23 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404021733030.13912-100000@studcom.urz.uni-halle.de>
References: <E1B98oP-0006rr-H4@sc8-sf-mx1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <E1B98oP-0006rr-H4@sc8-sf-mx1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ron Cococcia <ron.cococcia@request.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ron Cococcia wrote:
> In a setup I'm working with, I have a motherboard (815 w/82801BA-ICH2) that
> has an onboard/primary (00) AC97 codec (AD1885).  We've been playing around
> with adding a CNR card that would have a different/secondary (01) codec on
> it (CS4299). [...]
> The onboard chip is generating (I think) a BIT_CLK signal, and (I think) the
> CNR is as well (it's wired to an oscillator).

There is exactly one clock signal on the AC'97 bus, driven either by
the primary codec or (more often) by the controller.  I guess the
oscillator on the CMR card is for a configuration where the CS4299
would be the primary codec.

> I'm worried that both chips generating a BIT_CLK might cause
> jitter, and could cause audio quality issues.

Even worse, two different clocks would drift apart over time, which
would make it impossible to send synchronized samples to both codecs.
Having two independent clocks in an audio system would require
resampling.

The second codec in an AC'97 system should not affect the primary one.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
