From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 1/3] ASoC: codecs: wm8904: add dt ids table
Date: Tue, 13 Jan 2015 16:20:58 +0100
Message-ID: <54B537DA.7030707@atmel.com>
References: <1418614273-2303-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1418614273-2303-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, Alexander Morozov <linux@meltdown.ru>
List-Id: alsa-devel@alsa-project.org

Le 15/12/2014 04:31, Bo Shen a =E9crit :
> From: Alexander Morozov <linux@meltdown.ru>
>=20
> Signed-off-by: Alexander Morozov <linux@meltdown.ru>
> [Add driver data to distinguish device type]
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
>=20
> Changes in v2:
> - Add driver data for distinguish the device capability.
>=20
>  sound/soc/codecs/wm8904.c | 22 ++++++++++++++++++++++

Mark,

Do you want us to re-send this patch or can you take it?

On my side, I'm planning to take the 2 last ones of this series: is it
okay for you?

Thanks, bye.

>  1 file changed, 22 insertions(+)
>=20
> diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
> index 4d2d2b1..6e3f175 100644
> --- a/sound/soc/codecs/wm8904.c
> +++ b/sound/soc/codecs/wm8904.c
> @@ -2255,10 +2255,32 @@ static const struct i2c_device_id wm8904_i2c_=
id[] =3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, wm8904_i2c_id);
> =20
> +#ifdef CONFIG_OF
> +static enum wm8904_type wm8904_data =3D WM8904;
> +static enum wm8904_type wm8912_data =3D WM8912;
> +
> +static const struct of_device_id wm8904_of_match[] =3D {
> +	{
> +		.compatible =3D "wlf,wm8904",
> +		.data =3D &wm8904_data,
> +	}, {
> +		.compatible =3D "wlf,wm8912",
> +		.data =3D &wm8912_data,
> +	}, {
> +		.compatible =3D "wlf,wm8918",
> +		.data =3D &wm8904_data,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, wm8904_of_match);
> +#endif
> +
>  static struct i2c_driver wm8904_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "wm8904",
>  		.owner =3D THIS_MODULE,
> +		.of_match_table =3D of_match_ptr(wm8904_of_match),
>  	},
>  	.probe =3D    wm8904_i2c_probe,
>  	.remove =3D   wm8904_i2c_remove,
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-sound" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
