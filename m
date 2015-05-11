From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 2/5] ASoC: rsnd: make sure it uses lock when
 it calls rsnd_dai_call
Date: Mon, 11 May 2015 15:57:43 +0100
Message-ID: <20150511145743.GD3458@sirena.org.uk>
References: <8761948j4f.wl%kuninori.morimoto.gx@renesas.com>
 <8738488j2k.wl%kuninori.morimoto.gx@renesas.com>
 <alpine.DEB.2.10.1505041134140.4711@ayla.of.borg>
 <87iobz506i.wl%kuninori.morimoto.gx@renesas.com>
 <87lhgv33mp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lhgv33mp.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux-ALSA <alsa-devel@alsa-project.org>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, linux-sh@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, Simon <horms@verge.net.au>, Atsushi Tamaki <atsushi.tamaki.ks@renesas.com>
List-Id: alsa-devel@alsa-project.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 05:44:14PM +0900, Kuninori Morimoto wrote:

> Mark, is it possible to revert this patch ?

> e9c390df671fadc829550935ffb6b23549f26ded
> (ASoC: rsnd: make sure it uses lock when it calls rsnd_dai_call)

Sure, please send a patch for that with a changelog explaining why the
revert is being done.

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUMNmAAoJECTWi3JdVIfQrAoH/A3dHrPUqRtEds9S2r8mSNtu
xvLPD6bNG9hiz2mc4o5r25AtVbHfW3QUnMMEtC0J0PQg2B6YPAq0qcrn4m0Po/Va
3yQThLVc8dJDRlj06gUnK49vdZE6D403BfAXomzo12yb0TzcFZ0seaqQOVYYOUN+
+SfZkS3YQDKabZFyDslBwU1CqEgmVn7aYTz6w71lNEn/xtL5brV6fh6Ek6ZrrDkx
EHC3iPZh8iFtgQOkYw4tNRR+tHTXuSx7wKlDQfVWjdgbUR0dsiaKQiINTAjVYz7n
2GLhOGDgXWiGTT1i7f0P6giylx9mVyF1mpTMvVlOuA919E3WQlOjBvIX0NVdFfo=
=Q/ex
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
