From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/17] ASoC: dmaengine-pcm: Make requesting
 the DMA channel at PCM open optional
Date: Tue, 16 Apr 2013 07:33:12 +0200
Message-ID: <516CE298.6050203@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-2-git-send-email-lars@metafoo.de>
 <516C8D1B.3070901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EAB02652A3
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 07:30:46 +0200 (CEST)
In-Reply-To: <516C8D1B.3070901@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <rmallon@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/16/2013 01:28 AM, Ryan Mallon wrote:
> On 16/04/13 03:19, Lars-Peter Clausen wrote:
>> Refactor the dmaengine PCM library to allow the DMA channel to be requested
>> before opening a PCM substream. snd_dmaengine_pcm_open() now expects a DMA
>> channel instead of a filter function and filter parameter as its parameters.
>> snd_dmaengine_pcm_close() is updated to not release the DMA channel. This allows
>> a dmaengine based PCM driver to request its channels before the substream is
>> opened.
>>
>> The patch also introduces two new functions, snd_dmaengine_pcm_open_request_chan()
>> and snd_dmaengine_pcm_close_release_chan(), which have the same signature and
>> behaviour of the old snd_dmaengine_pcm_{open,close}() and internally use the new
>> variants of these functions. All users of snd_dmaengine_pcm_{open,close}() are
>> updated to use snd_dmaengine_pcm_open_request_chan() and
>> snd_dmaengine_pcm_close_release_chan().
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> <snip>
> 
>> --- a/sound/soc/cirrus/ep93xx-pcm.c
>> +++ b/sound/soc/cirrus/ep93xx-pcm.c
>> @@ -69,7 +69,8 @@ static int ep93xx_pcm_open(struct snd_pcm_substream *substream)
>>  
>>  	snd_soc_set_runtime_hwparams(substream, &ep93xx_pcm_hardware);
>>  
>> -	return snd_dmaengine_pcm_open(substream, ep93xx_pcm_dma_filter,
>> +	return snd_dmaengine_pcm_open_request_chan(substream,
>> +			ep93xx_pcm_dma_filter,
>>  			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
> 
> ep93xx_pcm_dma_filter is now unused and can be removed?

It's still used in the same way as before.

- Lars
