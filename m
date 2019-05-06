From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Add support for Conexant CX2072X
	CODEC
Date: Mon, 6 May 2019 23:05:06 +0900
Message-ID: <20190506140506.GQ14916@sirena.org.uk>
References: <20190423141336.12568-1-tiwai@suse.de>
 <20190423141336.12568-2-tiwai@suse.de>
 <20190427175938.GJ14916@sirena.org.uk>
 <s5h36lxpcbd.wl-tiwai@suse.de>
 <20190503064729.GF14916@sirena.org.uk>
 <s5hk1f8m2f1.wl-tiwai@suse.de>
 <20190506042625.GK14916@sirena.org.uk>
 <s5hsgtr6h5y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7627909057855159579=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D21A3F80C07
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 16:05:14 +0200 (CEST)
In-Reply-To: <s5hsgtr6h5y.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7627909057855159579==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9ZRxqsK4bBEmgNeO"
Content-Disposition: inline


--9ZRxqsK4bBEmgNeO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 11:55:37AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Fri, May 03, 2019 at 09:18:26AM +0200, Takashi Iwai wrote:

> > comments or something.  For safety the bits that look board specific
> > like the pinmuxing should ideally be behind DMI checks, though if nobody
> > else ever bought the CODEC that's probably not so important.

> Since this is the only code for this codec on the net and all existing
> platforms (Intel devices, RPi extensions and else) seem working with
> it -- i.e. all these depend on the same init sequence more or less, so
> splitting to platform data won't help much in practice.

Yeah, like I say that's a bit more nice to have given that it looks like
there's basically one system using the thing.

> > The board registration interfaces do vary as the hardware isn't very
> > standard so there's a bunch of things you can do for configuration
> > (though there is a generic interface for the 90% case, the main
> > limitation these days on using it is Intel's lack of any sensible
> > firmware interface).  I'm not aware of any issues with power management
> > though?

> Yeah, I understand the various use cases and coverage for a wide range
> of hardware implementations, but the lack of the documentation
> is... not a thing we can be proud of.

The bits that vary are driver specific interfaces so any sort of general
documentation is pretty hard.  The core stuff all at least has kerneldoc
which is about average here.

> Regarding the PM, my statement wasn't straight, sorry.  The fact is
> that ASoC manages so many different levels of (a sort of) "PM".  We
> have the Linux device-object system and runtime PMs, and we have BIAS
> level control.  The machine needed the jack handling via ACPI GPIO
> IRQ, that is outside the codec, which looks rather like a rare case,=20
> and  I had hard time to look for the right choice of the API usage.

The reason you're not finding much handling for interrupt GPIOs is that
if something is an interrupt it should be going through the kernel
interrupt interfaces, even if the pin that is providing the interrupt
has GPIO support the code should just ignore that and let the frameworks
deal with things.  The only exception that comes up is that there's a
few devices that manually emulate level triggered interrupts with GPIOs
and edge triggered interrupts for cases where controllers only provide
level triggers, unfortunately nobody had the time/enthusiasm to push
that emulation into the interrupt core but fortunately few hardware
designers are implementing edge triggered interrupt controllers these
days.

> This is rather a question how generic the codec driver should be
> written.  I changed the code in v5 patchset to embed the jack_gpio
> stuff inside the codec driver side rather than the machine driver, so
> the whole exported functions can be reduced now.  But, of course, it
> slightly gives more implicit assumption about the hardware
> implementations, too.  Though, the existing code seems to have already
> fixed gpio / pin setups, so the other setups wouldn't have worked, in
> anyway.

Like I say if the device is using the fact that the pin is a GPIO
there's quite likely something wrong - that shouldn't be something that
the user of an interrupt should need to see.

> > It's unlikely there are *no* default values - you'd kind of have to try
> > to have a specific register range like this with genuinely floating
> > values.  Given that the code for configuring the EQ was broken to IIRC
> > never take effect I'd not be 100% surprisd if someone couldn't figure
> > out why their settings weren't taking effect and just bodged something
> > directly in the driver.

> Actually I'm fine to drop the whole EQ stuff that brings lots of black
> magic.  Certainly it'll benefit us for code simplification.  Let's
> see.

Probably worth checking to make sure the default EQ setup isn't too
awful (though I guess the EQ is just turned off by default so it'll just
be an uncorrected speaker/headphone which should be fine if not ideal).

--9ZRxqsK4bBEmgNeO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQPxIACgkQJNaLcl1U
h9CfoQf+Pfz8yA57/fl8Fzjzb0iGOU8zjsyiPTo02O1IJ8doNHGC7gLkA6I1UuIS
ogSwTKCKbKLqqKWAUurCyKu8+QEapIiQXafN8F7bLP72c5a5On1BQBol7K5pshk1
Fm4IflhMbOtwNNbUsrEO2Ag4ALxEadIFz+9HM0J3A6NLEsOQEBif5/dYqB9hmxBW
IapUxSRnW/oCHFhWMkLJOHt9OyeKlOawGaWT/l3cSPJo0guhRB3QjXeKjjDm1Mvr
dbeY9jxJ+FDO0QjSuhvyh7z+jCVL6kJDU+F/jvgqabJ5Y//kJORCrsxPMDq1gZcP
mx7UzBoDw+VnW/87X3c6iCZoZ56bLQ==
=TvaA
-----END PGP SIGNATURE-----

--9ZRxqsK4bBEmgNeO--

--===============7627909057855159579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7627909057855159579==--
