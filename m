From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Disable WM8994/58 microphone
 detection over suspend
Date: Wed, 11 May 2011 14:45:14 +0100
Message-ID: <1305121514.3277.19.camel@odin>
References: <1305117363-11750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 91D4310393B
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 15:45:21 +0200 (CEST)
Received: by qwf7 with SMTP id 7so278604qwf.38
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2011 06:45:20 -0700 (PDT)
In-Reply-To: <1305117363-11750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-05-11 at 14:36 +0200, Mark Brown wrote:
> It will be non-functional with the basises and clocks off anyway, if the
> system needs microphone detection enabled over suspend then it should be
> causing the CODEC to ignore suspend using the APIs for that to prevent
> the biases being disabled.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index b6d47e7..e6dfa10 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -2416,8 +2416,19 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
>  static int wm8994_suspend(struct snd_soc_codec *codec, pm_message_t state)
>  {
>  	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
> +	struct wm8994 *control = codec->control_data;
>  	int i, ret;
>  
> +	switch (control->type) {
> +	case WM8994:
> +		snd_soc_update_bits(codec, WM8994_MICBIAS, WM8994_MICD_ENA, 0);
> +		break;
> +	case WM8958:
> +		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
> +				    WM8958_MICD_ENA, 0);
> +		break;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(wm8994->fll); i++) {
>  		memcpy(&wm8994->fll_suspend[i], &wm8994->fll[i],
>  		       sizeof(struct wm8994_fll_config));
> @@ -2435,6 +2446,7 @@ static int wm8994_suspend(struct snd_soc_codec *codec, pm_message_t state)
>  static int wm8994_resume(struct snd_soc_codec *codec)
>  {
>  	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
> +	struct wm8994 *control = codec->control_data;
>  	int i, ret;
>  	unsigned int val, mask;
>  
> @@ -2473,6 +2485,19 @@ static int wm8994_resume(struct snd_soc_codec *codec)
>  				 i + 1, ret);
>  	}
>  
> +	switch (control->type) {
> +	case WM8994:
> +		if (wm8994->micdet[0].jack || wm8994->micdet[1].jack)
> +			snd_soc_update_bits(codec, WM8994_MICBIAS,
> +					    WM8994_MICD_ENA, WM8994_MICD_ENA);
> +		break;
> +	case WM8958:
> +		if (wm8994->jack_cb)
> +			snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
> +					    WM8958_MICD_ENA, WM8958_MICD_ENA);
> +		break;
> +	}
> +
>  	return 0;
>  }
>  #else

Acked-by: Liam Girdwood <lrg@ti.com>
