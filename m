From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH v2 1/2] mfd: arizona: Add support for
 INn_Mode register control
Date: Thu, 21 Aug 2014 13:12:19 +0100
Message-ID: <20140821121219.GF4266@lee--X1>
References: <20140813205313.65bbe343@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140813205313.65bbe343@songinha-Samsung-DeskTop-System>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com, lgirdwood@gmail.com, sameo@linux.intel.com, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, 13 Aug 2014, Inha Song wrote:

> Some boards need to set the INn_MODE[1:0] register to change
> the input signal patch. This wlf,inmode property is optional.
> If present values must be specified by the number of
> ARIZONA_MAX_INPUT.
>=20
> Example:
>    - wlf,inmode =3D <2 0 2 0>;	/* IN1, IN3 use DMIC */
>=20
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> ---
>  drivers/mfd/arizona-core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

This is going to require a DT Ack.

Is [2/2] adding the documentation?  I can't easily go and look because
you send the patch-set unthreaded.  Please thread patch-sets.  See
the man page for `git send-email` for more information.

> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
> index 10a0cb9..2b68ccd 100644
> --- a/drivers/mfd/arizona-core.c
> +++ b/drivers/mfd/arizona-core.c
> @@ -534,7 +534,7 @@ EXPORT_SYMBOL_GPL(arizona_of_get_named_gpio);
>  static int arizona_of_get_core_pdata(struct arizona *arizona)
>  {
>  	struct arizona_pdata *pdata =3D &arizona->pdata;
> -	int ret, i;
> +	int ret, i, proplen;
> =20
>  	pdata->reset =3D arizona_of_get_named_gpio(arizona, "wlf,reset", tr=
ue);
> =20
> @@ -560,6 +560,15 @@ static int arizona_of_get_core_pdata(struct ariz=
ona *arizona)
>  			ret);
>  	}
> =20
> +	proplen =3D of_property_count_u32_elems(arizona->dev->of_node,
> +					      "wlf,inmode");
> +	if (proplen > 0 && proplen <=3D ARRAY_SIZE(arizona->pdata.inmode)) =
{
> +		for (i =3D 0; i < proplen; i++)
> +			of_property_read_u32_index(arizona->dev->of_node,
> +						   "wlf,inmode", i,
> +						    &arizona->pdata.inmode[i]);
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
