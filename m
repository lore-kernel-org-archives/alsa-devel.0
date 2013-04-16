From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 03/17] ASoC: Add a generic dmaengine_pcm
	driver
Date: Tue, 16 Apr 2013 16:42:10 +0200
Message-ID: <20130416144210.GD13272@pengutronix.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-4-git-send-email-lars@metafoo.de>
 <20130416141105.GB13272@pengutronix.de>
 <20130416143518.GA29127@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 5C1B626109C
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 16:42:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130416143518.GA29127@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 16, 2013 at 03:35:18PM +0100, Lee Jones wrote:
> > > +/**
> > > + * snd_dmaengine_pcm_register - Register a dmaengine based PCM device
> > > + * @dev: The parent device for the PCM device
> > > + * @config: Platform specific PCM configuration
> > > + * @flags: Platform specific quirks
> > > + */
> > > +int snd_dmaengine_pcm_register(struct device *dev,
> > > +	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
> > > +{
> > > +	struct dmaengine_pcm *pcm;
> > > +	unsigned int i;
> > > +
> > > +	if (!dev->of_node)
> > > +		return -EINVAL;
> 
> Why is this call Device Tree only?
> 
> Are devices which use platform data still supported?
> 
> > > +	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
> > > +	if (!pcm)
> > > +		return -ENOMEM;
> > > +
> > > +	pcm->config = config;
> > > +
> > > +	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
> > > +		pcm->chan[i] = of_dma_request_slave_channel(dev->of_node,
> > > +					dmaengine_pcm_dma_channel_names[i]);
> > > +	}
> > 
> > Perhaps you should use dma_request_slave_channel here? Then you could
> > also drop the of_dma.h include.
> 
> Then how would Device Tree be supported?

dma_request_slave_channel calls of_dma_request_slave_channel if
dev->of_node exists. As far as I know dma_request_slave_channel is
preferred for calls from outside the dmaengine core.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
