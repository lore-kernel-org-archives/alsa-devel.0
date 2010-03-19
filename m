From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai
 to snd_soc_pcm_stream
Date: Fri, 19 Mar 2010 15:14:53 +0000
Message-ID: <20100319151453.GH23306@rakim.wolfsonmicro.main>
References: <20100318182211.GH6142@rakim.wolfsonmicro.main>
	<1268940238-6283-1-git-send-email-daniel@caiaq.de>
	<201003190856.40650.peter.ujfalusi@nokia.com>
	<20100319070852.GR30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B3AE52436E
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 16:14:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100319070852.GR30801@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Sven Neumann <s.neumann@raumfeld.com>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Michael Hirsch <m.hirsch@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 19, 2010 at 08:08:53AM +0100, Daniel Mack wrote:
> On Fri, Mar 19, 2010 at 08:56:40AM +0200, Peter Ujfalusi wrote:

> > > b/sound/soc/davinci/davinci-i2s.c index 6362ca0..4aad7ec 100644
> > > --- a/sound/soc/davinci/davinci-i2s.c
> > > +++ b/sound/soc/davinci/davinci-i2s.c
> > > @@ -585,7 +585,8 @@ static int davinci_i2s_probe(struct platform_device
> > > *pdev) dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
> > > 
> > >         davinci_i2s_dai.private_data = dev;
> > > -       davinci_i2s_dai.dma_data = dev->dma_params;
> > > +       davinci_i2s_dai.capture.dma_data = dev->dma_params;
> > > +       davinci_i2s_dai.playback.dma_data = dev->dma_params;

> > Would not be more consistent around the places to actually use the
> > 		snd_soc_dai_set_dma_data(...);
> > function instead of direct assignment here, and there randomly?

> Sure. Now that this is possible, the davinvi code should be cleaned up.
> But as I say - I couldn't even compile-test these changes, so I didn't
> want to break the code flow logic as well. Davinci is special though,
> other drivers should be more consistent.

I agree with both of you, we can always tidy the code up later but cross
platform changes need some sync.  I've applied the patch, thanks once
again for analysing this and to everyone else for their review.
