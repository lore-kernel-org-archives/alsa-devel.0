From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: Drop owner assignment from platform_driver
Date: Wed, 15 Jul 2015 10:45:33 +0100
Message-ID: <20150715094533.GL11162@sirena.org.uk>
References: <1436934105-12700-1-git-send-email-k.kozlowski@samsung.com>
 <1436934105-12700-2-git-send-email-k.kozlowski@samsung.com>
 <55A60A54.7040004@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b0f+yOIoWb+ErSSH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55A60A54.7040004@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Support Opensource <support.opensource@diasemi.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Peter Rosin <peda@axentia.se>, Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Koro Chen <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--b0f+yOIoWb+ErSSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2015 at 04:23:00PM +0900, Krzysztof Kozlowski wrote:

> > platform_driver does not need to set an owner because
> > platform_driver_register() will set it.

> D'oh! I forgot to include ack from Koro Chen given here:
> https://lkml.org/lkml/2015/7/12/218

That and the fact that it's already applied.

--b0f+yOIoWb+ErSSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpiu8AAoJECTWi3JdVIfQfoUH/3XH5eenWa68rvAa64fV1tJ9
1TxAkso+cHESDqSiLquDHuN0awKawPb/Uo+/VJrw1CSgEDNNWIMG1qBugkZwCyCu
2Zmbn3iQJqsUpppjBNlPPzNVYhF2TF7qIxOf1q5uTizFobgdelgaSMEomjzJut67
pkUBIlz4drrodnyAheTILbsPbpS5zN5nrCCqxtKQn1BX67MDssq328zAn0DYz0m+
RC5WuOzHWpaEiyjmZOjCBuPNRzNUuQo0zZoUmN7bfeA0RTGQXd05jmLidtfFJpuW
sYcWTTX3kow0XprjhrMtp+l88SutFXtiMh4ETf6fmknZMWN7lAR+Flfmfu5syNI=
=ezZK
-----END PGP SIGNATURE-----

--b0f+yOIoWb+ErSSH--
