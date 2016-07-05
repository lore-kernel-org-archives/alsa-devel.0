From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: simple-card-utils: add
 asoc_simple_card_parse_dailink_name()
Date: Tue, 5 Jul 2016 14:35:02 +0200
Message-ID: <20160705123502.GR6247@sirena.org.uk>
References: <87wpl79q79.wl%kuninori.morimoto.gx@renesas.com>
 <87shvv9q3q.wl%kuninori.morimoto.gx@renesas.com>
 <87vb0l3plf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1trTh7oBgAEAEHeG"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87vb0l3plf.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--1trTh7oBgAEAEHeG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 05, 2016 at 12:24:54AM +0000, Kuninori Morimoto wrote:

> Please let me know if your favored style is name format should be
> handled on each sound card, not in utils.c
> I can arrange it.

I'd definitely prefer to limit the usage of DPCM in generic code so
keeping it in the card seems safer.

--1trTh7oBgAEAEHeG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXe6l1AAoJECTWi3JdVIfQDjAH/3UPqJSaEW7mJo3Rb0414hJF
GAx4yZMfwuBz2A0DOxdbX77MTgfWWqLOd9wKxc4oB75vHvbzXIvZP8oZJDFtB6H3
nvYBQpn6e105aOuFuxxjZ6qz8jXuWS3kATzwM6/lf6NpsmFJpHXaeolXGksvRJff
C24EpHTAqquqj4fedbhjgrX24dEA7PRt/6abJ9vDWan1/sKz4C00UrMKbVDBuCWF
b5sGwenYJ264yQELxAzMDATDzaGPT9SzzxopTLps1cYEUdOPO3JRI1S8EYhoNwCG
n+8iSKXwj4/rElGfll98P5C435aSm8YaBgvgD6QMOmxQsZrysJJpZboh/m+/Fuo=
=k3GL
-----END PGP SIGNATURE-----

--1trTh7oBgAEAEHeG--
