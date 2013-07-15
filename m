From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: max98088 - fix element type
 of the register cache.
Date: Mon, 15 Jul 2013 18:22:03 +0100
Message-ID: <20130715172203.GY11538@sirena.org.uk>
References: <1373906326-18601-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6036748786709043992=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EA9B2261989
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 19:22:09 +0200 (CEST)
In-Reply-To: <1373906326-18601-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: Chih-Chung Chang <chihchung@chromium.org>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, evan.ragsdale@maxim-ic.com
List-Id: alsa-devel@alsa-project.org


--===============6036748786709043992==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I2k41U2G4dq8LTBU"
Content-Disposition: inline


--I2k41U2G4dq8LTBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 09:38:46AM -0700, Dylan Reid wrote:
> From: Chih-Chung Chang <chihchung@chromium.org>
>=20
> The registers of max98088 are 8 bits, not 16 bits. This bug causes the
> contents of registers to be overwritten with bad values when the codec
> is suspended and then resumed.

Applied, thanks, though really this driver ought to be being converted
to regmap.

--I2k41U2G4dq8LTBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5C+4AAoJELSic+t+oim9pK8QAJPiprNcD1ilQIsoBwVNmrSY
1ELcQwUTKo823+J7p5mxcQnTcAdG2AJUTg4wRPklQvQuGk3FwL/kLSvG+wXcFjDf
LMkOJVMyq+SFPRrDqebo6VEwf421DdQM4/9J/YbFizakn8O2C8KnhSc4c5FFWkpD
a7GNfZGXXITWpEGsO8M0HZ4OKqao0QgKd0P16VxtUy7LcsKLsCnKNEkXMgv9l3ak
hmz6OD+hxRQUjPnur1AC+ihyeAP9E8w3t81fnbKfnCO2ZD+yfOJxOo8DO5yUkPtW
jxfMHhRfRJq6FJ0GaK139waXFIftPckMCoi+hZvKG7znBijlOTdGxwLG598m3MwY
/NJiQf+vYhJKSUUu8Mlvl3Wav0PxaTAjw/TiNUU/vH+2VXHdwDzYiqzjG3e5kHkl
AB5QxfvxXGav7KLTCfpbUm0t4LvE61Ug5yygbfOAQUt4elvnuL7cQZQnpz74rLEs
jbKngqjWlp7hjI36C1Lo97eSKA72NffbTG9WbVntCmSK2jQwujow75pgPj1p2ASS
9Rct8cGRh1Elp2D6r7D0g87Tr0Zt7tqxisJr2eSRIZd0QWU8VzPnLyRXFWiuIqEL
EIPJn6On6oWtY5zwqWZDX/Rvl4lLzwiYd66Tv4SILqeVGfa+7txmwLPK8Q2jJYyk
z7jThvc1+FoktPX9sQKV
=8KUl
-----END PGP SIGNATURE-----

--I2k41U2G4dq8LTBU--

--===============6036748786709043992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6036748786709043992==--
