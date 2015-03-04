From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH] ASoC: simple-card: Add a NULL pointer check in asoc_simple_card_dai_link_of
Date: Wed, 04 Mar 2015 21:29:55 +0100
Message-ID: <54F76B43.3030602@bfs.de>
References: <20150303132900.GA22246@vishal>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20150303132900.GA22246@vishal>
Sender: kernel-janitors-owner@vger.kernel.org
To: Vishal Thanki <vishalthanki@gmail.com>
Cc: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



Am 03.03.2015 14:29, schrieb Vishal Thanki:
> Make sure devm_kzalloc() succeeds.
> 
> Signed-off-by: Vishal Thanki <vishalthanki@gmail.com>
> ---
>  sound/soc/generic/simple-card.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> index f7c6734..fb550b5 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -372,6 +372,11 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
>  			    strlen(dai_link->cpu_dai_name)   +
>  			    strlen(dai_link->codec_dai_name) + 2,
>  			    GFP_KERNEL);
> +	if (!name) {
> +		ret = -ENOMEM;
> +		goto dai_link_of_err;
> +	}
> +
>  	sprintf(name, "%s-%s", dai_link->cpu_dai_name,
>  				dai_link->codec_dai_name);
>  	dai_link->name = dai_link->stream_name = name;


maybe it is more simple to use kasprintf here ?

just my 2 cents,
wh

