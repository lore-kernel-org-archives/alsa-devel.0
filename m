From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration	for
	ALSA SoC drivers
Date: Tue, 27 Apr 2010 21:59:24 +0100
Message-ID: <20100427205924.GC15083@opensource.wolfsonmicro.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EB3A324363
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 22:59:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BD74D0C.40303@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 03:46:04PM -0500, Timur Tabi wrote:

[Reflowed into 80 columns; please fix your mail client.]

> > (I've omitted the DMA nodes and some irrelevant details)  This is
> > enough information for a simplistic driver registration that probably
> > makes a lot of assumptions.  Such as the ssi represents a single
> > logical sound device.  It won't handle complex representations, but in

> Why would I ever represent the SSI as anything but a single logical
> sound device?  Let ALSA handle synchronizing multiple streams together
> if it wants to.

...

> > 		dai-links = <&ssi1 0 &codec 0
> >                            &ssi1 1 &codec 1>;
> > 		[...]

> I don't know when I would ever do this.  The two SSI devices are
> completely independent.  Why would I bind them together into one
> "device"?

It's entirely possible that if the board designer intended the verious
SSIs to be used in concert they've done something like cross wire the
clocks which creates a board-specific interrelationship that needs to be
dealt with.
