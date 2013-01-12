From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsl: fix multiple definition of
	init_module
Date: Sat, 12 Jan 2013 00:05:28 +0000
Message-ID: <20130112000528.GE7873@opensource.wolfsonmicro.com>
References: <1357832636-11463-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6872189700348760461=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A064926508C
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2013 01:05:29 +0100 (CET)
In-Reply-To: <1357832636-11463-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org


--===============6872189700348760461==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2013 at 11:43:56PM +0800, Shawn Guo wrote:
> With commit f2818d0 (ASoC: fsl: fix miscompilation of snd-soc-imx-pcm),
> we will see the following build error when building modules with
> CONFIG_SND_IMX_SOC=m in imx_v6_v7_defconfig.

Applied, thanks.

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8KjBAAoJELSic+t+oim9hFoP/32+02hcT+yciWHq2I70Zbdt
0dwYCB25pMyIRDmj3KzjON09zdZ3XOJWFeYQUjAtiJWN+oJ2v7qLlRnnSkyVq4sP
U0SLpegdrOUlKBBIkCuMwdANbjuRI4iwRBYzvN2ykVnbdklLGhq/yUtmpEitJBNa
lWhrCYZgCwJJR6afU/NybGGOMwS1kJHfow+jSNy9Fj0/hjaW54z+Ue85RmnXibDN
X4cOM8IecDLkuA8PEHidLRa9yAH4HSR5O3DMWwmx1YG4Wu9hTyiMhdXe1sCdhtEi
g8JeZXN0ggsJMMaxmKH+O1mTO2FUA53BfcYmZFx7Vj+yaAWRNV6A/b0FgsYcgEVv
DDHlTE+YtZt7VBT0U1GBHfOGLnFnDOKdHB3mHLnV6TqRXMHDCl4y6R/XVkp7Wu4W
jj+Dg7l+j1mB49uQvGyaef8BG6LV41BNLCuNE3zpEaDjpaylC4EAJ9/IJmy4SPZS
QXYzCVTSrJcrh0D4TSPldL993H1hpsHlyxSbHqZqhLQ7CNPnaKVbMBLMPsE9DNnh
i4KOIsB8hB701XGjM4l73CnAgRZDBB3lo1IioGLb578b3eQqRdPLwUtovUjj2l0q
9Nx3Na1GzK2NHkFoJQ7guuAnRfi5ST9uVnAvkj0ZBczuMBiFL+RrBe1QUwGqRCsq
Wn+OviiPqUbh4e6GghQG
=AoTr
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--

--===============6872189700348760461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6872189700348760461==--
