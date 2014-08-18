From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ASoC: fsl-asrc: Convert to use regmap framework's endianness
 method.
Date: Mon, 18 Aug 2014 20:54:13 +0530
Message-ID: <53F21A9D.4010507@gmail.com>
References: <1408352215-12014-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408352215-12014-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


On Monday 18 August 2014 02:26 PM, Xiubo Li wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>
> This is depended on the following regmap framework patches, which have
> just been merged into linux-next tree:
>
> https://lkml.org/lkml/2014/7/15/6
> https://lkml.org/lkml/2014/7/15/5
> https://lkml.org/lkml/2014/7/15/7
>
>
>
>
>
>
>   Documentation/devicetree/bindings/sound/fsl,asrc.txt | 10 +++++++---
>   sound/soc/fsl/fsl_asrc.c                             |  6 +-----
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
Reviewed-by: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--
Regards,
Varka Bhadram.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
