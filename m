From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Mon, 30 Nov 2009 16:57:42 +0100
Message-ID: <20091130155742.GI14091@buzzloop.caiaq.de>
References: <20091127112550.GA29821@rakim.wolfsonmicro.main>
	<20091127124139.GR14091@buzzloop.caiaq.de>
	<20091127133225.GB17711@rakim.wolfsonmicro.main>
	<4B1186B8.6070606@freescale.com>
	<C78B2A7F-3D02-406C-A87B-8C3231456726@opensource.wolfsonmicro.com>
	<4B11A19D.4070301@freescale.com>
	<20091129004433.GZ14091@buzzloop.caiaq.de>
	<5610599F537DD74A8D1F5CC946A7507303478C40@az33exm25.fsl.freescale.net>
	<20091130120158.GD10968@rakim.wolfsonmicro.main>
	<20091130123617.GG14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3055424351
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 16:57:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091130123617.GG14091@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Tabi Timur-B04825 <B04825@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 01:36:17PM +0100, Daniel Mack wrote:
> On Mon, Nov 30, 2009 at 12:01:59PM +0000, Mark Brown wrote:
> > On Sat, Nov 28, 2009 at 07:46:22PM -0700, Tabi Timur-B04825 wrote:
> > 
> > > Have you tested it on a Freescale MPC8610 HPCD?  Are you sure it still
> > > compiles and builds on any PowerPC system?
> > 
> > I can do a compile test on PowerPC (and that's one of the platforms that
> > gets tested with linux-next too) but I don't have hardware to do runtime
> > tests with.  Timur, would you be OK with compile tests for now - I'd not
> > expect to see 2.6.33 go out this year so if there are any runtime issues
> > it should be possible to fix them once you're back in the office?
> 
> Wait a sec before applying this, please. We might have caused a
> regression, I'm still investiating.

The current aproach does not work reliably, unfortunately. It turns out
that the codec necessarily needs its analogue supply to maintain its
state. For all other operations (iow, any of the volatges not applied),
it has to be held in reset mode. I did that manually by driving the GPIO
directly before, but with the current regulator framework support,
that's not possible anymore.

Hence, we can only power down the codec when we're in system suspend,
which is a pitty. But even for that, we should still drive the RESET
signal low. Can we make the GPIO pin number available to the codec
driver?

In any case, the current patch is plainly wrong and can be dropped.
Sorry for the noise caused.

Daniel
