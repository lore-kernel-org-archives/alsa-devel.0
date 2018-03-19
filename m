From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] ASoC: dwc: I2S Controller instance param
	added
Date: Mon, 19 Mar 2018 14:39:24 +0000
Message-ID: <BN6PR12MB18098B7AD50A9A9405AF6CFFF7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1521441332-18821-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0058.outbound.protection.outlook.com [104.47.34.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F1A6266F2E
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 15:39:28 +0100 (CET)
In-Reply-To: <1521441332-18821-1-git-send-email-Vijendar.Mukunda@amd.com>
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
To: "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "perex@perex.cz" <perex@perex.cz>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Agrawal,
 Akshu" <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Vijendar Mukunda [mailto:Vijendar.Mukunda@amd.com]
> Sent: Monday, March 19, 2018 2:36 AM
> To: broonie@kernel.org; alsa-devel@alsa-project.org; perex@perex.cz
> Cc: lgirdwood@gmail.com; tiwai@suse.de; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Agrawal, Akshu
> <Akshu.Agrawal@amd.com>; Mukunda, Vijendar
> <Vijendar.Mukunda@amd.com>
> Subject: [PATCH] ASoC: dwc: I2S Controller instance param added
> 
> When multiple I2S controller instances created, i2s_instance parameter
> refers to i2s controller instance value.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  include/sound/designware_i2s.h | 4 ++++
>  sound/soc/dwc/dwc-i2s.c        | 1 +
>  sound/soc/dwc/local.h          | 1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/include/sound/designware_i2s.h
> b/include/sound/designware_i2s.h index 830f5ca..2a94e7c 100644
> --- a/include/sound/designware_i2s.h
> +++ b/include/sound/designware_i2s.h
> @@ -44,6 +44,10 @@ struct i2s_platform_data {
>  	int channel;
>  	u32 snd_fmts;
>  	u32 snd_rates;
> +	/* i2s_instance parameter returns I2S controller instance value
> +	 * when multiple I2S controllers instantiated
> +	 */
> +	u32 i2s_instance;

Please add the defines for I2S_SP_INSTANCE and I2S_BT_INSTANCE to this header so you don't have to define them locally in the other patches.
With that fixed, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> 
>  	#define DW_I2S_QUIRK_COMP_REG_OFFSET	(1 << 0)
>  	#define DW_I2S_QUIRK_COMP_PARAM1	(1 << 1)
> diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c index
> e27e21f..20145c0 100644
> --- a/sound/soc/dwc/dwc-i2s.c
> +++ b/sound/soc/dwc/dwc-i2s.c
> @@ -549,6 +549,7 @@ static int dw_configure_dai_by_pd(struct dw_i2s_dev
> *dev,
> 
>  	if (dev->quirks & DW_I2S_QUIRK_16BIT_IDX_OVERRIDE)
>  		idx = 1;
> +	dev->i2s_instance = pdata->i2s_instance;
>  	/* Set DMA slaves info */
>  	dev->play_dma_data.pd.data = pdata->play_dma_data;
>  	dev->capture_dma_data.pd.data = pdata->capture_dma_data; diff -
> -git a/sound/soc/dwc/local.h b/sound/soc/dwc/local.h index
> 91dc70a..e89e464 100644
> --- a/sound/soc/dwc/local.h
> +++ b/sound/soc/dwc/local.h
> @@ -98,6 +98,7 @@ struct dw_i2s_dev {
>  	u32 ccr;
>  	u32 xfer_resolution;
>  	u32 fifo_th;
> +	u32 i2s_instance;
> 
>  	/* data related to DMA transfers b/w i2s and DMAC */
>  	union dw_i2s_snd_dma_data play_dma_data;
> --
> 2.7.4
