From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/3] ASoC: support sample sizes properly in
 the WM8776 codec driver
Date: Wed, 14 Sep 2011 13:35:10 +0100
Message-ID: <1316003710.3229.14.camel@odin>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 625081037FC
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 14:35:16 +0200 (CEST)
Received: by mail-wy0-f176.google.com with SMTP id 10so138395wyg.21
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 05:35:14 -0700 (PDT)
In-Reply-To: <1315936777-27994-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-09-13 at 12:59 -0500, Timur Tabi wrote:
> Use snd_pcm_format_width() to determine the sample size, instead of
> checking specify sample formats and assuming that those are the only
> valid format.
> 
> This change adds support for big-endian architectures (which use the _BE
> formats) and the packed 24-bit format (SNDRV_PCM_FORMAT_S24_3xE).
> 

Sounds like we also need this for the other codec drivers too at some
point.

> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  sound/soc/codecs/wm8776.c |   25 +++++++++++++------------
>  1 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
> index 8e7953b..ad6f0fa 100644
> --- a/sound/soc/codecs/wm8776.c
> +++ b/sound/soc/codecs/wm8776.c
> @@ -215,8 +215,6 @@ static int wm8776_hw_params(struct snd_pcm_substream *substream,
>  	int ratio_shift, master;
>  	int i;
>  
> -	iface = 0;
> -
>  	switch (dai->driver->id) {
>  	case WM8776_DAI_DAC:
>  		iface_reg = WM8776_DACIFCTRL;
> @@ -232,20 +230,23 @@ static int wm8776_hw_params(struct snd_pcm_substream *substream,
>  		return -EINVAL;
>  	}
>  
> -
>  	/* Set word length */
> -	switch (params_format(params)) {
> -	case SNDRV_PCM_FORMAT_S16_LE:
> +	i = snd_pcm_format_width(params_format(params));
> +	switch (i) {

Just a minor nitpick. I would not have used the intermediate 'i' here
and would have just embedded the snd_pcm call within the switch(). I
guess it may not fit the line width though.

Acked-by: Liam Girdwood <lrg@ti.com>

> +	case 16:
> +		iface = 0;
> +	case 20:
> +		iface = 0x10;
>  		break;
> -	case SNDRV_PCM_FORMAT_S20_3LE:
> -		iface |= 0x10;
> +	case 24:
> +		iface = 0x20;
>  		break;
> -	case SNDRV_PCM_FORMAT_S24_LE:
> -		iface |= 0x20;
> -		break;
> -	case SNDRV_PCM_FORMAT_S32_LE:
> -		iface |= 0x30;
> +	case 32:
> +		iface = 0x30;
>  		break;
> +	default:
> +		dev_err(codec->dev, "Unsupported sample size: %i\n", i);
> +		return -EINVAL;
>  	}
>  
>  	/* Only need to set MCLK/LRCLK ratio if we're master */
