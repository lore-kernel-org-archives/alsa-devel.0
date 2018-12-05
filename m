From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 2/2] ASoC: use dma_ops of parent device for
	acp_audio_dma
Date: Wed, 5 Dec 2018 06:45:59 +0000
Message-ID: <cc34f15e-c8a3-da32-4a61-a6c34bed8281@amd.com>
References: <20181204224253.216075-1-yuzhao@google.com>
 <20181204224253.216075-2-yuzhao@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800085.outbound.protection.outlook.com [40.107.80.85])
 by alsa0.perex.cz (Postfix) with ESMTP id A3197267B92
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 07:46:03 +0100 (CET)
In-Reply-To: <20181204224253.216075-2-yuzhao@google.com>
Content-Language: en-US
Content-ID: <79023FCB5CE2AD42A6B87E2AFFB67F79@namprd12.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yu Zhao <yuzhao@google.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, aroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org



On 05/12/18 4:12 AM, Yu Zhao wrote:
> AMD platform device acp_audio_dma can only be created by parent PCI
> device driver (drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c). Pass struct
> device of the parent to snd_pcm_lib_preallocate_pages() so
> dma_alloc_coherent() can use correct dma_ops. Otherwise, it will
> use default dma_ops which is nommu_dma_ops on x86_64 even when
> IOMMU is enabled and set to non passthrough mode.
> 
> Though platform device inherits some dma related fields during its
> creation in mfd_add_device(), we can't simply pass its struct device
> to snd_pcm_lib_preallocate_pages() because dma_ops is not among the
> inherited fields. Even it were, drivers/iommu/amd_iommu.c would
> ignore it because get_device_id() doesn't handle platform device.
> 
> This change shouldn't give us any trouble even struct device of the
> parent becomes null or represents some non PCI device in the future,
> because get_dma_ops() correctly handles null struct device or uses
> the default dma_ops if struct device doesn't have it set.
> 

This is really a good fix. We will also apply this fix for Raven platform.

Thanks,
Vijendar
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>   sound/soc/amd/acp-pcm-dma.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index fd3db4c37882..f4011bebc7ec 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -1146,18 +1146,21 @@ static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
>   	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
>   								    DRV_NAME);
>   	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
> +	struct device *parent = component->dev->parent;
>   
>   	switch (adata->asic_type) {
>   	case CHIP_STONEY:
>   		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
>   							    SNDRV_DMA_TYPE_DEV,
> -							    NULL, ST_MIN_BUFFER,
> +							    parent,
> +							    ST_MIN_BUFFER,
>   							    ST_MAX_BUFFER);
>   		break;
>   	default:
>   		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
>   							    SNDRV_DMA_TYPE_DEV,
> -							    NULL, MIN_BUFFER,
> +							    parent,
> +							    MIN_BUFFER,
>   							    MAX_BUFFER);
>   		break;
>   	}
> 
