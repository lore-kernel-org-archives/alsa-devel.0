From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ASoC: rt5631: Fixing compilation warning when DT is
 disabled
Date: Mon, 17 Nov 2014 16:56:17 +0100
Message-ID: <20141117155617.GJ27002@pengutronix.de>
References: <1416232589-31319-1-git-send-email-krishna.md@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416232589-31319-1-git-send-email-krishna.md@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krishna Mohan Dani <krishna.md@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, broonie@kernel.org, kgene.kim@samsung.com, Claude Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 17, 2014 at 07:26:29PM +0530, Krishna Mohan Dani wrote:
> Fixes the following compilation warning:
> Warning: 'rt5631_i2c_dt_ids' defined but not used - when DT is not us=
ed.
>=20
> Signed-off-by: Claude Youn <claude.youn@gmail.com>
> Signed-off-by: Krishna Mohan Dani <krishna.md@samsung.com>
> ---
>  sound/soc/codecs/rt5631.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
> index 3b7d5e4..9425545 100644
> --- a/sound/soc/codecs/rt5631.c
> +++ b/sound/soc/codecs/rt5631.c
> @@ -1691,12 +1691,14 @@ static const struct i2c_device_id rt5631_i2c_=
id[] =3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, rt5631_i2c_id);
> =20
> +#ifdef CONFIG_OF
>  static struct of_device_id rt5631_i2c_dt_ids[] =3D {
>  	{ .compatible =3D "realtek,rt5631"},
>  	{ .compatible =3D "realtek,alc5631"},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, rt5631_i2c_dt_ids);
> +#endif

An (IMHO nicer) alternative is:

-static struct of_device_id rt5631_i2c_dt_ids[] =3D {
+static struct of_device_id rt5631_i2c_dt_ids[] __maybe_unused =3D {

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
