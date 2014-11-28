From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Augment existing card DAPM routes in
 snd_soc_of_parse_audio_routing
Date: Fri, 28 Nov 2014 16:03:20 +0000
Message-ID: <20141128160320.GY7712@sirena.org.uk>
References: <1417122162-8122-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JOdSqRa1q7Th5Ot+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417122162-8122-1-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@lysator.liu.se>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org


--JOdSqRa1q7Th5Ot+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2014 at 10:02:42PM +0100, Peter Rosin wrote:

> -	routes =3D devm_kzalloc(card->dev, num_routes * sizeof(*routes),
> +	old_routes =3D card->num_dapm_routes;
> +	routes =3D devm_kzalloc(card->dev,
> +			      (old_routes + num_routes) * sizeof(*routes),
>  			      GFP_KERNEL);
>  	if (!routes) {
>  		dev_err(card->dev,
> @@ -4611,9 +4613,11 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_=
card *card,
>  		return -EINVAL;
>  	}
> =20
> +	memcpy(routes, card->dapm_routes, old_routes * sizeof(*routes));
> +

Aren't we open coding krealloc() here?

--JOdSqRa1q7Th5Ot+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUeJzHAAoJECTWi3JdVIfQHFgH/1PlWfrdpVbEHJdIPRjH2fTn
WuKmEcIDgBxkElmAscLjuoTCWMlFQ079OxO7CNLIwD7mW55+Xf77UiIys7uZDjVd
B68USu76j36m+Z4KmgQuDiWJWoNTlLschM/J3ef0wnGKJ0JGnfjpzN78p9EMcL2G
AlLYnewg3g6uwk4XAsY2+f3tS6zH3kh4ot9jp9sFynKtEBGxTwYpWKpTnmtoXGR6
PRmCprlwGZzUzg3aCiHey8BvNe6prqDgzhdkpk/160cOVXJ3SGvA5P40n4GZRcJ/
DLZwsNEnNDJDemGvRvHiAlGafFRpGEg5Mjc2nBAwxlOx+/tODP1y53E2ugmwCuE=
=5NBC
-----END PGP SIGNATURE-----

--JOdSqRa1q7Th5Ot+--
