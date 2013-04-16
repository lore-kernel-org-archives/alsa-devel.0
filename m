From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 03/17] ASoC: Add a generic dmaengine_pcm
	driver
Date: Tue, 16 Apr 2013 17:46:07 +0200
Message-ID: <516D723F.1020407@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-4-git-send-email-lars@metafoo.de>
 <20130416141105.GB13272@pengutronix.de> <20130416143518.GA29127@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-032.synserver.de (smtp-out-032.synserver.de
 [212.40.185.32])
 by alsa0.perex.cz (Postfix) with ESMTP id C99782610A6
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 17:46:58 +0200 (CEST)
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/16/2013 04:35 PM, Lee Jones wrote:
>>> +/**
>>> + * snd_dmaengine_pcm_register - Register a dmaengine based PCM device
>>> + * @dev: The parent device for the PCM device
>>> + * @config: Platform specific PCM configuration
>>> + * @flags: Platform specific quirks
>>> + */
>>> +int snd_dmaengine_pcm_register(struct device *dev,
>>> +	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
>>> +{
>>> +	struct dmaengine_pcm *pcm;
>>> +	unsigned int i;
>>> +
>>> +	if (!dev->of_node)
>>> +		return -EINVAL;
> 
> Why is this call Device Tree only?
> 
> Are devices which use platform data still supported?

The next patch (04/17) adds support for compat platforms.

> 
>>> +	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
>>> +	if (!pcm)
>>> +		return -ENOMEM;
>>> +
>>> +	pcm->config = config;
>>> +
>>> +	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
>>> +		pcm->chan[i] = of_dma_request_slave_channel(dev->of_node,
>>> +					dmaengine_pcm_dma_channel_names[i]);
>>> +	}
>>
>> Perhaps you should use dma_request_slave_channel here? Then you could
>> also drop the of_dma.h include.
> 
> Then how would Device Tree be supported?
> 
