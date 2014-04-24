From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-audmux: Fix section mismatch
Date: Thu, 24 Apr 2014 11:23:16 +0100
Message-ID: <20140424102316.GI12304@sirena.org.uk>
References: <1398320756-18123-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3945091398948753700=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 75968261B2D
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 12:23:41 +0200 (CEST)
In-Reply-To: <1398320756-18123-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3945091398948753700==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EJhpZT3muIGcMiNq"
Content-Disposition: inline


--EJhpZT3muIGcMiNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2014 at 08:25:56AM +0200, Lars-Peter Clausen wrote:
> audmux_debugfs_init() is marked as __init, but is called from imx_audmux_probe()
> which is not marked as __init. This creates a section mismatch and a potential
> runtime crash (if imx_audmux_probe() is called after the .init section was
> dropped). This patch removes the __init annotation from audmux_debugfs_init(),
> which fixes the following warning:

Applied, thanks.

--EJhpZT3muIGcMiNq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWOYRAAoJELSic+t+oim9YmEQAI/Vq6BrQkftPSnjDpOGVzsX
gvKab7kkUWOKUpIbYPvFkkyWTvArx3B9wJTBInNyjk3xVJGGHnm8iVyZkE0YA7zh
j5zi1D6i1AZwIzRbp+zIRHOZuQZu3QdWnKX3A0ko92losbfxbwGUAhTMMdLzizP4
TowixAnjV/O6/3WNDOTtNYGU80am4VrnPMDI0qiMV7WjY16Xs2BnKVv0g5DPLUR/
QVlFykQ6yHK+7/24Pxix2IaMog8rXPaKYujdX/Sl1de/A96s7fsO5oFKppq0QcPo
VwEGjCK2u2Dw5AcywYr6724VeFttV3KqLBrYdvZRloOZWm7nQVQhnTJZ/CaBJOrN
P4aq218ZVqDIooO8bH84mzP1HxgqqcxSrKWmqVT9ZNy7ySCTu1MRPEvcEKHmvgmZ
xIocu6WehczaLirBoP8t9uf9Rf5suIlrzdzZVOKarbYz9LpmrvtGA4/O8RubwmXs
dvI9LMV9Jy6N4eUHLeQqHrlrRp9vFMMcQtOUZzQDdZKFV7VgEXPeiFOoNFpiyP3U
afXHZ9O7J8p8IGaBFIN8caTJCb4vccis9xUSJEkdUrDvPSDCGw9dNzhRIlG7XW/M
1XUzQsZhxX1p4Z2mysxHQ+lkGyb7y6eEfLMDduSGlp6Q5PmCFwNfq0m5He5OeJMP
rLl6PlNqUWVzJcSvriRC
=vCo1
-----END PGP SIGNATURE-----

--EJhpZT3muIGcMiNq--

--===============3945091398948753700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3945091398948753700==--
