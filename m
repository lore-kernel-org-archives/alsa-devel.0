From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoc: wm8731: add 32bit mode and normal
 mode with 12MHz XTAL
Date: Thu, 9 Jun 2016 12:56:24 +0100
Message-ID: <20160609115624.GP20422@localhost.localdomain>
References: <57595463.2070700@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id D7A9626070C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 13:56:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <57595463.2070700@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2016 at 09:34:59PM +1000, Matt Flax wrote:
> This patch adds the 32 bit capability and updates the
> WM8731_IFACE as required.
> 
> This patch also allows the machine to set normal mode when using a
> 12 MHz crystal. In USB_MODE the 12 MHz crystal signal is output on
> the BCLK pin. In NORMAL_MODE the bit clock is output on the BCLK pin.
> The previously ignored direction variable input to the
> wm8731_set_dai_sysclk function is used to indicate whether crystal
> or bit clock is output on the BCLK codec pin.
> I have ensured that this does not effect the db1200.c machine driver
> (the only other driver to use a 12 MHz crystal in USB_MODE). It also
> does not effect the other machine drivers which use the wm8731 codec
> as they don't use USB_MODE nor 12 MHz crystals.

Probably best to split these into two patches, I know they are
both simple changes but they appear unrelated and if they arn't
you probably need to explain why they need to go in a single
patch.

> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---
>  sound/soc/codecs/wm8731.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
> index 4bcf5f8..b155cf6 100644
> --- a/sound/soc/codecs/wm8731.c
> +++ b/sound/soc/codecs/wm8731.c
> @@ -5,6 +5,7 @@
>   * Copyright 2006-12 Wolfson Microelectronics, plc
>   *
>   * Author: Richard Purdie <richard@openedhand.com>
> + * Author: Matt Flax <flatmax@flatmax.com> 12Mhz XTAL normal mode and 32bit
> mode.

Are you sure you mail setup is good here? A few points in the patch it
looks like lines have been line wrapped. Git won't apply the patches
if they have been tampered with by your email client.  A good way to
test this is to email the patch to yourself first and then try to
apply it yourself before you send it to the list.

>   *
>   * Based on wm8753.c by Liam Girdwood
>   *
> @@ -53,6 +54,7 @@ struct wm8731_priv {
>  	int sysclk_type;
>  	int playback_fs;
>  	bool deemph;
> +	bool bclk_12_mhz;
>   	struct mutex lock;
>  };
> @@ -192,7 +194,7 @@ static const struct snd_kcontrol_new
> wm8731_input_mux_controls =
>  SOC_DAPM_ENUM("Input Select", wm8731_insel_enum);
>   static const struct snd_soc_dapm_widget wm8731_dapm_widgets[] = {
> -SND_SOC_DAPM_SUPPLY("ACTIVE",WM8731_ACTIVE, 0, 0, NULL, 0),
> +SND_SOC_DAPM_SUPPLY("ACTIVE", WM8731_ACTIVE, 0, 0, NULL, 0),

Again probably better to put this into a seperate change it has
nothing to do with the rest of the patch.

>  SND_SOC_DAPM_SUPPLY("OSC", WM8731_PWR, 5, 1, NULL, 0),
>  SND_SOC_DAPM_MIXER("Output Mixer", WM8731_PWR, 4, 1,
>  	&wm8731_output_mixer_controls[0],
> @@ -341,8 +343,11 @@ static int wm8731_hw_params(struct snd_pcm_substream
> *substream,
>  	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
>  	u16 iface = snd_soc_read(codec, WM8731_IFACE) & 0xfff3;
>  	int i = get_coeff(wm8731->sysclk, params_rate(params));
> -	u16 srate = (coeff_div[i].sr << 2) |
> -		(coeff_div[i].bosr << 1) | coeff_div[i].usb;
> +	u16 srate = (coeff_div[i].sr << 2) | (coeff_div[i].bosr << 1);
> +
> +	/* this determines whether to output bit or crystal clk */
> +	if (wm8731->bclk_12_mhz)
> +		srate |= coeff_div[i].usb;
>   	wm8731->playback_fs = params_rate(params);
>  @@ -358,6 +363,9 @@ static int wm8731_hw_params(struct snd_pcm_substream
> *substream,
>  	case 24:
>  		iface |= 0x0008;
>  		break;
> +	case 32:
> +		iface |= 0x000c;
> +		break;
>  	}
>   	wm8731_set_deemph(codec);
> @@ -417,6 +425,11 @@ static int wm8731_set_dai_sysclk(struct snd_soc_dai
> *codec_dai,
>   	wm8731->sysclk = freq;
>  +	if (dir == SND_SOC_CLOCK_IN) /* output the 12 MHz clock */
> +		wm8731->bclk_12_mhz = 1;
> +	else /* SND_SOC_CLOCK_OUT, output the bit clock */
> +		wm8731->bclk_12_mhz = 0;
> +
>  	snd_soc_dapm_sync(dapm);
>   	return 0;
> @@ -541,7 +554,7 @@ static int wm8731_startup(struct snd_pcm_substream
> *substream,
>  #define WM8731_RATES SNDRV_PCM_RATE_8000_96000
>   #define WM8731_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE
> |\
> -	SNDRV_PCM_FMTBIT_S24_LE)
> +	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
>   static const struct snd_soc_dai_ops wm8731_dai_ops = {
>  	.startup	= wm8731_startup,
> -- 
> 2.5.0

Thanks,
Charles
