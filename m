From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: soc-core: defer card registration
 if codec component is missing
Date: Wed, 26 Jun 2019 23:20:22 +0200
Message-ID: <8b4822f7-6671-1c23-572d-37f7e94ea8cc@linux.intel.com>
References: <20190626133617.25959-1-jbrunet@baylibre.com>
 <20190626133617.25959-2-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190626133617.25959-2-jbrunet@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 6/26/19 3:36 PM, Jerome Brunet wrote:
> Like cpus and platforms, defer sound card initialization if the codec
> component is missing when initializing the dai_link
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   sound/soc/soc-core.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 358f1fbf9a30..002ddbf4e5a3 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1064,12 +1064,20 @@ static int soc_init_dai_link(struct snd_soc_card *card,
>   				link->name);
>   			return -EINVAL;
>   		}
> +
>   		/* Codec DAI name must be specified */
>   		if (!codec->dai_name) {
>   			dev_err(card->dev, "ASoC: codec_dai_name not set for %s\n",
>   				link->name);
>   			return -EINVAL;
>   		}
> +
> +		/*
> +		 * Defer card registartion if codec component is not added to

registration

> +		 * component list.
> +		 */
> +		if (!soc_find_component(codec))
> +			return -EPROBE_DEFER;
>   	}
>   
>   	/*
> 
