From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] extcon: arizona: Add support for
	select accessory detect mode when headphone detection"
Date: Fri, 17 Apr 2015 10:30:32 +0100
Message-ID: <20150417093032.GE3480@opensource.wolfsonmicro.com>
References: <1429259579-16563-1-git-send-email-ideal.song@samsung.com> <1429259579-16563-2-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429259579-16563-2-git-send-email-ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 17, 2015 at 05:32:58PM +0900, Inha Song wrote:
> This patch add support for select accessory detect mode to HPDETL or HPDETR.
> Arizona provides a headphone detection circuit on the HPDETL and HPDETR pins
> to measure the impedance of an external load connected to the headphone.
> 
> Depending on board design, headphone detect pins can change to HPDETR or HPDETL.
> 
> Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/extcon/extcon-arizona.c   | 34 ++++++++++++++++++++++++++++++----
>  include/linux/mfd/arizona/pdata.h |  3 +++
>  2 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index 63f01c4..7bc9159 100644
> --- a/drivers/extcon/extcon-arizona.c
>  
> +#ifdef CONFIG_OF
> +static int arizona_of_get_extcon_pdata(struct arizona *arizona)
> +{
> +	struct arizona_pdata *pdata = &arizona->pdata;
> +
> +	of_property_read_u32(arizona->dev->of_node, "wlf,hpdet-channel",
> +			     &pdata->hpdet_channel);
> +
> +	return 0;
> +}
> +#else
> +static inline int arizona_of_get_extcon_pdata(struct arizona *arizona)
> +{
> +	return 0;
> +}
> +#endif

Oh and one other comment can we rename this functions to
arizona_extcon_of_get_pdata.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
