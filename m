From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: jz4740: Add jz4780 support
Date: Sat, 07 Mar 2015 09:21:36 +0100
Message-ID: <54FAB510.90304@metafoo.de>
References: <1425655991-12468-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425655991-12468-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 03/06/2015 04:33 PM, Zubair Lutfullah Kakakhel wrote:
> The jz4780 and jz4740 have very similar i2s blocks.
>
> The slight difference is in Rx/Tx fifos.
> And the bitclocks for input/output are different.
>
> This patch adds jz4780 support to the driver
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Looks mostly good.
[...]
>   static inline uint32_t jz4740_i2s_read(const struct jz4740_i2s *i2s,
> @@ -267,13 +283,22 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
>   			ctrl |= JZ_AIC_CTRL_MONO_TO_STEREO;
>   		else
>   			ctrl &= ~JZ_AIC_CTRL_MONO_TO_STEREO;
> +
> +		div_reg &= ~I2SDIV_DV_MASK;
> +		div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
>   	} else {
>   		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
>   		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
> +
> +		if (i2s->version >= JZ_I2S_JZ4780) {
> +			div_reg &= ~I2SDIV_IDV_MASK;
> +			div_reg |= (div - 1) << I2SDIV_IDV_SHIFT;
> +		} else {
> +			div_reg &= ~I2SDIV_DV_MASK;
> +			div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
> +		}
>   	}

Given that the JZ4780 supports different rates for TX and RX in this 
configuration you can also remove the symmetric_rates flag from the DAI 
struct, so applications can actually make use of it.

>
> -	div_reg &= ~I2SDIV_DV_MASK;
> -	div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
>   	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
>   	jz4740_i2s_write(i2s, JZ_REG_AIC_CLK_DIV, div_reg);
>
[...]
> +	if (i2s->version >= JZ_I2S_JZ4780)
> +		return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL,
> +			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);

We should not be adding new users of SND_DMAENGINE_PCM_FLAG_NO_RESIDUE, this 
is a property of the DMA controller/driver and the DMAengine framework now 
has the capabilities to report on whether it supports residue reporting or not.
