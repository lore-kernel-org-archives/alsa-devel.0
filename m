From: Vasily khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 04/25] ARM: Samsung: Define common
 audio-dma device
Date: Tue, 19 Oct 2010 10:54:20 +0300
Message-ID: <20101019105420.37b90c0c@anarsoul-laptop>
References: <1P85Z9-0007a6-27>
	<1287471940-27598-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3852700886702013560=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 45044103923
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:54:34 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1357299ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2010 00:54:34 -0700 (PDT)
In-Reply-To: <1287471940-27598-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, june.bae@samsung.com, sw.youn@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

--===============3852700886702013560==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/8VDbRqv9EkNPc/mS+FK0j94"; protocol="application/pgp-signature"

--Sig_/8VDbRqv9EkNPc/mS+FK0j94
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Oct 2010 16:05:40 +0900
Jassi Brar <jassisinghbrar@gmail.com> wrote:

> From: Jassi Brar <jassi.brar@samsung.com>
>=20
> The ASoC uses common DMA driver for Audio devices. So it makes
> sense to a common audio-dma device shared across all platforms.
>=20
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/mach-s3c64xx/dev-audio.c         |   13 -------------
>  arch/arm/mach-s3c64xx/mach-smdk6410.c     |    2 +-
>  arch/arm/plat-s3c24xx/devs.c              |   15 ---------------
>  arch/arm/plat-samsung/Makefile            |    1 +
>  arch/arm/plat-samsung/dev-asocdma.c       |   24 ++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/devs.h |    2 +-
>  6 files changed, 27 insertions(+), 30 deletions(-)
>  create mode 100644 arch/arm/plat-samsung/dev-asocdma.c
>=20
> diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/de=
v-audio.c
> index c45cc37..c730dd2 100644
> --- a/arch/arm/mach-s3c64xx/dev-audio.c
> +++ b/arch/arm/mach-s3c64xx/dev-audio.c
> @@ -336,16 +336,3 @@ void __init s3c64xx_ac97_setup_gpio(int num)
>  	else
>  		s3c_ac97_pdata.cfg_gpio =3D s3c64xx_ac97_cfg_gpe;
>  }
> -
> -static u64 s3c_device_audio_dmamask =3D 0xffffffffUL;
> -
> -struct platform_device s3c_device_pcm =3D {
> -	.name		  =3D "samsung-audio",
> -	.id		  =3D -1,
> -	.dev              =3D {
> -		.dma_mask =3D &s3c_device_audio_dmamask,
> -		.coherent_dma_mask =3D 0xffffffffUL
> -	}
> -};
> -EXPORT_SYMBOL(s3c_device_pcm);
> -
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64x=
x/mach-smdk6410.c
> index ecbddd3..e2b18b8 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -283,7 +283,7 @@ static struct platform_device *smdk6410_devices[] __i=
nitdata =3D {
>  	&s3c_device_fb,
>  	&s3c_device_ohci,
>  	&s3c_device_usb_hsotg,
> -	&s3c_device_pcm,
> +	&samsung_asoc_dma,
>  	&s3c64xx_device_iisv4,
>  	&samsung_device_keypad,
> =20
> diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
> index 4bf0b39..d8fb4e6 100644
> --- a/arch/arm/plat-s3c24xx/devs.c
> +++ b/arch/arm/plat-s3c24xx/devs.c
> @@ -259,21 +259,6 @@ struct platform_device s3c_device_iis =3D {
> =20
>  EXPORT_SYMBOL(s3c_device_iis);
> =20
> -/* ASoC PCM DMA */
> -
> -static u64 s3c_device_audio_dmamask =3D 0xffffffffUL;
> -
> -struct platform_device s3c_device_pcm =3D {
> -	.name		  =3D "samsung-audio",
> -	.id		  =3D -1,
> -	.dev              =3D {
> -		.dma_mask =3D &s3c_device_audio_dmamask,
> -		.coherent_dma_mask =3D 0xffffffffUL
> -	}
> -};
> -
> -EXPORT_SYMBOL(s3c_device_pcm);
> -
>  /* RTC */
> =20
>  static struct resource s3c_rtc_resource[] =3D {
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makef=
ile
> index 4d8ff92..b97623a 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -17,6 +17,7 @@ obj-y				+=3D clock.o
>  obj-y				+=3D pwm-clock.o
>  obj-y				+=3D gpio.o
>  obj-y				+=3D gpio-config.o
> +obj-y				+=3D dev-asocdma.o
> =20
>  obj-$(CONFIG_SAMSUNG_GPIOLIB_4BIT)	+=3D gpiolib.o
>  obj-$(CONFIG_SAMSUNG_CLKSRC)	+=3D clock-clksrc.o
> diff --git a/arch/arm/plat-samsung/dev-asocdma.c b/arch/arm/plat-samsung/=
dev-asocdma.c
> new file mode 100644
> index 0000000..b7b1fca
> --- /dev/null
> +++ b/arch/arm/plat-samsung/dev-asocdma.c
> @@ -0,0 +1,24 @@
> +/* linux/arch/arm/plat-samsung/dev-asocdma.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co. Ltd
> + *	Jaswinder Singh <jassi.brar@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +
> +static u64 audio_dmamask =3D DMA_BIT_MASK(32);
> +
> +struct platform_device samsung_asoc_dma =3D {
> +	.name		  =3D "samsung-audio",
> +	.id		  =3D -1,
> +	.dev              =3D {
> +		.dma_mask =3D &audio_dmamask,
> +		.coherent_dma_mask =3D DMA_BIT_MASK(32),
> +	}
> +};
> +EXPORT_SYMBOL(samsung_asoc_dma);
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-sa=
msung/include/plat/devs.h
> index a9fecd6..21dfa68 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -32,7 +32,7 @@ extern struct platform_device s3c64xx_device_iisv4;
>  extern struct platform_device s3c64xx_device_spi0;
>  extern struct platform_device s3c64xx_device_spi1;
> =20
> -extern struct platform_device s3c_device_pcm;
> +extern struct platform_device samsung_asoc_dma;
> =20
>  extern struct platform_device s3c64xx_device_pcm0;
>  extern struct platform_device s3c64xx_device_pcm1;
> --=20
> 1.6.2.5

This patch will definitely break my changes to mach-rx1950.c and
mach-h1940.c in Ben's tree, it just will not compile. However
fix is trivial, I'll send patch to Ben as soon as your changes will be
merged.

Sent this mail just as reminder for myself :)

Regards
Vasily

--Sig_/8VDbRqv9EkNPc/mS+FK0j94
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky9TqwACgkQRM6pQpltKE7VVwCfQDzyN+HkRMp/kLWDdvFlkyRB
84gAn2V66QaMfegYceZcJjuLYHEMu38K
=/cOb
-----END PGP SIGNATURE-----

--Sig_/8VDbRqv9EkNPc/mS+FK0j94--

--===============3852700886702013560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3852700886702013560==--
