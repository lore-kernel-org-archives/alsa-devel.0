From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v2 19/25] ASoC: soc-core: don't call
 snd_soc_component_set_jack()
Date: Wed, 7 Aug 2019 20:49:09 +0200
Message-ID: <f3ead090-8c2c-6be5-70b8-c6530239302a@intel.com>
References: <87pnlhahr6.wl-kuninori.morimoto.gx@renesas.com>
 <87y305932s.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1671F800E4
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 20:49:15 +0200 (CEST)
In-Reply-To: <87y305932s.wl-kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 2019-08-07 03:31, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> snd_soc_component_set_jack() is used for both setting/clearing.
> Setting purpose is used under each driver.
> Hence, clearing purpose should be used under each driver, not soc-core.
> 
> soc-core shouldn't touch it even though its purpose was for clearing,
> otherwise, code becomes very confusable.
> This patch removes snd_soc_component_set_jack() from soc-core.c
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
> 	- no change
> 
>   sound/soc/soc-core.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 80703618..e708095 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -938,7 +938,6 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
>   
>   static void soc_cleanup_component(struct snd_soc_component *component)
>   {
> -	snd_soc_component_set_jack(component, NULL, NULL);
>   	list_del(&component->card_list);
>   	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
>   	soc_cleanup_component_debugfs(component);
> 

This has been added lately for a reason - reload/ unload series.
Amadeusz, could you comment on this change?
