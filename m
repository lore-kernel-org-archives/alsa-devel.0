From: Daniel Mack <zonque@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/2] ALSA: ASoc: davinci-mcasp: Add Support
 BCLK-to-LRCLK ratio for TDM modes
Date: Fri, 19 Apr 2013 19:38:01 +0200
Message-ID: <517180F9.8060601@gmail.com>
References: <1366378124-14368-1-git-send-email-michal.bachraty@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366378124-14368-1-git-send-email-michal.bachraty@streamunlimited.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Bachraty <michal.bachraty@streamunlimited.com>
Cc: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, marek.belisko@streamunlimited.com, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 19.04.2013 15:28, Michal Bachraty wrote:
> For TDM mode, BCLK-to-LCLK ratio is computed as (tdm_slots) x (word_length).
> I2S mode is only subset of TDM mode with specific tdm_slots = 2 channels.
> Also bclk_lrclk_ratio can be greater than 255, therefore u16 need to be used.
> 
> Signed-off-by: Michal Bachraty <michal.bachraty@streamunlimited.com>

Acked-by: Daniel Mack <zonque@gmail.com>

> ---
>  sound/soc/davinci/davinci-mcasp.c |    7 ++++---
>  sound/soc/davinci/davinci-mcasp.h |    2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 63633e9..d54e0d9 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -636,11 +636,12 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
>  	 * callback, take it into account here. That allows us to for example
>  	 * send 32 bits per channel to the codec, while only 16 of them carry
>  	 * audio payload.
> -	 * The clock ratio is given for a full period of data (both left and
> -	 * right channels), so it has to be divided by 2.
> +	 * The clock ratio is given for a full period of data (for I2S format
> +	 * both left and right channels), so it has to be divided by number of
> +	 * tdm-slots (for I2S - divided by 2).
>  	 */
>  	if (dev->bclk_lrclk_ratio)
> -		word_length = dev->bclk_lrclk_ratio / 2;
> +		word_length = dev->bclk_lrclk_ratio / dev->tdm_slots;
>  
>  	/* mapping of the XSSZ bit-field as described in the datasheet */
>  	fmt = (word_length >> 1) - 1;
> diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
> index 0edd3b5..a9ac0c1 100644
> --- a/sound/soc/davinci/davinci-mcasp.h
> +++ b/sound/soc/davinci/davinci-mcasp.h
> @@ -38,7 +38,7 @@ struct davinci_audio_dev {
>  	u8	num_serializer;
>  	u8	*serial_dir;
>  	u8	version;
> -	u8	bclk_lrclk_ratio;
> +	u16	bclk_lrclk_ratio;
>  
>  	/* McASP FIFO related */
>  	u8	txnumevt;
> 
