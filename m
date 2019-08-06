From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 15/28] ASoC: soc-core: tidyup for
 card->deferred_resume_work
Date: Tue, 6 Aug 2019 09:55:21 -0500
Message-ID: <b0fee4cb-2347-7c21-e9b8-ad41133340aa@linux.intel.com>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <87ftmf2ifk.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7F4BF805A8
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 17:16:12 +0200 (CEST)
In-Reply-To: <87ftmf2ifk.wl-kuninori.morimoto.gx@renesas.com>
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
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> card->deferred_resume_work is used if CONFIG_PM_SLEEP was defined.
> but
> 	1) It is defined even though CONFIG_PM_SLEEP was not defined
> 	2) randam ifdef code is difficlut to read.

typos: random .. difficult

> This patch tidyup these issues.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   include/sound/soc.h  |  5 +++--
>   sound/soc/soc-core.c | 14 ++++++++++----
>   2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 6ac6481..85ad971 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -1058,8 +1058,6 @@ struct snd_soc_card {
>   	int num_of_dapm_routes;
>   	bool fully_routed;
>   
> -	struct work_struct deferred_resume_work;
> -
>   	/* lists of probed devices belonging to this card */
>   	struct list_head component_dev_list;
>   	struct list_head list;
> @@ -1080,6 +1078,9 @@ struct snd_soc_card {
>   #ifdef CONFIG_DEBUG_FS
>   	struct dentry *debugfs_card_root;
>   #endif
> +#ifdef CONFIG_PM_SLEEP
> +	struct work_struct deferred_resume_work;
> +#endif
>   	u32 pop_time;
>   
>   	void *drvdata;
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index e8ed57a..2536ba4 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -701,9 +701,18 @@ int snd_soc_resume(struct device *dev)
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(snd_soc_resume);
> +
> +static void soc_resume_init(struct snd_soc_card *card)
> +{
> +	/* deferred resume work */
> +	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
> +}
>   #else
>   #define snd_soc_suspend NULL
>   #define snd_soc_resume NULL
> +static inline void soc_resume_init(struct snd_soc_card *card)
> +{
> +}
>   #endif
>   
>   static const struct snd_soc_dai_ops null_dai_ops = {
> @@ -1975,10 +1984,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
>   
>   	soc_init_card_debugfs(card);
>   
> -#ifdef CONFIG_PM_SLEEP
> -	/* deferred resume work */
> -	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
> -#endif
> +	soc_resume_init(card);
>   
>   	snd_soc_dapm_new_controls(&card->dapm, card->dapm_widgets,
>   				  card->num_dapm_widgets);
> 
