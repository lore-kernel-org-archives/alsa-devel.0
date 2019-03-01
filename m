From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] ASoC: hdmi-codec: fix S/PDIF DAI
Date: Fri, 1 Mar 2019 11:09:44 +0200
Message-ID: <e6823774-d630-c418-1779-d0e894df9382@ti.com>
References: <E1gzNdq-000598-RJ@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E95BF8073C
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 10:09:49 +0100 (CET)
In-Reply-To: <E1gzNdq-000598-RJ@rmk-PC.armlinux.org.uk>
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
To: Russell King <rmk+kernel@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 28/02/2019 17:30, Russell King wrote:
> When using the S/PDIF DAI, there is no requirement to call
> snd_soc_dai_set_fmt() as there is no DAI format definition that defines
> S/PDIF.  In any case, S/PDIF does not have separate clocks, this is
> embedded into the data stream.
> 
> Consequently, when attempting to use TDA998x in S/PDIF mode, the attempt
> to configure TDA998x via the hw_params callback fails as the
> hdmi_codec_daifmt is left initialised to zero.
> 
> Since the S/PDIF DAI will only be used by S/PDIF, prepare the
> hdmi_codec_daifmt structure for this format.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Jyri Sarha <jsarha@ti.com>

> ---
>  sound/soc/codecs/hdmi-codec.c | 118 +++++++++++++++++++++---------------------
>  1 file changed, 59 insertions(+), 59 deletions(-)
> 
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index e5b6769b9797..d5f73c837281 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -529,73 +529,71 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
>  {
>  	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
>  	struct hdmi_codec_daifmt cf = { 0 };
> -	int ret = 0;
>  
>  	dev_dbg(dai->dev, "%s()\n", __func__);
>  
> -	if (dai->id == DAI_ID_SPDIF) {
> -		cf.fmt = HDMI_SPDIF;
> -	} else {
> -		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> -		case SND_SOC_DAIFMT_CBM_CFM:
> -			cf.bit_clk_master = 1;
> -			cf.frame_clk_master = 1;
> -			break;
> -		case SND_SOC_DAIFMT_CBS_CFM:
> -			cf.frame_clk_master = 1;
> -			break;
> -		case SND_SOC_DAIFMT_CBM_CFS:
> -			cf.bit_clk_master = 1;
> -			break;
> -		case SND_SOC_DAIFMT_CBS_CFS:
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +	if (dai->id == DAI_ID_SPDIF)
> +		return 0;
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		cf.bit_clk_master = 1;
> +		cf.frame_clk_master = 1;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFM:
> +		cf.frame_clk_master = 1;
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +		cf.bit_clk_master = 1;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
> -		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> -		case SND_SOC_DAIFMT_NB_NF:
> -			break;
> -		case SND_SOC_DAIFMT_NB_IF:
> -			cf.frame_clk_inv = 1;
> -			break;
> -		case SND_SOC_DAIFMT_IB_NF:
> -			cf.bit_clk_inv = 1;
> -			break;
> -		case SND_SOC_DAIFMT_IB_IF:
> -			cf.frame_clk_inv = 1;
> -			cf.bit_clk_inv = 1;
> -			break;
> -		}
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +		break;
> +	case SND_SOC_DAIFMT_NB_IF:
> +		cf.frame_clk_inv = 1;
> +		break;
> +	case SND_SOC_DAIFMT_IB_NF:
> +		cf.bit_clk_inv = 1;
> +		break;
> +	case SND_SOC_DAIFMT_IB_IF:
> +		cf.frame_clk_inv = 1;
> +		cf.bit_clk_inv = 1;
> +		break;
> +	}
>  
> -		switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> -		case SND_SOC_DAIFMT_I2S:
> -			cf.fmt = HDMI_I2S;
> -			break;
> -		case SND_SOC_DAIFMT_DSP_A:
> -			cf.fmt = HDMI_DSP_A;
> -			break;
> -		case SND_SOC_DAIFMT_DSP_B:
> -			cf.fmt = HDMI_DSP_B;
> -			break;
> -		case SND_SOC_DAIFMT_RIGHT_J:
> -			cf.fmt = HDMI_RIGHT_J;
> -			break;
> -		case SND_SOC_DAIFMT_LEFT_J:
> -			cf.fmt = HDMI_LEFT_J;
> -			break;
> -		case SND_SOC_DAIFMT_AC97:
> -			cf.fmt = HDMI_AC97;
> -			break;
> -		default:
> -			dev_err(dai->dev, "Invalid DAI interface format\n");
> -			return -EINVAL;
> -		}
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		cf.fmt = HDMI_I2S;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_A:
> +		cf.fmt = HDMI_DSP_A;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_B:
> +		cf.fmt = HDMI_DSP_B;
> +		break;
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		cf.fmt = HDMI_RIGHT_J;
> +		break;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		cf.fmt = HDMI_LEFT_J;
> +		break;
> +	case SND_SOC_DAIFMT_AC97:
> +		cf.fmt = HDMI_AC97;
> +		break;
> +	default:
> +		dev_err(dai->dev, "Invalid DAI interface format\n");
> +		return -EINVAL;
>  	}
>  
>  	hcp->daifmt[dai->id] = cf;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
> @@ -792,8 +790,10 @@ static int hdmi_codec_probe(struct platform_device *pdev)
>  		i++;
>  	}
>  
> -	if (hcd->spdif)
> +	if (hcd->spdif) {
>  		hcp->daidrv[i] = hdmi_spdif_dai;
> +		hcp->daifmt[DAI_ID_SPDIF].fmt = HDMI_SPDIF;
> +	}
>  
>  	dev_set_drvdata(dev, hcp);
>  
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
