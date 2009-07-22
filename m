From: "chaithrika" <chaithrika@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Enable PLL when not
	bypassed
Date: Wed, 22 Jul 2009 18:40:26 +0530
Message-ID: <020001ca0acd$c75684f0$56038ed0$@com>
References: <1248263104-12142-1-git-send-email-chaithrika@ti.com>
	<7A436F7769CA33409C6B44B358BFFF0C011E89804C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id A38E7103908
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 15:11:21 +0200 (CEST)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C011E89804C@dlee02.ent.ti.com>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "'Mani, Arun'" <avm@ti.com>, alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 22, 2009 at 18:09:58, Mani, Arun wrote:
> Hi Chaithrika,
> Do you know why it worked in dm644x. I don't see any specific path taken
for the DM644x.
> 

On DM644x EVM the MCLK frequency is different when compared
to DM646x and DM355 EVM. Also, some sample frequencies bypass the
PLL and will work fine. However for example in the case of 44100Hz
sampling rate, the PLL should be used but was not enabled and the 
playback is slightly faster: a 60s audio file plays in about 56s.
With this patch applied the playback seems to be correct.

Regards, 
Chaithrika
 
> Arun
> 
> -----Original Message-----
> From: davinci-linux-open-source-bounces@linux.davincidsp.com
[mailto:davinci-linux-open-source-bounces@linux.davincidsp.com] On Behalf Of
Subrahmanya, Chaithrika
> Sent: Wednesday, July 22, 2009 7:45 AM
> To: alsa-devel@alsa-project.org
> Cc: davinci-linux-open-source@linux.davincidsp.com;
broonie@opensource.wolfsonmicro.com
> Subject: [PATCH] ASoC: tlv320aic3x: Enable PLL when not bypassed
> 
> PLL was not being enabled when it was not bypassed. This patch
> enables the PLL when it is used. Additionally, it disables the PLL
> when it is bypassed.
> 
> Without this patch, the audio on TI DM646x EVM and DM355 EVM
> does not work properly. The bit clocks and the frame sync signals
> from the codec are not correct and hence the playback/record are faster
> than usual for most sample rates. The reason for this was that the PLL
> was not enabled when it was not bypassed.
> 
> Tested on DM6467 EVM, playback tested on DM355 EVM.
> 
> Signed-off-by: Chaithrika U S <chaithrika@ti.com>
> ---
> Applies to master branch of ALSA GIT tree at
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=summary
> 
>  sound/soc/codecs/tlv320aic3x.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320aic3x.c
b/sound/soc/codecs/tlv320aic3x.c
> index ab099f4..cb0d1bf 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -767,6 +767,7 @@ static int aic3x_hw_params(struct snd_pcm_substream
*substream,
>  	int codec_clk = 0, bypass_pll = 0, fsref, last_clk = 0;
>  	u8 data, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1;
>  	u16 pll_d = 1;
> +	u8 reg;
>  
>  	/* select data word length */
>  	data =
> @@ -801,8 +802,16 @@ static int aic3x_hw_params(struct snd_pcm_substream
*substream,
>  		pll_q &= 0xf;
>  		aic3x_write(codec, AIC3X_PLL_PROGA_REG, pll_q <<
PLLQ_SHIFT);
>  		aic3x_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_CLKDIV);
> -	} else
> +		/* disable PLL if it is bypassed */
> +		reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
> +		aic3x_write(codec, AIC3X_PLL_PROGA_REG, reg & ~PLL_ENABLE);
> +
> +	} else {
>  		aic3x_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_PLLDIV);
> +		/* enable PLL when it is used */
> +		reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
> +		aic3x_write(codec, AIC3X_PLL_PROGA_REG, reg | PLL_ENABLE);
> +	}
>  
>  	/* Route Left DAC to left channel input and
>  	 * right DAC to right channel input */
> -- 
> 1.5.6
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source@linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
