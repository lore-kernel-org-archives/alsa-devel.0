From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 3/3] ASoC: fsl_asrc: spba clock is needed by asrc
 device
Date: Fri, 20 Nov 2015 08:29:46 -0600
Message-ID: <20151120142946.GA6949@rob-hp-laptop>
References: <cover.1447997800.git.shengjiu.wang@freescale.com>
 <7b40da78c965d4152c15794ec527c75198c9e2f9.1447997800.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7b40da78c965d4152c15794ec527c75198c9e2f9.1447997800.git.shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shengjiu Wang <shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 20, 2015 at 02:17:53PM +0800, Shengjiu Wang wrote:
> ASRC need to enable the spba clock, when sdma is using share peripheral
> script. In this case, there is two spba master port is used, if don't
> enable the clock, the spba bus will have arbitration issue, which may
> cause read/write wrong data from/to ASRC registers
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt |  2 ++
>  sound/soc/fsl/fsl_asrc.c                             | 10 ++++++++++
>  sound/soc/fsl/fsl_asrc.h                             |  1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> index b93362a..d8eeee3 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> @@ -25,6 +25,8 @@ Required properties:
>  	"mem"		  Peripheral access clock to access registers.
>  	"ipg"		  Peripheral clock to driver module.
>  	"asrck_<0-f>"	  Clock sources for input and output clock.
> +	"spba"		  The spba clock is needed when two spba master port
> +			  is used.

I'm assuming the same comments on patch 1 apply to all 3.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
