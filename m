From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: mop500: Deletion of unnecessary checks before
 the function call "of_node_put"
Date: Wed, 3 Dec 2014 18:31:23 +0000
Message-ID: <20141203183123.GJ7712@sirena.org.uk>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <547DEB6B.5000105@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ViqsC9kT1FfWPhoo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <547DEB6B.5000105@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org


--ViqsC9kT1FfWPhoo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2014 at 05:40:11PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Dec 2014 17:15:11 +0100
>=20
> The of_node_put() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.

Sorry, realised what the dependency was - applied, thanks.

--ViqsC9kT1FfWPhoo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf1b6AAoJECTWi3JdVIfQQOgH/3liXIlkPdYxHxPHrJe0UfPP
W99frMcq24UGybTyBgNMs/V3maC4/p/z6U23Tj3Ik0OubNdT8P+M6CjKH2Hf8tqb
wOiirSqdqi+6Myf+/ziEDk0/7dJuJnVmQxN37KiOUA32q4r94bLoqgMQwpNyE1K8
sEY8xzD1vKegHm8ynnCxe2gNpweHE6XAms1eN+PCL4dvv2BKygz3WbRGDPIBnCrY
6/v55sPEtFf2/SB7Gq86YwwLhzoOkdI74qbNUh4FUFmQG73/8ABnVbUL6oaFSMfE
uSzfDdw/Iuf4aGyWKQBj3PHs34SIf/BlV3EMhDSo2sxftDQBjsNOvDb2tc/kdwA=
=AOHg
-----END PGP SIGNATURE-----

--ViqsC9kT1FfWPhoo--
