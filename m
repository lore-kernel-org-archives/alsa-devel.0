From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Provide a dummy wrapper of
 snd_soc_set_dmi_name()
Date: Fri, 21 Apr 2017 20:43:02 +0100
Message-ID: <1492803782.2527.123.camel@loki>
References: <20170421155525.15012-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D5CC326727F
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 21:43:11 +0200 (CEST)
In-Reply-To: <20170421155525.15012-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-04-21 at 17:55 +0200, Takashi Iwai wrote:
> For systems without DMI, it makes no sense to have the code.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---

Both :-

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>

>  include/sound/soc.h  | 8 ++++++++
>  sound/soc/soc-core.c | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index cdfb55f7aede..915c06cb2b32 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -497,7 +497,15 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream);
>  int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>  	unsigned int dai_fmt);
>  
> +#ifdef CONFIG_DMI
>  int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour);
> +#else
> +static inline int snd_soc_set_dmi_name(struct snd_soc_card *card,
> +				       const char *flavour)
> +{
> +	return 0;
> +}
> +#endif
>  
>  /* Utility functions to get clock rates from various things */
>  int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 2722bb0c5573..aac73ff8a92a 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1918,6 +1918,7 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>  EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
>  
> 
> +#ifdef CONFIG_DMI
>  /* Trim special characters, and replace '-' with '_' since '-' is used to
>   * separate different DMI fields in the card long name. Only number and
>   * alphabet characters and a few separator characters are kept.
> @@ -2049,6 +2050,7 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_set_dmi_name);
> +#endif /* CONFIG_DMI */
>  
>  static int snd_soc_instantiate_card(struct snd_soc_card *card)
>  {
