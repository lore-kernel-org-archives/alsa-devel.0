From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 05/25] ASoC: soc-component: add
 snd_soc_component_prepare()
Date: Thu, 25 Jul 2019 21:59:42 +0200
Message-ID: <2d2e6827-1c57-caf4-88ed-4b61f3b5a990@intel.com>
References: <8736iwurtc.wl-kuninori.morimoto.gx@renesas.com>
 <87v9vstd7a.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EACF5F800E8
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 21:59:48 +0200 (CEST)
In-Reply-To: <87v9vstd7a.wl-kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 2019-07-24 03:51, Kuninori Morimoto wrote:> +
> +int snd_soc_component_prepare(struct snd_soc_component *component,
> +			      struct snd_pcm_substream *substream)
> +{
> +	if (component->driver->ops &&
> +	    component->driver->ops->prepare)
> +		return component->driver->ops->prepare(substream);
> +
> +	return 0;
> +}
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 86d2e6b..a77a14c 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -774,11 +774,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
>   	for_each_rtdcom(rtd, rtdcom) {
>   		component = rtdcom->component;
>   
> -		if (!component->driver->ops ||
> -		    !component->driver->ops->prepare)
> -			continue;
> -
> -		ret = component->driver->ops->prepare(substream);
> +		snd_soc_component_prepare(component, substream);
>   		if (ret < 0) {
>   			dev_err(component->dev,
>   				"ASoC: platform prepare error: %d\n", ret);
> 

Compared to old code, ret gets ignored here. Guess unintended modification?
