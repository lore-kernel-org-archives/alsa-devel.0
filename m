From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: kbl: Enabling ASRC for RT5663
 codec on kabylake platform
Date: Wed, 16 Aug 2017 10:28:25 +0530
Message-ID: <20170816045824.GO3053@localhost>
References: <1502427646-18880-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 402422674A8
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 06:55:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1502427646-18880-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen M <naveen.m@intel.com>
Cc: alsa-devel@alsa-project.org, Shruthi Sudhakar <shruthi.sudhakar@intel.com>, tiwai@suse.de, liam.r.girdwood@linux.intel.com, Harsha Priya N <harshapriya.n@intel.com>, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 11, 2017 at 10:30:46AM +0530, Naveen M wrote:
> From: Harsha Priya N <harshapriya.n@intel.com>
> 
> Patch fixes cracking noise in rt5663 headphones for kbl platform by
> calling rt5663_sel_asrc_clk_src() for RT5663_AD_STEREO_FILTER to set
> ASRC.
> 
> The ASRC function is for asynchronous MCLK and LRCK. For RT5663 ASRC
> should be enabled to  support special i2s clock format like Intel's
		    ^^^^^^
daouble space

it is not special, it is pcm format with 100fs

> 100fs. ASRC function will track i2s clock and generate corresponding
> system clock for codec. Calling this func helps select clock source
> for both RT5663_AD_STEREO_FILTER and RT5663_DA_STEREO_FILTER filters
> which fixes the crackling sound.
> 
> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
> Signed-off-by: Shruthi Sudhakar <shruthi.sudhakar@intel.com>
> Signed-off-by: Naveen M <naveen.m@intel.com>
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
> index f9ba977..29b50e4 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
> @@ -312,11 +312,13 @@ static int kabylake_rt5663_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>  	int ret;
>  
> -	ret = snd_soc_dai_set_sysclk(codec_dai,
> -			RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
>  	/* use ASRC for internal clocks, as PLL rate isn't multiple of BCLK */
> -	rt5663_sel_asrc_clk_src(codec_dai->codec, RT5663_DA_STEREO_FILTER, 1);
> +	rt5663_sel_asrc_clk_src(codec_dai->codec,
> +			RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
> +			RT5663_CLK_SEL_I2S1_ASRC);
>  
> +	ret = snd_soc_dai_set_sysclk(codec_dai,
> +			RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
>  	if (ret < 0)
>  		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
>  
> -- 
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
