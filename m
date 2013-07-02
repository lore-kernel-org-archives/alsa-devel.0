From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: atmel-pcm: use generic dmaengine
 framework
Date: Tue, 02 Jul 2013 17:34:30 +0200
Message-ID: <51D2F306.7040603@metafoo.de>
References: <1372755849-19546-1-git-send-email-voice.shen@atmel.com> <1372755849-19546-3-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1372755849-19546-3-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, richard.genoud@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 07/02/2013 11:04 AM, Bo Shen wrote:
[...]
> -/*--------------------------------------------------------------------------*\
> - * DMAENGINE operations
> -\*--------------------------------------------------------------------------*/
> -static bool filter(struct dma_chan *chan, void *slave)
> -{
> -	struct at_dma_slave *sl = slave;
> -
> -	if (sl->dma_dev == chan->device->dev) {
> -		chan->private = sl;
> -		return true;
> -	} else {
> -		return false;
> -	}
> -}

I'm wondering why is filtering no longer required?

[...]
> +		slave_config->dst_addr = (dma_addr_t)ssc->phybase + SSC_THR;
[...]
> +		slave_config->src_addr = (dma_addr_t)ssc->phybase + SSC_RHR;

Change the type of phybase to dma_addr_t

[...]
>  }
>  
> -static int atmel_pcm_dma_prepare(struct snd_pcm_substream *substream)
> -{
> -	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct atmel_pcm_dma_params *prtd;
> -
> -	prtd = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> -
> -	ssc_writex(prtd->ssc->regs, SSC_IER, prtd->mask->ssc_error);
> -	ssc_writex(prtd->ssc->regs, SSC_CR, prtd->mask->ssc_enable);

These writes are also completely lost

> -
> -	return 0;
> -}

I think it would also be good to get rid of any references to the ssc struct
from the DMA driver and move them over to the DAI driver.

- Lars
