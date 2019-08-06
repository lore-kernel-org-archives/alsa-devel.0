From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 13/28] ASoC: soc-core: remove verbose debug
 message from soc_bind_dai_link()
Date: Tue, 6 Aug 2019 09:54:16 -0500
Message-ID: <ba8876cf-97cb-3ca4-b957-c7f4bd1636ef@linux.intel.com>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <87imrb2ify.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FA03F8011B
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 17:15:55 +0200 (CEST)
In-Reply-To: <87imrb2ify.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 8/5/19 8:29 PM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> soc_bind_dai_link() will print debug message if dai_link was
> already binded. But it is very verbose. Print dai_link name when
> first binding is very enough.
> This patch removes verbose debug message
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   sound/soc/soc-core.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index df0c22e..838a843 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -864,13 +864,10 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
>   	if (dai_link->ignore)
>   		return 0;
>   
> -	dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);
> -
> -	if (soc_is_dai_link_bound(card, dai_link)) {
> -		dev_dbg(card->dev, "ASoC: dai link %s already bound\n",
> -			dai_link->name);
> +	if (soc_is_dai_link_bound(card, dai_link))
>   		return 0;
> -	}
> +
> +	dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);

If you want to reduce verbosity, I would have kept the other message 
which tells you about a configuration error. Here you are reducing the 
ability to debug really.

>   
>   	rtd = soc_new_pcm_runtime(card, dai_link);
>   	if (!rtd)
> 
