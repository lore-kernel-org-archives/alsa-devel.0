From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Latency of mixer reconfiguration
Date: Fri, 19 Feb 2010 09:54:38 +0000
Message-ID: <20100219095438.GM2032@sirena.org.uk>
References: <20100217181530.GA23152@tango.0pointer.de>
	<20100218100127.GJ2032@sirena.org.uk>
	<20100218180422.GA5606@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E38AB103957
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 10:54:38 +0100 (CET)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>) id 1NiPZG-0003GC-M4
	for alsa-devel@alsa-project.org; Fri, 19 Feb 2010 09:54:38 +0000
Content-Disposition: inline
In-Reply-To: <20100218180422.GA5606@tango.0pointer.de>
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

On Thu, Feb 18, 2010 at 07:04:22PM +0100, Lennart Poettering wrote:
> On Thu, 18.02.10 10:01, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:

> > will be dominated by I/O costs, which will in turn depend on the bus
> > used to access the codec - it'd be good if the buses could provide some
> > information to ASoC to allow it to do an estimate, but at the minute
> > we've got nothing really to go on.

> But what would you guess? In which range will this most likely be? < 1ms? 
> 1ms? 10ms? 100ms? 1s? 1h? 10h? 10d? 10y?

1ms or less normally - worst case will be a couple of I2C writes, though
potentially over a congested bus.

> tbh I feared less the actually IO latency but more that some PCM data
> fifos might need flushing before the volume is actually updated. And
> the latency of those fifos I feared might be more than a handful of
> samples?

Yes, mostly the buffers in the CPU.  These vary from very small to very
large - some systems allow relatively large audio buffers (hundreds of
kilobytes for example) in order to allow the CPU and RAM to be powered
down for extended periods of time during playback.  It's the same
problem as working out the latency for video sync.

> > I suspect that trying to offer additional resolution in this way is more
> > trouble than it's worth if you're concerned about the artifacts that are
> > introduced during updates.  Providing per-channel differentiation if the
> > hardware has only mono control has much fewer problems, though.

> The current logic is to not do any software adjustment if the hardware
> adjustment is "close enough" to the total adjustment we want to do,
> tested against a threshold. Which I think is quite a reasonable
> approach because it enables/disables this feature not globally, but
> looks at each case and enables this logic only if it really has a
> benefit.

That sounds reasonable, though it's kind of surprising to me that there
is hardware out there which benefits from it - I'd have expected either
adequate resolution or nothing at all there.
