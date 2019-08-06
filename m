From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 07/28] ASoC: soc-core: don't check widget
 for snd_soc_dapm_new_controls()
Date: Mon, 05 Aug 2019 21:35:58 -0700
Message-ID: <203f012de6a77b8994060448b30dc795f03a0528.camel@linux.intel.com>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <87r25z2ihd.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0096FF800F3
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 06:36:02 +0200 (CEST)
In-Reply-To: <87r25z2ihd.wl-kuninori.morimoto.gx@renesas.com>
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
> snd_soc_dapm_new_controls() registers controls by using
> for(... i < num; ...). It means if widget was NULL, num should be
> zero.
> Thus, we don't need to check about widget pointer.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/soc-core.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 6347d65..bdd6a2e 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1264,16 +1264,14 @@ static int soc_probe_component(struct
> snd_soc_card *card,
>  
>  	soc_init_component_debugfs(component);
>  
> -	if (component->driver->dapm_widgets) {
> -		ret = snd_soc_dapm_new_controls(dapm,
> +	ret = snd_soc_dapm_new_controls(dapm,
>  					component->driver-
> >dapm_widgets,
>  					component->driver-
> >num_dapm_widgets);
>  
> -		if (ret != 0) {
> -			dev_err(component->dev,
> -				"Failed to create new controls %d\n",
> ret);
> -			goto err_probe;
> -		}
> +	if (ret != 0) {
> +		dev_err(component->dev,
> +			"Failed to create new controls %d\n", ret);
> +		goto err_probe;
>  	}
>  
>  	for_each_component_dais(component, dai) {
> @@ -1989,13 +1987,11 @@ static int snd_soc_instantiate_card(struct
> snd_soc_card *card)
>  	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
>  #endif
>  
> -	if (card->dapm_widgets)
> -		snd_soc_dapm_new_controls(&card->dapm, card-
> >dapm_widgets,
> -					  card->num_dapm_widgets);
> +	snd_soc_dapm_new_controls(&card->dapm, card->dapm_widgets,
> +				  card->num_dapm_widgets);
Should the return value be checked here?
>  
> -	if (card->of_dapm_widgets)
> -		snd_soc_dapm_new_controls(&card->dapm, card-
> >of_dapm_widgets,
> -					  card->num_of_dapm_widgets);
> +	snd_soc_dapm_new_controls(&card->dapm, card->of_dapm_widgets,
> +				  card->num_of_dapm_widgets);
and here?

Thanks,
Ranjani
