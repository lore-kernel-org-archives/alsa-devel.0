From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH 2/2] ASoc: wm8731: add normal mode with
	12MHz XTAL
Date: Sat, 11 Jun 2016 19:16:34 +1000
Message-ID: <575BD6F2.70600@flatmax.org>
References: <1465517516-1917-1-git-send-email-flatmax@flatmax.org>
 <1465517516-1917-2-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas05p.mx.bigpond.com (nskntmtas05p.mx.bigpond.com
 [61.9.168.149]) by alsa0.perex.cz (Postfix) with ESMTP id B26F82654B6
 for <alsa-devel@alsa-project.org>; Sat, 11 Jun 2016 11:16:40 +0200 (CEST)
In-Reply-To: <1465517516-1917-2-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

I have realised that this second patch may not be necessary. It is also 
likely that it will skew the actual sample rate.

Charles, can you please advise me on the following...

I notice that I can probably get the correct sample rates by spoofing 
the crystal frequencies in my machine driver. For example ...
The ratio between the USB and Normal mode fs multipliers with BOSR=0 is :
250/256 = 0.97656
Similarly, I can match this with the following crystal frequency ratio 
(crystal f in MHz) :
12/12.288 = 0.97656
By induction, I assume that I can spoof a 12.288 clock with BOSR=0 for 
sample rate = 48kHz, 96 kHz when using a 12 MHz crystal.

Again, I can match ratios between the following crystal frequecies (in 
MHz) :
12/16.9344 = 0.70862
With BOSR = 1, I assume that can get 44.1 kHz and 88.2 kHz because the 
fs ratio between normal and usb mode is :
272/384 = 0.70833

Now these two ratios are skew by 0.41% which is equvalent to the skew in 
12 MHz USB mode clocks of 44.1kHz to 44.118kHz as reported in the  
wm8731 datasheet.

Can you advise me whether my idea of spoofing clocks in the machine 
driver is perhaps a better way of acquiring the correct sample rates, 
rather then this patch ?

thanks
Matt

On 10/06/16 10:11, Matt Flax wrote:
> This patch allows a machine to set normal mode when using a
> 12 MHz crystal. In USB_MODE the 12 MHz crystal signal is output on
> the BCLK pin. In NORMAL_MODE the bit clock is output on the BCLK pin.
> The previously ignored direction variable input to the
> wm8731_set_dai_sysclk function is used to indicate whether crystal
> or bit clock is output on the BCLK codec pin.
> I have ensured that this does not effect the db1200.c machine driver
> (the only other driver to use a 12 MHz crystal in USB_MODE). It also
> does not effect the other machine drivers which use the wm8731 codec
> as they don't use USB_MODE nor 12 MHz crystals.
>
> When driving the wm8731 in normal mode with a 12 MHz crystal, the
> DSP filters are expected to be effected. If the filters are activated
> then it is expected that the filter cut offs are shifted by 2.3% at
> 250 fs and 29.1% at 272 fs. The assumption is that the filters are
> linear, which implies a linear shift in rate scaling effects the
> filter cut off frequencies linearly. If the filters are not active,
> there will be no effects.
>
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---
>   sound/soc/codecs/wm8731.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
> index d18261a..ec98d5a 100644
> --- a/sound/soc/codecs/wm8731.c
> +++ b/sound/soc/codecs/wm8731.c
> @@ -5,6 +5,7 @@
>    * Copyright 2006-12 Wolfson Microelectronics, plc
>    *
>    * Author: Richard Purdie <richard@openedhand.com>
> + * Author: Matt Flax <flatmax@flatmax.com> 12Mhz XTAL normal mode and 32bit mode.
>    *
>    * Based on wm8753.c by Liam Girdwood
>    *
> @@ -53,6 +54,7 @@ struct wm8731_priv {
>   	int sysclk_type;
>   	int playback_fs;
>   	bool deemph;
> +	bool bclk_12_mhz;
>   
>   	struct mutex lock;
>   };
> @@ -341,8 +343,11 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
>   	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
>   	u16 iface = snd_soc_read(codec, WM8731_IFACE) & 0xfff3;
>   	int i = get_coeff(wm8731->sysclk, params_rate(params));
> -	u16 srate = (coeff_div[i].sr << 2) |
> -		(coeff_div[i].bosr << 1) | coeff_div[i].usb;
> +	u16 srate = (coeff_div[i].sr << 2) | (coeff_div[i].bosr << 1);
> +
> +	/* this determines whether to output bit or crystal clk */
> +	if (wm8731->bclk_12_mhz)
> +		srate |= coeff_div[i].usb;
>   
>   	wm8731->playback_fs = params_rate(params);
>   
> @@ -420,6 +425,11 @@ static int wm8731_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>   
>   	wm8731->sysclk = freq;
>   
> +	if (dir == SND_SOC_CLOCK_IN) /* output the 12 MHz clock */
> +		wm8731->bclk_12_mhz = 1;
> +	else /* SND_SOC_CLOCK_OUT, output the bit clock */
> +		wm8731->bclk_12_mhz = 0;
> +
>   	snd_soc_dapm_sync(dapm);
>   
>   	return 0;
