From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel][PATCH v2] ASoC: wm8960: update pll and clock
	setting function
Date: Wed, 8 Jul 2015 17:55:02 +0100
Message-ID: <20150708165501.GK16517@opensource.wolfsonmicro.com>
References: <d358b452bd8bc645cc6ab599f95924314e60d33c.1435912582.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d358b452bd8bc645cc6ab599f95924314e60d33c.1435912582.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 03, 2015 at 05:13:42PM +0800, Zidan Wang wrote:
> Add sysclk auto mode. When it's sysclk auto mode, if the MCLK is
> available for clock configure, using MCLK to provide sysclk directly,
> otherwise, search a available pll out frequcncy and set pll.
> 
> TX and RX share the same sysclk and bclk divider register, and have
> different DAC/ADC divier register. When playback and capture
> simultaneously, the second stream should not set pll, should not
> change the sysclk and bclk, just need set DAC/ADC divider to support
> different TX and RX sample rate.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
>  sound/soc/codecs/wm8960.c | 256 ++++++++++++++++++++++++++++++++++++++--------
>  sound/soc/codecs/wm8960.h |   1 +
>  2 files changed, 214 insertions(+), 43 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
> index 94c5c46..e170bdf 100644
> --- a/sound/soc/codecs/wm8960.c
> +++ b/sound/soc/codecs/wm8960.c
> @@ -48,6 +48,9 @@
>  #define WM8960_DISOP     0x40
>  #define WM8960_DRES_MASK 0x30
>  
> +static bool is_pll_freq_available(unsigned int source, unsigned int target);
> +static int wm8960_set_pll(struct snd_soc_dai *codec_dai,
> +		unsigned int freq_in, unsigned int freq_out);
>  /*
>   * wm8960 register cache
>   * We can't read the WM8960 register space when we are
> @@ -126,9 +129,12 @@ struct wm8960_priv {
>  	struct snd_soc_dapm_widget *rout1;
>  	struct snd_soc_dapm_widget *out3;
>  	bool deemph;
> -	int playback_fs;
> -	int bclk;
>  	int sysclk;
> +	int clk_id;
> +	int freq_in;
> +	int fs[2];
> +	int dac_div[2];
> +	bool is_stream_in_use[2];
>  	struct wm8960_data pdata;
>  };
>  
> @@ -164,8 +170,8 @@ static int wm8960_set_deemph(struct snd_soc_codec *codec)
>  	if (wm8960->deemph) {
>  		best = 1;
>  		for (i = 2; i < ARRAY_SIZE(deemph_settings); i++) {
> -			if (abs(deemph_settings[i] - wm8960->playback_fs) <
> -			    abs(deemph_settings[best] - wm8960->playback_fs))
> +			if (abs(deemph_settings[i] - wm8960->fs[1]) <
> +			    abs(deemph_settings[best] - wm8960->fs[1]))
>  				best = i;
>  		}
>  
> @@ -565,6 +571,9 @@ static struct {
>  	{  8000, 5 },
>  };
>  
> +/* -1 for reserved value */
> +static const int sysclk_divs[] = { 1, -1, 2, -1 };
> +
>  /* Multiply 256 for internal 256 div */
>  static const int dac_divs[] = { 256, 384, 512, 768, 1024, 1408, 1536 };
>  
> @@ -574,61 +583,166 @@ static const int bclk_divs[] = {
>  	120, 160, 220, 240, 320, 320, 320
>  };
>  
> -static void wm8960_configure_clocking(struct snd_soc_codec *codec,
> -		bool tx, int lrclk)
> +static int wm8960_configure_clocking(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
>  {
> +	struct snd_soc_codec *codec = dai->codec;
>  	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
> +	unsigned int sample_rate = params_rate(params);
> +	unsigned int channels = params_channels(params);
> +	unsigned int sysclk, bclk, freq_out, freq_in;
> +	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;

Might be slightly nicer to use an int here since we are going to
use it to index an array.

>  	u16 iface1 = snd_soc_read(codec, WM8960_IFACE1);
>  	u16 iface2 = snd_soc_read(codec, WM8960_IFACE2);
> -	u32 sysclk;
> -	int i, j;
> +	int i, j, k;
>  
>  	if (!(iface1 & (1<<6))) {
>  		dev_dbg(codec->dev,
>  			"Codec is slave mode, no need to configure clock\n");
> -		return;
> +		return 0;
> +	}
> +
> +	/*
> +	 * playback and capture using the same registers of bclk and sysclk
> +	 * div, and different registers for dac/adc div. If playback and capture
> +	 * simultaneously, the second should not set pll, should not change
> +	 * the sysclk and bclk, only dac/adc div can be set to support different
> +	 * frame clock.
> +	 */
> +	if (wm8960->is_stream_in_use[!tx]) {
> +		/*
> +		 * If ADCLRC configure as GPIO pin, DACLRC pin is used as a
> +		 * frame clock for ADCs and DACs.
> +		 */
> +		if (iface2 & (1 << 6)) {
> +			snd_soc_update_bits(codec, WM8960_CLOCK1,
> +					0x7 << 3, wm8960->dac_div[!tx] << 3);
> +			return 0;
> +		}
> +
> +		/*
> +		 * If the different TX and RX sample rate can be support,
> +		 * setting corresponding DAC or ADC divider.
> +		 */
> +		for (i = 0; i < ARRAY_SIZE(dac_divs); ++i) {
> +			if (wm8960->fs[!tx] * dac_divs[wm8960->dac_div[!tx]]
> +					== wm8960->fs[tx] * dac_divs[i]) {
> +				if (tx)
> +					snd_soc_update_bits(codec,
> +						WM8960_CLOCK1,
> +						0x7 << 3, dac_divs[i] << 3);
> +				else
> +					snd_soc_update_bits(codec,
> +						WM8960_CLOCK1,
> +						0x7 << 6, dac_divs[i] << 6);
> +				wm8960->dac_div[tx] = dac_divs[i];
> +				return 0;
> +			}
> +		}
> +		if (i == ARRAY_SIZE(dac_divs)) {
> +			dev_err(codec->dev,
> +				"can't support TX=%d RX=%d\n simultaneously",
> +				wm8960->fs[1], wm8960->fs[0]);
> +			return -EINVAL;
> +		}
> +	}

The DAI has symmetric_rates defined at the moment. So if we are
going to add support for asymmetric rates it would probably be
better as a seperate patch.

> +
> +	if (wm8960->clk_id != WM8960_SYSCLK_MCLK && !wm8960->freq_in) {
> +		dev_err(codec->dev, "No MCLK configured\n");
> +		return -EINVAL;
>  	}
>  
> -	if (!wm8960->sysclk) {
> -		dev_dbg(codec->dev, "No SYSCLK configured\n");
> -		return;
> +	freq_in = wm8960->freq_in;
> +
> +	bclk = snd_soc_params_to_bclk(params);
> +	if (channels == 1)
> +		bclk *= 2;
> +
> +	/*
> +	 * If it's sysclk auto mode, check if the MCLK can provide sysclk or
> +	 * not. If MCLK can provide sysclk, using MCLK to provide sysclk
> +	 * directly. Otherwise, auto select a available pll out frequency
> +	 * and set PLL.
> +	 */
> +	if (wm8960->clk_id == WM8960_SYSCLK_AUTO) {
> +		/* disable the PLL and using MCLK to provide sysclk */
> +		wm8960_set_pll(dai, 0, 0);
> +		freq_out = freq_in;
> +	} else if (wm8960->sysclk)
> +		freq_out = wm8960->sysclk;
> +	else {
> +		dev_err(codec->dev, "No SYSCLK configured\n");
> +		return -EINVAL;
>  	}
>  
> -	if (!wm8960->bclk || !lrclk) {
> -		dev_dbg(codec->dev, "No audio clocks configured\n");
> -		return;
> +	/* check if the sysclk frequency is available. */
> +	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
> +		if (sysclk_divs[i] == -1)
> +			continue;
> +		sysclk = freq_out / sysclk_divs[i];
> +		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
> +			if (sysclk == dac_divs[j] * sample_rate) {
> +				for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k)
> +					if (sysclk == bclk * bclk_divs[k] / 10)
> +						break;
> +				if (k != ARRAY_SIZE(bclk_divs))
> +					break;
> +			}
> +		}
> +		if (j != ARRAY_SIZE(dac_divs))
> +			break;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(dac_divs); ++i) {
> -		if (wm8960->sysclk == lrclk * dac_divs[i]) {
> -			for (j = 0; j < ARRAY_SIZE(bclk_divs); ++j) {
> -				sysclk = wm8960->bclk * bclk_divs[j] / 10;
> -				if (wm8960->sysclk == sysclk)
> +	if (i != ARRAY_SIZE(sysclk_divs))
> +		goto configure_clock;
> +	else if (wm8960->clk_id != WM8960_SYSCLK_AUTO) {
> +		dev_err(codec->dev, "failed to configure clock\n");
> +		return -EINVAL;
> +	}
> +	/* get a available pll out frequency and set pll */
> +	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
> +		if (sysclk_divs[i] == -1)
> +			continue;
> +		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
> +			sysclk = sample_rate * dac_divs[j];
> +			freq_out = sysclk * sysclk_divs[i];
> +
> +			for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k) {
> +				if (sysclk == bclk * bclk_divs[k] / 10 &&
> +				    is_pll_freq_available(freq_in, freq_out)) {
> +					wm8960_set_pll(dai, freq_in, freq_out);
>  					break;
> +				} else
> +					continue;
>  			}
> -			if(j != ARRAY_SIZE(bclk_divs))
> +			if (k != ARRAY_SIZE(bclk_divs))
>  				break;
>  		}
> +		if (j != ARRAY_SIZE(dac_divs))
> +			break;
>  	}
>  
> -	if (i == ARRAY_SIZE(dac_divs)) {
> -		dev_err(codec->dev, "Unsupported sysclk %d\n", wm8960->sysclk);
> -		return;
> +	if (i == ARRAY_SIZE(sysclk_divs)) {
> +		dev_err(codec->dev, "failed to configure clock\n");
> +		return -EINVAL;
>  	}
>  
> -	/*
> -	 * configure frame clock. If ADCLRC configure as GPIO pin, DACLRC
> -	 * pin is used as a frame clock for ADCs and DACs.
> -	 */
> -	if (iface2 & (1<<6))
> -		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 3, i << 3);
> +configure_clock:
> +	snd_soc_update_bits(codec, WM8960_CLOCK1, 3 << 1, i << 1);
> +
> +	if (iface2 & (1 << 6))
> +		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 3, j << 3);
>  	else if (tx)
> -		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 3, i << 3);
> +		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 3, j << 3);
>  	else if (!tx)
> -		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 6, i << 6);
> +		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 6, j << 6);
>  
>  	/* configure bit clock */
> -	snd_soc_update_bits(codec, WM8960_CLOCK2, 0xf, j);
> +	snd_soc_update_bits(codec, WM8960_CLOCK2, 0xf, k);
> +
> +	wm8960->dac_div[tx] = j;
> +
> +	return 0;
>  }
>  
>  static int wm8960_hw_params(struct snd_pcm_substream *substream,
> @@ -641,10 +755,6 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  	int i;
>  
> -	wm8960->bclk = snd_soc_params_to_bclk(params);
> -	if (params_channels(params) == 1)
> -		wm8960->bclk *= 2;
> -
>  	/* bit size */
>  	switch (params_width(params)) {
>  	case 16:
> @@ -667,11 +777,11 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
>  		return -EINVAL;
>  	}
>  
> +	wm8960->fs[tx] = params_rate(params);
>  	/* Update filters for the new rate */
> -	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -		wm8960->playback_fs = params_rate(params);
> +	if (tx)
>  		wm8960_set_deemph(codec);
> -	} else {
> +	else {

If one side of the else has brackets both should.

>  		for (i = 0; i < ARRAY_SIZE(alc_rates); i++)
>  			if (alc_rates[i].rate == params_rate(params))
>  				snd_soc_update_bits(codec,
> @@ -682,7 +792,27 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
>  	/* set iface */
>  	snd_soc_write(codec, WM8960_IFACE1, iface);
>  
> -	wm8960_configure_clocking(codec, tx, params_rate(params));
> +	wm8960->is_stream_in_use[tx] = true;
> +
> +	return wm8960_configure_clocking(substream, params, dai);
> +}
> +
> +static int wm8960_hw_free(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
> +	u16 clock1 = snd_soc_read(codec, WM8960_CLOCK1);
> +	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> +
> +	wm8960->is_stream_in_use[tx] = false;
> +	/*
> +	 * If it's sysclk auto mode, no stream in use, and the pll is enabled,
> +	 * disable the pll
> +	 */
> +	if (wm8960->clk_id == WM8960_SYSCLK_AUTO && (clock1 & 0x1) &&
> +	    !wm8960->is_stream_in_use[!tx])
> +		wm8960_set_pll(dai, 0, 0);

Feels like powering up and down the PLL should really be in
set_bias_level rather than hw_params/free, this can cause
problems with bypass style paths which may get powered up
without hw_params getting called.

>  
>  	return 0;
>  }
> @@ -892,6 +1022,28 @@ struct _pll_div {
>  	u32 k:24;
>  };
>  
> +static bool is_pll_freq_available(unsigned int source, unsigned int target)
> +{
> +	unsigned int Ndiv;
> +
> +	if (source == 0 || target == 0)
> +		return false;
> +
> +	/* Scale up target to PLL operating frequency */
> +	target *= 4;
> +	Ndiv = target / source;
> +
> +	if (Ndiv < 6) {
> +		source >>= 1;
> +		Ndiv = target / source;
> +	}
> +
> +	if ((Ndiv < 6) || (Ndiv > 12))
> +		return false;
> +
> +	return true;
> +}
> +
>  /* The size in bits of the pll divide multiplied by 10
>   * to allow rounding later */
>  #define FIXED_PLL_SIZE ((1 << 24) * 10)
> @@ -943,8 +1095,8 @@ static int pll_factors(unsigned int source, unsigned int target,
>  	return 0;
>  }
>  
> -static int wm8960_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
> -		int source, unsigned int freq_in, unsigned int freq_out)
> +static int wm8960_set_pll(struct snd_soc_dai *codec_dai,
> +		unsigned int freq_in, unsigned int freq_out)
>  {
>  	struct snd_soc_codec *codec = codec_dai->codec;
>  	u16 reg;
> @@ -986,6 +1138,20 @@ static int wm8960_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
>  	return 0;
>  }
>  
> +static int wm8960_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
> +		int source, unsigned int freq_in, unsigned int freq_out)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
> +
> +	wm8960->freq_in = freq_in;
> +
> +	if (wm8960->clk_id == WM8960_SYSCLK_AUTO)
> +		return 0;
> +
> +	return wm8960_set_pll(codec_dai, freq_in, freq_out);
> +}
> +
>  static int wm8960_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
>  		int div_id, int div)
>  {
> @@ -1043,11 +1209,14 @@ static int wm8960_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>  		snd_soc_update_bits(codec, WM8960_CLOCK1,
>  					0x1, WM8960_SYSCLK_PLL);
>  		break;
> +	case WM8960_SYSCLK_AUTO:
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
>  	wm8960->sysclk = freq;
> +	wm8960->clk_id = clk_id;
>  
>  	return 0;
>  }
> @@ -1060,6 +1229,7 @@ static int wm8960_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>  
>  static const struct snd_soc_dai_ops wm8960_dai_ops = {
>  	.hw_params = wm8960_hw_params,
> +	.hw_free = wm8960_hw_free,
>  	.digital_mute = wm8960_mute,
>  	.set_fmt = wm8960_set_dai_fmt,
>  	.set_clkdiv = wm8960_set_dai_clkdiv,
> diff --git a/sound/soc/codecs/wm8960.h b/sound/soc/codecs/wm8960.h
> index 2d8163d..ab3220d 100644
> --- a/sound/soc/codecs/wm8960.h
> +++ b/sound/soc/codecs/wm8960.h
> @@ -82,6 +82,7 @@
>  
>  #define WM8960_SYSCLK_MCLK		(0 << 0)
>  #define WM8960_SYSCLK_PLL		(1 << 0)
> +#define WM8960_SYSCLK_AUTO		(2 << 0)
>  
>  #define WM8960_DAC_DIV_1		(0 << 3)
>  #define WM8960_DAC_DIV_1_5		(1 << 3)
> -- 
> 1.9.1
> 

I need to have a bit more of a think through some of it, but
mostly looks ok to me, other than the comments I have put in so
far.

Thanks,
Charles
