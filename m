From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: wm8741: Add differential
	mono	mode support
Date: Mon, 11 May 2015 09:12:25 +0100
Message-ID: <20150511081225.GC3480@opensource.wolfsonmicro.com>
References: <1430858791-11825-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F9C326067F
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 10:12:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1430858791-11825-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 05, 2015 at 10:46:31PM +0200, Sergej Sawazki wrote:
> The WM8741 DAC supports several differential output modes (stereo,
> stereo reversed, mono left, mono right). Add platform data and DT
> bindings to configure it.
> 
> Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
> ---
>  Documentation/devicetree/bindings/sound/wm8741.txt |  11 +++
>  sound/soc/codecs/wm8741.c                          | 108 ++++++++++++++++++---
>  sound/soc/codecs/wm8741.h                          |  10 ++
>  3 files changed, 117 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/wm8741.txt b/Documentation/devicetree/bindings/sound/wm8741.txt
> index 74bda58..a133154 100644
> --- a/Documentation/devicetree/bindings/sound/wm8741.txt
> +++ b/Documentation/devicetree/bindings/sound/wm8741.txt
> @@ -10,9 +10,20 @@ Required properties:
>    - reg : the I2C address of the device for I2C, the chip select
>            number for SPI.
>  
> +Optional properties:
> +
> +  - diff-mode: Differential output mode configuration. Default value for field
> +    DIFF in register R8 (MODE_CONTROL_2). If absent, the default is 0, shall be:
> +    0 = stereo
> +    1 = mono left
> +    2 = stereo reversed
> +    3 = mono right
> +
>  Example:
>  
>  codec: wm8741@1a {
>  	compatible = "wlf,wm8741";
>  	reg = <0x1a>;
> +
> +	diff-mode = <3>;
>  };
> diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
> index 9e71c76..cbf90ab 100644
> --- a/sound/soc/codecs/wm8741.c
> +++ b/sound/soc/codecs/wm8741.c
> @@ -41,6 +41,7 @@ static const char *wm8741_supply_names[WM8741_NUM_SUPPLIES] = {
>  
>  /* codec private data */
>  struct wm8741_priv {
> +	struct wm8741_platform_data pdata;
>  	struct regmap *regmap;
>  	struct regulator_bulk_data supplies[WM8741_NUM_SUPPLIES];
>  	unsigned int sysclk;
> @@ -398,7 +399,7 @@ static struct snd_soc_dai_driver wm8741_dai = {
>  	.name = "wm8741",
>  	.playback = {
>  		.stream_name = "Playback",
> -		.channels_min = 2,  /* Mono modes not yet supported */
> +		.channels_min = 2,
>  		.channels_max = 2,
>  		.rates = WM8741_RATES,
>  		.formats = WM8741_FORMATS,
> @@ -416,6 +417,60 @@ static int wm8741_resume(struct snd_soc_codec *codec)
>  #define wm8741_resume NULL
>  #endif
>  
> +static int wm8741_configure(struct snd_soc_codec *codec)
> +{
> +	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
> +
> +	/* Configure differential mode */
> +	switch (wm8741->pdata.diff_mode) {
> +	case WM8741_DIFF_MODE_STEREO:
> +	case WM8741_DIFF_MODE_STEREO_REVERSED:
> +	case WM8741_DIFF_MODE_MONO_LEFT:
> +	case WM8741_DIFF_MODE_MONO_RIGHT:
> +		snd_soc_update_bits(codec, WM8741_MODE_CONTROL_2,
> +				WM8741_DIFF_MASK,
> +				wm8741->pdata.diff_mode << WM8741_DIFF_SHIFT);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Change some default settings - latch VU */
> +	snd_soc_update_bits(codec, WM8741_DACLLSB_ATTENUATION,
> +			WM8741_UPDATELL, WM8741_UPDATELL);
> +	snd_soc_update_bits(codec, WM8741_DACLMSB_ATTENUATION,
> +			WM8741_UPDATELM, WM8741_UPDATELM);
> +	snd_soc_update_bits(codec, WM8741_DACRLSB_ATTENUATION,
> +			WM8741_UPDATERL, WM8741_UPDATERL);
> +	snd_soc_update_bits(codec, WM8741_DACRMSB_ATTENUATION,
> +			WM8741_UPDATERM, WM8741_UPDATERM);
> +
> +	return 0;
> +}
> +
> +static int wm8741_add_controls(struct snd_soc_codec *codec)
> +{
> +	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (wm8741->pdata.diff_mode) {
> +	case WM8741_DIFF_MODE_STEREO:
> +	case WM8741_DIFF_MODE_STEREO_REVERSED:
> +		snd_soc_add_codec_controls(codec, wm8741_snd_controls,
> +				ARRAY_SIZE(wm8741_snd_controls));
> +		break;
> +	case WM8741_DIFF_MODE_MONO_LEFT:
> +	case WM8741_DIFF_MODE_MONO_RIGHT:
> +		/* The machine driver is responsible for mixer controls
> +		 * if the codec is configured in differential mono mode.
> +		 */

Would it not be better to add controls but with a channel neutral
name and then the machine driver can use the name_prefix stuff to
stick left and right onto them? Seems a bit odd for the machine
driver to have to know exact register details of the CODEC and
manually add the volume controls?

Thanks,
Charles
