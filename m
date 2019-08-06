From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 02/28] ASoC: soc-core: set
 component->debugfs_root NULL
Date: Tue, 6 Aug 2019 09:49:20 -0500
Message-ID: <f7a47bad-b680-cbd2-2341-7be081ac4b2c@linux.intel.com>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <87y3072iib.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EDD48F8011B
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 17:15:53 +0200 (CEST)
In-Reply-To: <87y3072iib.wl-kuninori.morimoto.gx@renesas.com>
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


> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 40bac40..00887f7 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -171,7 +171,10 @@ static void soc_init_component_debugfs(struct snd_soc_component *component)
>   
>   static void soc_cleanup_component_debugfs(struct snd_soc_component *component)
>   {
> +	if (!component->debugfs_root)
> +		return;

that test is redundant, it's safe to call debugfs_remove_recursive() 
without checking the argument (done internally).

>   	debugfs_remove_recursive(component->debugfs_root);
> +	component->debugfs_root = NULL;
>   }
