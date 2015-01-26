From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 1/4] sound: soc: jz4740: Add dynamic sampling rate support
 to jz4740-i2s
Date: Mon, 26 Jan 2015 11:35:43 +0100
Message-ID: <54C6187F.4050802@metafoo.de>
References: <1422267511-6649-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1422267511-6649-2-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422267511-6649-2-git-send-email-Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, tiwai-l3A5Bk7waGM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 01/26/2015 11:18 AM, Zubair Lutfullah Kakakhel wrote:
[...]
>   #define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
> +#define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)

This looks like it slipped in by accident. Otherwise the patch looks good.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
