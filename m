From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ssm2602: Fix ADC powerup sequencing
Date: Fri, 25 May 2018 15:52:45 +0100
Message-ID: <20180525145245.GM4828@sirena.org.uk>
References: <20180517133009.26079-1-m.felsch@pengutronix.de>
 <CAL_JsqKhkVOYf+XEA3MYpK4JYfMrZTbHZtoXgaH=wCBRoU6cfQ@mail.gmail.com>
 <1526640409.3948.5.camel@pengutronix.de>
 <20180523165352.GA6187@rob-hp-laptop>
 <20180525094724.3f4edofopk52i3v6@pengutronix.de>
 <20180525102609.GK4828@sirena.org.uk>
 <20180525114253.jj6akdazsbxqkbfu@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4514041100903265689=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 24056267679
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 16:52:48 +0200 (CEST)
In-Reply-To: <20180525114253.jj6akdazsbxqkbfu@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de, devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============4514041100903265689==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jaerp9zHWz52Eeko"
Content-Disposition: inline


--Jaerp9zHWz52Eeko
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 01:42:53PM +0200, Marco Felsch wrote:

> Also the formula for the delay time (t =3D C =D7 25,000/3.5) depends only=
 on
> the capacity size.

Why not just have the user specify the capacitance of the capacitor on
the rail which they can directly read from the schematic rather than
forcing them to do the calcualtion?  That seems a bit clearer and more
user friendly (plus if someone decides the spec was wrong it's easier to
roll out fixes).

--Jaerp9zHWz52Eeko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsIIzwACgkQJNaLcl1U
h9AMMwf5AbfhApAIwtbE6x7JfKx7Wb9e8ACw+0X+hvlLm5Lp4EcU5Q2KfXBhvh7Y
VOs+lfHPBBXW5+R2DRc3ECsRgKrpuTlTXyF7w0ABUJgnppB+kwWLOuRgIkmpyrZH
IJV60dG9BrdvNCNPdA1XX4AdJPPdhJbQrRw39qOgd5kI4v4EiM+ESlu1eadi8H1/
Qxx5F6VcB/+d60RJ4BEdoSGY+cu/BXCzqRUSyzwzB2YBPKucnqp0aTF+80CZk4yM
o7MobuMK7NQvhksItdFZklk7gQUOYz2MzMOVIEbiR23AEUvf9YFkQ9yEZwi+au+j
lwgdr2tmhbvlAW26DWdRowNZHyYacg==
=og3K
-----END PGP SIGNATURE-----

--Jaerp9zHWz52Eeko--

--===============4514041100903265689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4514041100903265689==--
