From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 25/28] ASoC: soc-core: initialize component
 list
Date: Tue, 6 Aug 2019 10:07:22 -0500
Message-ID: <7dc56456-3f31-966a-ca09-a24363c8c217@linux.intel.com>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <871rxz2idw.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5101F805E2
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 17:16:17 +0200 (CEST)
In-Reply-To: <871rxz2idw.wl-kuninori.morimoto.gx@renesas.com>
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



On 8/5/19 8:30 PM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> snd_soc_component_initialize() isn't initialize component->list,

doesn't

> but we should do it.
> This patch initialize it.

initializes

> It might return without initializing in error case.
> In such case, uninitialized list might be used at error handler.
> This patch initializes all necessary variable before return.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   sound/soc/soc-core.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 75b1770..666851b 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2641,6 +2641,10 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
>   {
>   	struct snd_soc_dapm_context *dapm;
>   
> +	INIT_LIST_HEAD(&component->dai_list);
> +	INIT_LIST_HEAD(&component->list);

is this actually required or is this 'list' used for list management?

> +	mutex_init(&component->io_mutex);
> +
>   	component->name = fmt_single_name(dev, &component->id);
>   	if (!component->name) {
>   		dev_err(dev, "ASoC: Failed to allocate name\n");
> @@ -2657,9 +2661,6 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
>   	dapm->idle_bias_off = !driver->idle_bias_on;
>   	dapm->suspend_bias_off = driver->suspend_bias_off;
>   
> -	INIT_LIST_HEAD(&component->dai_list);
> -	mutex_init(&component->io_mutex);
> -
>   	return 0;
>   }
>   
> 
