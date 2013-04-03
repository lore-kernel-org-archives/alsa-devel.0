From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 6/8] ASoC: tegra: Use common DAI DMA data
	struct
Date: Wed, 03 Apr 2013 20:38:18 +0200
Message-ID: <515C771A.4080608@metafoo.de>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-2-git-send-email-lars@metafoo.de>
 <515C6212.6070401@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-220.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 96BD2265DA7
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 19:39:03 +0200 (CEST)
In-Reply-To: <515C6212.6070401@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/03/2013 07:08 PM, Stephen Warren wrote:
> On 04/03/2013 03:06 AM, Lars-Peter Clausen wrote:
>> Use the common DAI DMA data struct for tegra, this allows us to use the common
>> helper function to configure the DMA slave config based on the DAI DMA data.
> 
> Nice. Patches 2, 5, 6,
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> But one minor question below:
> 
>> diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
> 
>> @@ -92,16 +89,9 @@ static int tegra_pcm_hw_params(struct snd_pcm_substream *substream,
> 
>> +	snd_dmaengine_pcm_set_config_from_dai_data(substream,
>> +			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream),
>> +			&slave_config);
> 
> Would it make sense to have snd_dmaengine_pcm_set_config_from_dai_data()
> call snd_soc_dai_get_dma_data() internally, to avoid all call-sites from
> having to do it?

Yes, I thought about that as well, but there are some platforms like mmp
which we can't switch to using the generic DAI DMA data yet, but may find it
useful to be able to use this function. So they'd initialize the dma data
struct on the stack and pass it to the function.

- Lars
