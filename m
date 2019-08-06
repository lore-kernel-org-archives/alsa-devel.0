From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 09/28] ASoC: soc-core: don't check routes
 for snd_soc_dapm_add_routes()
Date: Mon, 05 Aug 2019 21:41:04 -0700
Message-ID: <3849f0d37debfab976f0c5be6d9afe77965a43e0.camel@linux.intel.com>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <87o9132ih0.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F006F8011B
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 06:41:07 +0200 (CEST)
In-Reply-To: <87o9132ih0.wl-kuninori.morimoto.gx@renesas.com>
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
> snd_soc_dapm_add_routes() registers routes by using
> for(... i < num; ...). If routes was NULL, num should be zero.
> Thus, we don't need to check about route pointer.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/soc-core.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 7be8385..5b26a59 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1307,10 +1307,9 @@ static int soc_probe_component(struct
> snd_soc_card *card,
>  	snd_soc_add_component_controls(component,
>  				       component->driver->controls,
>  				       component->driver-
> >num_controls);
> -	if (component->driver->dapm_routes)
> -		snd_soc_dapm_add_routes(dapm,
> -					component->driver->dapm_routes,
> -					component->driver-
> >num_dapm_routes);
> +	snd_soc_dapm_add_routes(dapm,
> +				component->driver->dapm_routes,
> +				component->driver->num_dapm_routes);
return value needs to be checked for all the snd_soc_dapm_add_routes()
calls?

Thanks,
Ranjani
>  
>  	list_add(&dapm->list, &card->dapm_list);
>  	/* see for_each_card_components */
> @@ -2053,13 +2052,11 @@ static int snd_soc_instantiate_card(struct
> snd_soc_card *card)
>  		snd_soc_add_card_controls(card, card->controls,
>  					  card->num_controls);
>  
> -	if (card->dapm_routes)
> -		snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
> -					card->num_dapm_routes);
> +	snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
> +				card->num_dapm_routes);
>  
> -	if (card->of_dapm_routes)
> -		snd_soc_dapm_add_routes(&card->dapm, card-
> >of_dapm_routes,
> -					card->num_of_dapm_routes);
> +	snd_soc_dapm_add_routes(&card->dapm, card->of_dapm_routes,
> +				card->num_of_dapm_routes);
>  
>  	/* try to set some sane longname if DMI is available */
>  	snd_soc_set_dmi_name(card, NULL);
