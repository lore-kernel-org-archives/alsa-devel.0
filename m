From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 10/14] ASoC: sun4i-codec: Add support for A31 ADC
 capture path
Date: Thu, 3 Nov 2016 09:30:16 +0100
Message-ID: <20161103083016.cgxnxtudezdmbhsr@lukather>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-11-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q3n7532fvxoencji"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161103075556.29018-11-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: alsa-devel@alsa-project.org


--q3n7532fvxoencji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2016 at 03:55:52PM +0800, Chen-Yu Tsai wrote:
> The A31's internal codec capture path has a mixer in front of the ADC
> for each channel, capable of selecting various inputs, including
> microphones, line in, phone in, and the main output mixer.
>=20
> This patch adds the various controls, widgets and routes needed for
> audio capture from the already supported inputs on the A31.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--q3n7532fvxoencji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYGvWYAAoJEBx+YmzsjxAgsGwQAMGE5wZu3qfmmzmmpLc6hHQ5
ugaorp4mnvSQ1P4fpfdPQzEnh00F97pueFtWZ6nBNUCJMO+5S4hj5vY6mKvOJIaq
o3hMKbUx9iL/JuGAvUnDVXbgG0b7Gqva2VsDFOBU1uysAOxlQWcbQy8p70Fq/sDj
2rEwqxa6h/NqGXa/RdbRC97wILge0nuyHx/U1IMT6odkz3yjputMPG/se9kLmF6j
e3ovvijdQ8/ikB0MLUSo7QlR2Qdk901xcbLmA81uU4jh0xYY3H6x7A33bEOeJVOO
+qzcnrygaBQNJ4XMgN7BpZ0XIfstK5VaEQAEm7JTDQxcoCVE9/8pmKyYAIGdQ+Ns
wfIEm1GR2hQT5z90zYY1ldg3k3DtQIIvrKedisF49H31/B3YXv+sLWfJBWNqw+nh
+CJ52zmGWLfu6yjsmXphLnm28PdLfAIx6UOFiBM1QMmHdQiW5jenQ+S5Iz0FDf9K
q6IZOQz33/QvBGiTCFMmijiQhEgbF350S36mktPKbUKz4BZjWAadzMT/nFgkqm8+
f7DHXd9hZWhL+aPw6KT1fxozaowuEij9cIDb2e3nu7dDYV5mu4Vn54Jtowoz2Z3g
Ss1jnePTlaGQzzMF9YCVdRo9h2JWroU+fbeJuuis5v0sTCFuQoThXEbaWhbW/J1p
jJZ+8ubSO31jqb0/PqyG
=mV8N
-----END PGP SIGNATURE-----

--q3n7532fvxoencji--
