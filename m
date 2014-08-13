From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/14] ASoC: rsnd: delete unneeded test before of_node_put
Date: Wed, 13 Aug 2014 12:14:25 +0100
Message-ID: <20140813111425.GO17528@sirena.org.uk>
References: <1407492475-26283-8-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kfy0q0s2rBHKMG0i"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407492475-26283-8-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, kernel-janitors@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--Kfy0q0s2rBHKMG0i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 08, 2014 at 12:07:49PM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> Of_node_put supports NULL as its argument, so the initial test is not
> necessary.

Applied, thanks.

--Kfy0q0s2rBHKMG0i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT60iOAAoJELSic+t+oim9Qu4P/02dlKJ+WIXGN3WoYbKUQWZ5
ZMMcea2h9M2pCz4A5MNmfgW1/SEX/bu6W0+Fq2FrIkXgFdH8GxSM3y8E/lKXuVLS
nTZXs4PfKf2cPtoRf/PTHskcCiyV6A5gpp9Z49iheGmzgGVwOTgZuHHe44e5Dz5M
UyE+haT6L5PZ22FaRXi/R0V6bqJdZKaRKjM6qTfatRGS/b3lq96QV5zl9CsSOeoB
q5xIsMJC4Ji0Us2MRk/G+i/oRqXGTvU4xEv757nwfObUrKbcHU0eQ6fEULGk7jVB
Xq/XyQk4oGYpf4SnOZsqr09+VE1dX6K0X074MFIKKbl+CzZ1UnZmhkYlO00MlLYK
PqaMLVKorHupYIRzoj1pgzGVYW0RfTwYOZ9RWtnk4gHdGVv7SZ0oIR/O26felrgf
D8A1roJs15vQ3LynsD2D9eIRa/2XNNd+lt8jXsJwNVS/JZCPU39IWmeULMvU2QdZ
aTlZdbO+Y2ztbS0fWHAGAMLdlw/YefxWWZ8K7X0fm7oRWz7TL+mtxOPF5yaVARyg
pZ2S2+vq5+ffKcwKu74e0lD5gWx7+TBFZJem4m3saLqZ32cuNsKdzPlV1/K5trjQ
sP3HGS5yUM4rPZVduKxmEFz0TPvj9XZRWhQtXCKtraKL7rzvgHKxBIBiANFdx0kC
3/vrdSylDWhhCovG+DAy
=0zvg
-----END PGP SIGNATURE-----

--Kfy0q0s2rBHKMG0i--
