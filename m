From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 16/17] ASoC: ep93xx: Use generic dmaengine
	PCM
Date: Tue, 16 Apr 2013 07:32:35 +0200
Message-ID: <516CE273.7080006@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-17-git-send-email-lars@metafoo.de>
 <516C91E5.9080309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 545E62652A2
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 07:30:07 +0200 (CEST)
In-Reply-To: <516C91E5.9080309@gmail.com>
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

On 04/16/2013 01:48 AM, Ryan Mallon wrote:
> On 16/04/13 03:20, Lars-Peter Clausen wrote:
>> Use the generic dmaengine PCM driver instead of a custom implementation.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  sound/soc/cirrus/Kconfig      |   2 +-
>>  sound/soc/cirrus/ep93xx-i2s.c |   4 +-
>>  sound/soc/cirrus/ep93xx-pcm.c | 138 ++++--------------------------------------
>>  3 files changed, 14 insertions(+), 130 deletions(-)
>>
>> diff --git a/sound/soc/cirrus/Kconfig b/sound/soc/cirrus/Kconfig
>> index 88143db..2c20f01 100644
>> --- a/sound/soc/cirrus/Kconfig
>> +++ b/sound/soc/cirrus/Kconfig
>> @@ -1,7 +1,7 @@
>>  config SND_EP93XX_SOC
>>  	tristate "SoC Audio support for the Cirrus Logic EP93xx series"
>>  	depends on ARCH_EP93XX && SND_SOC
>> -	select SND_SOC_DMAENGINE_PCM
>> +	select SND_SOC_GENERIC_DMAENGINE_PCM
>>  	help
>>  	  Say Y or M if you want to add support for codecs attached to
>>  	  the EP93xx I2S or AC97 interfaces.
>> diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
>> index 453a89c..ef731e6 100644
>> --- a/sound/soc/cirrus/ep93xx-i2s.c
>> +++ b/sound/soc/cirrus/ep93xx-i2s.c
>> @@ -140,8 +140,8 @@ static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info, int stream)
>>  
>>  static int ep93xx_i2s_dai_probe(struct snd_soc_dai *dai)
>>  {
>> -	dai->playback_dma_data = ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_PLAYBACK];
>> -	dai->capute_dma_data = ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_CAPTURE]
>> +	dai->playback_dma_data = &ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_PLAYBACK];
>> +	dai->capture_dma_data = &ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_CAPTURE];
> 
> Why did this change? I can't see a change to ep93xx_i2s_dma_data. Was
> this just incorrect in the previous patch? All patches in a series
> should be buildable/runnable to assist things like git bisect.
> 

Yes, that part belongs to the previous patch and only ended up here by accident.

>>  
>>  	return 0;
>>  }
>> diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
>> index 4880326..0e9f56e 100644
>> --- a/sound/soc/cirrus/ep93xx-pcm.c
>> +++ b/sound/soc/cirrus/ep93xx-pcm.c
>> @@ -14,20 +14,14 @@
>>  
>>  #include <linux/module.h>
>>  #include <linux/init.h>
>> -#include <linux/device.h>
>> -#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>>  #include <linux/dmaengine.h>
>> -#include <linux/dma-mapping.h>
>>  
>> -#include <sound/core.h>
>>  #include <sound/pcm.h>
>> -#include <sound/pcm_params.h>
>>  #include <sound/soc.h>
>>  #include <sound/dmaengine_pcm.h>
>>  
>>  #include <linux/platform_data/dma-ep93xx.h>
>> -#include <mach/hardware.h>
>> -#include <mach/ep93xx-regs.h>
> 
> Awesome. It looks like this header can also be removed from ep93xx-i2s.c
> also, which gets us a step closer to making this header private to the
> ep93xx soc code in arch/arm.
> 
> ~Ryan
> 
