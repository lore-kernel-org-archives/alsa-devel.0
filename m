From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: simple-card-utils: add
 asoc_simple_card_set_dailink_name()
Date: Fri, 8 Jul 2016 14:43:33 +0200
Message-ID: <20160708124333.GW6247@sirena.org.uk>
References: <87zipvlgyf.wl%kuninori.morimoto.gx@renesas.com>
 <87y45flguw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kxzGxOQ47d/df3Gk"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y45flguw.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--kxzGxOQ47d/df3Gk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 06, 2016 at 10:01:27AM +0900, Kuninori Morimoto wrote:

> +	if (name) {
> +		ret = 0;
> +
> +		dai_link->name =
> +		dai_link->stream_name = name;
> +	}

This code is unclear - it's valid C but the line break in the middle of
the set of assignments makes it look like the first assignment is an
error.  This should be two assignments.

--kxzGxOQ47d/df3Gk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXf5/sAAoJECTWi3JdVIfQ1VEH/14XhrosiOyYwYYoAXeAwD9/
64tUdKDAofKL6Djt6qakiMErnqk7Ki2SeorVNtoTU0BqvLf/W44/7m5WlivJU/tt
VXZldir6Dg58pQVLEY+eeGctTGJZ97oLTjy6TyRLgymGukAnug5p7H1l6POnS9iv
zkgSqoIWQWKs/dgeZF9Jwl9ql1/vhcibqfZhFARQybYMrtw4hQbfpwckxZUMnhO2
7mMmT7wno9f0n0Kd0CYlJzLvbdmq7bnTLkgt14fxyv8rxnPit0p4NPg7fBaxnWE7
Qr/RfNSxEMnMgRJO8RSZO6yUZ8NJrOGMqrAoD2QZaMsTjSvPeHy8lTOL9qfo1+o=
=ani7
-----END PGP SIGNATURE-----

--kxzGxOQ47d/df3Gk--
