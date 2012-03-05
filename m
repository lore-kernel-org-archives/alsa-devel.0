From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine
	driver
Date: Mon, 5 Mar 2012 11:56:12 +0000
Message-ID: <20120305115612.GB3224@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
	<20120304133818.GE3083@opensource.wolfsonmicro.com>
	<20120305080623.GD16232@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1712930195274714703=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D6AB7244C9
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 12:56:14 +0100 (CET)
In-Reply-To: <20120305080623.GD16232@S2101-09.ap.freescale.net>
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


--===============1712930195274714703==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 04:06:25PM +0800, Shawn Guo wrote:
> On Sun, Mar 04, 2012 at 01:38:18PM +0000, Mark Brown wrote:

> > This looks like there's a problem with the bindings, why are you
> > registering the DMA device from the card?

> There is a dma node in the device tree to instantiate the dma device
> backed by a dmaengine driver.  As a client peripheral of that dmaengine
> device, the SSI owns just a dma request/event number.  With the number
> encoded in SSI node, there is no hardware resource to be claimed by
> that pcm-device, so we do not have it in device tree.  Then we have
> to register this device in either fsl_ssi driver or machine driver.
> I chose to do something that tegra is doing, registering the pcm device
> in machine driver, to keep fsl_ssi away from imx specific bits as much
> as possible.

The above sounds like you have a unified DAI and PCM driver.  In that
case they should either both be using the same device or should have
some sort of parent/child/sibling relationship.  Either way the machine
driver really shouldn't be involved in instantiating things, perhaps
arch/arm but not the audio machine driver.

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVKnPAAoJEBus8iNuMP3doXYP/0FN7OBUSCS8Q3vYIMh8T00U
Y8k6ygmmXciQ/0HIzPzTTv7yMfbs3SmiD/JHEWiVvJd+FcwWuDrQT+QxLX37im0P
iMR207svMfgZ+648Z7zq6XllMuut6M7q+KXzuKONKBCwXoUa0OFWWTGsxO8TZ3cC
Jz2oFF4pcp7pPCcFamXs1QIWbb9e9D1/++KcRxQJ4jEOOn/qYOKYrH6nfjDN8280
BrozoBWGVnbfUVfE2uxvO/0bFz79dN1tJ8zLjRQCkKFlNLaFJfjD7neaDAAgFgW+
uRAwUZMUrGWjyrrWYS2Y27a5e6Qj5vz+r4O6YU2kMNqx84D75LK6zgBhTszR6yej
a+UNngc4p4SMIM6Qr+KUJ1gYxPMVlVc7tYuvj2p0JSHLl/yVWgNbeWUcRezEMDCr
Hpcsq0EvURMlHO65lniVWYiImfQOuWCwGl9gBPoVFPBlTEmsKnmTIXkaaM7+t5sN
2enKziDLg1rro3kRXoohYXqOKAyxdmthz7pGrk3Mvg/oS/4kBn8MtxQlEU12ddM4
wqbx1QBCTfKI4osegIiLvn8H47uFQEaFw4JU/7tWdoFSI21kpMxQ9z2FN2OP7ot+
/Qh0MoMu0yvGxjbb9KdppD8GgDeHZrtb/8dLZvJdmnMKsPnw/9MAMXRYuledziHz
YOit52PwEozdiHJmn+c2
=EcxN
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--

--===============1712930195274714703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1712930195274714703==--
