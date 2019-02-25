From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Mon, 25 Feb 2019 15:45:44 +0200
Message-ID: <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
References: <20190222212619.ghxly3eb6dx7p2ut@shell.armlinux.org.uk>
 <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3086F89644
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 14:45:50 +0100 (CET)
In-Reply-To: <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
Content-Language: en-GB
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Russell King <rmk+kernel@armlinux.org.uk>, Sven Van Asbroeck <thesven73@gmail.com>, Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 22/02/2019 23:27, Russell King wrote:
> Some HDMI codecs need to know the relationship between the I2S bit clock
> and the I2S word clock in order to correctly generate the CTS value for
> audio clock recovery on the sink.
> 
> Add support for this, but there are currently no callers of
> snd_soc_dai_set_bclk_ratio(), we provide a default implementation that
> uses the sample width to derive the ratio from the 8-bit aligned
> sample size.  This reflects the derivation that is in TDA998x, which
> we are going to convert to use this new support.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  include/sound/hdmi-codec.h    |  1 +
>  sound/soc/codecs/hdmi-codec.c | 45 +++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> index 9483c55f871b..0fca69880dc3 100644
> --- a/include/sound/hdmi-codec.h
> +++ b/include/sound/hdmi-codec.h
> @@ -42,6 +42,7 @@ struct hdmi_codec_daifmt {
>  	unsigned int frame_clk_inv:1;
>  	unsigned int bit_clk_master:1;
>  	unsigned int frame_clk_master:1;
> +	unsigned int bclk_ratio;
>  };
>  
>  /*
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index e5b6769b9797..d71a7e5a2231 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -470,6 +470,7 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
>  				struct snd_soc_dai *dai)
>  {
>  	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
> +	struct hdmi_codec_daifmt fmt;
>  	struct hdmi_codec_params hp = {
>  		.iec = {
>  			.status = { 0 },
> @@ -520,8 +521,43 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
>  	hp.sample_rate = params_rate(params);
>  	hp.channels = params_channels(params);
>  
> +	fmt = hcp->daifmt[dai->id];
> +
> +	/*
> +	 * If the .set_bclk_ratio() has not been called, default it
> +	 * using the sample width for compatibility for TDA998x.
> +	 * Rather than changing this, drivers should arrange to make
> +	 * an appropriate call to snd_soc_dai_set_bclk_ratio().
> +	 */
> +	if (fmt.bclk_ratio == 0) {
> +		switch (hp.sample_width) {
> +		case 16:
> +			fmt.bclk_ratio = 32;
> +			break;
> +		case 18:
> +		case 20:
> +		case 24:
> +			fmt.bclk_ratio = 48;
> +			break;

AFAIK, this is not the usual choice for 18- or 20-bit samples. Usually,
the bclk_ratio is set to the exact frame length required by the sample
width without any padding. That is at least the case with
tlv320aic3x-driver and 20-bit sample width.


> +		default:
> +			fmt.bclk_ratio = 64;
> +			break;
> +		}
> +	}
> +
>  	return hcp->hcd.ops->hw_params(dai->dev->parent, hcp->hcd.data,
> -				       &hcp->daifmt[dai->id], &hp);
> +				       &fmt, &hp);
> +}
> +
> +static int hdmi_codec_set_bclk_ratio(struct snd_soc_dai *dai,
> +				     unsigned int ratio)
> +{
> +	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
> +
> +	/* FIXME: some validation here would be good? */
> +	hcp->daifmt[dai->id].bclk_ratio = ratio;
> +
> +	return 0;
>  }
>  
>  static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
> @@ -593,7 +629,11 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
>  		}
>  	}
>  
> -	hcp->daifmt[dai->id] = cf;
> +	hcp->daifmt[dai->id].fmt = cf.fmt;
> +	hcp->daifmt[dai->id].bit_clk_inv = cf.bit_clk_inv;
> +	hcp->daifmt[dai->id].frame_clk_inv = cf.frame_clk_inv;
> +	hcp->daifmt[dai->id].bit_clk_master = cf.bit_clk_master;
> +	hcp->daifmt[dai->id].frame_clk_master = cf.frame_clk_master;
>  
>  	return ret;
>  }
> @@ -615,6 +655,7 @@ static const struct snd_soc_dai_ops hdmi_dai_ops = {
>  	.startup	= hdmi_codec_startup,
>  	.shutdown	= hdmi_codec_shutdown,
>  	.hw_params	= hdmi_codec_hw_params,
> +	.set_bclk_ratio	= hdmi_codec_set_bclk_ratio,
>  	.set_fmt	= hdmi_codec_set_fmt,
>  	.digital_mute	= hdmi_codec_digital_mute,
>  };
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
