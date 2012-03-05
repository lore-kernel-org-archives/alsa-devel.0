From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine
 driver
Date: Mon, 5 Mar 2012 17:03:18 +0000
Message-ID: <20120305170317.GV3224@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
	<20120304133818.GE3083@opensource.wolfsonmicro.com>
	<20120305080623.GD16232@S2101-09.ap.freescale.net>
	<20120305115612.GB3224@opensource.wolfsonmicro.com>
	<20120305130707.GF16232@S2101-09.ap.freescale.net>
	<20120305131332.GM3224@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17BE861C14@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5943056462120911425=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8A1DB10400D
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 18:03:20 +0100 (CET)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BE861C14@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============5943056462120911425==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hc4757KF+wLS/WHK"
Content-Disposition: inline


--hc4757KF+wLS/WHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 08:55:22AM -0800, Stephen Warren wrote:
> Mark Brown wrote at Monday, March 05, 2012 6:14 AM:

> > The DMA and SSI drivers should have some relationship with each other if
> > they're the same piece of hardware.  The machine driver certainly
> > shouldn't be creating either of them.

> Note that in Tegra's case, the DMA HW and the DAI (I2S/SPDIF) HW are
> entirely separate HW blocks and have entirely separate drivers. The DMA
> engine is generic and not audio specific, so has a node that instantiates
> just a standalone DMA device which has its own API. This doesn't
> instantiate any kind of ALSA PCM driver. It doesn't make sense to have a

In this case (and probably in the i.MX case, at a guess the structure is
the same) I'd just have the DAI drivers kick off registration of the
ASoC DMA stuff, it's all part of the ASoC driver for the hardware really.

> DT node to instantiate the ALSA PCM driver since the PCM driver is more
> of an API bridge to the real DMA HW, and certainly not an actual HW

Yes, and a Linux driver model device is questionable too.

> Perhaps our regular DMA module driver should expose both its custom
> interface for other clients, and register an ASoC PCM driver? That way
> we could remove the PCM device registration from the ASoC machine
> drivers.

That's another option, do it from the DMA driver instead of the DAI
driver.  My main concern here is that it shouldn't be the machine driver
as it's all internal to the CPU and not machine specific.

--hc4757KF+wLS/WHK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVPHPAAoJEBus8iNuMP3d9S4P+QFSkizgETeDvIOXmIJDD9B2
PEpvvn18g/6zRoADL0CBclCDmgbrtBMeo8I761d+f9o9e+NehuCFsaUATUHKvSFr
SnsyW1pt6TimKty9gEKk0cQDzvI8Fui5CsaYEkbE9FOxxR0vWCYcevt919ZSNMTo
g3f/569XIYcDkX8X0g16khC2+kCQP5yjpeCJA/EmU/ogzTA1gHepHfb23Tw4dD/8
xi0nWmrRF13FaWmUjyHbNS0Z9GfMNwVuZEPn2Iq2dyja+ZTmLZioKAh57DnUxiXt
h8fp5NVGo/D38H04gIKMjBiAYT/cteyMEhlJoUULCIs2jeBxvReYMSmazJ7ijmrd
DNH/nWxHRfY2I7Sw8+Z4AYlilCfeP57f8Qu5G3KSbLKPL+VwPxCuwewu1Hax5h/f
c8waa1RIlP433d/QAdnRS60WRsuK7fMaa8gjK43aj+jLTgK3IRmeBZZOKD9iP6p8
Qhvl/fV2FGE3rUq0vA6oH2xtUkGfO6eKknutPgFlyOgLmg+NvsWaxxm4Xr8WHn00
RAheUS6jCh8OpHm+2h3qDYjC3g0YX7VPwv8uP6Y16UJ3xmdetHRx3OC0XmIIgv2P
J/1DpJEZjlvzvrJO/RiYr9JMkwwoiSSS8Oh59BtoSgE4xHCusV5/oDX3lSmLFF55
A2Wfe8fKh/piDsaVHW6u
=MOwE
-----END PGP SIGNATURE-----

--hc4757KF+wLS/WHK--

--===============5943056462120911425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5943056462120911425==--
