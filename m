From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 16/28] ASoC: soc-core: initialize rtd->list
Date: Mon, 05 Aug 2019 22:00:05 -0700
Message-ID: <d39ec17119eee48eaedae7282bf4906534155926.camel@linux.intel.com>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <87ef1z2ife.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10883F800F4
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 07:00:08 +0200 (CEST)
In-Reply-To: <87ef1z2ife.wl-kuninori.morimoto.gx@renesas.com>
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
> No one initialize rtd->list, so far.
> Let's do it.
Morimoto-san,

I dont think this is needed. The rtd->list is not meant to be a list
but rather just as a member of the card->rtd_list. So no need to
initialize.

Thanks,
Ranjani
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/soc-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 2536ba4..2347b58 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -354,6 +354,7 @@ static struct snd_soc_pcm_runtime
> *soc_new_pcm_runtime(
>  	if (!rtd)
>  		return NULL;
>  
> +	INIT_LIST_HEAD(&rtd->list);
>  	INIT_LIST_HEAD(&rtd->component_list);
>  	rtd->card = card;
>  	rtd->dai_link = dai_link;
