From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/13] ASoC: Intel: Delete an unnecessary check before the
 function call "sst_dma_free"
Date: Mon, 5 Jan 2015 14:35:51 +0000
Message-ID: <20150105143551.GQ11764@sirena.org.uk>
References: <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54A9355F.4050102@users.sourceforge.net>
 <54A93B5A.9050504@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gdkky/UkxKPTIP6j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54A93B5A.9050504@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org


--Gdkky/UkxKPTIP6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 04, 2015 at 02:08:42PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 3 Jan 2015 19:03:55 +0100
>=20
> The sst_dma_free() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.

I'm missing aptches 1-5, are there any dependencies?

--Gdkky/UkxKPTIP6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqqFGAAoJECTWi3JdVIfQAjoH/1d5YdMG7Fjv49Utt7uD3WNz
xJLmrZMxYB5bv8FrwiP5DDNeu7/MvFEMhvme7S8rp9AzlJ1zDX3SX5RJs/zGFdDQ
kpK4snywZoZ191vOLwDHXb8YjIPnZ2zwN4Eke4aOo23HyvSBRHZ2J9jfFfE4Rgsx
+ZDZ8Xr6lcQ2Y9+XbNYZAg2rvCytogkljCY9/XD9TT9iMHvRQks98edUWnOY6yk/
oBqUcHo9y8PavyDzRCpXpvObZzjxwq3JnpNa6NmvblgiCruN59UyBCoJtqvXRiwq
u2891fKOzw4tao6fzaSR8R2oZxKkOeGL99cgVfkeHCh46eQRwBGc7BEzUMl9Xlg=
=Ya+P
-----END PGP SIGNATURE-----

--Gdkky/UkxKPTIP6j--
