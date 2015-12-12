From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 176/182] ASoC: rt5677: use gpiochip data pointer
Date: Sat, 12 Dec 2015 22:48:29 +0000
Message-ID: <20151212224829.GA579@sirena.org.uk>
References: <1449669079-7119-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449669079-7119-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 02:51:19PM +0100, Linus Walleij wrote:
> This makes the driver use the data pointer added to the gpio_chip
> to store a pointer to the state container instead of relying on
> container_of().

Acked-by: Mark Brown <broonie@kernel.org>

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWbKQ8AAoJECTWi3JdVIfQxvgH/2snGIAkQNHC2rC3JNZsCrjb
uTxdQ63Rz2Xgp1U4Veu8uC1RAsV2AE97Qp6voKLzh9gReosMx8GT0r65fODnM9j6
CGOPx2h9hzPQbGwGmG/0TFgVGiLW2MZNhWzYKuIhaX90XNPVaVphWl5iizrdET6D
kIy/Ux6ur3YyMxPJvs0oMYBvtG8yA6iivzCpu63Tkw5k+G1yShvKhslO1wmWcPjx
awBrY2jNgkw/00SB1OeJ7xlRuWPfRDCnZxJIhsmGUjrQRAom05sETyM2O4g8h/jP
Ck7vYx4FHiNINox1qA2PqezAz5V9+Hj9zwNDJrxISVZBbI/tG8+zc5edoPVrLyg=
=nsAB
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
