From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] ASoC: core: Add strobe control
Date: Mon, 23 Apr 2012 20:13:02 +0100
Message-ID: <20120423191302.GZ8318@opensource.wolfsonmicro.com>
References: <1334914364-27373-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0168405914751977309=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8EEF8104359
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 21:13:06 +0200 (CEST)
In-Reply-To: <1334914364-27373-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0168405914751977309==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrEcvySKR+fOA8iz"
Content-Disposition: inline


--yrEcvySKR+fOA8iz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2012 at 11:32:44AM +0200, Ola Lilja wrote:
> From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
>=20
> Added support for a control that strobes a bit in
> a register to high then back to low (or the inverse).

I've applied this but...

> +	unsigned int val =3D snd_soc_read(codec, reg) & mask;
> +
> +	if (shift !=3D 0 && val !=3D 0)
> +		val =3D val >> shift;
> +	ucontrol->value.enumerated.item[0] =3D val ^ invert;

=2E..it seems weird that the code actually reads back the enumeration
status, even if we're in the middle of strobing it should be a very
brief, transitory, status which it isn't really worth going to the
effort of reporting.

--yrEcvySKR+fOA8iz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlamqAAoJEBus8iNuMP3dr4wP/3fOkJHog+TjmpeakSQncQHW
4b+Fs81QalK+kRe+VFco3g2Yv3AgyDhHHopy+d17bNVY6TRGfnzkRej4QZ8HVHAa
I0bLM+T7ZDDqjCIrlR1Sh4b1o7ccJy+MVDlzVgJ75kb73184/H9yaaYJTKCD5Y64
fXhC+K9lrF/KhPtK7iX5laXmQfvwwvEwDB7zm6fHi9Pkkwu67w64scl1UMQrVP7C
LunCZiQixYCHQFZJ8oPTmL4gwAnSkRqJfGESPBv9nkx9iCxBvvK4QcuRm+CF+KeG
JL4g+pMwn5Mzzy8xBziwFmYhNoIaldhU3/RR7L3HvwALqFRft27SoYd3hHng6pOD
cexvD7X7yhRoTJqGNAauLmCXLWuYsYs1jFgbNCtTwp58yYeVBiL9/q6W9FZe6sd1
6pW2rRoflMsxoq7Ka4QO/6FVJoej+8bjHB6SGk1LCVTvlBzfzhW8lnwMImAZZ6I9
qinrbBHkmRZmpKkmqj2WLBimJ5CjpqHOR2psytvno2Z8SVTgHm6FVEBKi/SktTRg
aMGSHtUwlmqLwI3A1Sm5Axuu5EO8Ud4jbpEVnpttYbE1+Nt7yWC7Lbk0z9e4eUZp
b1nISqYpCuEe5evXiWHGdiFctRsR7uVVtGCB078SFNyJi+BLp1JVs2ynfHq0uTf7
cJbQV+R+J1cog1+Kja+r
=qK/Q
-----END PGP SIGNATURE-----

--yrEcvySKR+fOA8iz--

--===============0168405914751977309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0168405914751977309==--
