From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH][RFC] ASoC: add default xlate on
	snd_soc_of_get_dai_name()
Date: Wed, 16 Oct 2013 11:09:20 +0200
Message-ID: <525E57C0.6000508@metafoo.de>
References: <87li1vdx9y.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-202.synserver.de (smtp-out-202.synserver.de
 [212.40.185.202])
 by alsa0.perex.cz (Postfix) with ESMTP id A4CFA265083
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 11:07:14 +0200 (CEST)
In-Reply-To: <87li1vdx9y.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/15/2013 05:32 AM, Kuninori Morimoto wrote:
> Current snd_soc_of_get_dai_name() needs .of_xlate_dai_name()
> callback on each component drivers.
> But required behavior on almost all these drivers is
> just returns its indexed dai driver's name.
> 
> This patch adds this feature as default behavior.
> .of_xlate_dai_name() can overwrite it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

I'm not exactly sure if adding the dai_drv field to the component struct is
the right approach. But it doesn't look to intrusive and could be removed
again at some point, if it turns out there is a better way to do this.

[...]
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 711bd36..51ea2c3 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -4048,6 +4048,7 @@ __snd_soc_register_component(struct device *dev,
>  
>  	cmpnt->dev	= dev;
>  	cmpnt->driver	= cmpnt_drv;
> +	cmpnt->dai_drv	= dai_drv;
>  	cmpnt->num_dai	= num_dai;
>  
>  	/*
> @@ -4609,12 +4610,19 @@ int snd_soc_of_get_dai_name(struct device_node *of_node,
>  		if (pos->dev->of_node != args.np)
>  			continue;
>  
> -		if (!pos->driver->of_xlate_dai_name) {
> -			ret = -ENOSYS;
> -			break;
> +		if (pos->driver->of_xlate_dai_name) {
> +			ret = pos->driver->of_xlate_dai_name(pos, &args, dai_name);
> +		} else {
> +			int id = args.args[0];

You should check that args.args_count is 1. And maybe also allow args_count
to be 0 if the number of DAIs is 1.

> +
> +			if (id < 0 || id >= pos->num_dai) {
> +				ret = -EINVAL;
> +			} else {
> +				*dai_name = pos->dai_drv[id].name;
> +				ret = 0;
> +			}
>  		}
>  
> -		ret = pos->driver->of_xlate_dai_name(pos, &args, dai_name);
>  		break;
>  	}
>  	mutex_unlock(&client_mutex);
> 
