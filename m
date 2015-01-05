From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: alc5632: Constify struct regmap_config and
 snd_soc_codec_driver
Date: Mon, 5 Jan 2015 21:19:29 +0000
Message-ID: <20150105211929.GR2634@sirena.org.uk>
References: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LbN0412894TjpI52"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420449508-10701-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--LbN0412894TjpI52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2015 at 10:18:21AM +0100, Krzysztof Kozlowski wrote:
> The regmap_config struct may be const because it is not modified by the
> driver and regmap_init() accepts pointer to const. Make struct
> snd_soc_codec_driver const as well (snd_soc_register_codec() accepts
> pointer to const).

Applied all, thanks.

--LbN0412894TjpI52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqv/gAAoJECTWi3JdVIfQ/wQH/ipMaA4LO3UY2ry33LHLfDDz
C4fMay6ONKj9ONkmB1dXyR070aicAN1+0UvVYXEKbsdO7NJ2yAEOpVzKAA3dJoZk
/NHEEZcBCXtPHLi4WEIIznHwLdEQZWHYq9SsIerCG4zg7SriVayW/29ji4YKO7fb
JC008Zci+sbZ7+twqSLsQ2LgMyTpsO5ZLJ1WlbIvQzVHdnO/RoA4jk0l3I658xCk
WNNKAVIqYcx/4APYpNqTd8bnGEDzXoh1EqzJfr0Kt+VTWOd9/PEFvvZtTo2vcpVI
oYidP3tVLDnRCI8IcQLUZQYJ64y4PSCUYKzRfzOOJiM7Ez94Tw/qLIhCiQ6kwXk=
=vL0R
-----END PGP SIGNATURE-----

--LbN0412894TjpI52--
