From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/9] ASoC: rt5514: Avoid legacy dai naming
Date: Mon, 21 Aug 2017 18:31:07 +0100
Message-ID: <20170821173107.wzkbnvqylkovg634@sirena.org.uk>
References: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
 <20170818031147.16810-2-jeffy.chen@rock-chips.com>
 <20170818114544.szfxl5pbul7gwgxg@sirena.org.uk>
 <599701D2.5080001@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wgkzqw3f4bi4chrm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <599701D2.5080001@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jeffy <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de, briannorris@chromium.org, mka@chromium.org, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--wgkzqw3f4bi4chrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2017 at 11:03:46PM +0800, jeffy wrote:

> when using legacy dai naming, the dai->name for rt5514-spi would be the dev
> name, which is spi2.0 with my local 4.4 kernel, and would be spi32765.0 with
> upstream kernel.

It would be better to fix the code to not need a name if the device by
itself is unambiguous.

--wgkzqw3f4bi4chrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmbGNoACgkQJNaLcl1U
h9B+Pwf+K413a5t9vOemk2suknjIJWu2KSZU9/Z4r5fLJgoJ+HEFaTyFqzJqtftl
2hyxA9gaexGOsI+9OraTNUZgDCM2QqeYi+u2x1CYXx2KBo0MnwQpR/CJd6yRDV5C
9Tayj7G7phIXyh8O4SYCJa20/hV+Cdgwoe0D3KhgdGzEmPY+CaVfi9+jMyO1d0ax
0IjYnXibCtYbhHajyJ1Pu3jl7lPxSiLRqRdX6IDlbFzcDYNZmmiVnsskFIKzsS6v
QG1G9gLCKyzI7BLn+i2bD+XjmgTFKYIoysqYYISwrOIvgM3fUBrFGTtwvgGPMc1/
HKAB9qzGrQBHBP7RK7a17MD6i8EY9Q==
=pb2k
-----END PGP SIGNATURE-----

--wgkzqw3f4bi4chrm--
