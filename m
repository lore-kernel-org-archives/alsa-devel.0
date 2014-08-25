From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 5/5] ASoC: fsl-sai: rename big_endian_data to
 is_msb_first.
Date: Sun, 24 Aug 2014 18:50:53 -0700
Message-ID: <20140825015053.GB26651@Alpha>
References: <1408421693-9929-1-git-send-email-Li.Xiubo@freescale.com>
 <1408421693-9929-6-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408421693-9929-6-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 19, 2014 at 12:14:53PM +0800, Xiubo Li wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 8 ++++----
>  sound/soc/fsl/fsl_sai.c                             | 6 +++---
>  sound/soc/fsl/fsl_sai.h                             | 2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index aed1f21..e25ef38 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -20,9 +20,9 @@ Required properties:
>    See ../pinctrl/pinctrl-bindings.txt for details of the property values.
>  - big-endian: Boolean property, required if all the SAI device registers
>    are big-endian rather than little-endian.
> -- big-endian-data: If this property is absent, the little endian mode will
> -  be in use as default, or the big endian mode will be in use for all the
> -  fifo data.
> +- msb-first: Configures whether the LSB or the MSB is transmitted first for
> +  the fifo data. If this property is absent, the LSB is transmitted first as
> +  default, or the MSB is transmitted first.
>  - fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
>    that SAI will work in the synchronous mode (sync Tx with Rx) which means
>    both the transimitter and receiver will send and receive data by following
> @@ -53,5 +53,5 @@ sai2: sai@40031000 {
>  	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
>  		   <&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
>  	      big-endian;
> -	      big-endian-data;
> +	      msb-first;
>  };
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index a6eb784..4e48431 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -175,7 +175,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
>  	bool tx = fsl_dir == FSL_FMT_TRANSMITTER;
>  	u32 val_cr2 = 0, val_cr4 = 0;
>  
> -	if (!sai->big_endian_data)
> +	if (!sai->is_msb_first)
>  		val_cr4 |= FSL_SAI_CR4_MF;

IIRC, MF stands for 'MSB First' but the condition is !is_msb_first..

And also we can't not simply inverse the condition here since those
platforms without the original 'big_endian_data' property will be
broken unless they add the new 'is_msb_first' into the DT bindings,
which is, however, a violation due to breaking the old bindings.

So I guess is_lsb_first might be better here?

And actually, Xiubo, what's your purpose to add this patch? I can't
see any commit comments to explain the reason. So could you please
say something about it?

Thanks
Nicolin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
