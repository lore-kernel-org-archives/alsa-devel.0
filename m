From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine
 driver
Date: Tue, 6 Mar 2012 20:11:53 +0000
Message-ID: <20120306201153.GF19635@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
	<20120304133818.GE3083@opensource.wolfsonmicro.com>
	<20120305080623.GD16232@S2101-09.ap.freescale.net>
	<20120305115612.GB3224@opensource.wolfsonmicro.com>
	<20120305130707.GF16232@S2101-09.ap.freescale.net>
	<20120305131332.GM3224@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17BE861C14@HQMAIL01.nvidia.com>
	<20120305170317.GV3224@opensource.wolfsonmicro.com>
	<4F565528.1090505@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4314617223342483564=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 73C7124418
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 21:11:55 +0100 (CET)
In-Reply-To: <4F565528.1090505@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============4314617223342483564==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LsnByradU3Ze6UwI"
Content-Disposition: inline


--LsnByradU3Ze6UwI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2012 at 11:19:20AM -0700, Stephen Warren wrote:

> > In this case (and probably in the i.MX case, at a guess the structure is
> > the same) I'd just have the DAI drivers kick off registration of the
> > ASoC DMA stuff, it's all part of the ASoC driver for the hardware reall=
y.
>=20
> How would that work when there are multiple DAIs, e.g. on a system with
> 2 I2S and 1 SPDIF DAI and they all want to register the PCM driver? I
> guess I could just add some utility function in the PCM driver file to
> ensure that the platform device only gets created once, and probably
> would also need to refcount it for when the DAIs get unloaded etc.

You could just create a DMA device per DAI since it's just a wrapper,
you shouldn't even need to allocate a new struct device but just use the
DAI device when registering the ASoC DMA driver.

--LsnByradU3Ze6UwI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVm+BAAoJEBus8iNuMP3dKSsP+warZ2x59m4FvG1kvD8YZJs6
+YDAlfg9WuE5XuKCCChZdetMarlLxLg2pZ/lm9k44G/T+975JP0vAhF/pYgSXIbv
rfe0lJLmjAZb8OFvgcDPgIN7GoN5rDGhrbdS5emOPIhNkawPzxN+4T+rO/+my0bj
zqOLy/ZQ+WMsGU183fB0TrJxgPEMlpAPYdQjn91jipLxXFoLTDYZprRgoycBqVXT
UoPu8pMw3hkfx4glCZOgkDNauq1ZhJg1GzEGpW9CXYLAQ3N2SmReesLReTfA+fIh
HW94XI3RxFbo3zkhmRwlviQfUmhFaOg0DOr6RLRC4xUMSntyW6eJ10rw9Pb9+MOz
nu84QPsEDGvJcKf7l4XoVtxQ7KW93z0hzF/A9miXdWQt9GATOexvOTQTv/vzJznC
jtbV+rUjqGVWmfjkLDZHxoL0Sg7KipkJLTZU6q8O0YM451AcqK/SfK4L4jzvy/vN
Uai9G+Adid4a2XPn1AQkA2KJdKnfjFfyWR7bq0G0YoJBwaQJ2/GyPHnojwYqgJWv
nU1g4mKQj0ckzhLjUTsaHKtoFca64PJ/nPBcG7tajRcCMSjGmdi0SwunISvbxMfE
IzktBISWOnnYy8Qk0kiNDXG0vI+iSWLTFSSN6EUWlwZNFVRIQB7ozo6D6aieMFyM
kA6kJeWd6yFxuj/6ViAV
=NDPR
-----END PGP SIGNATURE-----

--LsnByradU3Ze6UwI--

--===============4314617223342483564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4314617223342483564==--
