From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Latency of mixer reconfiguration
Date: Fri, 19 Feb 2010 16:03:30 +0100
Message-ID: <20100219150330.GA25873@tango.0pointer.de>
References: <20100217181530.GA23152@tango.0pointer.de>
	<20100218100127.GJ2032@sirena.org.uk>
	<20100218180422.GA5606@tango.0pointer.de>
	<20100219095438.GM2032@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id AA71F243AF
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 16:03:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100219095438.GM2032@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 19.02.10 09:54, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:

> > > I suspect that trying to offer additional resolution in this way is more
> > > trouble than it's worth if you're concerned about the artifacts that are
> > > introduced during updates.  Providing per-channel differentiation if the
> > > hardware has only mono control has much fewer problems, though.
> 
> > The current logic is to not do any software adjustment if the hardware
> > adjustment is "close enough" to the total adjustment we want to do,
> > tested against a threshold. Which I think is quite a reasonable
> > approach because it enables/disables this feature not globally, but
> > looks at each case and enables this logic only if it really has a
> > benefit.
> 
> That sounds reasonable, though it's kind of surprising to me that there
> is hardware out there which benefits from it - I'd have expected either
> adequate resolution or nothing at all there.

On my own hardware this mechanism proved useful in two cases: one card
had a single volume slider for both channels and with PA you can now
set their volume independantly. And one set of external USB speakers
has a volume slider that starts at a very high level, so that the
minimum volume setting is everything but silent. PA extends the scale
downwards so that this limitation of the hw does not become apparent.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
