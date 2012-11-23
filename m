From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [BUGFIX PATCH] ASoC: fsl: fix miscompilation of snd-soc-imx-pcm
Date: Fri, 23 Nov 2012 11:05:18 +0900
Message-ID: <20121123020517.GJ4385@opensource.wolfsonmicro.com>
References: <1353587470-11994-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y+Z5jE7Arku/2GrR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353587470-11994-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Y+Z5jE7Arku/2GrR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2012 at 01:31:06PM +0100, Lothar Wa=DFmann wrote:

>  obj-$(CONFIG_SND_SOC_IMX_PCM) +=3D snd-soc-imx-pcm.o
>  snd-soc-imx-pcm-y :=3D imx-pcm.o
> -snd-soc-imx-pcm-$(CONFIG_SND_SOC_IMX_PCM_FIQ) +=3D imx-pcm-fiq.o
> -snd-soc-imx-pcm-$(CONFIG_SND_SOC_IMX_PCM_DMA) +=3D imx-pcm-dma.o
> +ifneq ($(CONFIG_SND_SOC_IMX_PCM_FIQ),)
> +	snd-soc-imx-pcm-objs +=3D imx-pcm-fiq.o
> +endif
> +ifneq ($(CONFIG_SND_SOC_IMX_PCM_DMA),)
> +	snd-soc-imx-pcm-objs +=3D imx-pcm-dma.o
> +endif

What is the actual bug here?  This fix doesn't look obviously right, and
if we do need to move to -objs for some reason then the block ought to
be in the -objs section of the Makefile.

--Y+Z5jE7Arku/2GrR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrtnJAAoJELSic+t+oim9oN4QAJThJQxMGp5w28hEwKUk2cv1
xqHdFlKhz3b405mhKnknSbniWISsZTsodwW5U84xtcYA7x6aD0jneXeleV/UaIPS
vOQbQe7Modz3fu5k4/F5lIdg5jG9imYixZJ52+qyqpcG+H1fFMQdwFF1s2d4cCwi
NSgj3D+ki3dxQrMzPK9NOuhVD0Q+Hy4Uc4m/6PsrehnI6zT9zdz1WWX+jYUgOLxm
gl4HsfgaYTGwMGNYOHFHwie4xrkofYWsKjLqalmTH1h7u9XxwGken4N1mI8oQVWi
Mn4YQia3ZWPYm5kbK4nlpdOguAeOEtRGfEO3+64waFIm+4SwZICyUYmIst82zQKW
cBT2dsQGPh6to+/ycXRiGZFiaazvscANtV6XW+CDdEChU3D8xlTgQhQbGMHDRE9o
T3vTLRLqCMScHN9vosR9Xv5a1BiRCTZXG1u0EWIXGjJHu153IN7SGUUKsEM7oozm
axvRWvCiJr0CVw4GLBhVyvLy3zLSz3U7udLYeLgKvtxZgowb+9rI28ZIM32xtXWe
Tmz+/2y0J6TBxduiefxgKuQc1UA8+6LOKebHBu9MXX75sSObksaGxRO/P4XGuyQK
zM4WRRWeJ+Isip3C0f1Kj7fLMuLIHN11gOEVcXJ6klGWzwSp1ggZBmEv5Uc4Vn4c
Cr8Ny8dyT5JdcD+thQ7l
=6z2r
-----END PGP SIGNATURE-----

--Y+Z5jE7Arku/2GrR--
