From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 02/10] ASoC: imx-pcm-dma: DT support
Date: Thu, 18 Apr 2013 15:56:02 +0100
Message-ID: <20130418145602.GL13687@opensource.wolfsonmicro.com>
References: <1366288424-7660-1-git-send-email-mpa@pengutronix.de>
 <1366288424-7660-3-git-send-email-mpa@pengutronix.de>
 <5170069F.4030200@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8408910823354031386=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D122264F0F
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 16:56:04 +0200 (CEST)
In-Reply-To: <5170069F.4030200@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8408910823354031386==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cW0eHRJ76X8TDo3d"
Content-Disposition: inline


--cW0eHRJ76X8TDo3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2013 at 04:43:43PM +0200, Lars-Peter Clausen wrote:
> On 04/18/2013 02:33 PM, Markus Pargmann wrote:

> > +	if (pdev->dev.platform_data)
> > +		pdev->dev.of_node = pdev->dev.platform_data;

> In my opinion it's better to use pdev->dev.parent->of_node here. In the ssi
> driver you use platform_device_register_data, which will create a copy of
> the of_node you pass in as platform data. I'm not quite sure how well this
> will work. If you want to continue to use platform_data you should at least
> change the code in the ssi driver to not make a copy of the of_node.

If nothing else the above code just looks wrong and confusing.

--cW0eHRJ76X8TDo3d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRcAlTAAoJELSic+t+oim9r0EP/3uVVhDqP28BfB8bvqLeCkSA
mrugRLtP8B4VTIRBlNTTBTwB8l70auA4GjEhSpL5Lyu02paHeJF0ppfLVezs5R5n
TFz0nnmqQmeQe7OXu/swLCjQLzGRULk24hl0kQMvNucn/76oq4og5S9QP5NWyzBH
y0kYtIvSUPO3fRw3rfAmHQCafBsvr10v/bD5dMpAZqeZS5UuRa7uM2yL+g0wXQzE
pAP/ecM1KR2/RgDoWZea7GxzBphA8hjFqXDskvwDTWc00TKkKDNsQJkAKrivWgzr
5zYdI2FtDPQglBI8w3xRcJhFYNglXHspSQxyjQ1mCyk+LPeO5XgKBvUpiLQIF5cv
SP9ZqG+htAbG6W+BtHowUcyVSiKrCIuiSn7H/3KvUnQiDwHi/iWAYOEYJ2guPPK8
6lu0IyG7/ifiWON1QZOkQDIrjvtb+Z6IrTTGSNokm7qqcsMgsJ9wsmMhQ+8aNAym
LPF+9op2Je23qVcTnjWXEPNQWhZhlVjIR4CJH+JCFtNdIMLsefn0ciyw89dsJbn3
xB0QRH/BDGyGehOwHzeYd8jgMpKNRot3BPf4dFEc6RvGo0vJllX896DZxqq1iyOI
9Sh/Z1UFmv6gLQfE0SMCU6kY8zZDbXNL/yx/72rD0Rv8SOgSPaWyM0RPZ0nCXRg8
1+FLoyeeMMOsYr1SbBXz
=WFo8
-----END PGP SIGNATURE-----

--cW0eHRJ76X8TDo3d--

--===============8408910823354031386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8408910823354031386==--
