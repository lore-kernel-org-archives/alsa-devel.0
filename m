From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsl: assign dma peripheral type
 according to bus topology
Date: Wed, 28 Mar 2012 12:07:36 +0100
Message-ID: <20120328110735.GL3232@opensource.wolfsonmicro.com>
References: <1332920096-9701-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8267947395714864980=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B400103F4A
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 13:08:02 +0200 (CEST)
In-Reply-To: <1332920096-9701-1-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============8267947395714864980==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z1OTrj3C7qypP14j"
Content-Disposition: inline


--Z1OTrj3C7qypP14j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 28, 2012 at 03:34:56PM +0800, Shawn Guo wrote:
> The dma peripheral_type for SSI should be IMX_DMATYPE_SSI_SP if the SSI
> is on SPBA bus.

Applied, thanks.

--Z1OTrj3C7qypP14j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPcvDxAAoJEBus8iNuMP3d2C0P/A0pUfsR2FvoN0v7i89CoUM5
Qb7Lxvmys0N/Now3a0miPXfixEm2d46Bo2cvYsDO6PBlSHd4L7n9SdbLUyw4iTwe
7/9tXXvn5sBLrUPCqHOquy3xEXiKTJMUnFDd78Ap/vHlSToNvNmewFcDhRD0VUET
8tSPZ01/MC55yWsb6YL3U1fiu60uvLeSzoMH0waYxHxVG/7kHpDUiVnLX1wJIUbz
M31ZSwyqpRrocEAYA6kefEfVrbPdwZFdx7jZTAgPs5EQ+NECUhbJvx+rFk00Gn3h
r/YWEhowknv778yRe20QBoI8OmfkVoWNUhD1IS/VV5jchvsQjD+JPEE5Lg9r4PqZ
WuriocgXTOMe9B/bL2d/NpFgfbA8f+mTcJdd3VAlHwKcfx2cA97TjROewN+H8I8O
/LvrYRhZb1SU7s+Q7FEEI0c+nPJxgE3u82mTaPDqv56hWVO1u/jDoW6w6X/vWA3u
g+5m6I0L1tAvigPU1AU7D4s7S8F7i0lhsmnlwfQ4aJtFh/t6/7VatcVpXe0iHQa2
Z5HLzYwLfNVFYA91C8U3IdwMMCEfLUKmOYqSZQ9g4SpHgoeoYxl1ZksXO2gJfb62
6Da+XRr57t2kyb6i16VX2OX4r0y2YTGYWYCF98Mx66sYTAfMG+iSrvibT0XuzKXZ
5STpLXZdgixHNyVYpB94
=0vJS
-----END PGP SIGNATURE-----

--Z1OTrj3C7qypP14j--

--===============8267947395714864980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8267947395714864980==--
