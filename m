From: Liam Girdwood <lrg@ti.com>
Subject: Re: [RFC 1/2] ASoC: imx-ssi: use dma_writecombine
	consistently
Date: Thu, 25 Aug 2011 17:21:32 +0100
Message-ID: <4E56768C.4080409@ti.com>
References: <1314280496-21826-1-git-send-email-w.sang@pengutronix.de>
	<20110825141945.GW31404@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C17924645
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 18:21:41 +0200 (CEST)
In-Reply-To: <20110825141945.GW31404@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On 25/08/11 15:19, Sascha Hauer wrote:
> On Thu, Aug 25, 2011 at 03:54:55PM +0200, Wolfram Sang wrote:
>> If the channel is allocated as writecombine, then mmaping it should also
>> use writecombine. Also, add a proper device for the call. Ported from a
>> similar fix for mach-mxs.
>>
>> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Liam Girdwood <lrg@ti.com>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> both:
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> 

Acked-by: Liam Girdwood <lrg@ti.com>

> 
>> ---
>>  sound/soc/imx/imx-ssi.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
>> index 10a8e27..3b8d5cd 100644
>> --- a/sound/soc/imx/imx-ssi.c
>> +++ b/sound/soc/imx/imx-ssi.c
>> @@ -357,8 +357,8 @@ int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
>>  	struct snd_pcm_runtime *runtime = substream->runtime;
>>  	int ret;
>>  
>> -	ret = dma_mmap_coherent(NULL, vma, runtime->dma_area,
>> -			runtime->dma_addr, runtime->dma_bytes);
>> +	ret = dma_mmap_writecombine(substream->pcm->card->dev, vma,
>> +		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
>>  
>>  	pr_debug("%s: ret: %d %p 0x%08x 0x%08x\n", __func__, ret,
>>  			runtime->dma_area,
>> -- 
>> 1.7.5.4
>>
>>
> 
