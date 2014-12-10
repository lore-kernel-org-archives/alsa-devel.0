From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] sound/soc/adi/axi-spdif.c: Support programmable master
 clock
Date: Wed, 10 Dec 2014 10:34:36 +0100
Message-ID: <548813AC.1080105@metafoo.de>
References: <54806D4E.8040504@topic.nl> <1417783029-22492-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417783029-22492-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/05/2014 01:37 PM, Mike Looijmans wrote:
> If the master clock supports programmable rates, program it to generate
> the desired frequency. Only apply constraints when the clock is fixed.
> This allows proper clock generation for both 44100 and 48000 Hz based
> sampling rates if the platform supports it.
>
> The clock frequency must be set before enabling it. Enabling the clock
> was done in "startup", but that occurs before "hw_params" where the rate
> is known. Enabling a programmable clock without first setting a valid
> frequency may harm the system. Move the clock start to the hw_params
> routine, and keep track of whether the clock has been started, because
> shutdown may be called without having called hw_params first.
> Starting the clock and enabling the SPDIF output AFTER programming the
> dividers is a more logical order anyway.
>
> To detect if the source clock is fixed, the driver calls clk_round_rate
> for two frequencies. If the results are equal, or if the call returns
> an error, the driver assumes the clock is fixed.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Hi,

Sorry for the delay.

[...]
>
> +	/* Try to set the master clock */
> +	clk_set_rate(spdif->clk_ref, rate * 128);
> +
>   	clkdiv = DIV_ROUND_CLOSEST(clk_get_rate(spdif->clk_ref),
>   			rate * 64 * 2) - 1;
>   	clkdiv <<= AXI_SPDIF_CTRL_CLKDIV_OFFSET;
> @@ -103,6 +108,14 @@ static int axi_spdif_hw_params(struct snd_pcm_substream *substream,
>   	regmap_update_bits(spdif->regmap, AXI_SPDIF_REG_CTRL,
>   		AXI_SPDIF_CTRL_CLKDIV_MASK, clkdiv);
>
> +	ret = clk_prepare_enable(spdif->clk_ref);

I'm still not convinced this is the right place. I do see your point. But it 
just feels wrong to enable the clock in hw_params. It's a bit of a dilemma. 
the startup callback is to early, hw_params is the wrong place and we can't 
put it in the trigger callback as the trigger callback can not sleep.

But in any way hwparmas can be called multiple times, so you need to handle 
the case where the clock is already enabled.

> +	if (ret)
> +		return ret;
> +	spdif->clk_ref_running = true;
> +
> +	regmap_update_bits(spdif->regmap, AXI_SPDIF_REG_CTRL,
> +		AXI_SPDIF_CTRL_TXEN, AXI_SPDIF_CTRL_TXEN);

This should probably be moved to the trigger callback though.

> +
>   	return 0;
>   }
