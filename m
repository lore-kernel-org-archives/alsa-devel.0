From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v5 1/4] ASoC: tlv320aic32x4: Support for
	master clock
Date: Thu, 20 Feb 2014 12:37:49 +0100
Message-ID: <20140220113749.GB16727@pengutronix.de>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-2-git-send-email-mpa@pengutronix.de>
 <20140218012329.GR2669@sirena.org.uk>
 <20140218204646.GB10590@pengutronix.de>
 <20140219035406.GP2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6917742773091199290=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 2943D2619DC
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 12:37:59 +0100 (CET)
In-Reply-To: <20140219035406.GP2669@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============6917742773091199290==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 19, 2014 at 12:54:06PM +0900, Mark Brown wrote:
> On Tue, Feb 18, 2014 at 09:46:46PM +0100, Markus Pargmann wrote:
> > On Tue, Feb 18, 2014 at 10:23:29AM +0900, Mark Brown wrote:
>=20
> > > Looking at the code the clock isn't physically optional, why not make=
 it
> > > mandatory?  There's only one mainline user, it looks like it should be
> > > straightforward to update with a fixed clock.
>=20
> > The masterclock is physically optional. There are several modes to use
> > this codec without master clock. The PLL can use different clock inputs,
> > BCLK, MCLK, etc. and even the PLL is not necessary. Instead BCLK and so
> > on can be used as direct codec clock input. However, most of this is not
> > supported by the driver yet and I can't test these cases.
>=20
> Are any of these modes supported by the driver yet?  If there's modes
> that don't use MCLK supported then I'd expect them to only enable MCLK
> if it's actively being used in the current configuration (triggered via
> set_sysclk()).

It seems none of these modes are supported yet. aic32x4_hw_params setups
the clock tree relying on a master clock to be used for the PLL.
Otherwise hw_params fails. So currently mclk is not optional for the
driver. But it is still optional for the real hardware.

What do you think about declaring the mclk as optional property in the
DT bindings documentation but to handle it as a required clock in the
driver?

Thanks,

Markus



--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTBekNAAoJEEpcgKtcEGQQ6bAP/j0UopLnPK1coabSzTrLM0jI
2AumHCHsmQZwu+n34P0N/btde/Ah3NmnVMqiaXzU4ATsjhOf5PpG4LHGrqdpkUBl
7/6d7e39yO50BbDoi9viSIw58qy/qZUZWaa+Qh+8/uwVDItNgfHMO2XI/KfznZFQ
r+54gDtsOXbtc6PRM5cJ7042dGcp+gB+Ti4s3SIzIKhp4Try0qk8PurEd04WxE9e
ttnXUYWYwLLjaJW0Pw+Qg8EMDOU3qh5tTGfmwZSMzBTUtz7zr910pknlPPeAz7l4
HwxxYOtlmrnc7Gz2qR6M5JfzeuHL2Tiarh0Gh+IJyJfYfZaUAffIT+CErx1wZehA
019H5K7xjgp1nj2VZSxlWF7rGNSnZEsHei4KfHHtA9FihBp4K4+JSoQyzAa38icU
F77JcsdMHZyh9ag6AbkZYUcNwHIqzLd6SqmmNgu5q6Jks5dPax3PkdP3PgVgz21z
OokwmwsrGIy4e1jXkzkupJPBKxAUYKZTf9rZiXIOBOyC0oB9aNGMJjty+aZzGBXn
GWBpV1cgaejAuIKm04XK9UncIqxhQf4R+gL/RzGO1hb7BRKcV+JqHJLbiV1GIipa
G6vMBiqVGneHQN+bezsiutjwtpK6uQkn0GpYmoaKfd33OyT79p/eDfOWnX/LRG3+
TbP6P4WvIbXMPANs1xJ2
=baKn
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

--===============6917742773091199290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6917742773091199290==--
