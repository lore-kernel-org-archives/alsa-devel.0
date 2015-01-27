From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH_V3 4/4] sound: jz4740: set i2s clk rate to 12MHz
Date: Tue, 27 Jan 2015 12:35:48 +0000
Message-ID: <54C78624.5000702@imgtec.com>
References: <1422283993-53642-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1422283993-53642-5-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422283993-53642-5-git-send-email-Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tiwai-l3A5Bk7waGM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 26/01/15 14:53, Zubair Lutfullah Kakakhel wrote:
> i2s clock rate is not set to 12MHz currently. Set it before enabling
> the clock.
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> 
> ---
> V2 changes: Removed clk_prepare_enable call as clock was already being
> enabled elsewhere. Just set rate to 12MHz.
> ---
>  sound/soc/jz4740/jz4740-i2s.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
> index 07f7781..c2e5852 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -125,6 +125,7 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
>  	ctrl |= JZ_AIC_CTRL_FLUSH;
>  	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
>  
> +	clk_set_rate(i2s->clk_i2s, 12000000);

Lars recommended using dt and assigned-clock-rates for this. (irc)
I've checked and it can be done.

This patch is not needed.

Patch 1-3 in this series are OK. This last one can be skipped.

Do you want me to repost the series without it? Or is this fine?

Thanks,
ZubairLK

>  	clk_prepare_enable(i2s->clk_i2s);
>  
>  	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
