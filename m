From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASOC: wm8960: Add multiple MCLK frequency support
Date: Tue, 12 Dec 2017 17:37:56 +0000
Message-ID: <20171212173756.GM16323@sirena.org.uk>
References: <1513079936-163297-1-git-send-email-chen.liu.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xtx0sNU5lZ46KfgK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513079936-163297-1-git-send-email-chen.liu.opensource@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen.Liu" <chen.liu.opensource@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, shengjiu.wang@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2017 at 07:58:56PM +0800, Chen.Liu wrote:

> +retry:
> +	if (unsupport) {

As Charles says this would be better as a loop.  It'd also be better to
say "unsupported" rather than "unsupport" - it scans better for native
speakers.

--xtx0sNU5lZ46KfgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlowE/MACgkQJNaLcl1U
h9DR5gf+IRGFFjoWX577ki4jQnLo26O8PEL0AHCxHR2omSNE/X4FpbsgHok1o2J6
h6YBz1iiWX3638lhnQIPNAMd96P84dqeKx15h2DG3F0pjvVHxwpHQ7Jy2HBfP61F
p8+617InHWNaSy1yPBcVwwPqcof9Su+s93mSaQBWKwxS1ucUkJOXH5BKUdxnkIZu
2Hf8r6IAkA81mAx07kPHE5eVbn4+7BA1INjYj3R5lbpiBJ5EXGxTJBUPOATzHAeS
feLZV9pPM6cjJCppXO/49EuUdkxSXu0ZUJljKOLKJL7ub7AyHhBhoNrmg5RCtUmo
hfflz61WKyZDD4gl+KmC9GhmN9nMTw==
=5yi5
-----END PGP SIGNATURE-----

--xtx0sNU5lZ46KfgK--
