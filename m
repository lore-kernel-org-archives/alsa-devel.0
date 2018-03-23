From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH V2] ASoC: dwc: I2S Controller instance
	param added
Date: Fri, 23 Mar 2018 11:23:23 +0530
Message-ID: <7239a5b3-2e46-a3a8-9823-6f1f69b46978@amd.com>
References: <1521529942-21262-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0083.outbound.protection.outlook.com [104.47.33.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 264DF267282
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 06:51:33 +0100 (CET)
In-Reply-To: <1521529942-21262-1-git-send-email-Vijendar.Mukunda@amd.com>
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
To: broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz
Cc: tiwai@suse.de, lgirdwood@gmail.com, Akshu.Agrawal@amd.com
List-Id: alsa-devel@alsa-project.org



On Tuesday 20 March 2018 12:42 PM, Vijendar Mukunda wrote:
> When multiple I2S controller instances created,
> i2s_instance parameter refers to i2s controller instance value.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> v1->v2: defined I2S instance macros in designware header file
>   include/sound/designware_i2s.h | 6 ++++++
>   sound/soc/dwc/dwc-i2s.c        | 1 +
>   sound/soc/dwc/local.h          | 1 +
>   3 files changed, 8 insertions(+)
> 
> diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
> index 830f5ca..8113759 100644
> --- a/include/sound/designware_i2s.h
> +++ b/include/sound/designware_i2s.h
> @@ -44,6 +44,10 @@ struct i2s_platform_data {
>   	int channel;
>   	u32 snd_fmts;
>   	u32 snd_rates;
> +	/* i2s_instance parameter returns I2S controller instance value
> +	 * when multiple I2S controllers instantiated
> +	 */
> +	u32 i2s_instance;
>   
>   	#define DW_I2S_QUIRK_COMP_REG_OFFSET	(1 << 0)
>   	#define DW_I2S_QUIRK_COMP_PARAM1	(1 << 1)
> @@ -74,5 +78,7 @@ struct i2s_dma_data {
>   #define FOUR_CHANNEL_SUPPORT	4	/* up to 3.1 */
>   #define SIX_CHANNEL_SUPPORT	6	/* up to 5.1 */
>   #define EIGHT_CHANNEL_SUPPORT	8	/* up to 7.1 */
> +#define I2S_SP_INSTANCE		1
> +#define I2S_BT_INSTANCE		2
>   
>   #endif /*  __SOUND_DESIGNWARE_I2S_H */
> diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
> index e27e21f..20145c0 100644
> --- a/sound/soc/dwc/dwc-i2s.c
> +++ b/sound/soc/dwc/dwc-i2s.c
> @@ -549,6 +549,7 @@ static int dw_configure_dai_by_pd(struct dw_i2s_dev *dev,
>   
>   	if (dev->quirks & DW_I2S_QUIRK_16BIT_IDX_OVERRIDE)
>   		idx = 1;
> +	dev->i2s_instance = pdata->i2s_instance;
>   	/* Set DMA slaves info */
>   	dev->play_dma_data.pd.data = pdata->play_dma_data;
>   	dev->capture_dma_data.pd.data = pdata->capture_dma_data;
> diff --git a/sound/soc/dwc/local.h b/sound/soc/dwc/local.h
> index 91dc70a..e89e464 100644
> --- a/sound/soc/dwc/local.h
> +++ b/sound/soc/dwc/local.h
> @@ -98,6 +98,7 @@ struct dw_i2s_dev {
>   	u32 ccr;
>   	u32 xfer_resolution;
>   	u32 fifo_th;
> +	u32 i2s_instance;
>   
>   	/* data related to DMA transfers b/w i2s and DMAC */
>   	union dw_i2s_snd_dma_data play_dma_data;
> 

Hi Mark,

Could you please review the patch.

Thanks,
Vijendar
