From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64
	SoC
Date: Wed, 6 Dec 2017 19:53:08 +0100
Message-ID: <20171206185308.ijt76lodwgkz2pm3@flea.lan>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-5-anarsoul@gmail.com>
 <20171205080444.zo2rlusqpjyraqcw@flea.lan>
 <CA+E=qVdZME2fiMw09NUP4DNCYhk58dqSapCdfBjLrdMq5HFwyg@mail.gmail.com>
 <20171206153205.k3l5sofdco3t75mi@flea.lan>
 <20171206154810.eb2czpb4kusxv5kj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6967349602128069912=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 48666267048
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 19:53:09 +0100 (CET)
In-Reply-To: <20171206154810.eb2czpb4kusxv5kj@sirena.org.uk>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, arm-linux <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============6967349602128069912==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="odsm553lhsv476hf"
Content-Disposition: inline


--odsm553lhsv476hf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 03:48:10PM +0000, Mark Brown wrote:
> On Wed, Dec 06, 2017 at 04:32:05PM +0100, Maxime Ripard wrote:
>=20
> > BCLK is sample rate * sample size * channels, and LRCK is running at
> > the sample rate. So the ratio is the sample size * channels.
>=20
> > Anything deviating from those standard i2s concepts should at least be
> > documented, with arguments to back them off.
>=20
> BCLK can be higher than the minimum there in most formats, though some
> hardware is more restrictive so we tend to go for the minimum clock rate.

How does that work in such a case? Is LRCK faster as well, and we're
keeping the same ratio, or will the codec buffer the current sample
until the next word?

Is it usually a property of the codec or the DAI?

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--odsm553lhsv476hf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlooO/YACgkQ0rTAlCFN
r3QI8w//ZTBYyyRGNK63x1mh32Ps4Ee/Ot+asZ+NJXJlWHa+DiNAiQWUS3CjTDyV
W5z7WIBBKv4tOu2GV6gw5/6iTFWj81RPkOX78AsA/b3453XbEiIavqmqQXKHWoy4
ZDsLiZKCjdBLWpqLjx5PDVmPAG/OGEYVa+gMQG9hoIr/bCFJLPM1+vQE8+j8PVH6
p5VmktyCFQhDN0uyS+9s12xkYBqhXGLowe3V5w5NHaQJ42rk5orqVZ0JPAOi7crT
Gfh8trJaYqLe/UzTizQElJPeCoQJ6/kqGQCRmqWBEK5FbBmkHhld5oFJjglj/YCm
fO2sFb7Gco6X6n0zVLp0xl/+qWz+/u+ri7HJpzQ9MN+ESirGK/9wUm3cNBYFAumC
pvPeioyey6zyxrWUBHmA3TpWwlcUBff1/YxWKunWk9C1UL6mEQiOn9f8FEw57wvS
6idJICmYY+C3kW12lgMCwTsi07Xq6BBOCbC77XXQrOJyyBA6oRWqtreBIVun8gk7
X604b1nRGAOv2xCrHLrY9lJu/2K4CL2esuBFLSVSIRKlPi+6O9SjYBOOPrV3pt79
3g9iyqOGFtMM2osb08m1YoNNWxoQWaVIQ8luw17iLNkvHt9bXwd6p0EYCXLQMvb7
IUq1JUltiAfyym9WW/XNE9jmHOKSilBhO13kLCIvx6E4g275Ezk=
=ZKls
-----END PGP SIGNATURE-----

--odsm553lhsv476hf--

--===============6967349602128069912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6967349602128069912==--
