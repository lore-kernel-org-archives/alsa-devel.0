From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 1/2] extcon: arizona: Add support for
	select accessory detect mode when headphone detection
Date: Sat, 25 Apr 2015 13:50:25 +0100
Message-ID: <20150425125025.GI3480@opensource.wolfsonmicro.com>
References: <1429701801-25287-1-git-send-email-ideal.song@samsung.com> <1429701801-25287-2-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429701801-25287-2-git-send-email-ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 22, 2015 at 08:23:20PM +0900, Inha Song wrote:
> This patch add support for select accessory detect mode to HPDETL or HPDETR.
> Arizona provides a headphone detection circuit on the HPDETL and HPDETR pins
> to measure the impedance of an external load connected to the headphone.
> 
> Depending on board design, headphone detect pins can change to HPDETR or HPDETL.
> 
> Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  
> +static int arizona_extcon_of_get_pdata(struct arizona *arizona)
> +{
> +	struct arizona_pdata *pdata = &arizona->pdata;
> +	unsigned int val;

I would rather this is "unsigned int val =
ARIZONA_ACCDET_MODE_HPL;".

> +
> +	of_property_read_u32(arizona->dev->of_node, "wlf,hpdet-channel", &val);

Because this won't fill val if the DT entry isn't present.

> +	switch (val) {

Which means we hit this with val uninitialised.

> +	case ARIZONA_ACCDET_MODE_HPL:
> +	case ARIZONA_ACCDET_MODE_HPR:

So we may select either channel at random.

> +		pdata->hpdet_channel = val;
> +		break;
> +	default:
> +		dev_err(arizona->dev,
> +			"Wrong wlf,hpdet-channel DT value %d\n", val);

Or most likely just print an error but the DT being missing
shouldn't really be an error it is an optional entry.

> +		pdata->hpdet_channel = ARIZONA_ACCDET_MODE_HPL;
> +	}
> +
> +	return 0;
> +}

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
