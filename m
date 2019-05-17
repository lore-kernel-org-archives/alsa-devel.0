From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH][RFC] ASoC: soc-dpm: fixup DAI active
 unbalance
Date: Thu, 16 May 2019 22:21:31 -0500
Message-ID: <34505df5-e479-679c-7c67-ecb45d61414b@linux.intel.com>
References: <87mujl3n4t.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BD8AF806E7
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2019 05:21:35 +0200 (CEST)
In-Reply-To: <87mujl3n4t.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Vinod Koul <vkoul@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 5/16/19 8:21 PM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> snd_soc_dai_link_event() is updating snd_soc_dai :: active,
> but it is unbalance.
> It counts up if it has startup callback.
> 
> 	case SND_SOC_DAPM_PRE_PMU:
> 		...
> 		snd_soc_dapm_widget_for_each_source_path(w, path) {
> 			...
> 			if (source->driver->ops->startup) {
> 				...
> =>				source->active++;
> 			}
> 			...
> 		}
> 		...
> 
> But, always counts down
> 
> 	case SND_SOC_DAPM_PRE_PMD:
> 		...
> 		snd_soc_dapm_widget_for_each_source_path(w, path) {
> 			...
> =>			source->active--;
> 			...
> 		}
> 
> This patch always counts up when SND_SOC_DAPM_PRE_PMD.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> Mark, Liam
> 
> I think this is bug, but I can't confirm it,
> because my driver need to have .startup.
> Thus, I added [RFC] on this patch.
> I'm happy if someone can confirm it.

This looks like a bug since the initial Intel contribution in 2015. 
9b8ef9f6b3fc ('ASoC: dapm: Add startup & shutdown for dai_links') 
already has this imbalance.

I don't have a clue why this is not symmetric or not done as suggested 
by Morimoto-san. Vinod, any idea?

> 
>   sound/soc/soc-dapm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index c864502..147ad9d 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -3828,8 +3828,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
>   						ret);
>   					goto out;
>   				}
> -				source->active++;
>   			}
> +			source->active++;
>   			ret = soc_dai_hw_params(&substream, params, source);
>   			if (ret < 0)
>   				goto out;
> @@ -3850,8 +3850,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
>   						ret);
>   					goto out;
>   				}
> -				sink->active++;
>   			}
> +			sink->active++;
>   			ret = soc_dai_hw_params(&substream, params, sink);
>   			if (ret < 0)
>   				goto out;
> 
