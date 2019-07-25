From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 07/25] ASoC: soc-component: add
 snd_soc_component_hw_free()
Date: Wed, 24 Jul 2019 17:35:10 -0700
Message-ID: <31817869f1121bdaf5ce6806342d9fe93538b347.camel@linux.intel.com>
References: <8736iwurtc.wl-kuninori.morimoto.gx@renesas.com>
 <87sgqwtd71.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2845CF8026F
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 02:35:14 +0200 (CEST)
In-Reply-To: <87sgqwtd71.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-07-24 at 10:51 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current ALSA SoC is directly using component->driver->ops->xxx,
> thus, it is deep nested, and makes code difficult to read,
> and is not good for encapsulation.
> This patch adds new snd_soc_component_hw_free() and use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/soc-component.h |  2 ++
>  sound/soc/soc-component.c     | 10 ++++++++++
>  sound/soc/soc-pcm.c           |  6 +-----
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/include/sound/soc-component.h b/include/sound/soc-
> component.h
> index ac93189..9ec67a3 100644
> --- a/include/sound/soc-component.h
> +++ b/include/sound/soc-component.h
> @@ -332,5 +332,7 @@ int snd_soc_component_prepare(struct
> snd_soc_component *component,
>  int snd_soc_component_hw_params(struct snd_soc_component *component,
>  				struct snd_pcm_substream *substream,
>  				struct snd_pcm_hw_params *params);
> +int snd_soc_component_hw_free(struct snd_soc_component *component,
> +			      struct snd_pcm_substream *substream);
>  
>  #endif /* __SOC_COMPONENT_H */
> diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
> index 249dac4..7246518 100644
> --- a/sound/soc/soc-component.c
> +++ b/sound/soc/soc-component.c
> @@ -326,3 +326,13 @@ int snd_soc_component_hw_params(struct
> snd_soc_component *component,
>  
>  	return 0;
>  }
> +
> +int snd_soc_component_hw_free(struct snd_soc_component *component,
> +			       struct snd_pcm_substream *substream)
> +{
> +	if (component->driver->ops &&
> +	    component->driver->ops->hw_free)
> +		return component->driver->ops->hw_free(substream);
> +
> +	return 0;
> +}
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 26f73af..780a119 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -843,11 +843,7 @@ static int soc_pcm_components_hw_free(struct
> snd_pcm_substream *substream,
>  		if (component == last)
>  			break;
>  
> -		if (!component->driver->ops ||
> -		    !component->driver->ops->hw_free)
> -			continue;
> -
> -		component->driver->ops->hw_free(substream);
> +		snd_soc_component_hw_free(component, substream);
Morimoto-san,

Just wondering why we dont care about the return value here. I see that
the original code ignores the return value too but is it something that
should be addressed?

Thanks,
Ranjani
>  	}
>  
>  	return 0;
