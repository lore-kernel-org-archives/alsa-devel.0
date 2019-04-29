From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: avoid Oops if DMA setup fails
Date: Mon, 29 Apr 2019 13:45:46 -0500
Message-ID: <951de893-e6ff-5bd0-3483-4c1d93b30cfc@linux.intel.com>
References: <20190429182517.210909-1-zwisler@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190429182517.210909-1-zwisler@google.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org
Cc: Ross Zwisler <zwisler@google.com>, Jaroslav Kysela <perex@perex.cz>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 4/29/19 1:25 PM, Ross Zwisler wrote:
> Currently in sst_dsp_new() if we get an error return from sst_dma_new()
> we just print an error message and then still complete the function
> successfully.  This means that we are trying to run without sst->dma
> properly set up, which will result in NULL pointer dereference when
> sst->dma is later used.  This was happening for me in
> sst_dsp_dma_get_channel():
> 
>          struct sst_dma *dma = dsp->dma;
> 	...
>          dma->ch = dma_request_channel(mask, dma_chan_filter, dsp);
> 
> This resulted in:
> 
>     BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
>     IP: sst_dsp_dma_get_channel+0x4f/0x125 [snd_soc_sst_firmware]
> 
> Fix this by adding proper error handling for the case where we fail to
> set up DMA.
> 
> This change only affects Haswell and Broadwell systems.  Baytrail
> systems explicilty opt-out of DMA via sst->pdata->resindex_dma_base
> being set to -1.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> Cc: stable@vger.kernel.org

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Ross!

FWIW we should start deprecating this driver now and transition to SOF. 
I'll double-check how the upcoming 1.3 release works on my Pixel 
2015/Samus device later this week.


> ---
> 
> Changes in v2:
>   - Upgraded the sst_dma_new() failure message from dev_warn() to dev_err()
>     (Pierre-Louis).
>   - Noted in the changelog that this change only affects Haswell and
>     Broadwell (Pierre-Louis).
> 
> ---
>   sound/soc/intel/common/sst-firmware.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
> index 1e067504b6043..f830e59f93eaa 100644
> --- a/sound/soc/intel/common/sst-firmware.c
> +++ b/sound/soc/intel/common/sst-firmware.c
> @@ -1251,11 +1251,15 @@ struct sst_dsp *sst_dsp_new(struct device *dev,
>   		goto irq_err;
>   
>   	err = sst_dma_new(sst);
> -	if (err)
> -		dev_warn(dev, "sst_dma_new failed %d\n", err);
> +	if (err)  {
> +		dev_err(dev, "sst_dma_new failed %d\n", err);
> +		goto dma_err;
> +	}
>   
>   	return sst;
>   
> +dma_err:
> +	free_irq(sst->irq, sst);
>   irq_err:
>   	if (sst->ops->free)
>   		sst->ops->free(sst);
> 
