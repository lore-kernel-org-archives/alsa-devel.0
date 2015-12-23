From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: Intel: add NULL test
Date: Wed, 23 Dec 2015 00:02:45 +0000
Message-ID: <20151223000245.GF16023@sirena.org.uk>
References: <1450610153-7746-1-git-send-email-Julia.Lawall@lip6.fr>
 <1450610153-7746-5-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450610153-7746-5-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, kernel-janitors@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 20, 2015 at 12:15:53PM +0100, Julia Lawall wrote:
> Add NULL test on call to devm_kzalloc.
>=20
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)

If there was a patch 3 in this series I seem to be missing it.

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWeeSkAAoJECTWi3JdVIfQAcgH/AnXYLkd8gXHMDybnNC9+oaD
CVwq0j5B5a74EH/qGKqhI6+uO8m036ILqLjVA7UqW+cCHmQPkyRrnsVyxRZfLI2p
O0Zz1JL21qhh8Or+KmzaqS9paQrDa+i6PEcOopmXpPTgt5gzKE2kAWzt1TdQLIFf
VJ8JhTO51G062YezaC2SRjInriZ8IkiVvbL43O48KcB/xFa23Gw9iD+eScCAU2cU
hqSeR/VnOkvairb+gHTYTWWSSsQcYsLG0JN5FF3WlC9hx+KX6md8OS9UFrbazfMX
1Kg9f9fETKVItwjO1y2gT/+oaCtXc5vbxo4RntRbqPipyqqQEW2UD/oMjHU9rPI=
=4TrR
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
