From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 2/3] ARM: mx28evk: add platform data for
	saif
Date: Thu, 10 Nov 2011 09:38:52 +0100
Message-ID: <20111110083852.GU16886@pengutronix.de>
References: <1320907333-12696-1-git-send-email-b29396@freescale.com>
	<1320907333-12696-3-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B7A17243C2
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 09:38:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1320907333-12696-3-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, shawn.guo@freescale.com, u.kleine-koenig@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 10, 2011 at 02:42:12PM +0800, Dong Aisheng wrote:
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
> No changes since v3:
> Changes since v2:
>  * separate clkmux code into another patch
>  * A few minus fixes suggested by Uwe & Wolfram.
> Changes since v1:
>  * move saif clkmux code into mach-specific part
> ---
>  arch/arm/mach-mxs/devices-mx28.h                |    3 ++-
>  arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 +++--
>  arch/arm/mach-mxs/include/mach/common.h         |    2 ++
>  arch/arm/mach-mxs/include/mach/devices-common.h |    4 +++-
>  arch/arm/mach-mxs/mach-mx28evk.c                |   16 ++++++++++++++--
>  5 files changed, 24 insertions(+), 6 deletions(-)
> =

> diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices=
-mx28.h
> index c888710..4f50094 100644
> --- a/arch/arm/mach-mxs/devices-mx28.h
> +++ b/arch/arm/mach-mxs/devices-mx28.h
> @@ -47,6 +47,7 @@ struct platform_device *__init mx28_add_mxsfb(
>  		const struct mxsfb_platform_data *pdata);
>  =

>  extern const struct mxs_saif_data mx28_saif_data[] __initconst;
> -#define mx28_add_saif(id)              mxs_add_saif(&mx28_saif_data[id])
> +#define mx28_add_saif(id, pdata) \
> +	mxs_add_saif(&mx28_saif_data[id], pdata)
>  =

>  struct platform_device *__init mx28_add_rtc_stmp3xxx(void);
> diff --git a/arch/arm/mach-mxs/devices/platform-mxs-saif.c b/arch/arm/mac=
h-mxs/devices/platform-mxs-saif.c
> index 1ec965e..f6e3a60 100644
> --- a/arch/arm/mach-mxs/devices/platform-mxs-saif.c
> +++ b/arch/arm/mach-mxs/devices/platform-mxs-saif.c
> @@ -32,7 +32,8 @@ const struct mxs_saif_data mx28_saif_data[] __initconst=
 =3D {
>  };
>  #endif
>  =

> -struct platform_device *__init mxs_add_saif(const struct mxs_saif_data *=
data)
> +struct platform_device *__init mxs_add_saif(const struct mxs_saif_data *=
data,
> +				const struct mxs_saif_platform_data *pdata)
>  {
>  	struct resource res[] =3D {
>  		{
> @@ -56,5 +57,5 @@ struct platform_device *__init mxs_add_saif(const struc=
t mxs_saif_data *data)
>  	};
>  =

>  	return mxs_add_platform_device("mxs-saif", data->id, res,
> -					ARRAY_SIZE(res), NULL, 0);
> +				ARRAY_SIZE(res), pdata, sizeof(*pdata));
>  }
> diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/=
include/mach/common.h
> index 635bb5d..bf91a10 100644
> --- a/arch/arm/mach-mxs/include/mach/common.h
> +++ b/arch/arm/mach-mxs/include/mach/common.h
> @@ -29,4 +29,6 @@ extern void mx28_init_irq(void);
>  =

>  extern void icoll_init_irq(void);
>  =

> +extern int mxs_saif_clkmux_select(unsigned int clkmux);
> +extern int mxs_get_saif_clk_master_id(unsigned int saif_id);
>  #endif /* __MACH_MXS_COMMON_H__ */
> diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/m=
ach-mxs/include/mach/devices-common.h
> index a8080f4..dc369c1 100644
> --- a/arch/arm/mach-mxs/include/mach/devices-common.h
> +++ b/arch/arm/mach-mxs/include/mach/devices-common.h
> @@ -94,6 +94,7 @@ struct platform_device *__init mxs_add_mxs_pwm(
>  		resource_size_t iobase, int id);
>  =

>  /* saif */
> +#include <sound/saif.h>
>  struct mxs_saif_data {
>  	int id;
>  	resource_size_t iobase;
> @@ -103,4 +104,5 @@ struct mxs_saif_data {
>  };
>  =

>  struct platform_device *__init mxs_add_saif(
> -		const struct mxs_saif_data *data);
> +		const struct mxs_saif_data *data,
> +		const struct mxs_saif_platform_data *pdata);
> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx=
28evk.c
> index 4a3cca3..5aab344 100644
> --- a/arch/arm/mach-mxs/mach-mx28evk.c
> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> @@ -28,6 +28,7 @@
>  =

>  #include <mach/common.h>
>  #include <mach/iomux-mx28.h>
> +#include <mach/digctl.h>
>  =

>  #include "devices-mx28.h"
>  =

> @@ -417,6 +418,17 @@ static void __init mx28evk_add_regulators(void)
>  static void __init mx28evk_add_regulators(void) {}
>  #endif
>  =

> +static int mx28evk_mxs_saif_pinit(void)
> +{
> +	return mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
> +}

This is board specific and not saif specific and thus should be called
directly in your board setup.

> +
> +static const struct mxs_saif_platform_data
> +			mx28evk_mxs_saif_pdata __initconst =3D {
> +	.init =3D mx28evk_mxs_saif_pinit,
> +	.get_master_id =3D mxs_get_saif_clk_master_id,

This looks *very* suspicious. .init sets the mux register and
.get_master_id reads the very same information back. Why not simply put
a bool is_master into platform data?
This function pointers are not devicetree friendly. I don't know whether
i.MX28 will be ever converted to devicetree, but we should not
unnecessary additional hurdles.

Sascha

-- =

Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
