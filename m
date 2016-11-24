From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [patch] ASoC: sunxi: Uninitialized variable in probe()
Date: Thu, 24 Nov 2016 11:29:19 +0100
Message-ID: <20161124102919.mvmq4znw6juxucvn@lukather>
References: <20161123222906.GA27895@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hyw7ylok4jr7lrmf"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161123222906.GA27895@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--hyw7ylok4jr7lrmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2016 at 01:29:06AM +0300, Dan Carpenter wrote:
> Oddly enough, my version of GCC misses this uninitialized variable.
>=20
> Fixes: ba2ff3027b5a ("ASoC: sunxi: Add support for A23/A33/H3 codec's ana=
log path controls")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--hyw7ylok4jr7lrmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYNsD3AAoJEBx+YmzsjxAgOVcP+wRo8vBl24Zomfl04eg05gZx
ZTrCNcPBBKw/Zkama/E7TRuaw3SBD+Pkxz9Ogq1LkDXCuTDS+SFkNcCH17wZaNib
4leT3o2lr1LgOLiAhd801QhASObgxH4eNRUpFNS6koRyLxB0ZLn63GaE3ZQCk2gc
o+Dj6Qdm7Oa6LeaCKIK/9drfxRagrqoLElctxNyvxKrKc4BFWCvue5Ej3a5rzSMS
P1Nt3Ag6N8nbA5e6rDtFrEYFH6ecB3qHlu0rsbZKtHIlSN8ZlR5EXfSAqAcjrxci
iZC1nU0Dp9f7Ps99p20+ecINHYDbTHgwZOaQMxwyvDFifRexP3Ks4Dov37y8coLH
poKRpwTb/u4ULmk2H8kl8aAxllpIvtpU5jGZitHONP4KpepIRJBKDb7CoeQehzSR
dormAxk4aKkWWPEq5zj9jtOuRZeWzOjt6XYGE0mtSUD/BgaapEgGyK1tIasTy1bn
qCROr95Q3jaiFRhFu2g45Ioz1KfeuVmtbxVyM6w46/TjDlJmpn6Zenw2JrBzQwVZ
1BR97hVqp3F4nA83HI9g9JDlCM/fPn1O0iygchZFTH3NlQeMHaa1PIZW/HF12P3g
aAHmp3Jh4KX/nu+nbl0dOofnE9UxkXwsWt2aYTrSaGQnsIJgVZOtSqBKlNg18qdT
JwhQyYnyyn+7KRBEpBCV
=yh3l
-----END PGP SIGNATURE-----

--hyw7ylok4jr7lrmf--
