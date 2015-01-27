From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/10] ASoC: sta32x: add status register.
Date: Tue, 27 Jan 2015 17:03:45 +0000
Message-ID: <20150127170345.GX21293@sirena.org.uk>
References: <1421881322-27806-1-git-send-email-niederp@physik.uni-kl.de>
 <1421881322-27806-5-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8925444312180833004=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 317822608EC
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 18:04:04 +0100 (CET)
In-Reply-To: <1421881322-27806-5-git-send-email-niederp@physik.uni-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, brandau@gmx.de, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8925444312180833004==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CmyYfwfsVa1xvDOW"
Content-Disposition: inline


--CmyYfwfsVa1xvDOW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2015 at 12:01:56AM +0100, Thomas Niederpr=FCm wrote:

> The sta32x defines a read-only status register at address 0x2d.

> +++ b/sound/soc/codecs/sta32x.c
> @@ -101,6 +101,7 @@ static const struct reg_default sta32x_regs[] =3D {
>  	{ 0x28, 0xc0 },
>  	{ 0x2b, 0x00 },
>  	{ 0x2c, 0x0c },
> +	{ 0x2d, 0x0f },
>  };

If it's a status register I'd expect it to be volatile and not have a
default, otherwise it's not terribly useful.

--CmyYfwfsVa1xvDOW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx8TxAAoJECTWi3JdVIfQMCgH/RlQMjILldWs/AS68zN9d49F
PuCQdtHsV9nSiE83coGUpqzw56lEOYjTZjqdIVDy3qiKXysSVvhc/GUKyHhfZpz8
Nyg2T8W48xriiBMAZ+1uoZzGlI2B8XMZNSrXdMn3gWxjcrohp485zogrTw8s2giB
w0HGZLR+ilx3vnLrPw2KhtoW5GuOxkmeWrOrmswSGFUiCwfx+4Q8IbSWbMAbU2q4
AFNjNLPdQ2PbzPh24nufFTld8FNWQNRysUwMoXwD7pv0LiWzUtlGHg18STLeBwsA
dFvwRPdaRJr8bnLxvQ2gppPFGZLbAKbOsP+mtPp0aY4BmYCXup2qVhDxtl1iGYg=
=OIYv
-----END PGP SIGNATURE-----

--CmyYfwfsVa1xvDOW--

--===============8925444312180833004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8925444312180833004==--
