From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 2/4] ASoC: simple-card: dynamically
 allocate the DAI link array
Date: Mon, 24 Feb 2014 03:32:02 +0000
Message-ID: <397c6a465f424a3eb42ead8f1e55f7d9@BY2PR03MB505.namprd03.prod.outlook.com>
References: <cover.1392995566.git.moinejf@free.fr>
 <41aa7354a6883f31afa60c21c2e14ecbb3bbb7e9.1392995566.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D4EA2651EB
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 04:32:06 +0100 (CET)
In-Reply-To: <41aa7354a6883f31afa60c21c2e14ecbb3bbb7e9.1392995566.git.moinejf@free.fr>
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
To: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org



> @@ -20,7 +20,6 @@ struct simple_card_data {
>  	unsigned int daifmt;
>  	struct asoc_simple_dai cpu_dai;
>  	struct asoc_simple_dai codec_dai;
> -	struct snd_soc_dai_link snd_link;
>  };
> 
>  static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
> @@ -246,7 +245,9 @@ static int asoc_simple_card_probe(struct platform_device
> *pdev)
>  	struct device *dev = &pdev->dev;
>  	int ret;
> 
> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	priv = devm_kzalloc(dev,
> +			sizeof(*priv) + sizeof(*dai_link),

This is okey for me.

Well, how about splitting the *priv and *dai_link into two separated
memory blocks? As we can get the dai-link pointer via priv->snd_card.dai_link
in other places.

IMHO, then the code will be much more simplifier and readable.

Just for one suggestion.

Thanks,

--
Best regards,
Xiubo


> +			GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> 
> @@ -255,7 +256,7 @@ static int asoc_simple_card_probe(struct platform_device
> *pdev)
>  	 */
>  	priv->snd_card.owner = THIS_MODULE;
>  	priv->snd_card.dev = dev;
> -	dai_link = &priv->snd_link;
> +	dai_link = (struct snd_soc_dai_link *) (priv + 1);
>  	priv->snd_card.dai_link = dai_link;
>  	priv->snd_card.num_links = 1;
> 
> --
> 1.9.0
> 
> 
