From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 14/28] ASoC: soc-core: remove duplicated
 soc_is_dai_link_bound()
Date: Mon, 05 Aug 2019 21:49:55 -0700
Message-ID: <1a3810dbfe579b6d896bc9edc420c2320d631c30.camel@linux.intel.com>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <87h86v2ifr.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61DC3F800F4
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 06:49:59 +0200 (CEST)
In-Reply-To: <87h86v2ifr.wl-kuninori.morimoto.gx@renesas.com>
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

On Tue, 2019-08-06 at 10:29 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> soc_is_dai_link_bound() check will be called both
> *before* soc_bind_dai_link(), and
> *under*  soc_bind_dai_link().
> These are very verboqse.
> Let's remove one of them.
> 
> *	static int soc_bind_dai_link(...)
> 	{
> 		...
> =>		if (soc_is_dai_link_bound(...)) {
> 			...
> 			return 0;
> 		}
> 		...
> 	}
> 
> 	static int snd_soc_instantiate_card(...)
> 	{
> 		...
> 		for_each_card_links(...) {
> =>			if (soc_is_dai_link_bound(...))
> =>				continue;
> 			...
> *			ret = soc_bind_dai_link(...);
> 			if (ret)
> 				goto probe_end;
> 		}
> 		...
> 	}
Morimoto-san,

I think we should keep both the calls. The call to check if
(soc_is_dai_link_bound(...)) will prevent soc_init_dai_link() if the
dai link is already bound. 

Thanks,
Ranjani
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/soc-core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 838a843..e8ed57a 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2016,9 +2016,6 @@ static int snd_soc_instantiate_card(struct
> snd_soc_card *card)
>  	 * Components with topology may bring new DAIs and DAI links.
>  	 */
>  	for_each_card_links(card, dai_link) {
> -		if (soc_is_dai_link_bound(card, dai_link))
> -			continue;
> -
>  		ret = soc_init_dai_link(card, dai_link);
>  		if (ret)
>  			goto probe_end;
