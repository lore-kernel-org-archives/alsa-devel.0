From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v5 1/2] mfd: arizona: Add support for
 INn_Mode register control
Date: Mon, 1 Sep 2014 09:32:33 +0100
Message-ID: <20140901083233.GC7374@lee--X1>
References: <1409365639-5320-1-git-send-email-ideal.song@samsung.com>
 <1409365639-5320-2-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409365639-5320-2-git-send-email-ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, 30 Aug 2014, Inha Song wrote:

> Some boards need to set the INn_MODE[1:0] register to change
> the input signal patch. This wlf,inmode property is optional.
> If present, values must be specified less than or equal to
> the number of input singals. If values less than the number
> of input signals, elements that has not been specifed are set
> to 0 by default.
>=20
> Example:
>    - wlf,inmode =3D <2 0 2>;	/* IN1, IN3 use DMIC */
>=20
> Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Reviewed-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> ---
>  drivers/mfd/arizona-core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

That looks better.

Applied, thanks.

Charles,
  Can you confirm your Reviewed-by for this version of the patch
  please?

> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
> index 10a0cb9..31757f7 100644
> --- a/drivers/mfd/arizona-core.c
> +++ b/drivers/mfd/arizona-core.c
> @@ -534,7 +534,11 @@ EXPORT_SYMBOL_GPL(arizona_of_get_named_gpio);
>  static int arizona_of_get_core_pdata(struct arizona *arizona)
>  {
>  	struct arizona_pdata *pdata =3D &arizona->pdata;
> +	struct property *prop;
> +	const __be32 *cur;
> +	u32 val;
>  	int ret, i;
> +	int count =3D 0;
> =20
>  	pdata->reset =3D arizona_of_get_named_gpio(arizona, "wlf,reset", tr=
ue);
> =20
> @@ -560,6 +564,15 @@ static int arizona_of_get_core_pdata(struct ariz=
ona *arizona)
>  			ret);
>  	}
> =20
> +	of_property_for_each_u32(arizona->dev->of_node, "wlf,inmode", prop,
> +				 cur, val) {
> +		if (count =3D=3D ARRAY_SIZE(arizona->pdata.inmode))
> +			break;
> +
> +		arizona->pdata.inmode[count] =3D val;
> +		count++;
> +	}
> +
>  	return 0;
>  }
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
