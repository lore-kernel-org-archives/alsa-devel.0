From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ASoC: soc-core: call snd_soc_unbind_card()
 under mutex_lock;
Date: Mon, 24 Jun 2019 18:13:08 -0700
Message-ID: <c98d6db0d63f8ecb51a87209432f5f00d76eac78.camel@linux.intel.com>
References: <878stywfjt.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DCBC1F8065B
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2019 03:13:13 +0200 (CEST)
In-Reply-To: <878stywfjt.wl-kuninori.morimoto.gx@renesas.com>
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

On Wed, 2019-06-19 at 10:07 +0900, Kuninori Morimoto wrote:
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
> 
> commit 495f926c68ddb90 ("ASoC: core: Fix deadlock in
> snd_soc_instantiate_card()") tried to fixup it, but still not
> enough. We still have lockdep warning when we try unbind/bind.
> 
> We need mutex_lock() under snd_soc_unregister_card()
> instead of snd_remove_link_components()/snd_soc_unbind_card().
> 
> Fixes: 34ac3c3eb8f0c07 ("ASoC: core: lock client_mutex while removing
> link components")
> Fixes: 495f926c68ddb90 ("ASoC: core: Fix deadlock in
> snd_soc_instantiate_card()")
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

> ---
>  sound/soc/soc-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 2353886..2a408cc 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2747,14 +2747,12 @@ static void snd_soc_unbind_card(struct
> snd_soc_card *card, bool unregister)
>  		snd_soc_dapm_shutdown(card);
>  		snd_soc_flush_all_delayed_work(card);
>  
> -		mutex_lock(&client_mutex);
>  		/* remove all components used by DAI links on this card
> */
>  		for_each_comp_order(order) {
>  			for_each_card_rtds(card, rtd) {
>  				soc_remove_link_components(card, rtd,
> order);
>  			}
>  		}
> -		mutex_unlock(&client_mutex);
>  
>  		soc_cleanup_card_resources(card);
>  		if (!unregister)
> @@ -2773,7 +2771,9 @@ static void snd_soc_unbind_card(struct
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
