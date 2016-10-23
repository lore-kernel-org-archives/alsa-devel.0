From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
Date: Sun, 23 Oct 2016 18:31:07 +0200
Message-ID: <20161023183107.5b75b6aad62853378713299f@free.fr>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
        <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
        <20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
        <20161004165553.GS5228@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161004165553.GS5228@lukather>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: =?ISO-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, 4 Oct 2016 18:55:54 +0200
Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> On Tue, Oct 04, 2016 at 12:40:11PM +0200, Jean-Francois Moine wrote:
> > On Tue,  4 Oct 2016 11:46:14 +0200
> > Mylène Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > 
> > > Add the case of a burst of 4 which is handled by the SoC.
> > > 
> > > Signed-off-by: Mylène Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > > ---
> > >  drivers/dma/sun6i-dma.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > > index 8346199..0485204 100644
> > > --- a/drivers/dma/sun6i-dma.c
> > > +++ b/drivers/dma/sun6i-dma.c
> > > @@ -240,6 +240,8 @@ static inline s8 convert_burst(u32 maxburst)
> > >  	switch (maxburst) {
> > >  	case 1:
> > >  		return 0;
> > > +	case 4:
> > > +		return 1;
> > >  	case 8:
> > >  		return 2;
> > >  	default:
> > > -- 
> > > 2.9.3
> > 
> > This patch has already been rejected by Maxime in the threads
> > 	http://www.spinics.net/lists/dmaengine/msg08610.html
> > and
> > 	http://www.spinics.net/lists/dmaengine/msg08719.html
> > 
> > I hope you will find the way he wants for this maxburst to be added.
> 
> I was talking about something along these lines (not tested):

I wonder why you don't submit this yourself.

> -------8<---------
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 83461994e418..573ac4608293 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -240,6 +240,8 @@ static inline s8 convert_burst(u32 maxburst)
>  	switch (maxburst) {
>  	case 1:
>  		return 0;
> +	case 4:
> +		return 1;
>  	case 8:
>  		return 2;
>  	default:
> @@ -1110,11 +1112,19 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>  	sdc->slave.dst_addr_widths		= BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> +	sdc->slave.dst_bursts			= BIT(1) | BIT(8);
> +	sdc->slave.src_bursts			= BIT(1) | BIT(8);
>  	sdc->slave.directions			= BIT(DMA_DEV_TO_MEM) |
>  						  BIT(DMA_MEM_TO_DEV);
>  	sdc->slave.residue_granularity		= DMA_RESIDUE_GRANULARITY_BURST;
>  	sdc->slave.dev = &pdev->dev;
>  
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "allwinner,sun8i-h3-dma")) {
> +		sdc->slave.dst_bursts |= BIT(4);
> +		sdc->slave.src_bursts |= BIT(4);
> +	}
> +
>  	sdc->pchans = devm_kcalloc(&pdev->dev, sdc->cfg->nr_max_channels,
>  				   sizeof(struct sun6i_pchan), GFP_KERNEL);
>  	if (!sdc->pchans)
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index cc535a478bae..f7bbec24bb58 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -673,6 +673,8 @@ struct dma_filter {
>   * 	each type of direction, the dma controller should fill (1 <<
>   * 	<TYPE>) and same should be checked by controller as well
>   * @max_burst: max burst capability per-transfer
> + * @dst_bursts: bitfield of the available burst sizes for the destination
> + * @src_bursts: bitfield of the available burst sizes for the source

You did not define dst_bursts nor src_bursts.

>   * @residue_granularity: granularity of the transfer residue reported
>   *	by tx_status
>   * @device_alloc_chan_resources: allocate resources and return the
> @@ -800,6 +802,14 @@ struct dma_device {
>  static inline int dmaengine_slave_config(struct dma_chan *chan,
>  					  struct dma_slave_config *config)
>  {
> +	if (config->src_maxburst && config->device->src_bursts &&
> +	    !(BIT(config->src_maxburst) & config->device->src_bursts))

The maxburst may be as big as 4Kibytes, then, I am not sure that this
code will work!

> +		return -EINVAL;
> +
> +	if (config->dst_maxburst && config->device->dst_bursts &&
> +	    !(BIT(config->dst_maxburst) & config->device->dst_bursts))
> +		return -EINVAL;
> +
>  	if (chan->device->device_config)
>  		return chan->device->device_config(chan, config);
> -------8<------------ 

Yes, I know that the burst size is always a power of 2.
The best way to check it would be to change the {src,dts}_maxburst to a
bitmap of the possible bursts as 0x0d for 1,4 and 8 bytes. But this
asks for a lot of changes...

-- 
Ken ar c'hentañ	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
