From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH][RFC] ASoC: soc-pcm: fixup module_put()
 calling timing
Date: Sat, 18 May 2019 10:53:02 -0700
Message-ID: <507314777fe91504238a26135614844209dd53b8.camel@linux.intel.com>
References: <87ef4x33wh.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B388AF806E7
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2019 19:53:05 +0200 (CEST)
In-Reply-To: <87ef4x33wh.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Vinod Koul <vkoul@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2019-05-17 at 17:16 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> soc_pcm_components_close() try to call module_put()
> based on component->driver->module_get_upon_open.
> But, it should be called even though it doesn't have .close callback.
I think this makes sense. Thanks!

Ranjani
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> Mark, Pierre-Louis, Vinod, Liam
> 
> I think this patch is correct, but I'm not sure.
> I'm happy if someone can confirm it.
> 
>  sound/soc/soc-pcm.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 7b4cda6..e24eab3 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -477,11 +477,9 @@ static int soc_pcm_components_close(struct
> snd_pcm_substream *substream,
>  		if (component == last)
>  			break;
>  
> -		if (!component->driver->ops ||
> -		    !component->driver->ops->close)
> -			continue;
> -
> -		component->driver->ops->close(substream);
> +		if (component->driver->ops &&
> +		    component->driver->ops->close)
> +			component->driver->ops->close(substream);
>  
>  		if (component->driver->module_get_upon_open)
>  			module_put(component->dev->driver->owner);
