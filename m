From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Thu, 15 Mar 2012 17:11:13 +0000
Message-ID: <20120315171112.GP3138@opensource.wolfsonmicro.com>
References: <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
	<4F591B8D.8090705@freescale.com>
	<20120309013216.GH2499@S2101-09.ap.freescale.net>
	<4F5FD706.8040209@freescale.com>
	<20120313234638.GY3177@opensource.wolfsonmicro.com>
	<4F6008FA.3040805@freescale.com>
	<20120314122723.GC3133@opensource.wolfsonmicro.com>
	<4F612319.50302@freescale.com>
	<20120315142702.GL3138@opensource.wolfsonmicro.com>
	<4F621C60.5090700@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3347906925804036658=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EF9E22437E
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 18:11:17 +0100 (CET)
In-Reply-To: <4F621C60.5090700@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <b04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============3347906925804036658==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S0GG+JvAI2G0KxBG"
Content-Disposition: inline


--S0GG+JvAI2G0KxBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 15, 2012 at 11:44:16AM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> > The SoC is the bit of silicon with the CPU and other devices on it like
> > the DMA controller and SSI or whatever ports.  The card is the PCB this
> > has been soldered down onto.

> Well, I asked about the difference between the soc BINDING and the card
> BINDING.  On PowerPC, at least, there's no distinct binding for either.
> For example, I2C devices are on the PCB, but they're listed as child nodes
> of the I2C controller, which is on the SoC.

Right, but this is the problem in a nutshell - there's nowhere to put
the board binding so the SoC code has to know about and do it.

> However, I don't like the way this is being represented as a PowerPC vs.
> ARM issue, because that's just not correct.  It's an "old binding" vs "new
> binding" issue.  For example:

I think that's just creeping in because the old binding is the existing
practice on PowerPC.

> +	/*
> +	 * In case of imx, the machine driver uses new binding which does
> +	 * not require SSI driver to trigger machine driver's probe, but
> +	 * the pcm device needs to be registered here.
> +	 */
> +	if (ssi_private->ssi_on_imx) {
> +		ssi_private->imx_pcm_pdev =
> +			platform_device_register_simple("imx-pcm-audio",

> This prohibits me from using the new binding on any future PowerPC parts,
> because it clearly says "iMX" on everything.

So long as it's internal to the code (which the above is) I don't think
it really matters, the code can be changed later.  We need to do
something about DMA controllers in general, and there was some recent
discussion on the DT list about a generic binding for them, so leaving
the code as-is with nothing in the DT itself seems like a good place to
leave things initially.

--S0GG+JvAI2G0KxBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYiKqAAoJEBus8iNuMP3ddNYP/0SLpcKk4ToWVCfx/dIFyzGY
q7hR55wu+b6YPBXp4AZK9PVmXotJC7rkagLz+z4Vlob/2GEVIc7jbfMa8d0giTiw
wuoocYeh8TH4eZhQeio0BqPdJL171aoFlmErrKe1xSYbmQ4rnTFgJb/HavX/urxB
buzZak2aD7RxNDS9xaH0705tML75ngXhKx47yjzFBPsz/gf292tYFCD/ofeAYRSy
0oke13tDiak2PXZ4MGirdb6yvCtg2BjEYJ5DXjs4XuUbl7Yg5dJo68/SQXieGFdX
khl+6QmQk57SrKihZvwJZb0JKO/DH44k3cCLQ06ig7gOO6RsN8m9wtIe1oM3ZHsb
KdWWXvoix/yn/R0Mw4vm54NpV+/oSmSIm6xU/6s2UMfS/e8jCe33GWWHXXvQmGxI
bzI5hF8oNiFt77ZxnKnL9xthIjdHFBOrvOlKBdGgtFbvocrfMiucezS6YTnb/DPI
hnZlEsH/45IQ7XjcNlIcB79q+wIYaEcTBUz0nTVX6Ww1KLr9vHGKls8/A40fLynf
m+DgCaDtxBBp/tgxeO84lQwLienr+GY9sWSPTJg4cjCeGtqEQ/P2Wv20k0hExYKp
Vj9WuHo1QFgaxinGJHicmVItc+9lFCs7Fcna4gautjCx09BTl8Qh4JkonoTuQS3r
7IxU1A7DW1oQCVHmYKsg
=A2Uv
-----END PGP SIGNATURE-----

--S0GG+JvAI2G0KxBG--

--===============3347906925804036658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3347906925804036658==--
