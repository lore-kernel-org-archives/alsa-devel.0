From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: sst: remove redundant variable
 dma_dev_name
Date: Thu, 19 Oct 2017 11:33:29 -0500
Message-ID: <2e0d8b0e-a778-a2c5-45a2-dbef62d40a8b@linux.intel.com>
References: <20171019123352.30294-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019123352.30294-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 10/19/2017 07:33 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer dma_dev_name is assigned but never read, it is redundant
> and can therefore be removed.
>
> Cleans up clang warning:
> sound/soc/intel/common/sst-firmware.c:288:3: warning: Value stored to
> 'dma_dev_name' is never read
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Indeed this has been unused since at least 2015...
FWIW
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/common/sst-firmware.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
> index a086c35f91bb..79a9fdf94d38 100644
> --- a/sound/soc/intel/common/sst-firmware.c
> +++ b/sound/soc/intel/common/sst-firmware.c
> @@ -274,7 +274,6 @@ int sst_dma_new(struct sst_dsp *sst)
>   	struct sst_pdata *sst_pdata = sst->pdata;
>   	struct sst_dma *dma;
>   	struct resource mem;
> -	const char *dma_dev_name;
>   	int ret = 0;
>   
>   	if (sst->pdata->resindex_dma_base == -1)
> @@ -285,7 +284,6 @@ int sst_dma_new(struct sst_dsp *sst)
>   	* is attached to the ADSP IP. */
>   	switch (sst->pdata->dma_engine) {
>   	case SST_DMA_TYPE_DW:
> -		dma_dev_name = "dw_dmac";
>   		break;
>   	default:
>   		dev_err(sst->dev, "error: invalid DMA engine %d\n",
