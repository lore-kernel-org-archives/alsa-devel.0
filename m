From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from
	USB	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 11:17:21 +0000
Message-ID: <20100217111721.GA2032@sirena.org.uk>
References: <alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 23CF410383A
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 12:17:22 +0100 (CET)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>) id 1NhhuD-00014e-UJ
	for alsa-devel@alsa-project.org; Wed, 17 Feb 2010 11:17:21 +0000
Content-Disposition: inline
In-Reply-To: <20100216235658.GA6766@tango.0pointer.de>
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

On Wed, Feb 17, 2010 at 12:56:58AM +0100, Lennart Poettering wrote:

> Nah. I actually don't need this value for PulseAudio. In PulseAudio I
> chose to shift all scales so that maximum amplification becomes 0 dB,
> so that the UIs are similar to how most hifi racks do it, and which I

Interesting.  The hifi equipment I've dealt with typically doesn't
present any units at all in the UI outside of level monitors.

> think is a nice, easy and understandable logic. That way my volume
> scales range from -inf dB to 0 dB in all cases, regardless of the
> hardware/drivers in use. Of course, that means that ALSA's own 0dB is
> not directly visible on the scale. Because it might be sometimes
> useful to know where it is, we export that position as "base volume"
> and the UIs show it with a little marker at the side.

Yeah, the actual zero point is definitely needed - it gives an
indication of the expected output level which is very useful during
setup.

I really do need to find time to dig into this code at some point -
there's also the digital vs. analogue gain thing I've mentioned to you
before that I wanted to look at.
