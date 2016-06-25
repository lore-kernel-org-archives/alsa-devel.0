From: Sylwester Nawrocki <sylwester.nawrocki@gmail.com>
Subject: Re: [PATCH 03/11] ASoC: simple-card-utils: add
 asoc_simple_card_parse_dailink_name()
Date: Sat, 25 Jun 2016 22:45:53 +0200
Message-ID: <576EED81.3010203@gmail.com>
References: <87wplfxumi.wl%kuninori.morimoto.gx@renesas.com>
 <87shw3xui4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87shw3xui4.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/24/2016 03:16 AM, Kuninori Morimoto wrote:

> +int asoc_simple_card_parse_dailink_name(struct device *dev,
> +					struct snd_soc_dai_link *dai_link)
> +{
> +	char *name = NULL;
> +	int ret = -ENOMEM;
> +
> +	if (dai_link->dynamic && dai_link->cpu_dai_name) {
> +		name = devm_kzalloc(dev,
> +				    strlen(dai_link->cpu_dai_name) + 4,
> +				    GFP_KERNEL);
> +		if (name)
> +			sprintf(name, "fe.%s", dai_link->cpu_dai_name);
> +
> +	} else if (dai_link->no_pcm && dai_link->codec_dai_name) {
> +		name = devm_kzalloc(dev,
> +				    strlen(dai_link->codec_dai_name) + 4,
> +				    GFP_KERNEL);
> +		if (name)
> +			sprintf(name, "be.%s", dai_link->codec_dai_name);
> +	} else if (dai_link->cpu_dai_name && dai_link->codec_dai_name) {
> +		name = devm_kzalloc(dev,
> +				    strlen(dai_link->cpu_dai_name)   +
> +				    strlen(dai_link->codec_dai_name) + 2,
> +				    GFP_KERNEL);
> +		if (name) {
> +			sprintf(name, "%s-%s",
> +				dai_link->cpu_dai_name,
> +				dai_link->codec_dai_name);
> +		}
> +	}

This could be simplified by using devm_kasprintf().
