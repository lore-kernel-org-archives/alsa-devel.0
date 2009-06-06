From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
 Left_J support
Date: Sat, 06 Jun 2009 05:26:45 -0300
Message-ID: <1244276805.15998.102.camel@brutus>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0013059511199928069=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id E47E924434
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Jun 2009 10:26:52 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1171935qwk.56
	for <alsa-devel@alsa-project.org>; Sat, 06 Jun 2009 01:26:52 -0700 (PDT)
In-Reply-To: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>, Paul Shen <boshen9@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============0013059511199928069==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-b2Svq7BZ9E+fHIzgtqxo"


--=-b2Svq7BZ9E+fHIzgtqxo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Qua, 2009-06-03 =C3=A0s 20:33 +0800, Eric Miao escreveu:
> Make the pxa I2S configuration generic, add support for Left_J, add
> support for variable frame width like 32fs, 48fs, 64fs and 96fs
>=20
> Signed-off-by: Paul Shen <bshen9@marvell.com>
> Signed-off-by: Eric Miao <eric.miao@marvell.com>
> Cc: Daniel Mack <daniel@caiaq.de>
> ---
>  arch/arm/mach-pxa/include/mach/regs-ssp.h |   14 +++---
>  sound/soc/pxa/pxa-ssp.c                   |   62 ++++++++++++++---------=
-----
>  sound/soc/pxa/pxa-ssp.h                   |    9 ++++
>  3 files changed, 47 insertions(+), 38 deletions(-)
>=20
> diff --git a/arch/arm/mach-pxa/include/mach/regs-ssp.h
> b/arch/arm/mach-pxa/include/mach/regs-ssp.h
> index 6a2ed35..27f0cd4 100644
> --- a/arch/arm/mach-pxa/include/mach/regs-ssp.h
> +++ b/arch/arm/mach-pxa/include/mach/regs-ssp.h
> @@ -108,21 +108,21 @@
>  #define SSSR_TINT		(1 << 19)	/* Receiver Time-out Interrupt */
>  #define SSSR_PINT		(1 << 18)	/* Peripheral Trailing Byte Interrupt */
>=20
> -#if defined(CONFIG_PXA3xx)
> -#define SSPSP_EDMYSTOP(x)	((x) << 28)     /* Extended Dummy Stop */
> -#define SSPSP_EDMYSTRT(x)	((x) << 26)     /* Extended Dummy Start */
> -#endif
> -
>  #define SSPSP_FSRT		(1 << 25)	/* Frame Sync Relative Timing */
> -#define SSPSP_DMYSTOP(x)	((x) << 23)	/* Dummy Stop */
>  #define SSPSP_SFRMWDTH(x)	((x) << 16)	/* Serial Frame Width */
>  #define SSPSP_SFRMDLY(x)	((x) << 9)	/* Serial Frame Delay */
> -#define SSPSP_DMYSTRT(x)	((x) << 7)	/* Dummy Start */
>  #define SSPSP_STRTDLY(x)	((x) << 4)	/* Start Delay */
>  #define SSPSP_ETDS		(1 << 3)	/* End of Transfer data State */
>  #define SSPSP_SFRMP		(1 << 2)	/* Serial Frame Polarity */
>  #define SSPSP_SCMODE(x)		((x) << 0)	/* Serial Bit Rate Clock Mode */
>=20
> +/* NOTE: PXA3xx extends the bit number of dummy start and stop, the macr=
os
> + * below are compatible with PXA25x/27x as long as the parameter is with=
in
> + * the correct limits, driver code has to take care of this.
> + */
> +#define SSPSP_DMYSTRT(x)	((((x) & 3) << 7)  | ((((x) >> 2) & 3) << 26))
> +#define SSPSP_DMYSTOP(x)	((((x) & 3) << 23) | ((((x) >> 2) & 7) << 28))
> +
>  #define SSACD_SCDB		(1 << 3)	/* SSPSYSCLK Divider Bypass */
>  #define SSACD_ACPS(x)		((x) << 4)	/* Audio clock PLL select */
>  #define SSACD_ACDS(x)		((x) << 0)	/* Audio clock divider select */
> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index 6fc7876..2831c16 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c
> @@ -463,7 +463,8 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cp=
u_dai,
>=20
>  	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>  	case SND_SOC_DAIFMT_I2S:
> -		sscr0 |=3D SSCR0_PSP;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		sscr0 |=3D SSCR0_PSP | SSCR0_MOD;

Why do you enforce network mode here?

>  		sscr1 |=3D SSCR1_RWOT | SSCR1_TRAIL;
>=20
>  		/* See hw_params() */
> @@ -541,6 +542,7 @@ static int pxa_ssp_hw_params(struct
> snd_pcm_substream *substream,
>  	int chn =3D params_channels(params);
>  	u32 sscr0;
>  	u32 sspsp;
> +	int frame_width;
>  	int width =3D snd_pcm_format_physical_width(params_format(params));
>  	int ttsa =3D ssp_read_reg(ssp, SSTSA) & 0xf;
>=20
> @@ -585,40 +587,38 @@ static int pxa_ssp_hw_params(struct
> snd_pcm_substream *substream,
>=20
>  	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>  	case SND_SOC_DAIFMT_I2S:
> -	       sspsp =3D ssp_read_reg(ssp, SSPSP);
> -
> -		if ((ssp_get_scr(ssp) =3D=3D 4) && (width =3D=3D 16)) {
> -			/* This is a special case where the bitclk is 64fs
> -			* and we're not dealing with 2*32 bits of audio
> -			* samples.
> -			*
> -			* The SSP values used for that are all found out by
> -			* trying and failing a lot; some of the registers
> -			* needed for that mode are only available on PXA3xx.
> -			*/
> +		sspsp =3D ssp_read_reg(ssp, SSPSP);
> +		frame_width =3D PXA_SSP_FRM_WIDTH(priv->dai_fmt);

I would expect FRM_WIDTH to also change SSCR0_EDSS and SSCR0_DataSize

>=20
> -#ifdef CONFIG_PXA3xx
> -			if (!cpu_is_pxa3xx())
> -				return -EINVAL;
> -
> -			sspsp |=3D SSPSP_SFRMWDTH(width * 2);
> -			sspsp |=3D SSPSP_SFRMDLY(width * 4);
> -			sspsp |=3D SSPSP_EDMYSTOP(3);
> -			sspsp |=3D SSPSP_DMYSTOP(3);
> -			sspsp |=3D SSPSP_DMYSTRT(1);
> -#else
> +		if (frame_width < width * 2)
>  			return -EINVAL;
> -#endif
> -		} else {
> -			/* The frame width is the width the LRCLK is
> -			 * asserted for; the delay is expressed in
> -			 * half cycle units.  We need the extra cycle
> -			 * because the data starts clocking out one BCLK
> -			 * after LRCLK changes polarity.
> +
> +		if (frame_width =3D=3D width * 2)
> +			/* frame width is exactly double of data sample width,
> +			 * use FSRT instead
>  			 */
> -			sspsp |=3D SSPSP_SFRMWDTH(width + 1);
> -			sspsp |=3D SSPSP_SFRMDLY((width + 1) * 2);
> +			sspsp |=3D SSPSP_FSRT | SSPSP_SFRMWDTH(width);
> +		else {
>  			sspsp |=3D SSPSP_DMYSTRT(1);
> +			sspsp |=3D SSPSP_DMYSTOP((frame_width / 2 - width - 1));
> +			sspsp |=3D SSPSP_SFRMWDTH(frame_width / 2);
> +		}
> +
> +		ssp_write_reg(ssp, SSPSP, sspsp);
> +		break;
> +
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		sspsp =3D ssp_read_reg(ssp, SSPSP);
> +		frame_width =3D PXA_SSP_FRM_WIDTH(priv->dai_fmt);
> +
> +		if (frame_width < width * 2)
> +			return -EINVAL;
> +
> +		if (frame_width =3D=3D width * 2)
> +			sspsp |=3D SSPSP_SFRMWDTH(width);
> +		else {
> +			sspsp |=3D SSPSP_DMYSTOP((frame_width / 2 - width));
> +			sspsp |=3D SSPSP_SFRMWDTH(frame_width / 2);
>  		}
>=20
>  		ssp_write_reg(ssp, SSPSP, sspsp);
> diff --git a/sound/soc/pxa/pxa-ssp.h b/sound/soc/pxa/pxa-ssp.h
> index 91deadd..fda51d0 100644
> --- a/sound/soc/pxa/pxa-ssp.h
> +++ b/sound/soc/pxa/pxa-ssp.h
> @@ -40,6 +40,15 @@
>  #define PXA_SSP_CLK_SCDB_1		1
>  #define PXA_SSP_CLK_SCDB_8		2
>=20
> +/* frame size definitions for I2S and Left_J formats - default is
> + * 32fs, other possibilities are 48fs, 64fs and 96fs
> + */
> +#define PXA_SSP_FRM_32FS	(0 << 16)
> +#define PXA_SSP_FRM_48FS	(1 << 16)
> +#define PXA_SSP_FRM_64FS	(2 << 16)
> +#define PXA_SSP_FRM_96FS	(3 << 16)
> +#define PXA_SSP_FRM_WIDTH(x)	(((((x) >> 16) & 0x3) + 2) << 4)
> +
>  #define PXA_SSP_PLL_OUT  0
>=20
>  extern struct snd_soc_dai pxa_ssp_dai[4];

I am testing this patch with PXA272 slave of clock and frame,
DAIFMT_LEFT_J, tdm_slot(3,2), and it causes my audio to play with double
speed. (with tdm_slot(1,1) it plays at half speed).

Values that are known to work fine for my board are:
SSCR0 =3D 0x1000bf
SSPSP =3D 0x100002


--=20
Daniel Ribeiro

--=-b2Svq7BZ9E+fHIzgtqxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoqKDcACgkQw3OYl0G0liRU6ACgkTILi0S5CYS+xQCqrrsxRHOh
B8sAn3RJbfDrVvT2Y/LFCerCERgiifg2
=Kr8d
-----END PGP SIGNATURE-----

--=-b2Svq7BZ9E+fHIzgtqxo--


--===============0013059511199928069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0013059511199928069==--
