From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/2] ASoC: wm8940: Convert to table based
 control and DAPM init
Date: Sun, 17 Nov 2013 18:25:15 +0000
Message-ID: <52890A0B.6070207@cam.ac.uk>
References: <1383931413-8943-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-32.csi.cam.ac.uk (ppsw-32.csi.cam.ac.uk [131.111.8.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 9042B261685
 for <alsa-devel@alsa-project.org>; Sun, 17 Nov 2013 18:24:13 +0100 (CET)
In-Reply-To: <1383931413-8943-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 11/08/13 17:23, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
Don't have working hardware any more for this, but looks sensible.

Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  sound/soc/codecs/wm8940.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
> index b1591c6..4858b5c 100644
> --- a/sound/soc/codecs/wm8940.c
> +++ b/sound/soc/codecs/wm8940.c
> @@ -264,7 +264,7 @@ static const struct snd_soc_dapm_widget wm8940_dapm_widgets[] = {
>  	SND_SOC_DAPM_INPUT("AUX"),
>  };
>  
> -static const struct snd_soc_dapm_route audio_map[] = {
> +static const struct snd_soc_dapm_route wm8940_dapm_routes[] = {
>  	/* Mono output mixer */
>  	{"Mono Mixer", "PCM Playback Switch", "DAC"},
>  	{"Mono Mixer", "Aux Playback Switch", "Aux Input"},
> @@ -296,21 +296,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
>  	{"ADC", NULL, "Boost Mixer"},
>  };
>  
> -static int wm8940_add_widgets(struct snd_soc_codec *codec)
> -{
> -	struct snd_soc_dapm_context *dapm = &codec->dapm;
> -	int ret;
> -
> -	ret = snd_soc_dapm_new_controls(dapm, wm8940_dapm_widgets,
> -					ARRAY_SIZE(wm8940_dapm_widgets));
> -	if (ret)
> -		goto error_ret;
> -	ret = snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
> -
> -error_ret:
> -	return ret;
> -}
> -
>  #define wm8940_reset(c) snd_soc_write(c, WM8940_SOFTRESET, 0);
>  
>  static int wm8940_set_dai_fmt(struct snd_soc_dai *codec_dai,
> @@ -716,11 +701,6 @@ static int wm8940_probe(struct snd_soc_codec *codec)
>  			return ret;
>  	}
>  
> -	ret = snd_soc_add_codec_controls(codec, wm8940_snd_controls,
> -			     ARRAY_SIZE(wm8940_snd_controls));
> -	if (ret)
> -		return ret;
> -	ret = wm8940_add_widgets(codec);
>  	return ret;
>  }
>  
> @@ -736,6 +716,12 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8940 = {
>  	.suspend =	wm8940_suspend,
>  	.resume =	wm8940_resume,
>  	.set_bias_level = wm8940_set_bias_level,
> +	.controls =     wm8940_snd_controls,
> +	.num_controls = ARRAY_SIZE(wm8940_snd_controls),
> +	.dapm_widgets = wm8940_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(wm8940_dapm_widgets),
> +	.dapm_routes =  wm8940_dapm_routes,
> +	.num_dapm_routes = ARRAY_SIZE(wm8940_dapm_routes),
>  	.reg_cache_size = ARRAY_SIZE(wm8940_reg_defaults),
>  	.reg_word_size = sizeof(u16),
>  	.reg_cache_default = wm8940_reg_defaults,
> 
