From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v5 2/3] ARM: mx28evk: add platform data for
	saif
Date: Fri, 18 Nov 2011 05:58:14 +0100
Message-ID: <201111180558.14836.marek.vasut@gmail.com>
References: <1321003855-13430-1-git-send-email-b29396@freescale.com>
	<1321003855-13430-3-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D65A51037FC
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 05:58:18 +0100 (CET)
Received: by faaa20 with SMTP id a20so4106615faa.38
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 20:58:18 -0800 (PST)
In-Reply-To: <1321003855-13430-3-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, shawn.guo@freescale.com, kernel@pengutronix.de, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

> This is for supporting saif record function.
> =

> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> =

> ---
> Changes since v4:
>  * Using the new added master_id and master_mode in platfrom_data
> No changes since v3:
> Changes since v2:
>  * separate clkmux code into another patch
>  * A few minus fixes suggested by Uwe & Wolfram.
> Changes since v1:
>  * move saif clkmux code into mach-specific part
> ---
>  arch/arm/mach-mxs/devices-mx28.h                |    3 ++-
>  arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 +++--
>  arch/arm/mach-mxs/include/mach/devices-common.h |    4 +++-
>  arch/arm/mach-mxs/mach-mx28evk.c                |   18 ++++++++++++++++--
>  4 files changed, 24 insertions(+), 6 deletions(-)
> =

> diff --git a/arch/arm/mach-mxs/devices-mx28.h
> b/arch/arm/mach-mxs/devices-mx28.h index c888710..4f50094 100644
> --- a/arch/arm/mach-mxs/devices-mx28.h
> +++ b/arch/arm/mach-mxs/devices-mx28.h
> @@ -47,6 +47,7 @@ struct platform_device *__init mx28_add_mxsfb(
>  		const struct mxsfb_platform_data *pdata);
> =

>  extern const struct mxs_saif_data mx28_saif_data[] __initconst;
> -#define mx28_add_saif(id)              mxs_add_saif(&mx28_saif_data[id])
> +#define mx28_add_saif(id, pdata) \
> +	mxs_add_saif(&mx28_saif_data[id], pdata)
> =

>  struct platform_device *__init mx28_add_rtc_stmp3xxx(void);
> diff --git a/arch/arm/mach-mxs/devices/platform-mxs-saif.c
> b/arch/arm/mach-mxs/devices/platform-mxs-saif.c index 1ec965e..f6e3a60
> 100644
> --- a/arch/arm/mach-mxs/devices/platform-mxs-saif.c
> +++ b/arch/arm/mach-mxs/devices/platform-mxs-saif.c
> @@ -32,7 +32,8 @@ const struct mxs_saif_data mx28_saif_data[] __initconst=
 =3D
> { };
>  #endif
> =

> -struct platform_device *__init mxs_add_saif(const struct mxs_saif_data
> *data) +struct platform_device *__init mxs_add_saif(const struct
> mxs_saif_data *data, +				const struct =

mxs_saif_platform_data *pdata)
>  {
>  	struct resource res[] =3D {
>  		{
> @@ -56,5 +57,5 @@ struct platform_device *__init mxs_add_saif(const struct
> mxs_saif_data *data) };
> =

>  	return mxs_add_platform_device("mxs-saif", data->id, res,
> -					ARRAY_SIZE(res), NULL, 0);
> +				ARRAY_SIZE(res), pdata, sizeof(*pdata));

Wasn't there some ARRAY_AND_SIZE() macro somewhere? I checked and it's now =
used =

in three instances -- PXA, MMP, UX500 and maybe somewhere else -- can you m=
ove =

it to common header and use here?

>  }
> diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h
> b/arch/arm/mach-mxs/include/mach/devices-common.h index a8080f4..dc369c1
> 100644
> --- a/arch/arm/mach-mxs/include/mach/devices-common.h
> +++ b/arch/arm/mach-mxs/include/mach/devices-common.h
> @@ -94,6 +94,7 @@ struct platform_device *__init mxs_add_mxs_pwm(
>  		resource_size_t iobase, int id);
> =

>  /* saif */
> +#include <sound/saif.h>

It looks weird to intermix includes and code :-(

>  struct mxs_saif_data {
>  	int id;
>  	resource_size_t iobase;
> @@ -103,4 +104,5 @@ struct mxs_saif_data {
>  };
> =

>  struct platform_device *__init mxs_add_saif(
> -		const struct mxs_saif_data *data);
> +		const struct mxs_saif_data *data,
> +		const struct mxs_saif_platform_data *pdata);
> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c
> b/arch/arm/mach-mxs/mach-mx28evk.c index 4a3cca3..cfe7910 100644
> --- a/arch/arm/mach-mxs/mach-mx28evk.c
> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> @@ -28,6 +28,7 @@
> =

>  #include <mach/common.h>
>  #include <mach/iomux-mx28.h>
> +#include <mach/digctl.h>
> =

>  #include "devices-mx28.h"
> =

> @@ -417,6 +418,18 @@ static void __init mx28evk_add_regulators(void)
>  static void __init mx28evk_add_regulators(void) {}
>  #endif
> =

> +static const struct mxs_saif_platform_data
> +			mx28evk_mxs_saif_pdata[] __initconst =3D {
> +	/* working on EXTMSTR0 mode (saif0 master, saif1 slave) */
> +	{
> +		.master_mode =3D 1;
> +		.master_id =3D 0;
> +	}, {
> +		.master_mode =3D 0;
> +		.master_id =3D 0;
> +	},
> +};
> +
>  static void __init mx28evk_init(void)
>  {
>  	int ret;
> @@ -457,8 +470,9 @@ static void __init mx28evk_init(void)
> =

>  	mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
> =

> -	mx28_add_saif(0);
> -	mx28_add_saif(1);
> +	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
> +	mx28_add_saif(0, &mx28evk_mxs_saif_pdata[0]);
> +	mx28_add_saif(1, &mx28evk_mxs_saif_pdata[1]);
> =

>  	mx28_add_mxs_i2c(0);
>  	i2c_register_board_info(0, mxs_i2c0_board_info,

Otherwise,

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
