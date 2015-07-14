From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Drop owner assignment from i2c_driver
Date: Tue, 14 Jul 2015 17:57:58 +0100
Message-ID: <20150714165758.GF11162@sirena.org.uk>
References: <1436506231-8980-1-git-send-email-k.kozlowski@samsung.com>
 <1436506231-8980-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UI7gKp310iCrxvPC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436506231-8980-2-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Support Opensource <support.opensource@diasemi.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Peter Rosin <peda@axentia.se>, Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--UI7gKp310iCrxvPC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 10, 2015 at 02:30:30PM +0900, Krzysztof Kozlowski wrote:
> i2c_driver does not need to set an owner because i2c_register_driver()
> will set it.

This doesn't apply against current code, please check and resend.

--UI7gKp310iCrxvPC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpT+WAAoJECTWi3JdVIfQW5YH+QFSbzDjPD4wqWS9XJ9x8ckt
BEo5AsegihRvEBuMQwXS5/GGnp+RdrmWAmbuMYDQNWQP8g8h0wTgvs8J70Gr3xys
oNeAaqIknRUjadgfvSizQw0EwWlF1JV76yHqCFV6J0LO/0G0Ttx/FSV1g+yS2JSa
f4m86a7vHkyD6NOY7QxsnNn4pGGk5Ftk47X3sFV9LdjeH3WTt429ZIA3nK9Mi5/L
hbyc49RuwVzRhLSVn/vjqSUfE6QWyohQMdxeVQ4DY1wcdRua/2/YvDNHELUFCPBH
FEvi5P+JL3OTjO12//8pswMoOF4S9IOyAw4t2YfRJ2XSQRnbGStSqYEmBmfy8DA=
=Ctux
-----END PGP SIGNATURE-----

--UI7gKp310iCrxvPC--
