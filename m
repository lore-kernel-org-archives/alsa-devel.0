From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Fri, 16 Mar 2012 19:18:12 +0000
Message-ID: <20120316191809.GG3158@opensource.wolfsonmicro.com>
References: <20120313234638.GY3177@opensource.wolfsonmicro.com>
	<4F6008FA.3040805@freescale.com>
	<20120314122723.GC3133@opensource.wolfsonmicro.com>
	<4F612319.50302@freescale.com>
	<20120315142702.GL3138@opensource.wolfsonmicro.com>
	<4F621C60.5090700@freescale.com>
	<20120316020111.GE6065@S2101-09.ap.freescale.net>
	<4F62A06C.5000304@freescale.com>
	<20120316025219.GB7632@S2101-09.ap.freescale.net>
	<4F62B941.5010306@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2842150151040061068=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4AFCA2434F
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 20:18:16 +0100 (CET)
In-Reply-To: <4F62B941.5010306@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, srwarren@nvidia.com
List-Id: alsa-devel@alsa-project.org


--===============2842150151040061068==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 03:53:39AM +0000, Tabi Timur-B04825 wrote:

> might be a way to general the call to platform_device_register_simple.=20
> Maybe we could put "imx-pcm-audio" in the device tree?

We might end up doing that but as this adaption of the DMA controller to
the audio stack isn't really hardware so much as an implementation
detail of the audio stack it'd be nice to come up with some neater way
of doing it, ideally not involving the platform device at all.

I'm starting to think we should have a framework thing that lets DAI
drivers say they're a combined DMA/DAI driver for cases like this where
there is a generic DMA device that's being shared by lots of different
subsystems.  It's a common situation and it makes the device registration
clearer.  Adding Stephen Warren as he was thinking about this stuff in
the context of the nVidia drivers.

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPY5HqAAoJEBus8iNuMP3doOcP/2AJi84lntsZ5uDdrjNNoRxV
j/BYGhTLvhk5YZYyGjGm8xPskd8NGx9T1j0/MNAMFnE5bDWP4tThL9WMQwh/7o3S
fGPFzEFZu1LWvtZv9FB7xg0wVkZxHH5HWZSqUb+R/KEULbjXkOTFAuAzdCPQArR5
42eQGu7x2Jm831mOBmARchja9LWowFhZ1LYvHbP3jtTlIQtZffavqy1KD/xxwj9y
Rq1ZbFcyCADcK4G/4KDar4bWgLXlyynsBsRBV/rGxOHzZdNrYU/+Jatd9v9nGPZE
DDbpY7lAN87mgZdCFTQcMzWT72rjBW2hfntBGKA10GZ2cjHgRILDuh5S5zdBquQl
u6SXdSvh4uAXnkVN0NGp7pQCs+N4XSHUoKZXNf610cfR2KW9vox5tz+1etoYFzYN
7iztS7EKmNJc7jkq48njZQoc7HP7aB20tNn6gDWsVxu1D7ByW3t8psl6kJldcEZ8
fezdkWFoWIO4A4lFbgB5jR4+CPQjpt0rilIgiKcgyOoB0z61ymor9e2QHmNki0TP
noY+B83oC9n5QEvaUqLmVhaSa6EQ19G8xgcV6bOykoUGnKyJfZRPXILhtlKb5+da
3DTDIMLsZx820asyUjsHTvY5NcRpPFvSYT/h2SrdklaYh4ttpRrtd6RyRrHcNoyX
6hEKpAuWXEzjcX5zBmLB
=sqU7
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--

--===============2842150151040061068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2842150151040061068==--
