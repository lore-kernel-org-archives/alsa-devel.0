From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 03/17] ASoC: Add a generic dmaengine_pcm
 driver
Date: Wed, 17 Apr 2013 12:48:17 +0200
Message-ID: <516E7DF1.6080905@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-4-git-send-email-lars@metafoo.de> <516E6FD8.5040400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-241.synserver.de (smtp-out-241.synserver.de
 [212.40.185.241])
 by alsa0.perex.cz (Postfix) with ESMTP id E76DC26160C
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 12:49:03 +0200 (CEST)
In-Reply-To: <516E6FD8.5040400@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/17/2013 11:48 AM, Peter Ujfalusi wrote:
> On 04/15/2013 07:19 PM, Lars-Peter Clausen wrote:
>> This patch adds a generic dmaengine PCM driver. It builds on top of the
>> dmaengine PCM library and adds the missing pieces like DMA channel management,
>> buffer management and channel configuration. It will be able to replace the
>> majority of the existing platform specific dmaengine based PCM drivers.
>> Devicetree is used to map the DMA channels to the PCM device.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>> +static const char * const dmaengine_pcm_dma_channel_names[] = {
>> +	[SNDRV_PCM_STREAM_PLAYBACK] = "tx",
>> +	[SNDRV_PCM_STREAM_CAPTURE] = "rx",
>> +};
> 
>> +
>> +/**
>> + * snd_dmaengine_pcm_register - Register a dmaengine based PCM device
>> + * @dev: The parent device for the PCM device
>> + * @config: Platform specific PCM configuration
>> + * @flags: Platform specific quirks
>> + */
>> +int snd_dmaengine_pcm_register(struct device *dev,
>> +	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
>> +{
>> +	struct dmaengine_pcm *pcm;
>> +	unsigned int i;
>> +
>> +	if (!dev->of_node)
>> +		return -EINVAL;
>> +
>> +	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
>> +	if (!pcm)
>> +		return -ENOMEM;
>> +
>> +	pcm->config = config;
>> +
>> +	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
>> +		pcm->chan[i] = of_dma_request_slave_channel(dev->of_node,
>> +					dmaengine_pcm_dma_channel_names[i]);
> 
> Here we should have flexibility to provide custom DMA channel names. For OMAP4
> AESS support (which I'm cleaning up right now for upstream) will need such a
> flexibility since we will have 8 DMA channels and none of them is dedicated tx
> or rx.

This sounds like it needs more than just support for custom channel names.
The generic driver currently expects that there is exactly one DMA channel
for capture and one for playback (well and in case the DAI link is simplex
only either one of them).

What are these 8 channels exactly used for?

- Lars
