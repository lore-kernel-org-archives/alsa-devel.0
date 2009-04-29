From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 3/5] pxa: clean up the legacy SSP API
Date: Wed, 29 Apr 2009 19:51:51 +0100
Message-ID: <20090429185151.GC21459@n2100.arm.linux.org.uk>
References: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
	<20090428222035.GG29277@n2100.arm.linux.org.uk>
	<1240959968.30410.1.camel@brutus>
	<20090429072706.GA31566@n2100.arm.linux.org.uk>
	<20090429082152.GA2628@sirena.org.uk>
	<20090429084109.GB10541@n2100.arm.linux.org.uk>
	<f17812d70904290214g110f2a5ax5da4af478688f3d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 1AE10245BB
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 20:52:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70904290214g110f2a5ax5da4af478688f3d1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2009 at 05:14:13PM +0800, Eric Miao wrote:
> On Wed, Apr 29, 2009 at 4:41 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Apr 29, 2009 at 09:21:53AM +0100, Mark Brown wrote:
> >> On Wed, Apr 29, 2009 at 08:27:06AM +0100, Russell King - ARM Linux wro=
te:
> >> > On Tue, Apr 28, 2009 at 08:06:08PM -0300, Daniel Ribeiro wrote:
> >>
> >> > > The SPI subsystem?
> >>
> >> > Can the SPI system cope with the other chip being the master of the
> >> > interface. =A0In other words, can SPI sit around primed for a transf=
er,
> >> > and notify the user of SPI that new data has arrived?
> >>
> >> > If not, the SPI subsystem is totally unsuitable for this.
> >>
> >> It's slave only at the minute - there's holes in the API someone could
> >> fill in but that's not happened yet.
> >
> > Well, I guess someone else will have to do that; I don't spend much time
> > on the LX stuff, and so if it requires any time consuming work, it won't
> > be worth trying to get it into mainline.
> >
> =

> However, the patch itself doesn't looks like to be a SPI slave
> (I mean from the view of the processor).
> =

> 'struct spi_message' does support simultaneous rx/tx transfer
> and multiple such transfers being queued.

The transfers happen under control of PCON not the PXA; PCON asserts a
GPIO to activate the DMA to control when the transfer happens.

We can not just start the SSP for a 32 byte transfer and hope it happens.
PCON has to be totally in control.
