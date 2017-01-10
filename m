From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tm2_wm5110: include gpio/consumer.h
Date: Tue, 10 Jan 2017 16:40:42 +0000
Message-ID: <20170110164042.d6yb3j6ucdito7mq@sirena.org.uk>
References: <20170110153104.3143248-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="trt3g2pzno5g2mwq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170110153104.3143248-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Inha Song <ideal.song@samsung.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--trt3g2pzno5g2mwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 10, 2017 at 04:30:50PM +0100, Arnd Bergmann wrote:
> gpiod_set_value_cansleep is declared in linux/gpio/consumer.h, but that
> is not always included implicitly, so we have to include both
> gpio.h and gpio/consumer.h here:

This doesn't apply against current code, it looks like someone already
made the same change.

--trt3g2pzno5g2mwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh1DoYACgkQJNaLcl1U
h9BOMgf+Nbreiiu3fk68awYpz6ziBWSNvkgY1jQiHl3ouEMQud23YgzuNGQ9hnrg
SOlxhAFVWi3GJ2oERImgEdtrr+/fR3f7UmmK7ffwh/X012yolx/LflpW+TMnbLIg
ptYP6KOZOOI8Q/VA/f600rKqP1vLWrTgBjXD+dKc4plzC7kIt4UtUcyGSi6cfqnU
84izs+QzDbIt26G0Oz3qC58g8s6h/D2oigyx83+PYfaHI1NrdbRoTQKlLTD1IzQm
OBU/pcHDWZup8ZAHQMzDtHBh0X7ewavTorxLcfvuSPeBNcwYDXbeRpuseD3FY2qe
rzf7/0Sa6kl8sxZJ++9QgQkMv3y1vw==
=eI5V
-----END PGP SIGNATURE-----

--trt3g2pzno5g2mwq--
