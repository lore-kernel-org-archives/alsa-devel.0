From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASOC:DAPM: update DPCM runtime when
	mixer/mux changes
Date: Mon, 16 Dec 2013 20:14:12 +0000
Message-ID: <20131216201412.GR3185@sirena.org.uk>
References: <1386936829-9627-1-git-send-email-nhcao@marvell.com>
 <1386936829-9627-2-git-send-email-nhcao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1470064141951266203=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A5A712617AD
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 21:14:15 +0100 (CET)
In-Reply-To: <1386936829-9627-2-git-send-email-nhcao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nenghua Cao <nhcao@marvell.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Henry zhao <xzhao10@marvell.com>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, cxie4@marvell.com
List-Id: alsa-devel@alsa-project.org


--===============1470064141951266203==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hnpg0BSo5EvPlUVi"
Content-Disposition: inline


--Hnpg0BSo5EvPlUVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2013 at 08:13:49PM +0800, Nenghua Cao wrote:
> From: Nenghua Cao <nhcao@marvell.com>
>=20
>     DPCM can dynamically alter the FE to BE PCM links at runtime based
> on mixer/mux setting updates. Add soc_dpcm_runtime_update() calling in
> get/put function for mixer/mux to support this feature.

Applied, thanks.

--Hnpg0BSo5EvPlUVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSr18RAAoJELSic+t+oim9sCYP/iPYplYmH+/2UAzedKHYVHSK
Xbc9IoKfrOInDEKOuCXZtpdJQqMdMCm3Fhho1agkJhVycHbI8hcq7mVJ7QRC3lOx
OAq7VPTctqCwJ03U7Ozn1Y+Gn/LHjG0RaWza5qZ3ZRTOS5/FfeGXl2UtZl5CjL4m
pKjM/U+G6JWMzwHke9uH0XNYkGlze/zbNnmaW8IVA7nxzzCpXXmxvClYHBYH8liq
BO/Be/y0f5xM57Zkc7BNqBer+bKi63ljDg2/d0Vn19PeYfnSCuRcrUHRHWmpzyQ+
Vzf21fXZnFzqq58wgcDiDIsVEfmFDAymvRJ0LaYIQzDndgY4g7m5H6F/x0dil8O+
6ZnadErMc/wQFcVHAf2Fn4uWfB5C6eQcYXTf/MscJfKiX39LzIRgAZSTYF5kX2Qr
SFDDLqNvDZCmiZSSmigi3EsAXwKqpqCZWsKxz5bHFcMWLiSoxGOY1/YJeA+sA/Cy
I1U3oxLS7rtvugGhwyed2My0aKtMupQgMCZOieuMVYdf/z3b3TBPsimiT19jPV5+
15QuaGqR8YDHjV73j3G5G0E3v4Z5HcSzNpinm2GdXvE+YFZ83sldhHeWfFphyeIG
H9nXv0G3AwM7+3CzL2SDARLVJ5y+raEtKVhbgANsFjH0rtzxFr7Eb8ehVWerJ0S8
Ei9vJ4z5aCzveYXg8hih
=W5vD
-----END PGP SIGNATURE-----

--Hnpg0BSo5EvPlUVi--

--===============1470064141951266203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1470064141951266203==--
