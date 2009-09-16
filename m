From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DaVinci: Fixes to McASP configuration
Date: Wed, 16 Sep 2009 21:18:19 +0100
Message-ID: <20090916201819.GB20675@rakim.wolfsonmicro.main>
References: <1253052809-24547-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BE1781038A4
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 22:18:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253052809-24547-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 15, 2009 at 06:13:29PM -0400, Chaithrika U S wrote:
> McASP register settings are not correct for DSP mode of operation.
> There is a channel swap initally. This patch provides fixes to
> the register values for proper working.

Adding Troy since he's been looking at some L/R swap issues.  Does this
only apply in DSP mode or does it affect all modes (your commit message
isn't terribly clear on that one)?

> Tested on DA830/OMAP-L137 EVM, DM6467 EVM.

> Signed-off-by: Chaithrika U S <chaithrika@ti.com>

> Applies to ALSA GIT tree on branch topic/asoc at
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;
> h=topic/asoc
> 
>  sound/soc/davinci/davinci-mcasp.c |   24 ++++++++++++++++++++++--
>  1 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index eca22d7..7a06c0a 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -512,34 +512,49 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
>  				       int channel_size)
>  {
>  	u32 fmt = 0;
> +	u32 mask, rotate;
>  
>  	switch (channel_size) {
>  	case DAVINCI_AUDIO_WORD_8:
>  		fmt = 0x03;
> +		rotate = 6;
> +		mask = 0x000000ff;
>  		break;
>  
>  	case DAVINCI_AUDIO_WORD_12:
>  		fmt = 0x05;
> +		rotate = 5;
> +		mask = 0x00000fff;
>  		break;
>  
>  	case DAVINCI_AUDIO_WORD_16:
>  		fmt = 0x07;
> +		rotate = 4;
> +		mask = 0x0000ffff;
>  		break;
>  
>  	case DAVINCI_AUDIO_WORD_20:
>  		fmt = 0x09;
> +		rotate = 3;
> +		mask = 0x000fffff;
>  		break;
>  
>  	case DAVINCI_AUDIO_WORD_24:
>  		fmt = 0x0B;
> +		rotate = 2;
> +		mask = 0x00ffffff;
>  		break;
>  
>  	case DAVINCI_AUDIO_WORD_28:
>  		fmt = 0x0D;
> +		rotate = 1;
> +		mask = 0x0fffffff;
>  		break;
>  
>  	case DAVINCI_AUDIO_WORD_32:
>  		fmt = 0x0F;
> +		rotate = 0;
> +		mask = 0xffffffff;
>  		break;
>  
>  	default:
> @@ -550,6 +565,13 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
>  					RXSSZ(fmt), RXSSZ(0x0F));
>  	mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
>  					TXSSZ(fmt), TXSSZ(0x0F));
> +	mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXROT(rotate),
> +							TXROT(7));
> +	mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, RXROT(rotate),
> +							RXROT(7));
> +	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);
> +	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG, mask);
> +
>  	return 0;
>  }
>  
> @@ -638,7 +660,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
>  			printk(KERN_ERR "playback tdm slot %d not supported\n",
>  				dev->tdm_slots);
>  
> -		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, 0xFFFFFFFF);
>  		mcasp_clr_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
>  	} else {
>  		/* bit stream is MSB first with no delay */
> @@ -655,7 +676,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
>  			printk(KERN_ERR "capture tdm slot %d not supported\n",
>  				dev->tdm_slots);
>  
> -		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG, 0xFFFFFFFF);
>  		mcasp_clr_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
>  	}
>  }
> -- 
> 1.5.6
> 
