From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: rockchip: i2s: Add set the divider clock API
Date: Wed, 4 Nov 2015 13:54:51 +0000
Message-ID: <20151104135451.GB1717@sirena.org.uk>
References: <1446434042-2139-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446434042-2139-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2015 at 11:14:00AM +0800, Caesar Wang wrote:
> In order to support more rates, add the divider clock api.

> As the input source clock to the module is MCLK_I2S,
> and by the divider of the module, the clock generator generates
> SCLK and LRCK to transmitter and receiver.

Why is this a requirement?  The clock to use as a source should normally
be specified via set_sysclk() and any internal dividers calculated
automatically by the driver.

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOg4rAAoJECTWi3JdVIfQMgIH/jCjY7jaU6R38DpFQ1iQCS6Y
Ig5zNk+PTq6jW8n1Zj2CAqML2Z4qO2JmhSm8dPyAP8w/bNyi+Mga4iPjDvomhT5d
ZUUL7pRCbw6ufBhuSALlU2YYCSeC904+ELIkWH6XHlJOCiwOdJRfLG2Xr7KYJ3Vo
+N8uFBQkfRC0OrrVTNH3cXo5XrP8MHssRyAw9AfGIvO3bUlErJCeV5uK6Cy6xVJN
+fI09fvIAbj4w9f0C2nWJ4CbxhEQFX/ksKdhbQgc7gJTqV6IHI8Ns3eR2p+6AXo2
o62Oz9Z8oOz0NCLBbByoZr94hJ3NmahuQ5sMgn4DB9iP+GlnzkxQZocGYRdSpy4=
=5K1g
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
