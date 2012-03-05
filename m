From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine
	driver
Date: Mon, 5 Mar 2012 13:13:32 +0000
Message-ID: <20120305131332.GM3224@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
	<20120304133818.GE3083@opensource.wolfsonmicro.com>
	<20120305080623.GD16232@S2101-09.ap.freescale.net>
	<20120305115612.GB3224@opensource.wolfsonmicro.com>
	<20120305130707.GF16232@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0086013202056838533=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 025101041DE
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 14:13:34 +0100 (CET)
In-Reply-To: <20120305130707.GF16232@S2101-09.ap.freescale.net>
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


--===============0086013202056838533==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8m/hfNLtAhX2NvnO"
Content-Disposition: inline


--8m/hfNLtAhX2NvnO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 09:07:09PM +0800, Shawn Guo wrote:
> On Mon, Mar 05, 2012 at 11:56:12AM +0000, Mark Brown wrote:

> > In that
> > case they should either both be using the same device or should have
> > some sort of parent/child/sibling relationship.

> Sorry, I do not understand it.  Can you elaborate it a little bit?

The DMA and SSI drivers should have some relationship with each other if
they're the same piece of hardware.  The machine driver certainly
shouldn't be creating either of them.

> > Either way the machine
> > driver really shouldn't be involved in instantiating things, perhaps
> > arch/arm but not the audio machine driver.

> So you are saying neither what tegra_wm8903 and tegra_alc5632 are doing
> (registering pcm device in machine driver) nor what imx-ssi is doing
> (registering pcm device in DAI driver) is correct?  Can you please make
> it clear what's the right thing to do?

The above.

--8m/hfNLtAhX2NvnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVLveAAoJEBus8iNuMP3dXa0P/1Pk6aT0jMKdWx/rJ7FRJl21
q1moqQgH4Uq2S9xDMZDVdyuzcs/dHB2C0alAAKt1H2DuzBTc9ofPU9MHsU3T5b1h
CsDm7R4Jn6gqNFTElgz6Smx23YwhhwJn5sXHhjgQfUMgs06AYJ927zmcjKadPK2g
3V7zuLMkvPA3qxtCTFETntk8leXDzzz+g+MIx8kb+ZTHLq3amKTqk/NvcNWxpv61
PuJ3VjDfsLfJ/zyYkfQafzesT1swgj7xV0oXWaPn7hDUb7Rje16SIXQ8lyY+SNYg
K3dxy7e1VU0YobDEdnrHQ0EcHr2g0m1L9zdqrbdlYrgjsefBVNaOYUlENV0d9GWP
gXFY2cQLtAoiZ7MK5PXG7WzveolaThYQ4m7/7vsmFOlZRi2o+CO70a2jeRHIida1
xCl7KZglIdmi/LVZYOgSdKOXa46uHxRams0qyRbhkHdWx/zxdUyxnegDZDbs3b28
k/ewd+FOyRTR+rJr9Rzu/2dLiBvK3KfBlaYgJCpBtnvZgueZTUIRGtX09FrOjOSU
hg4iRD+3vmsbo8+pCf6F9lBUp4vUN9XmwGonS8ZN0lvVEaHiqbuOsORr/IkkF0QJ
9wdJn96gjI9lNx5T/2XUP5ODMJj1OzFnqjYD8hCYLlJzwH88ZUHZnOZ2tVgH6MNo
krhL8qK+QxV+vWr9F5yd
=zx7n
-----END PGP SIGNATURE-----

--8m/hfNLtAhX2NvnO--

--===============0086013202056838533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0086013202056838533==--
