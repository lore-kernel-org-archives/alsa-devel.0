From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ASoC: wm8985: add device-tree support
Date: Fri, 20 May 2016 17:21:28 +0100
Message-ID: <20160520162128.GS1646@localhost.localdomain>
References: <1463489389-17719-1-git-send-email-petr@barix.com>
 <1463489389-17719-2-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463489389-17719-2-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, plamen-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 17, 2016 at 02:49:49PM +0200, Petr Kulhavy wrote:
> Add device-tree support to the WM8985 driver.
> 
> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
> ---
> v1: initial
> v2: add missing of_match_ptr()
>     use chip type enum instead of chip structure
> 
>  sound/soc/codecs/wm8985.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
> index 436c7e2c5a0b..0b2dd2bc6fff 100644
> --- a/sound/soc/codecs/wm8985.c
> +++ b/sound/soc/codecs/wm8985.c
> @@ -32,6 +32,7 @@
>  #include <sound/soc.h>
>  #include <sound/initval.h>
>  #include <sound/tlv.h>
> +#include <linux/of_device.h>
>  
>  #include "wm8985.h"
>  
> @@ -1174,10 +1175,21 @@ static const struct regmap_config wm8985_regmap = {
>  	.num_reg_defaults = ARRAY_SIZE(wm8985_reg_defaults),
>  };
>  
> +static enum wm8985_type wm8985_data = WM8985;
> +static enum wm8985_type wm8758_data = WM8758;
> +
> +static const struct of_device_id wm8985_of_match[] = {
> +	{ .compatible = "wlf,wm8985", .data = &wm8985_data},
> +	{ .compatible = "wlf,wm8758", .data = &wm8758_data},

You can probably just use (void *)WM8985 instead here.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
