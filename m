From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFT 2/2] ASoC: samsung: Add proper error paths to s3c24xx I2S
 driver
Date: Thu, 27 Jul 2017 17:56:13 +0100
Message-ID: <20170727165613.uceqmidtgo52f3mx@sirena.org.uk>
References: <20170726185729.28897-1-krzk@kernel.org>
 <20170726185729.28897-2-krzk@kernel.org>
 <49f6f3df-f7c9-cf7e-95ad-e3d6fdc78014@gmail.com>
 <20170727165113.dkqx2djk2b2rgbp4@kozik-lap>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xmacla7j4impttiy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170727165113.dkqx2djk2b2rgbp4@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--xmacla7j4impttiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 27, 2017 at 06:51:13PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Jul 27, 2017 at 10:41:35AM +0530, Arvind Yadav wrote:
> > On Thursday 27 July 2017 12:27 AM, Krzysztof Kozlowski wrote:

> > Now s3c2412_i2s.iis_cclk and s3c2412_i2s.iis_pclk are holding "iis" clock.
> > Now no one handling "mpll" clock. If we will call s3c2412_i2s_remove.
> > It's means. we are disabling "iis" clock twice. Which is not correct.

> Right, what a obfuscated code is this... Thanks for pointing this out.
> Also the s3c_i2sv2_probe() misses clk_prepare().

Yeah, I think the root cause here is that the code needs a cleanup so
people can tell what's going on.

--xmacla7j4impttiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll6GywACgkQJNaLcl1U
h9Al2wf+KHBql1xY5QI8V6AJDm5Efcz4avJWn/WXPCf+ah2WiUeGUr8Yy0V5vFxQ
dNClzPMueURCBc4WWqjUSzNJQaPEcolljWAuBmKW/Wd20XHi2e3fPenP/opbzoN5
WTRz5il7v4c+UrIC9b7v78wNO7ITWcB8d1gcWfsFuTTpGHGhbqODiTdWT3oDup2z
FyJOnUKpf4DBA33LS04tilqVWyFMvplWovELn4bZCYcJId0zGPFqmYEZg+Twx+Yv
ZlNtJFt+Nl9Euk8Ey53a801ytscgvZQ7dZpbE8KKn7+o8Akux3D2PWwkA6DFoWW5
rgvSWMIjnYLzQUTu2juzA3jeaYz7Eg==
=9qy0
-----END PGP SIGNATURE-----

--xmacla7j4impttiy--
