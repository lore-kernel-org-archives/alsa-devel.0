From: "Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 1/4] ASoC: simple-card: Fix device node locks
Date: Mon, 24 Feb 2014 02:17:00 +0000
Message-ID: <23e531e0edb34aa9b84799e558abaf26@BY2PR03MB505.namprd03.prod.outlook.com>
References: <cover.1392995566.git.moinejf@free.fr>
 <4dca81f45b67a4dcb21271e57409ba114c3b59cb.1392995566.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4dca81f45b67a4dcb21271e57409ba114c3b59cb.1392995566.git.moinejf-GANU6spQydw@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

> @@ -169,22 +164,26 @@ static int asoc_simple_card_parse_of(struct device_node
> *node,
>  	/* CPU sub-node */
>  	ret = -EINVAL;
>  	np = of_get_child_by_name(node, "simple-audio-card,cpu");
> -	if (np)
> +	if (np) {
>  		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
>  						  &priv->cpu_dai,
>  						  &dai_link->cpu_of_node,
>  						  &dai_link->cpu_dai_name);
> +		of_node_put(np);

Does the of_node_put(np) is really needed here ?


> +	}
>  	if (ret < 0)
>  		return ret;
> 
>  	/* CODEC sub-node */
>  	ret = -EINVAL;
>  	np = of_get_child_by_name(node, "simple-audio-card,codec");
> -	if (np)
> +	if (np) {
>  		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
>  						  &priv->codec_dai,
>  						  &dai_link->codec_of_node,
>  						  &dai_link->codec_dai_name);
> +		of_node_put(np);

The same here...

> +	}
>  	if (ret < 0)
>  		return ret;
> 

Thanks,

--
Best Regards,
Xiubo

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
