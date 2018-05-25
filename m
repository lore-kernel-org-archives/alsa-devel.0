From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ssm2602: Fix ADC powerup sequencing
Date: Fri, 25 May 2018 18:24:41 +0100
Message-ID: <20180525172441.GN4828@sirena.org.uk>
References: <20180517133009.26079-1-m.felsch@pengutronix.de>
 <CAL_JsqKhkVOYf+XEA3MYpK4JYfMrZTbHZtoXgaH=wCBRoU6cfQ@mail.gmail.com>
 <1526640409.3948.5.camel@pengutronix.de>
 <20180523165352.GA6187@rob-hp-laptop>
 <20180525094724.3f4edofopk52i3v6@pengutronix.de>
 <20180525102609.GK4828@sirena.org.uk>
 <20180525114253.jj6akdazsbxqkbfu@pengutronix.de>
 <20180525145245.GM4828@sirena.org.uk>
 <1527261489.4938.9.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1939452328822749507=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 01AE6267677
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 19:24:44 +0200 (CEST)
In-Reply-To: <1527261489.4938.9.camel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Marco Felsch <m.felsch@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============1939452328822749507==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8QM4kKE+nfbBA4vJ"
Content-Disposition: inline


--8QM4kKE+nfbBA4vJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 05:18:09PM +0200, Philipp Zabel wrote:
> On Fri, 2018-05-25 at 15:52 +0100, Mark Brown wrote:
> > On Fri, May 25, 2018 at 01:42:53PM +0200, Marco Felsch wrote:

> > > Also the formula for the delay time (t =3D C =D7 25,000/3.5) depends =
only on
> > > the capacity size.

> > Why not just have the user specify the capacitance of the capacitor on
> > the rail which they can directly read from the schematic rather than
> > forcing them to do the calcualtion?  That seems a bit clearer and more
> > user friendly (plus if someone decides the spec was wrong it's easier to
> > roll out fixes).

> The exact capacitance may not be known or vary above the nominal value
> because of cheap components, and the formula from the datasheet is just
> a guideline.

That variability is going to apply just as much to the charge time
calculations/measurements as it is to the initial capacitance value -
the results are going to be very much garbage in, garbage out.

> I'd expect the usual method to set this delay to be semi-empirical:
> "start from the value calculated from datasheet and schematics and then
> increase until no more audio artifacts on a representative sample of
> boards".
> I think it is be better to specify a delay that works than a bogus
> capacitance value that happens to correspond to a delay that works.

If this is varying so drastically per board/system that it's relevant
then we're already into problematic territory.  For most devices we just
have a number for the part, not something that varies so wildly that
each system needs to configure it.

--8QM4kKE+nfbBA4vJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsIRtgACgkQJNaLcl1U
h9Bgxwf/RY7Q7a3jCjohxDoR84MqXn+NSDeTJGvqhQ896V5jKPDaH5DmMHm0sNd6
LVybEi3zgb3+y3zXfLKoo4P62Hl83LJZCpQWp0sH5f2TiRPsO2sgKZfXRC93ihZP
INUMx031TOZMl3BLPWGCer+wT7QZzHgJY4P/WP0iATZdps6Z8TfxBa30DZ4KRmwr
K+HBFhjj4NyQYpFI5uLrRs7utFTWgNh+LS5y8K4YYflIP+nb61FxKwpG5yyeYRGX
EIBF1bnJOzJxk1ur9kcWKQ4resM6biY6/eKXu2IMZUpGpfeiCtm+pO6aa5u2HEP4
TtJVkuVZ/9jebSz+AcDafamypcJeng==
=RnHn
-----END PGP SIGNATURE-----

--8QM4kKE+nfbBA4vJ--

--===============1939452328822749507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1939452328822749507==--
