From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH][RFC] ASoC: soc-pcm: fixup try_module_get()
	calling timing
Date: Fri, 17 May 2019 08:22:08 -0500
Message-ID: <c1fb57af-0710-98ca-9cc2-05e14dd221ac@linux.intel.com>
References: <87h89t39t6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98E16F806E7
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2019 15:22:11 +0200 (CEST)
In-Reply-To: <87h89t39t6.wl-kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Vinod Koul <vkoul@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 5/17/19 1:08 AM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> soc_pcm_components_open() try to call try_module_get()
> based on component->driver->module_get_upon_open.
> But, it should be always called, not relatead to .open callback.
> It should be called at (A) istead of (B)
> 
> => (A)
> 	if (!component->driver->ops ||
> 	    !component->driver->ops->open)
> 		continue;
> => (B)
> 	if (component->driver->module_get_upon_open &&
> 	    !try_module_get(component->dev->driver->owner)) {
> 		...
> 	}
> 
> 	ret = component->driver->ops->open(substream);
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> Mark, Pierre-Louis, Vinod, Liam
> 
> I think this patch is correct, but I'm not sure.
> I'm happy if someone can confirm it.

The try_module_get()/module_put() mechanism is based on the assumption 
that the .open and .close callbacks are both mandatory.

open flow:
		if (!component->driver->ops ||
		    !component->driver->ops->open)
			continue;

		if (component->driver->module_get_upon_open &&
		    !try_module_get(component->dev->driver->owner)) {
			ret = -ENODEV;
			goto module_err;
		}

		ret = component->driver->ops->open(substream);

close flow:
		if (!component->driver->ops ||
		    !component->driver->ops->close)
			continue;

		component->driver->ops->close(substream);

		if (component->driver->module_get_upon_open)
			module_put(component->dev->driver->owner);

it'd be odd to allow the refcount to be increased when there is no 
.open, since if there is no .close either then the refcount never decreases.

> 
> 
>   sound/soc/soc-pcm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 7737e00..7b4cda6 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -440,10 +440,6 @@ static int soc_pcm_components_open(struct snd_pcm_substream *substream,
>   		component = rtdcom->component;
>   		*last = component;
>   
> -		if (!component->driver->ops ||
> -		    !component->driver->ops->open)
> -			continue;
> -
>   		if (component->driver->module_get_upon_open &&
>   		    !try_module_get(component->dev->driver->owner)) {
>   			dev_err(component->dev,
> @@ -452,6 +448,10 @@ static int soc_pcm_components_open(struct snd_pcm_substream *substream,
>   			return -ENODEV;
>   		}
>   
> +		if (!component->driver->ops ||
> +		    !component->driver->ops->open)
> +			continue;
> +
>   		ret = component->driver->ops->open(substream);
>   		if (ret < 0) {
>   			dev_err(component->dev,
> 
