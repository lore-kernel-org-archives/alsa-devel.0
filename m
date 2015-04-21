From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 1/2] extcon: arizona: Add support for
	select accessory detect mode when headphone detection
Date: Tue, 21 Apr 2015 10:28:26 +0100
Message-ID: <20150421092826.GH3480@opensource.wolfsonmicro.com>
References: <1429589505-11954-1-git-send-email-ideal.song@samsung.com> <1429589505-11954-2-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429589505-11954-2-git-send-email-ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 21, 2015 at 01:11:44PM +0900, Inha Song wrote:
> This patch add support for select accessory detect mode to HPDETL or HPDETR.
> Arizona provides a headphone detection circuit on the HPDETL and HPDETR pins
> to measure the impedance of an external load connected to the headphone.
> 
> Depending on board design, headphone detect pins can change to HPDETR or HPDETL.
> 
> Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/extcon/extcon-arizona.c   | 28 ++++++++++++++++++++--------
>  include/dt-bindings/mfd/arizona.h |  8 ++++++++
>  include/linux/mfd/arizona/pdata.h |  3 +++
>  3 files changed, 31 insertions(+), 8 deletions(-)
>  create mode 100644 include/dt-bindings/mfd/arizona.h
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index 63f01c4..c827342 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -32,13 +32,10 @@
>  #include <linux/mfd/arizona/core.h>
>  #include <linux/mfd/arizona/pdata.h>
>  #include <linux/mfd/arizona/registers.h>
> +#include <dt-bindings/mfd/arizona.h>
>  
>  #define ARIZONA_MAX_MICD_RANGE 8
>  
> -#define ARIZONA_ACCDET_MODE_MIC 0
> -#define ARIZONA_ACCDET_MODE_HPL 1
> -#define ARIZONA_ACCDET_MODE_HPR 2
> -
>  #define ARIZONA_MICD_CLAMP_MODE_JDL      0x4
>  #define ARIZONA_MICD_CLAMP_MODE_JDH      0x5
>  #define ARIZONA_MICD_CLAMP_MODE_JDL_GP5H 0x9
> @@ -653,9 +650,9 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
>  	ret = regmap_update_bits(arizona->regmap,
>  				 ARIZONA_ACCESSORY_DETECT_MODE_1,
>  				 ARIZONA_ACCDET_MODE_MASK,
> -				 ARIZONA_ACCDET_MODE_HPL);
> +				 arizona->pdata.hpdet_channel);
>  	if (ret != 0) {
> -		dev_err(arizona->dev, "Failed to set HPDETL mode: %d\n", ret);
> +		dev_err(arizona->dev, "Failed to set HPDET mode: %d\n", ret);
>  		goto err;
>  	}
>  
> @@ -705,9 +702,9 @@ static void arizona_start_hpdet_acc_id(struct arizona_extcon_info *info)
>  				 ARIZONA_ACCESSORY_DETECT_MODE_1,
>  				 ARIZONA_ACCDET_SRC | ARIZONA_ACCDET_MODE_MASK,
>  				 info->micd_modes[0].src |
> -				 ARIZONA_ACCDET_MODE_HPL);
> +				 arizona->pdata.hpdet_channel);
>  	if (ret != 0) {
> -		dev_err(arizona->dev, "Failed to set HPDETL mode: %d\n", ret);
> +		dev_err(arizona->dev, "Failed to set HPDET mode: %d\n", ret);
>  		goto err;
>  	}
>  
> @@ -1103,6 +1100,16 @@ static void arizona_micd_set_level(struct arizona *arizona, int index,
>  	regmap_update_bits(arizona->regmap, reg, mask, level);
>  }
>  
> +static int arizona_extcon_of_get_pdata(struct arizona *arizona)
> +{
> +	struct arizona_pdata *pdata = &arizona->pdata;
> +
> +	of_property_read_u32(arizona->dev->of_node, "wlf,hpdet-channel",
> +			     &pdata->hpdet_channel);

I think we need to verify this is either HPL or HPR and default
it to HPL if isn't one of those. Otherwise this looks fine.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
