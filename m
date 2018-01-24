From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 14/38] ASoC: amd: replace platform to
	component
Date: Wed, 24 Jan 2018 14:45:13 +0530
Message-ID: <0bfdbf55-cff6-44eb-e245-94290a2064fd@amd.com>
References: <87vag7gb9o.wl%kuninori.morimoto.gx@renesas.com>
 <87bmhzgb0n.wl%kuninori.morimoto.gx@renesas.com>
 <87vafs6q67.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0059.outbound.protection.outlook.com [104.47.42.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 227B1266FE0
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 10:16:16 +0100 (CET)
In-Reply-To: <87vafs6q67.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
Cc: "Vemuri, Murali-krishna" <Murali-krishna.Vemuri@amd.com>
List-Id: alsa-devel@alsa-project.org

Tested-by: Mukunda,Vijendar <vijendar.mukunda@amd.com>


On Wednesday 24 January 2018 06:16 AM, Kuninori Morimoto wrote:
> I have asked patch test to Mukunda / Vemuri.
> Cc this mail to them.
>
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> Now platform can be replaced to component, let's do it.
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>   sound/soc/amd/acp-pcm-dma.c | 29 ++++++++++++++++++-----------
>>   1 file changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
>> index c33a512..78d7b62 100644
>> --- a/sound/soc/amd/acp-pcm-dma.c
>> +++ b/sound/soc/amd/acp-pcm-dma.c
>> @@ -23,6 +23,8 @@
>>   #include <drm/amd_asic_type.h>
>>   #include "acp.h"
>>   
>> +#define DRV_NAME "acp_audio_dma"
>> +
>>   #define PLAYBACK_MIN_NUM_PERIODS    2
>>   #define PLAYBACK_MAX_NUM_PERIODS    2
>>   #define PLAYBACK_MAX_PERIOD_SIZE    16384
>> @@ -702,8 +704,8 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
>>   	int ret = 0;
>>   	struct snd_pcm_runtime *runtime = substream->runtime;
>>   	struct snd_soc_pcm_runtime *prtd = substream->private_data;
>> -	struct audio_drv_data *intr_data = dev_get_drvdata(prtd->platform->dev);
>> -
>> +	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
>> +	struct audio_drv_data *intr_data = dev_get_drvdata(component->dev);
>>   	struct audio_substream_data *adata =
>>   		kzalloc(sizeof(struct audio_substream_data), GFP_KERNEL);
>>   	if (adata == NULL)
>> @@ -730,7 +732,7 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
>>   	ret = snd_pcm_hw_constraint_integer(runtime,
>>   					    SNDRV_PCM_HW_PARAM_PERIODS);
>>   	if (ret < 0) {
>> -		dev_err(prtd->platform->dev, "set integer constraint failed\n");
>> +		dev_err(component->dev, "set integer constraint failed\n");
>>   		kfree(adata);
>>   		return ret;
>>   	}
>> @@ -778,7 +780,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
>>   	struct snd_pcm_runtime *runtime;
>>   	struct audio_substream_data *rtd;
>>   	struct snd_soc_pcm_runtime *prtd = substream->private_data;
>> -	struct audio_drv_data *adata = dev_get_drvdata(prtd->platform->dev);
>> +	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
>> +	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
>>   
>>   	runtime = substream->runtime;
>>   	rtd = runtime->private_data;
>> @@ -907,6 +910,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
>>   	struct snd_pcm_runtime *runtime = substream->runtime;
>>   	struct snd_soc_pcm_runtime *prtd = substream->private_data;
>>   	struct audio_substream_data *rtd = runtime->private_data;
>> +	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
>>   
>>   	if (!rtd)
>>   		return -EINVAL;
>> @@ -924,7 +928,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
>>   			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
>>   						BIT(SYSRAM_TO_ACP_CH_NUM)) {
>>   				if (!loops--) {
>> -					dev_err(prtd->platform->dev,
>> +					dev_err(component->dev,
>>   						"acp dma start timeout\n");
>>   					return -ETIMEDOUT;
>>   				}
>> @@ -970,7 +974,8 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
>>   static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
>>   {
>>   	int ret;
>> -	struct audio_drv_data *adata = dev_get_drvdata(rtd->platform->dev);
>> +	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
>> +	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
>>   
>>   	switch (adata->asic_type) {
>>   	case CHIP_STONEY:
>> @@ -987,7 +992,7 @@ static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
>>   		break;
>>   	}
>>   	if (ret < 0)
>> -		dev_err(rtd->platform->dev,
>> +		dev_err(component->dev,
>>   				"buffer preallocation failer error:%d\n", ret);
>>   	return ret;
>>   }
>> @@ -998,7 +1003,8 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
>>   	struct snd_pcm_runtime *runtime = substream->runtime;
>>   	struct audio_substream_data *rtd = runtime->private_data;
>>   	struct snd_soc_pcm_runtime *prtd = substream->private_data;
>> -	struct audio_drv_data *adata = dev_get_drvdata(prtd->platform->dev);
>> +	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
>> +	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
>>   
>>   	kfree(rtd);
>>   
>> @@ -1044,7 +1050,8 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
>>   	.prepare = acp_dma_prepare,
>>   };
>>   
>> -static struct snd_soc_platform_driver acp_asoc_platform = {
>> +static struct snd_soc_component_driver acp_asoc_platform = {
>> +	.name = DRV_NAME,
>>   	.ops = &acp_dma_ops,
>>   	.pcm_new = acp_dma_new,
>>   };
>> @@ -1102,7 +1109,8 @@ static int acp_audio_probe(struct platform_device *pdev)
>>   		return status;
>>   	}
>>   
>> -	status = snd_soc_register_platform(&pdev->dev, &acp_asoc_platform);
>> +	status = devm_snd_soc_register_component(&pdev->dev,
>> +						&acp_asoc_platform, NULL, 0);
>>   	if (status != 0) {
>>   		dev_err(&pdev->dev, "Fail to register ALSA platform device\n");
>>   		return status;
>> @@ -1123,7 +1131,6 @@ static int acp_audio_remove(struct platform_device *pdev)
>>   	status = acp_deinit(adata->acp_mmio);
>>   	if (status)
>>   		dev_err(&pdev->dev, "ACP Deinit failed status:%d\n", status);
>> -	snd_soc_unregister_platform(&pdev->dev);
>>   	pm_runtime_disable(&pdev->dev);
>>   
>>   	return 0;
>> -- 
>> 1.9.1
>>
