From: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
Subject: Re: [PATCH] sound/soc/fsl/fsl_dma.c: add missing of_node_put
Date: Mon, 22 Aug 2011 16:06:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108221606220.10948@ask.diku.dk>
References: <1313825025-17590-1-git-send-email-julia@diku.dk>
	<4E5261A5.5050608@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4E5261A5.5050608-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 22 Aug 2011, Timur Tabi wrote:

> Julia Lawall wrote:
> > diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
> > index 0efc04a..b33271b 100644
> > --- a/sound/soc/fsl/fsl_dma.c
> > +++ b/sound/soc/fsl/fsl_dma.c
> > @@ -880,10 +880,12 @@ static struct device_node *find_ssi_node(struct device_node *dma_channel_np)
> >  		np = of_parse_phandle(ssi_np, "fsl,playback-dma", 0);
> >  		if (np == dma_channel_np)
> >  			return ssi_np;
> > +		of_node_put(np);
> >  
> >  		np = of_parse_phandle(ssi_np, "fsl,capture-dma", 0);
> >  		if (np == dma_channel_np)
> >  			return ssi_np;
> > +		of_node_put(np);
> >  	}
> 
> Thanks for catching the problem, Julia, but the fix is not quite correct.  My
> code assumes that of_parse_phandle() doesn't claim the node, but it doesn't
> actually use the node pointer, either.  All I care about is whether 'np' is
> equal to dma_channel_np.  I'm not going to use 'np'.  So I think the real fix is
> this:
> 
> @@ -880,10 +880,12 @@ static struct device_node *find_ssi_node(struct
> device_node *dma_channel_np)
>  		np = of_parse_phandle(ssi_np, "fsl,playback-dma", 0);
> +		of_node_put(np);
>  		if (np == dma_channel_np)
>  			return ssi_np;
> 
>  		np = of_parse_phandle(ssi_np, "fsl,capture-dma", 0);
> +		of_node_put(np);
>  		if (np == dma_channel_np)
>  			return ssi_np;
>  	}
> 
>  	return NULL;

OK, that looks reasonable.

julia
