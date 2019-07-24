From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 09/25] ASoC: soc-component: add
 snd_soc_component_pointer()
Date: Wed, 24 Jul 2019 10:13:44 +0100
Message-ID: <20190724091344.GT54126@ediswmail.ad.cirrus.com>
References: <8736iwurtc.wl-kuninori.morimoto.gx@renesas.com>
 <87pnm0td6q.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C7D4F800E8
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2019 11:13:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87pnm0td6q.wl-kuninori.morimoto.gx@renesas.com>
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

On Wed, Jul 24, 2019 at 10:52:00AM +0900, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current ALSA SoC is directly using component->driver->ops->xxx,
> thus, it is deep nested, and makes code difficult to read,
> and is not good for encapsulation.
> This patch adds new snd_soc_component_pointer() and use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> +int snd_soc_component_pointer(struct snd_soc_component *component,
> +			      struct snd_pcm_substream *substream)
> +{
> +	if (component->driver->ops &&
> +	    component->driver->ops->pointer)
> +		return component->driver->ops->pointer(substream);
> +
> +	return 0;
> +}
>
> @@ -1115,13 +1115,10 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>  	for_each_rtdcom(rtd, rtdcom) {
>  		component = rtdcom->component;
>  
> -		if (!component->driver->ops ||
> -		    !component->driver->ops->pointer)
> -			continue;
> -
> +		offset = snd_soc_component_pointer(component, substream);
>  		/* FIXME: use 1st pointer */
> -		offset = component->driver->ops->pointer(substream);
> -		break;
> +		if (offset > 0)
> +			break;

This doesn't feel like it is equivalent to the previous code, is
zero not a valid value for pointer to return?

Thanks,
Charles
