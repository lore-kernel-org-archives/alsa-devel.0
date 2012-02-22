From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2/7] ASoC: imx-pcm: Request DMA channel early
Date: Wed, 22 Feb 2012 13:22:37 +0000
Message-ID: <20120222132236.GF7340@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4626766516385253404=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9FBDA103F64
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:22:38 +0100 (CET)
In-Reply-To: <1329904151-5927-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4626766516385253404==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
Content-Disposition: inline


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 10:49:06AM +0100, Lars-Peter Clausen wrote:
> Request the DMA channel in the pcm open callback. This allows us to let open
> fail if there is no dma channel available.

Applied, thanks.

--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPROwWAAoJEBus8iNuMP3dywoP/3NqhwPCU3DrtVfZkUJ2AXWA
a4IgJnVMxUbPiyRzC2vGcW0aqwgEmCcNUykh8y0Lm06xNLKJL9OBfGezEPA27BW+
Wz5rKv95AvxWpstXg2uH5tmQLC/nNXNYsLfnTQeRuxEf5WkDUxcRwTRmJt5YpDgc
xLrj/4niOrqY+nu3HKgxjpDuwD7y7gC5e8d+fj9/J5/cv00YCmkzEOoEJRfFZdoF
WsHetQIyal6M0EmKf5HRojGWFHbkYzR/3yoACGxI0u4kWv7wA+izJIXR+ul8Z/Xp
1HNtPIZs+krpdfpbwHS4jqQgvzVVDOogXVQnSG3661E7wBbCAXqiZPGrD+933gCZ
G4F1AWnCywImFls5Jm55o3VIBetROFHJCO4d2RCWSM+mENa6A3cSS4tvyVi3LQ8m
gDASWIs2sS+fKOZxDzx8AQlUu/J4tTIpsZXFMLUIYdH9MYSRXZ6tcTXXhG5AEuLL
GeVJ1CJy9fr4wHL2GmP+Jeb89MdqrIvDySXAHZUZSHmeifB9jad9WpslBddkV2eD
yv9rAV/PV0ctvESvNABfC7a0CrqdNHtP7eSXRqguPAI0TJecafeVO6m/dqVckifE
B698lsMSgOs6QfIR8b1MmKsG/rjHQaTvDN1w3cKkY6rrDeMeQNhAJ1DTuqRGzjh5
gnxJ8siW9mJvF0CSyPr4
=qqad
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--

--===============4626766516385253404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4626766516385253404==--
