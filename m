From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [v2 2/3] ASoC: Intel: Fix pop noise of dmic
 recording in kabylake platform using rt5514
Date: Thu, 27 Jul 2017 08:12:29 +0530
Message-ID: <20170727024229.GN3053@localhost>
References: <1501102065-11083-1-git-send-email-harshapriya.n@intel.com>
 <1501102065-11083-3-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 835A3266AF9
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 04:39:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1501102065-11083-3-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <harshapriya.n@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 26, 2017 at 01:47:44PM -0700, Harsha Priya wrote:
> This patch fixes the pop noise in dmic recording using rt5514 on kabylake platform.
> This patch enables the rt5514 to use MCLK instead of BLCK as the sysclock which fixes
> the pop noise.

Please consider changing patch title to document the change you did so:

"ASoC: Intel: use MCLK instead of BLCK as the sysclock"

describes this patch rather than current one..

> 
> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
> ---
>  sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index cfde894..cfd89ca 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -351,19 +351,10 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
>  				return ret;
>  			}
>  
> -			ret = snd_soc_dai_set_pll(codec_dai, 0,
> -				RT5514_PLL1_S_BCLK, RT5514_AIF1_BCLK_FREQ,
> -						RT5514_AIF1_SYSCLK_FREQ);
> -			if (ret < 0) {
> -				dev_err(rtd->dev, "set bclk err: %d\n", ret);
> -				return ret;
> -			}
> -
>  			ret = snd_soc_dai_set_sysclk(codec_dai,
> -				RT5514_SCLK_S_PLL1, RT5514_AIF1_SYSCLK_FREQ,
> -							SND_SOC_CLOCK_IN);
> +				RT5514_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
>  			if (ret < 0) {
> -				dev_err(rtd->dev, "set sclk err: %d\n", ret);
> +				dev_err(rtd->dev, "set sysclk err: %d\n", ret);
>  				return ret;
>  			}
>  		}
> -- 
> 1.9.1
> 

-- 
~Vinod
