From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-audmux: Add driver suspend and resume to
 support MEGA Fast
Date: Fri, 16 Aug 2019 13:16:25 +0100
Message-ID: <20190816121625.GC4039@sirena.co.uk>
References: <1565931794-7218-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565931794-7218-1-git-send-email-shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, alsa-devel@alsa-project.org, linux-imx@nxp.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2019 at 01:03:14AM -0400, Shengjiu Wang wrote:

> +	for (i = 0; i < reg_max; i++)
> +		regcache[i] = readl(audmux_base + i * 4);

If only there were some framework which provided a register cache!  :P

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1WnpgACgkQJNaLcl1U
h9AuxQf/SUokJSA9quJeah9hsT6jJhQKPr9uQwbuhnIcx6+bhKouXbtrmPWZsHF8
zLUHwY1cvcQm2qitQxsYCZm1a65PWSIAX9P4s+GUfNVz9p2dL0q3TYDH8mDJBjWv
CK1KDEfko6PsY4AHrSa13aNy7IImcOn2J5+/CUOonmPlKPS7CezGbfACaQMG5Zdf
Ln4T/JnCQ6IZzFeJMwzD/RzXiwXOLc7SZ5mIADxbP+4rL9ByOG1BJy/rXIV9YbJe
IQqO5Zu7uen0NjPDOQP/Uy8RF4HItglOTrO8Cjr/95gQ4QJKxLzQyq5NzEGJu1h8
BgQWgH1vDAKWp04BZb2jzQtLMtmwiA==
=hQwi
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
