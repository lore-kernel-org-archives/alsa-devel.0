From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ASoC: soc-core: call snd_soc_unbind_card()
 under mutex_lock;
Date: Mon, 10 Jun 2019 09:27:41 -0700
Message-ID: <e111b6362100444554fba6d5929c6dfa2ceefbaf.camel@linux.intel.com>
References: <87imtev0l2.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48A1FF80791
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2019 18:27:46 +0200 (CEST)
In-Reply-To: <87imtev0l2.wl-kuninori.morimoto.gx@renesas.com>
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

On Mon, 2019-06-10 at 09:49 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> commit 34ac3c3eb8f0c07 ("ASoC: core: lock client_mutex while removing
> link components") added mutex_lock() at soc_remove_link_components().
> 
> Is is called from snd_soc_unbind_card()
> 
> 	snd_soc_unbind_card()
> =>		soc_remove_link_components()
> 		soc_cleanup_card_resources()
> 			soc_remove_dai_links()
> =>				soc_remove_link_components()
> 
> And, there are 2 way to call it.
> 
> (1)
> 	snd_soc_unregister_component()
> **		mutex_lock()
> 			snd_soc_component_del_unlocked()
> =>				snd_soc_unbind_card()
> **		mutex_unlock()
> 
> (2)
> 	snd_soc_unregister_card()
> =>		snd_soc_unbind_card()
> 
> (1) case is already using mutex_lock() when it calles
> snd_soc_unbind_card(), thus, we will get lockdep warning.
> We need mutex_lock() under snd_soc_unregister_card()
> instead of snd_remove_link_components().
Thanks, Morimoto-san. I submitted a solution to fix the deadlock just a
couple of days ago as well (
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-June/150764.html
). 

I am fine with either solution though. 

Thanks,
Ranjani
> 
> Fixes: 34ac3c3eb8f0c07 ("ASoC: core: lock client_mutex while removing
> link components")
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/soc-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 94a36ee..1679990 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1018,14 +1018,12 @@ static void soc_remove_link_components(struct
> snd_soc_card *card,
>  	struct snd_soc_component *component;
>  	struct snd_soc_rtdcom_list *rtdcom;
>  
> -	mutex_lock(&client_mutex);
>  	for_each_rtdcom(rtd, rtdcom) {
>  		component = rtdcom->component;
>  
>  		if (component->driver->remove_order == order)
>  			soc_remove_component(component);
>  	}
> -	mutex_unlock(&client_mutex);
>  }
>  
>  static void soc_remove_dai_links(struct snd_soc_card *card)
> @@ -2774,7 +2772,9 @@ static void snd_soc_unbind_card(struct
> snd_soc_card *card, bool unregister)
>   */
>  int snd_soc_unregister_card(struct snd_soc_card *card)
>  {
> +	mutex_lock(&client_mutex);
>  	snd_soc_unbind_card(card, true);
> +	mutex_unlock(&client_mutex);
>  	dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card-
> >name);
>  
>  	return 0;
