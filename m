From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/9] ASoC: fsl-ssi: Fix probe error
	handling
Date: Thu, 19 Dec 2013 13:03:34 +0000
Message-ID: <20131219130334.GZ31886@sirena.org.uk>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
 <1387367865-26391-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2909941096979416139=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E701265470
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 14:03:41 +0100 (CET)
In-Reply-To: <1387367865-26391-2-git-send-email-mpa@pengutronix.de>
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


--===============2909941096979416139==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lKbk9CFItQTD29wm"
Content-Disposition: inline


--lKbk9CFItQTD29wm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2013 at 12:57:37PM +0100, Markus Pargmann wrote:
> This patch fixes the error handling in the fsl-ssi probe function.

This doesn't apply against current code, please check and resend.

>  error_irqmap:
> -	irq_dispose_mapping(ssi_private->irq);
> +	if (ssi_private->use_dma && !of_device_is_compatible(pdev->dev.of_node,
> +				"fsl,imx21-ssi"))
> +		irq_dispose_mapping(ssi_private->irq);

This test is icky, a flag set when we create the mapping would be neter.

--lKbk9CFItQTD29wm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsu6jAAoJELSic+t+oim9H8gP/3pWXrwX0I/1jZndJL5XbbfV
1BhY5JVqpUQKkdJB31c2xk0isxOZEZWZHEvyUh5Ehig5VNxofFUisYFBfiPqB/yM
oM8hDmdCX1V15IH4TlZqr+ijNuPxUIZ5F2NvbXkSOyGYo+cEvfgquYg3pAmYbUqs
tLMil/07E0GVvlr10kzSx/hQ+jIA9jEZPG3czlZ5P9LQxFrS8Sm3OLJjDopFWbXd
YgxcoTsS3mYh7U9cIGpZFgneR8HuidpdlXU3RsB3F2PrLVDoxDr7LLZerb/3Cl1l
hYZveFVh7tKDn6iTdDh9oImZ9gs1gD3ugnmnBVxmImtwqERbpwEsQHaA++H7uHxz
MVh6sVa7R4NDyS/uo3eDwhfx15C6Znpc3BGgtdR9AYZ3s1ViYG8vVU7e14nvMrvB
qWe7FG65XcY8P4xipOYk7d+1E3VFQ955nW7kdgGsDeEWEItrTLwd9DUYVNiB9KYy
ZmTaDsOosP+9AsG9lwBcRLEyXj2Ii3C83sXa6KWv4e7wMPrg8CkMvIrDI3/IUayg
bco/j6kwxcmF6PGr9Z+YdPvCd9bV2NVMGJRZX+WOLos3O+UsMxktqnB+vRAR2fvF
7HhlHmoWBxIuoXi2g2hHVBVrB/9VMs1XYM1ayWlU3VOrphG4H7CHp3jiATOMBEv/
OdtR3QmRg30uNityrWZd
=D5i4
-----END PGP SIGNATURE-----

--lKbk9CFItQTD29wm--

--===============2909941096979416139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2909941096979416139==--
