From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/9] ASoC: fsl-ssi: Move sysfs stats to
	debugfs
Date: Wed, 8 Jan 2014 17:18:54 +0000
Message-ID: <20140108171854.GN31886@sirena.org.uk>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
 <1387545096-2334-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4843132424800769519=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E1094261B03
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 18:19:04 +0100 (CET)
In-Reply-To: <1387545096-2334-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4843132424800769519==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bq0hafZ/7LEVOrxw"
Content-Disposition: inline


--Bq0hafZ/7LEVOrxw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 02:11:29PM +0100, Markus Pargmann wrote:
> Interrupt statistics of fsl_ssi are mainly for debugging purpose. Most
> of those interrupts show error states, e.g. under/overflow.
> The stats should be exposed via debugfs instead of sysfs.

Applied, thanks.

--Bq0hafZ/7LEVOrxw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzYh7AAoJELSic+t+oim9Ff8QAJO5kgVGHUC+JsOUDOrJToga
V9Tw3WlGNIXDTUhRYyFlfiXR1zosN4t8m1dgjSLdsxc2Dt9qmnF7nR+arqsnLy5s
SXzs3f8kr7Xxnqs8YzuWVOu/crmPUapEtmrs4i4TMS60Y9w8bd5cIyd0PwL5oxT0
F7wUeRwxK2jGr+Emgpv/NUkS/ZASl/Xx7qrZMd7NLAu1fw1Zg62FQ+YrGLpFLEjk
naXOioa1nBHAWNl/xNZ0BfgVkilGGC1FMn5bUsl7fLvoHo7bEjBf87/LoAy/isuU
zzCVMviePW6MZxb34Uf5wc6WgwPpnPggNaEr/qpt7TsfyoZgsky12vtCLtQFHP9O
HdqfFX0+4SWoPIcInwY02o9ZdYYjWgEgJcdzT5zYjVHPg89vymLT8ecxtosBb3Y1
v/ff/AiiCld/x+8AdGdqsr6apt1f8Oz+eW9gv6+jRZh+4WP536eK+wYKw3udHNbI
yomn7/2WkLGO5oBEJp/3+PVUUvY9EosxljiI0gct8sFTIUHyXcnCFOR5zuXmQlCD
9/9BRfWxsEfyafr/YI2/Y0dm31bRpejv/S3WcS1DWluyyFRoulnpCU7DmN+J96Yf
lP7YRQOprpe04LhAvBDMgPl5wN7oWF5qMOis6LnFdxsQKywKItR5oMPjl9lxzVfN
L9yqrd4kC030IGffu99b
=PuOh
-----END PGP SIGNATURE-----

--Bq0hafZ/7LEVOrxw--

--===============4843132424800769519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4843132424800769519==--
