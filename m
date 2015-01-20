From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [RESEND PATCH] mfd: wm8994: set mfd id-base for
 regulator devs creation to avoid conflicts
Date: Tue, 20 Jan 2015 11:30:00 +0000
Message-ID: <20150120113000.GH13701@x1>
References: <1420679073-3316-1-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420679073-3316-1-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 08 Jan 2015, Inha Song wrote:

> After commit: 6e3f62f0793e ("mfd: core: Fix platform-device id genera=
tion")
> We must set the id base when register a duplicate name of mfd_cell.
> If not, duplicate filename error was reported.
>=20
> - sysfs: cannot create duplicate filename '/devices/.../wm8994-ldo'
>=20
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> ---
>  drivers/mfd/wm8994-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
> index e6fab94..47cd3cc 100644
> --- a/drivers/mfd/wm8994-core.c
> +++ b/drivers/mfd/wm8994-core.c
> @@ -36,12 +36,12 @@
>  static const struct mfd_cell wm8994_regulator_devs[] =3D {
>  	{
>  		.name =3D "wm8994-ldo",
> -		.id =3D 1,
> +		.id =3D 0,
>  		.pm_runtime_no_callbacks =3D true,
>  	},
>  	{
>  		.name =3D "wm8994-ldo",
> -		.id =3D 2,
> +		.id =3D 1,
>  		.pm_runtime_no_callbacks =3D true,
>  	},
>  };
> @@ -344,7 +344,7 @@ static int wm8994_device_init(struct wm8994 *wm89=
94, int irq)
>  	dev_set_drvdata(wm8994->dev, wm8994);
> =20
>  	/* Add the on-chip regulators first for bootstrapping */
> -	ret =3D mfd_add_devices(wm8994->dev, -1,
> +	ret =3D mfd_add_devices(wm8994->dev, 0,
>  			      wm8994_regulator_devs,
>  			      ARRAY_SIZE(wm8994_regulator_devs),
>  			      NULL, 0, NULL);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
