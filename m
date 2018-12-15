From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] ASoC: simple-card-utils: fixup
 asoc_simple_card_get_dai_id() ID method
Date: Sat, 15 Dec 2018 09:16:54 +0900
Message-ID: <9040fb84-8978-71d6-a8aa-8b10b08564fe@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www501.sakura.ne.jp (www501.sakura.ne.jp [59.106.13.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DE6526798A
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2018 01:16:59 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Morioto-san,

On 2018/12/14 11:29, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> commit b6f3fc005a2c8 ("ASoC: simple-card-utils: fixup
> asoc_simple_card_get_dai_id() counting") fixuped getting DAI ID method.
> It will get DAI ID from OF graph "port", but, we want to consider about
> "endpoint", too.
> And, we also want to keep compatibility.
> 
> This patch fixup it as
> 
> 	if (driver has specified DAI ID)
> 		use it as DAI ID
> 	else if (OF graph endpoint has reg)
> 		use it as DAI ID
> 	else if (OF graph port has reg)
> 		use it as DAI ID
> 	else
> 		use endpoint count as DAI ID
> 
> Fixes: commit b6f3fc005a2c8 ("ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id() counting")
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Tony Lindgren <tony@atomide.com>

Sorry for late reply.
It works fine with our devicetree that doesn't have 'reg' properties.

Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

> ---
>   sound/soc/generic/simple-card-utils.c | 32 ++++++++++++++++++++++++++++----
>   1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
> index 17d8aee..b807a47 100644
> --- a/sound/soc/generic/simple-card-utils.c
> +++ b/sound/soc/generic/simple-card-utils.c
> @@ -269,22 +269,46 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_parse_dai);
>   
>   static int asoc_simple_card_get_dai_id(struct device_node *ep)
>   {
> +	struct device_node *node;
> +	struct device_node *endpoint;
>   	struct of_endpoint info;
> +	int i, id;
>   	int ret;
>   
> +	/* use driver specified DAI ID if exist */
>   	ret = snd_soc_get_dai_id(ep);
>   	if (ret != -ENOTSUPP)
>   		return ret;
>   
> +	/* use endpoint/port reg if exist */
> +	ret = of_graph_parse_endpoint(ep, &info);
> +	if (ret == 0) {
> +		if (info.id)
> +			return info.id;
> +		if (info.port)
> +			return info.port;
> +	}
> +
> +	node = of_graph_get_port_parent(ep);
> +
>   	/*
>   	 * Non HDMI sound case, counting port/endpoint on its DT
>   	 * is enough. Let's count it.
>   	 */
> -	ret = of_graph_parse_endpoint(ep, &info);
> -	if (ret)
> -		return -ENXIO;
> +	i = 0;
> +	id = -1;
> +	for_each_endpoint_of_node(node, endpoint) {
> +		if (endpoint == ep)
> +			id = i;
> +		i++;
> +	}
> +
> +	of_node_put(node);
> +
> +	if (id < 0)
> +		return -ENODEV;
>   
> -	return info.port;
> +	return id;
>   }
>   
>   int asoc_simple_card_parse_graph_dai(struct device_node *ep,
> 
