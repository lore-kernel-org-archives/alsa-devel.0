From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai
 to snd_soc_pcm_stream
Date: Fri, 19 Mar 2010 08:08:53 +0100
Message-ID: <20100319070852.GR30801@buzzloop.caiaq.de>
References: <20100318182211.GH6142@rakim.wolfsonmicro.main>
	<1268940238-6283-1-git-send-email-daniel@caiaq.de>
	<201003190856.40650.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 93C6310388B
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 08:09:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201003190856.40650.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Michael Hirsch <m.hirsch@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 19, 2010 at 08:56:40AM +0200, Peter Ujfalusi wrote:
> On Thursday 18 March 2010 21:23:58 ext Daniel Mack wrote:
> > This fixes a memory corruption when ASoC devices are used in
> > full-duplex mode. Specifically for pxa-ssp code, where this pointer
> > is dynamically allocated for each direction and destroyed upon each
> > stream start.
> > 
> > All other platforms are fixed blindly, I couldn't even compile-test
> > them. Sorry for any breakage I may have caused.
> 
> At least the OMAP code should not be affected by the bug, that you have with the 
> pxa-ssp. I think the bug could be also fixed within the pxa code, since the 
> whole thing goes down to inconsistent memory management within the pxa code.

Maybe OMAP is not affected, but I've seen other platforms that also use
this dma_data pointer at many more other callbacks and the code seems to
believe the pointer is still set to what has been given in the hw_param
call (think it was S6000).

> Having said that, I do think having separate dma_data for each streams is a 
> really good idea.
> One thing that I can think of in OMAP case, where this could fix a nasty race 
> condition is (have never seen it, but it is in theory possible):
> Also in duplex case, when the second hw_param gets called after the first 
> omap_mcbsp_hw_params, and before the omap_pcm_hw_params for the first stream.
> The second omap_mcbsp_hw_params will override the dma_data, thus we would set 
> bogus parameters for the first stream.

Right.

> For the omap-mcbsp.c and omap-pcm.c changes:
> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Thanks!

> > b/sound/soc/atmel/atmel_ssc_dai.c index e588e63..0b59806 100644
> > --- a/sound/soc/atmel/atmel_ssc_dai.c
> > +++ b/sound/soc/atmel/atmel_ssc_dai.c
> > @@ -363,12 +363,12 @@ static int atmel_ssc_hw_params(struct
> > snd_pcm_substream *substream, ssc_p->dma_params[dir] = dma_params;
> > 
> >         /*
> > -        * The cpu_dai->dma_data field is only used to communicate the
> > -        * appropriate DMA parameters to the pcm driver hw_params()
> > +        * The snd_soc_pcm_stream->dma_data field is only used to
> > communicate +        * the appropriate DMA parameters to the pcm driver
> > hw_params() * function.  It should not be used for other purposes
> >          * as it is common to all substreams.
> >          */
> > -       rtd->dai->cpu_dai->dma_data = dma_params;
> > +       snd_soc_dai_set_dma_data(rtd->dai->cpu_dai, substream, dma_params);
> > 
> >         channels = params_channels(params);
> > 
> > diff --git a/sound/soc/davinci/davinci-i2s.c
> > b/sound/soc/davinci/davinci-i2s.c index 6362ca0..4aad7ec 100644
> > --- a/sound/soc/davinci/davinci-i2s.c
> > +++ b/sound/soc/davinci/davinci-i2s.c
> > @@ -585,7 +585,8 @@ static int davinci_i2s_probe(struct platform_device
> > *pdev) dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
> > 
> >         davinci_i2s_dai.private_data = dev;
> > -       davinci_i2s_dai.dma_data = dev->dma_params;
> > +       davinci_i2s_dai.capture.dma_data = dev->dma_params;
> > +       davinci_i2s_dai.playback.dma_data = dev->dma_params;
> 
> Would not be more consistent around the places to actually use the
> 		snd_soc_dai_set_dma_data(...);
> function instead of direct assignment here, and there randomly?

Sure. Now that this is possible, the davinvi code should be cleaned up.
But as I say - I couldn't even compile-test these changes, so I didn't
want to break the code flow logic as well. Davinci is special though,
other drivers should be more consistent.

Daniel
