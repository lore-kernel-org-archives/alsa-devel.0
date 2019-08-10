From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 13/15] ASoC: soc-core: remove legacy style
	of aux_dev
Date: Sat, 10 Aug 2019 12:20:36 +0300
Message-ID: <0b60fbc7-61ad-af8d-50c5-5953e0c7a9d4@bitmer.com>
References: <87zhkk6wdy.wl-kuninori.morimoto.gx@renesas.com>
 <87h86s6w8x.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (50-87-157-213.static.tentacle.fi [213.157.87.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6058DF800E4
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2019 11:21:31 +0200 (CEST)
In-Reply-To: <87h86s6w8x.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <maxime.ripard@bootlin.com>, Jie Yang <yang.jie@linux.intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Richard Fontana <rfontana@redhat.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Jerome Brunet <jbrunet@baylibre.com>, Anders Roxell <anders.roxell@linaro.org>, Kevin Hilman <khilman@baylibre.com>, YueHaibing <yuehaibing@huawei.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@google.com>, Chen-Yu Tsai <wens@csie.org>, Georgii Staroselski i <georgii.staroselskii@emlid.com>, Danny Milosavljevic <dannym@scratchpost.org>, Hans de Goede <hdegoede@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>Alexios Zavras <al>
List-Id: alsa-devel@alsa-project.org

On 8/8/19 8:54 AM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Now all drivers are using snd_soc_dai_link_component for aux_dev.
> Let's remove legacy style
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/soc.h  | 9 ---------
>  sound/soc/soc-core.c | 6 ------
>  2 files changed, 15 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 9dad2bf..ebc0645 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -963,19 +963,10 @@ struct snd_soc_codec_conf {
>  };
>  
>  struct snd_soc_aux_dev {
> -	const char *name;		/* Codec name */
> -
>  	/*
>  	 * specify multi-codec either by device name, or by
>  	 * DT/OF node, but not both.
>  	 */
> -	const char *codec_name;
> -	struct device_node *codec_of_node;
> -
> -	/*
> -	 * name, codec_name, codec_of_node will be replaced
> -	 * into dlc. don't use both in the same time
> -	 */
>  	struct snd_soc_dai_link_component dlc;
>  
>  	/* codec/machine specific init - e.g. add machine controls */
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index ecaea88..8bfe421 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
