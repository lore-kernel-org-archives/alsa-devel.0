From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH V2] ASoC: amd: dma driver changes for BT
 I2S controller instance
Date: Mon, 19 Mar 2018 14:40:59 +0000
Message-ID: <BN6PR12MB1809E4817EF07F43DAB75A11F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1521441636-18933-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0081.outbound.protection.outlook.com [104.47.34.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 176912672A7
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 15:41:02 +0100 (CET)
In-Reply-To: <1521441636-18933-1-git-send-email-Vijendar.Mukunda@amd.com>
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
To: "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Agrawal,
 Akshu" <Akshu.Agrawal@amd.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Vijendar Mukunda [mailto:Vijendar.Mukunda@amd.com]
> Sent: Monday, March 19, 2018 2:41 AM
> To: broonie@kernel.org; alsa-devel@alsa-project.org
> Cc: lgirdwood@gmail.com; tiwai@suse.de; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Mukunda, Vijendar
> <Vijendar.Mukunda@amd.com>; Agrawal, Akshu
> <Akshu.Agrawal@amd.com>
> Subject: [PATCH V2] ASoC: amd: dma driver changes for BT I2S controller
> instance
> 
> With in ACP, There are three I2S controllers can be configured/enabled ( I2S
> SP, I2S MICSP, I2S BT).
> Default enabled I2S controller instance is I2S SP.
> This patch provides required changes to support I2S BT controller Instance.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>  sound/soc/amd/acp-pcm-dma.c | 106
> +++++++++++++++++++++++++++++++++++---------
>  sound/soc/amd/acp.h         |  10 +++++
>  2 files changed, 94 insertions(+), 22 deletions(-)
> 
> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-
> dma.c index 540088d..a61c4e0 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -697,6 +697,7 @@ static int acp_dma_open(struct snd_pcm_substream
> *substream)
>  	struct snd_soc_pcm_runtime *prtd = substream->private_data;
>  	struct snd_soc_component *component =
> snd_soc_rtdcom_lookup(prtd, DRV_NAME);
>  	struct audio_drv_data *intr_data = dev_get_drvdata(component-
> >dev);
> +	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(prtd->cpu_dai);
>  	struct audio_substream_data *adata =
>  		kzalloc(sizeof(struct audio_substream_data), GFP_KERNEL);
>  	if (adata == NULL)
> @@ -710,7 +711,21 @@ static int acp_dma_open(struct snd_pcm_substream
> *substream)
>  		default:
>  			runtime->hw = acp_pcm_hardware_playback;
>  		}
> +		adata->i2s_play_instance = dev->i2s_instance;
> +		if (adata->i2s_play_instance == I2S_SP_INSTANCE)
> +			adata->i2ssp_renderbytescount = 0;
> +		else if (adata->i2s_play_instance == I2S_BT_INSTANCE)
> +			adata->i2sbt_renderbytescount = 0;
> +		else
> +			return -EINVAL;
>  	} else {
> +		adata->i2s_capture_instance = dev->i2s_instance;
> +		if (adata->i2s_capture_instance == I2S_SP_INSTANCE)
> +			adata->i2ssp_capturebytescount = 0;
> +		else if (adata->i2s_capture_instance == I2S_BT_INSTANCE)
> +			adata->i2sbt_capturebytescount = 0;
> +		else
> +			return -EINVAL;
>  		switch (intr_data->asic_type) {
>  		case CHIP_STONEY:
>  			runtime->hw = acp_st_pcm_hardware_capture; @@
> -736,11 +751,20 @@ static int acp_dma_open(struct snd_pcm_substream
> *substream)
>  	 * This enablement is not required for another stream, if current
>  	 * stream is not closed
>  	*/
> -	if (!intr_data->play_i2ssp_stream && !intr_data-
> >capture_i2ssp_stream)
> +	if (!intr_data->play_i2ssp_stream && !intr_data-
> >capture_i2ssp_stream &&
> +		!intr_data->play_i2sbt_stream &&
> +		!intr_data->capture_i2sbt_stream)
>  		acp_reg_write(1, adata->acp_mmio,
> mmACP_EXTERNAL_INTR_ENB);
> 
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -		intr_data->play_i2ssp_stream = substream;
> +		switch (adata->i2s_play_instance) {
> +		case I2S_BT_INSTANCE:
> +			intr_data->play_i2sbt_stream = substream;
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			intr_data->play_i2ssp_stream = substream;
> +		}
>  		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
>  		 * won't be turned off. The default state for SRAM banks is
> ON.
>  		 * Setting SRAM bank state code skipped for STONEY
> platform.
> @@ -751,7 +775,14 @@ static int acp_dma_open(struct snd_pcm_substream
> *substream)
>  							bank, true);
>  		}
>  	} else {
> -		intr_data->capture_i2ssp_stream = substream;
> +		switch (adata->i2s_capture_instance) {
> +		case I2S_BT_INSTANCE:
> +			intr_data->capture_i2sbt_stream = substream;
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			intr_data->capture_i2ssp_stream = substream;
> +		}
>  		if (intr_data->asic_type != CHIP_STONEY) {
>  			for (bank = 5; bank <= 8; bank++)
>  				acp_set_sram_bank_state(intr_data-
> >acp_mmio,
> @@ -1010,34 +1041,49 @@ static int acp_dma_close(struct
> snd_pcm_substream *substream)
>  	struct snd_soc_component *component =
> snd_soc_rtdcom_lookup(prtd, DRV_NAME);
>  	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
> 
> -	kfree(rtd);
> -
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -		adata->play_i2ssp_stream = NULL;
> -		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
> -		 * won't be turned off. The default state for SRAM banks is
> ON.
> -		 * Setting SRAM bank state code skipped for STONEY
> platform.
> -		 * added condition checks for Carrizo platform only
> -		 */
> -		if (adata->asic_type != CHIP_STONEY) {
> -			for (bank = 1; bank <= 4; bank++)
> -				acp_set_sram_bank_state(adata-
> >acp_mmio, bank,
> -				false);
> +		switch (rtd->i2s_play_instance) {
> +		case I2S_BT_INSTANCE:
> +			adata->play_i2sbt_stream = NULL;
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			adata->play_i2ssp_stream = NULL;
> +			/* For Stoney, Memory gating is disabled,i.e SRAM
> Banks
> +			 * won't be turned off. The default state for SRAM
> banks
> +			 * is ON.Setting SRAM bank state code skipped for
> STONEY
> +			 * platform.Added condition checks for Carrizo
> platform
> +			 * only.
> +			 */
> +			if (adata->asic_type != CHIP_STONEY) {
> +				for (bank = 1; bank <= 4; bank++)
> +					acp_set_sram_bank_state(adata-
> >acp_mmio,
> +							bank, false);
> +			}
>  		}
>  	} else  {
> -		adata->capture_i2ssp_stream = NULL;
> -		if (adata->asic_type != CHIP_STONEY) {
> -			for (bank = 5; bank <= 8; bank++)
> -				acp_set_sram_bank_state(adata-
> >acp_mmio, bank,
> -						     false);
> +		switch (rtd->i2s_capture_instance) {
> +		case I2S_BT_INSTANCE:
> +			adata->capture_i2sbt_stream = NULL;
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			adata->capture_i2ssp_stream = NULL;
> +			if (adata->asic_type != CHIP_STONEY) {
> +				for (bank = 5; bank <= 8; bank++)
> +					acp_set_sram_bank_state(adata-
> >acp_mmio,
> +							bank, false);
> +			}
>  		}
>  	}
> 
>  	/* Disable ACP irq, when the current stream is being closed and
>  	 * another stream is also not active.
> -	*/
> -	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
> +	 */
> +	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream &&
> +		!adata->play_i2sbt_stream && !adata-
> >capture_i2sbt_stream)
>  		acp_reg_write(0, adata->acp_mmio,
> mmACP_EXTERNAL_INTR_ENB);
> +	kfree(rtd);
> 
>  	return 0;
>  }
> @@ -1089,6 +1135,8 @@ static int acp_audio_probe(struct platform_device
> *pdev)
> 
>  	audio_drv_data->play_i2ssp_stream = NULL;
>  	audio_drv_data->capture_i2ssp_stream = NULL;
> +	audio_drv_data->play_i2sbt_stream = NULL;
> +	audio_drv_data->capture_i2sbt_stream = NULL;
> 
>  	audio_drv_data->asic_type =  *pdata;
> 
> @@ -1177,6 +1225,20 @@ static int acp_pcm_resume(struct device *dev)
>  			adata->capture_i2ssp_stream->runtime-
> >private_data,
>  			adata->asic_type);
>  	}
> +	if (adata->asic_type != CHIP_CARRIZO) {
> +		if (adata->play_i2sbt_stream &&
> +			adata->play_i2sbt_stream->runtime) {
> +			config_acp_dma(adata->acp_mmio,
> +				adata->play_i2sbt_stream->runtime-
> >private_data,
> +				adata->asic_type);
> +		}
> +		if (adata->capture_i2sbt_stream &&
> +			adata->capture_i2sbt_stream->runtime) {
> +			config_acp_dma(adata->acp_mmio,
> +				adata->capture_i2sbt_stream->runtime-
> >private_data,
> +				adata->asic_type);
> +		}
> +	}
>  	acp_reg_write(1, adata->acp_mmio,
> mmACP_EXTERNAL_INTR_ENB);
>  	return 0;
>  }
> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h index
> ba01510..8bc78cc 100644
> --- a/sound/soc/amd/acp.h
> +++ b/sound/soc/amd/acp.h
> @@ -4,6 +4,8 @@
> 
>  #include "include/acp_2_2_d.h"
>  #include "include/acp_2_2_sh_mask.h"
> +#include <sound/designware_i2s.h>
> +#include "../dwc/local.h"
> 
>  #define ACP_PAGE_SIZE_4K_ENABLE			0x02
> 
> @@ -72,6 +74,8 @@
>  #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
>  #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
>  #define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
> +#define I2S_SP_INSTANCE 1
> +#define I2S_BT_INSTANCE 2

Please add the defines for I2S_SP_INSTANCE and I2S_BT_INSTANCE to the dws platform data header so you don't have to define them locally here.
With that fixed, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>  enum acp_dma_priority_level {
>  	/* 0x0 Specifies the DMA channel is given normal priority */
>  	ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
> @@ -88,12 +92,18 @@ struct audio_substream_data {
>  	uint64_t size;
>  	u64 i2ssp_renderbytescount;
>  	u64 i2ssp_capturebytescount;
> +	u64 i2sbt_renderbytescount;
> +	u64 i2sbt_capturebytescount;
>  	void __iomem *acp_mmio;
> +	u16 i2s_play_instance;
> +	u16 i2s_capture_instance;
>  };
> 
>  struct audio_drv_data {
>  	struct snd_pcm_substream *play_i2ssp_stream;
>  	struct snd_pcm_substream *capture_i2ssp_stream;
> +	struct snd_pcm_substream *play_i2sbt_stream;
> +	struct snd_pcm_substream *capture_i2sbt_stream;
>  	void __iomem *acp_mmio;
>  	u32 asic_type;
>  };
> --
> 2.7.4
