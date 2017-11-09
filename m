From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da7213: add support for DSP modes
Date: Thu, 9 Nov 2017 10:39:42 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1AC26B@SW-EX-MBX01.diasemi.com>
References: <20171108224231.30564-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta6.messagelabs.com (mail1.bemta6.messagelabs.com
 [193.109.254.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6874D266B80
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 11:39:47 +0100 (CET)
In-Reply-To: <20171108224231.30564-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 08 November 2017 22:43, Pierre-Louis Bossart wrote:

> DSP modes are documented in the data sheet but not enabled in the driver.
> The work-around already implemented for DA7218/9 is also required to
> make sure the bit clock handling in DSP modes follows ASoC conventions.
> 
> Tested with ARD-AUDIO-DA7212 and Minnowmax Turbot boards
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  sound/soc/codecs/da7213.c | 58 +++++++++++++++++++++++++++++++++++++++---
> -----
>  sound/soc/codecs/da7213.h |  1 +
>  2 files changed, 49 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index cc0b2d2eaf15..41d9b1da27c2 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -1220,6 +1220,7 @@ static int da7213_set_dai_fmt(struct snd_soc_dai
> *codec_dai, unsigned int fmt)
>  	struct snd_soc_codec *codec = codec_dai->codec;
>  	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
>  	u8 dai_clk_mode = 0, dai_ctrl = 0;
> +	u8 dai_offset = 0;
> 
>  	/* Set master/slave mode */
>  	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> @@ -1234,17 +1235,46 @@ static int da7213_set_dai_fmt(struct snd_soc_dai
> *codec_dai, unsigned int fmt)
>  	}
> 
>  	/* Set clock normal/inverted */
> -	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> -	case SND_SOC_DAIFMT_NB_NF:
> -		break;
> -	case SND_SOC_DAIFMT_NB_IF:
> -		dai_clk_mode |= DA7213_DAI_WCLK_POL_INV;
> -		break;
> -	case SND_SOC_DAIFMT_IB_NF:
> -		dai_clk_mode |= DA7213_DAI_CLK_POL_INV;
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +	case SND_SOC_DAIFMT_LEFT_J:
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +		case SND_SOC_DAIFMT_NB_NF:
> +			break;
> +		case SND_SOC_DAIFMT_NB_IF:
> +			dai_clk_mode |= DA7213_DAI_WCLK_POL_INV;
> +			break;
> +		case SND_SOC_DAIFMT_IB_NF:
> +			dai_clk_mode |= DA7213_DAI_CLK_POL_INV;
> +			break;
> +		case SND_SOC_DAIFMT_IB_IF:
> +			dai_clk_mode |= DA7213_DAI_WCLK_POL_INV |
> +					DA7213_DAI_CLK_POL_INV;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>  		break;
> -	case SND_SOC_DAIFMT_IB_IF:
> -		dai_clk_mode |= DA7213_DAI_WCLK_POL_INV |
> DA7213_DAI_CLK_POL_INV;
> +	case SND_SOC_DAI_FORMAT_DSP_A:
> +	case SND_SOC_DAI_FORMAT_DSP_B:
> +		/* The bclk is inverted wrt ASoC conventions */
> +		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +		case SND_SOC_DAIFMT_NB_NF:
> +			dai_clk_mode |= DA7213_DAI_CLK_POL_INV;
> +			break;
> +		case SND_SOC_DAIFMT_NB_IF:
> +			dai_clk_mode |= DA7213_DAI_WCLK_POL_INV |
> +					DA7213_DAI_CLK_POL_INV;
> +			break;
> +		case SND_SOC_DAIFMT_IB_NF:
> +			break;
> +		case SND_SOC_DAIFMT_IB_IF:
> +			dai_clk_mode |= DA7213_DAI_WCLK_POL_INV;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1261,6 +1291,13 @@ static int da7213_set_dai_fmt(struct snd_soc_dai
> *codec_dai, unsigned int fmt)
>  	case SND_SOC_DAIFMT_RIGHT_J:
>  		dai_ctrl |= DA7213_DAI_FORMAT_RIGHT_J;
>  		break;
> +	case SND_SOC_DAI_FORMAT_DSP_A: /* L data MSB after FRM LRC */
> +		dai_ctrl |= DA7213_DAI_FORMAT_DSP;
> +		dai_offset = 1;
> +		break;
> +	case SND_SOC_DAI_FORMAT_DSP_B: /* L data MSB during FRM LRC */
> +		dai_ctrl |= DA7213_DAI_FORMAT_DSP;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1271,6 +1308,7 @@ static int da7213_set_dai_fmt(struct snd_soc_dai
> *codec_dai, unsigned int fmt)
>  	snd_soc_write(codec, DA7213_DAI_CLK_MODE, dai_clk_mode);
>  	snd_soc_update_bits(codec, DA7213_DAI_CTRL,
> DA7213_DAI_FORMAT_MASK,
>  			    dai_ctrl);
> +	snd_soc_write(codec, DA7213_DAI_OFFSET, dai_offset);
> 
>  	return 0;
>  }
> diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
> index 16ef56f77cd4..5a78dba1dcb5 100644
> --- a/sound/soc/codecs/da7213.h
> +++ b/sound/soc/codecs/da7213.h
> @@ -188,6 +188,7 @@
>  #define DA7213_DAI_FORMAT_I2S_MODE				(0x0 << 0)
>  #define DA7213_DAI_FORMAT_LEFT_J				(0x1 << 0)
>  #define DA7213_DAI_FORMAT_RIGHT_J				(0x2 << 0)
> +#define DA7213_DAI_FORMAT_DSP					(0x3 << 0)
>  #define DA7213_DAI_FORMAT_MASK					(0x3 << 0)
>  #define DA7213_DAI_WORD_LENGTH_S16_LE				(0x0 << 2)
>  #define DA7213_DAI_WORD_LENGTH_S20_LE				(0x1 << 2)
> --
> 2.11.0
