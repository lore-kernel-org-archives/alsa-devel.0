From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine
	driver
Date: Mon, 5 Mar 2012 17:32:30 +0000
Message-ID: <20120305173230.GW3224@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
	<20120304133818.GE3083@opensource.wolfsonmicro.com>
	<20120305080623.GD16232@S2101-09.ap.freescale.net>
	<20120305115612.GB3224@opensource.wolfsonmicro.com>
	<20120305130707.GF16232@S2101-09.ap.freescale.net>
	<20120305131332.GM3224@opensource.wolfsonmicro.com>
	<4F54F0CE.60706@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7889511330823728461=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2595103FFB
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 18:32:32 +0100 (CET)
In-Reply-To: <4F54F0CE.60706@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7889511330823728461==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b2s+RKoBicgQlNJs"
Content-Disposition: inline


--b2s+RKoBicgQlNJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2012 at 10:58:54AM -0600, Timur Tabi wrote:
> Mark Brown wrote:

> > The DMA and SSI drivers should have some relationship with each other if
> > they're the same piece of hardware. =20

> The DMA and SSI are completely separate blocks in the SOC.  On PowerPC,
> the P1022 SOC has an SSI and the standard FSL PPC DMA controller (we call
> it the Elo controller).  On i.MX, there is a completely different DMA
> controller (I'm not familiar with it), but the same exact SSI.

Right, but in both cases we're talking about the adaption layer from
ASoC to the support for the controller which is shared between
everything on the SoC (though currently the PowerPC one just talks to
the registers directly) so logically from a system perspective it's a
part of the SSI driver.

Possibly the way to go here is to just call the DMA driver something
generic (though you don't really need a separate Linux level device from
a subsystem point of view) or have a library function which is
implemented differently on each platform then have the SSI driver either
create the device or do the call.

Either way it's something the SoC code ought to be handling, individual
machine drivers shouldn't have to worry themselves about it.

--b2s+RKoBicgQlNJs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVPinAAoJEBus8iNuMP3dvqYP/3GLgVN2NzPGvFse60SWQbZU
t+i9CF2keTFgepzvyN1QqKUNa+kQfIcC/WkiIjGQd7eFmmQrg2uUWeGHFQclIhm5
+WUUHgZE8Ee5C8vnhd1/tMniP6RMGkchgq6A52iLcvEmw6PzTvDazxw5aayZ2w4v
sNG9fglhLiJJzKh3Z3k3+ZhmuR2ArHOqMEP9OqId7vstjZc22XLRfIIBpFt7aMe+
thaed8pLoUDwfOdmaGW0laDd9GfVsDgueve5dH7iQAcw9hyrmpjgf19zFm2a0OH9
iR+iKcIToUgvFe9ZuY+b6/uaWbvoOaCwTUlDqLa+YgkbAYzgLyhVE7FwCEdwluUj
qAwfL0f9FANE2dGNOGLY2Y1yKPMKgYbVV5gHjstGpUZTKXv/EzLONGwhAhfF8obl
0R+50AbBkySJT3OaPowjF72fgsTTbXr7lCMLU8CZLc5HLHwWpRO3XkH9H1zpPNiS
pvnF90yRFaiAhjbCCgtRGaSIMMdAkS5p3JrQddCZHGVa9BUdKWwM7G6HrFtdNzR4
0yZSYpl8P0xJHViiyT5O0/CTmpm9GGWpZGseBRobXhsHq3nStwrM6sMRbuSUSUTm
YzK3HoNdZjDQ2dfDq5G3Ge4iQ9NIDtKcb5z5YuQY5fxwOgDkTbt6RMPMNxM3W9Xz
rxsqpaPsxsyhqB3RIQHh
=INAC
-----END PGP SIGNATURE-----

--b2s+RKoBicgQlNJs--

--===============7889511330823728461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7889511330823728461==--
