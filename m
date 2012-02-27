From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ
Date: Mon, 27 Feb 2012 14:36:55 +0000
Message-ID: <20120227143655.GI3191@opensource.wolfsonmicro.com>
References: <1329900026-24270-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7349519059040874025=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 793D124680
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 15:36:58 +0100 (CET)
In-Reply-To: <1329900026-24270-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7349519059040874025==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Content-Disposition: inline


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 04:40:26PM +0800, Shawn Guo wrote:
> CONFIG_FIQ is only needed when CONFIG_SND_MXC_SOC_FIQ is selected to
> build imx-pcm-fiq.c, so let SND_MXC_SOC_FIQ select FIQ.

Applied, thanks.

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPS5UAAAoJEBus8iNuMP3dj28QAIaHJrooFIaWhx+9mzXURPwE
ZZ5LEyfBFBfwu+gQRfELtNLlWUjsVbFgjekX4FHOR86LJ6HCpLP3ef+R1vOZqkUE
yHnjOPak9UQ9hdSquDR3C0p6Vo2f9fzB/Ta02hO4myN1re4D3PVyCag+B2j8VlUY
d/Cy+XmcpiCHx8Qphw/GrwUbWZKm3lljDmqcZi16Jby9YbZHXbOrEj9t/Bv5VTPu
yKSDkRZk8FAitltCplynN/5L7srOxetlxwvkoYM8fXq7s/4UdXJWoR663l9Ow5Cd
tzy13rXJCjomuENm7SxFgoRVg30ld7eqMtaynqvTpwZbJye/qKdSUW/w9DDYwAG0
trobclz7dVWXWNCviJIsXLGA8ipUsdK57c/cnbYwmVHAVKof8cqOVQanxSF0sHHV
LQ97UC9Jf8x32Md8chqvrjqHBTWvfc/FeMEswc2aRt+gerWJEHjQ6C3ZsufhGjCx
6RVrMDm2Vd4bGIi6IgcnD+61cy4kyxZ/0e7Ty8tpaHTwQ0XVKxI246uxCrvikxkh
5oaMvvCO3Y8+hKPkJnmRolyHt4Nenb5teOA0KRR4PjS2bsAB9TTwqhXBNKWzDukL
oqldAmP82KNlxxdqDfFxQbh2oSj2ScAtCLEijLwJ4Ut+u1J5YMzylFa1LSPeoEDn
ZJx1s4qHDbTQlLjewQdf
=SJU2
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--

--===============7349519059040874025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7349519059040874025==--
