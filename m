From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 08/28] ASoC: soc-core: don't check controls
 for snd_soc_add_component_controls()
Date: Mon, 05 Aug 2019 21:38:34 -0700
Message-ID: <be2a83d94bce44931ffa16ec5c6a33b153b100fb.camel@linux.intel.com>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <87pnlj2ih6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8AD94F800F3
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 06:38:36 +0200 (CEST)
In-Reply-To: <87pnlj2ih6.wl-kuninori.morimoto.gx@renesas.com>
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

On Tue, 2019-08-06 at 10:28 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> snd_soc_add_component_controls() registers controls by using
> for(... i < num; ...). If controls was NULL, num should be zero.
> Thus, we don't need to check about controls pointer.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/soc-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index bdd6a2e..7be8385 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1304,10 +1304,9 @@ static int soc_probe_component(struct
> snd_soc_card *card,
>  		}
>  	}
>  
> -	if (component->driver->controls)
> -		snd_soc_add_component_controls(component,
> -					       component->driver-
> >controls,
> -					       component->driver-
> >num_controls);
> +	snd_soc_add_component_controls(component,
> +				       component->driver->controls,
> +				       component->driver-
> >num_controls);
Should the return value be checked?

Thanks,
Ranjani

>  	if (component->driver->dapm_routes)
>  		snd_soc_dapm_add_routes(dapm,
>  					component->driver->dapm_routes,
