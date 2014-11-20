From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel][PATCH v2 1/2] ASoC: wm8960: Add device tree support
Date: Thu, 20 Nov 2014 09:56:34 +0100
Message-ID: <546DACC2.702@metafoo.de>
References: <1416472878-12108-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416472878-12108-1-git-send-email-b50113@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <b50113@freescale.com>, broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/20/2014 09:41 AM, Zidan Wang wrote:
[...][
> +Optional properties:
> +  - shared_lrclk: This is a boolean property. If present, the LRCM bit of
> +	R24 (Additional control 2 ) gets set, indicating that ADCLRC and DACLRC
> +	will be disabled only when ADC (Left and Right) and DAC (Left and Right)
> +	are disabled.
> +
> +  - capless: This is a boolean property. If present, OUT3 will be enabled
> +	and disabled together with HP_L and HP_R in response to jack detect events.


Custom properties need a vendor prefix and properties should use '-' instead 
of '_'. Also the devicetree describes the hardware and not the driver, so 
the description should say for which hardware setups this flag should be 
set, not what the behavior of the driver will be.

- Lars
