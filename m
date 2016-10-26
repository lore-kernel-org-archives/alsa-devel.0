From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/14] mfd: sun6i-prcm: Add sun8i analog
 codec as subnode
Date: Wed, 26 Oct 2016 15:05:01 +0100
Message-ID: <20161026140501.GH13127@dell>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <c74aea452bd1831f439dd67884cb2879e0849f03.1475571575.git.mylene.josserand@free-electrons.com>
Reply-To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBB5HOYLAAKGQE4CBMNKI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <c74aea452bd1831f439dd67884cb2879e0849f03.1475571575.git.mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, 04 Oct 2016, Myl=C3=A8ne Josserand wrote:

> The sun8i audio codec is using PRCM registers to configure all the
> analog part of the audio codec. It is added as a subnode of the PRCM
> with his resource (offset of 0x1c0).
>=20
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>
> ---
>  drivers/mfd/sun6i-prcm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
> index 011fcc5..e0c6bf5 100644
> --- a/drivers/mfd/sun6i-prcm.c
> +++ b/drivers/mfd/sun6i-prcm.c
> @@ -12,6 +12,8 @@
>  #include <linux/init.h>
>  #include <linux/of.h>
> =20
> +#define SUN6I_AUDIO_CODEC_ANALOG	0x1c0
> +
>  struct prcm_data {
>  	int nsubdevs;
>  	const struct mfd_cell *subdevs;
> @@ -57,6 +59,14 @@ static const struct resource sun6i_a31_apb0_rstc_res[]=
 =3D {
>  	},
>  };
> =20
> +static const struct resource sun8i_adda_res[] =3D {
> +	{
> +		.start =3D SUN6I_AUDIO_CODEC_ANALOG,
> +		.end =3D 0x1c3,

This also needs defining.  No magic numbers please.

> +		.flags =3D IORESOURCE_MEM,
> +	},
> +};
> +
>  static const struct mfd_cell sun6i_a31_prcm_subdevs[] =3D {
>  	{
>  		.name =3D "sun6i-a31-ar100-clk",
> @@ -109,6 +119,12 @@ static const struct mfd_cell sun8i_a23_prcm_subdevs[=
] =3D {
>  		.num_resources =3D ARRAY_SIZE(sun6i_a31_apb0_rstc_res),
>  		.resources =3D sun6i_a31_apb0_rstc_res,
>  	},
> +	{
> +		.name =3D "sun8i-codec-analog",
> +		.of_compatible =3D "allwinner,sun8i-codec-analog",
> +		.num_resources =3D ARRAY_SIZE(sun8i_adda_res),
> +		.resources =3D sun8i_adda_res,
> +	},
>  };
> =20
>  static const struct prcm_data sun6i_a31_prcm_data =3D {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
