From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: cht_bsw_max98090: remove
 useless code, align with ChromeOS driver
Date: Mon, 9 Oct 2017 14:46:14 +0530
Message-ID: <20171009091614.GT30097@localhost>
References: <20171005040427.26612-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 032F726716A
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 11:12:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171005040427.26612-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Thierry Escande <thierry.escande@collabora.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 04, 2017 at 11:04:27PM -0500, Pierre-Louis Bossart wrote:
> Remove dead code which was missed in previous changes. This is not
> visible with git diff but there is a test+return on the same condition
> just above.
> 
> Also reuse local variable instead of fetching the jack information twice.
> 
> Tested on Acer R11 (cyan)

Acked-By: Vinod Koul <vinod.koul@intel.com>


> Fixes: 3bbda5a38601 ('ASoC: Intel: cht_bsw_max98090_ti: Fix jack initialization')
> Cc: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/intel/boards/cht_bsw_max98090_ti.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> index 74c047a4b05c..119da5503fee 100644
> --- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> +++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> @@ -219,10 +219,6 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
>  		return ret;
>  	}
>  
> -
> -	if (ctx->ts3a227e_present)
> -		snd_soc_jack_notifier_register(jack, &cht_jack_nb);
> -
>  	ret = snd_soc_jack_add_gpiods(runtime->card->dev->parent, jack,
>  				      ARRAY_SIZE(hs_jack_gpios),
>  				      hs_jack_gpios);
> @@ -323,7 +319,7 @@ static int cht_max98090_headset_init(struct snd_soc_component *component)
>  		return ret;
>  	}
>  
> -	return ts3a227e_enable_jack_detect(component, &ctx->jack);
> +	return ts3a227e_enable_jack_detect(component, jack);
>  }
>  
>  static const struct snd_soc_ops cht_aif1_ops = {
> -- 
> 2.11.0
> 

-- 
~Vinod
