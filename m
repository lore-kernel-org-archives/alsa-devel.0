From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: avoid Oops if DMA setup fails
Date: Fri, 26 Apr 2019 16:03:47 -0500
Message-ID: <0b030b85-00c8-2e35-3064-bb764aaff0f6@linux.intel.com>
References: <20190426164740.211139-1-zwisler@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190426164740.211139-1-zwisler@google.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org
Cc: Ross Zwisler <zwisler@google.com>, Jaroslav Kysela <perex@perex.cz>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 4/26/19 11:47 AM, Ross Zwisler wrote:
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
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> Cc: stable@vger.kernel.org
> ---
>   sound/soc/intel/common/sst-firmware.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
> index 1e067504b6043..9be3a793a55e3 100644
> --- a/sound/soc/intel/common/sst-firmware.c
> +++ b/sound/soc/intel/common/sst-firmware.c
> @@ -1251,11 +1251,15 @@ struct sst_dsp *sst_dsp_new(struct device *dev,
>   		goto irq_err;
>   
>   	err = sst_dma_new(sst);
> -	if (err)
> +	if (err)  {
>   		dev_warn(dev, "sst_dma_new failed %d\n", err);
> +		goto dma_err;
> +	}

Thanks for the patch.
The fix looks correct, but does it make sense to keep a dev_warn() here? 
Should it be changed to dev_err() instead since as you mentioned it's 
fatal to keep going.
Also you may want to mention in the commit message that this should only 
impact Broadwell and maybe the legacy Baytrail driver. IIRC we don't use 
the DMAs in other cases.

>   
>   	return sst;
>   
> +dma_err:
> +	free_irq(sst->irq, sst);
>   irq_err:
>   	if (sst->ops->free)
>   		sst->ops->free(sst);
> 
