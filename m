From: Mark Brown <broonie@kernel.org>
Subject: Re: Multiple codecs on the same DAI
Date: Thu, 7 Dec 2017 11:36:16 +0000
Message-ID: <20171207113616.xpzwz7jlbd7hrssd@sirena.org.uk>
References: <20171124123921.ajhxztwypujty6ps@sirena.org.uk>
 <alpine.DEB.2.11.1711241456420.27895@lnxricardw1.se.axis.com>
 <20171124180456.6c63tkph4e7ahuid@sirena.org.uk>
 <alpine.DEB.2.11.1712061352160.22247@lnxricardw1.se.axis.com>
 <20171206130323.GG1827@finisterre>
 <alpine.DEB.2.11.1712061521180.22247@lnxricardw1.se.axis.com>
 <20171206154552.iqcdtyhuj7oyfwcg@sirena.org.uk>
 <alpine.DEB.2.11.1712070841040.22247@lnxricardw1.se.axis.com>
 <20171207112016.bkiw2gi4pcmvendr@sirena.org.uk>
 <alpine.DEB.2.11.1712071230120.22247@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2847585931588746276=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A4EBD2670BC
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 12:36:18 +0100 (CET)
In-Reply-To: <alpine.DEB.2.11.1712071230120.22247@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2847585931588746276==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5dttzbzgbdwleqfr"
Content-Disposition: inline


--5dttzbzgbdwleqfr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 12:31:12PM +0100, Ricard Wanderlof wrote:
> On Thu, 7 Dec 2017, Mark Brown wrote:

> > Or register a device that consumes the regulator and maps it into ASoC
> > like that.

> Do you offhand know of an example of such an external regulator=20
> implementation in the soc tree that I could look at to see how it all fit=
s=20
> together?

No.  I honestly can't think of any such hardware that I've ever seen -
current sensing microphone biases I've seen have all been integrated
into a CODEC.

--5dttzbzgbdwleqfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlopJ7AACgkQJNaLcl1U
h9D4Bgf/XvIm76k1TiIabf8euCddvcLZNyhFu+TaIBe22M/pFVbIPupEX7bW1qhO
6EdCTZZA5fuBDI6IYhltdiBOdA6JQn6I3jEyOj6KJYfpoRHax/lwlc9ULl77fehi
iV/zQP3mvp+AUbsP77YU7OoQOaAiK/8589CX0ApT1WIR6Got62k+DecNDxJ2P8JS
DAdlm/nc4Eb4+mcEpunUYOGo5ohp9b2wIypKUcLmoeUPIR80XiDBWT6HY69rafxY
bVIOayS3KgDBiPqrGyInQI7PP2B9AJSHBj+cOZMVPNhH0sv8GlUBJGRx7sxlgGXL
eM12MoHFN6doJH1RW3Ndog1FkimUvg==
=XS65
-----END PGP SIGNATURE-----

--5dttzbzgbdwleqfr--

--===============2847585931588746276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2847585931588746276==--
