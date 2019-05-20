From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: soc-pcm: fixup
 try_module_get()/module_put() timing
Date: Mon, 20 May 2019 08:29:50 -0500
Message-ID: <deb932a6-32cf-d455-e609-ea4657ecb229@linux.intel.com>
References: <87imu5zzh7.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C38BF80726
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2019 15:29:58 +0200 (CEST)
In-Reply-To: <87imu5zzh7.wl-kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



On 5/19/19 8:42 PM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> soc_pcm_components_open/close() try to call
> try_module_get()/module_put() based on
> component->driver->module_get_upon_open.
> 
> Here, the purpose why we need to call these functions are to
> checking module reference.
> Thus, we need to call try_module_open() even though it doesn't
> have .open callback.
> 
> The same reason, we need to call module_put() even though it
> doesn't have .close
> 
> This patch calls try_module_get()/module_put() regardless of
> .open/.close
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


LGTM, this removes the assumptions on the implementation of .open and 
.close.

FWIW
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks!

> ---
> v1 -> v2
> 
>   - merge both try_module_get()/module_put() patch into 1
> 
>   sound/soc/soc-pcm.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 7737e00..e24eab3 100644
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
> @@ -477,11 +477,9 @@ static int soc_pcm_components_close(struct snd_pcm_substream *substream,
>   		if (component == last)
>   			break;
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
>   		if (component->driver->module_get_upon_open)
>   			module_put(component->dev->driver->owner);
> 
