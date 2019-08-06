From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 23/28] ASoC: soc-core: don't alloc memory
 carelessly when creating debugfs
Date: Tue, 6 Aug 2019 10:05:16 -0500
Message-ID: <baa98584-e6a2-6816-d024-2ae25a617359@linux.intel.com>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <874l2v2ie8.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E6EBF805A8
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 17:16:15 +0200 (CEST)
In-Reply-To: <874l2v2ie8.wl-kuninori.morimoto.gx@renesas.com>
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
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current ALSA SoC might allocate debugfs name memory via kasprintf(),
> but, it is grandiose and the code becoming very complex.

grandiose sounds lyric. did you mean unnecessary?

> Using enough size local variable is very enough for this purpose.

Using local variable with appropriate size is enough.

> 
> This patch uses 64byte local variable for it.
> It is very enough size for this purposeq.

last sentence is redundant

> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   sound/soc/soc-core.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index c737349..bf3bda2 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -147,23 +147,19 @@ static const struct attribute_group *soc_dev_attr_groups[] = {
>   #ifdef CONFIG_DEBUG_FS
>   static void soc_init_component_debugfs(struct snd_soc_component *component)
>   {
> +	char name[64];
> +
>   	if (!component->card->debugfs_card_root)
>   		return;
>   
> -	if (component->debugfs_prefix) {
> -		char *name;
> -
> -		name = kasprintf(GFP_KERNEL, "%s:%s",
> +	if (component->debugfs_prefix)
> +		snprintf(name, ARRAY_SIZE(name), "%s:%s",
>   			component->debugfs_prefix, component->name);
> -		if (name) {
> -			component->debugfs_root = debugfs_create_dir(name,
> -				component->card->debugfs_card_root);
> -			kfree(name);
> -		}
> -	} else {
> -		component->debugfs_root = debugfs_create_dir(component->name,
> -				component->card->debugfs_card_root);
> -	}
> +	else
> +		snprintf(name, ARRAY_SIZE(name), "%s", component->name);
> +
> +	component->debugfs_root = debugfs_create_dir(name,
> +					component->card->debugfs_card_root);
>   
>   	snd_soc_dapm_debugfs_init(snd_soc_component_get_dapm(component),
>   		component->debugfs_root);
> 
