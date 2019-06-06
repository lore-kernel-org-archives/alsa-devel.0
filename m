From: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH v2 114/146] ASoC: soc-topology: use modern
 dai_link style
Date: Thu, 6 Jun 2019 15:17:47 +0200
Message-ID: <20190606151747.343ddd4c@xxx>
References: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
 <87v9xjfjgo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 238C1F896CE
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 15:14:02 +0200 (CEST)
In-Reply-To: <87v9xjfjgo.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 06 Jun 2019 13:19:14 +0900
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> ASoC is now supporting modern style dai_link
> (= snd_soc_dai_link_component) for CPU/Codec/Platform.
> This patch switches to use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/soc-topology.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index 3299ebb..f485f7f 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -560,7 +560,7 @@ static void remove_link(struct snd_soc_component
> *comp, 
>  	kfree(link->name);
>  	kfree(link->stream_name);
> -	kfree(link->cpu_dai_name);
> +	kfree(link->cpus->dai_name);
>  
>  	list_del(&dobj->list);
>  	snd_soc_remove_dai_link(comp->card, link);
> @@ -1879,12 +1879,22 @@ static int soc_tplg_fe_link_create(struct
> soc_tplg *tplg, struct snd_soc_tplg_pcm *pcm)
>  {
>  	struct snd_soc_dai_link *link;
> +	struct snd_soc_dai_link_component *dlc;
>  	int ret;
>  
> -	link = kzalloc(sizeof(struct snd_soc_dai_link), GFP_KERNEL);
> +	/* link + cpu + codec */
> +	link = kzalloc(sizeof(*link) + (2 * sizeof(*dlc)),
> GFP_KERNEL); if (link == NULL)
>  		return -ENOMEM;
>  
> +	dlc = (struct snd_soc_dai_link_component *)(link + 1);
> +
> +	link->cpus	= &dlc[0];
> +	link->codecs	= &dlc[1];

While I understand what is going on here, I find this bit ugly.
Can it perhaps be changed to something like:

	link = kzalloc(sizeof(*link), GFP_KERNEL);
	if (link == NULL)
		return -ENOMEM;
	link->cpus = kzalloc(sizeof(*dlc), GFP_KERNEL);
	if (link->cpus == NULL) {
		ret = -ENOMEM;
		goto err;
	}
	link->codecs = kzalloc(sizeof(*dlc), GFP_KERNEL);
	if (link->cpus == NULL) {
		ret = -ENOMEM;
		goto err;
	}

(...)
err:
	kfree(link->cpus);
	kfree(link);
	return ret;

While it has a bit more of boiler plate it's easier to follow.

And while I look at soc_tplg_fe_link_create() it could use some
more memory checks, but it's a topic for separate patch.

> +
> +	link->num_cpus	 = 1;
> +	link->num_codecs = 1;
> +
>  	if (strlen(pcm->pcm_name)) {
>  		link->name = kstrdup(pcm->pcm_name, GFP_KERNEL);
>  		link->stream_name = kstrdup(pcm->pcm_name,
> GFP_KERNEL); @@ -1892,10 +1902,10 @@ static int
> soc_tplg_fe_link_create(struct soc_tplg *tplg, link->id =
> le32_to_cpu(pcm->pcm_id); 
>  	if (strlen(pcm->dai_name))
> -		link->cpu_dai_name = kstrdup(pcm->dai_name,
> GFP_KERNEL);
> +		link->cpus->dai_name = kstrdup(pcm->dai_name,
> GFP_KERNEL); 
> -	link->codec_name = "snd-soc-dummy";
> -	link->codec_dai_name = "snd-soc-dummy-dai";
> +	link->codecs->name = "snd-soc-dummy";
> +	link->codecs->dai_name = "snd-soc-dummy-dai";
>  
>  	/* enable DPCM */
>  	link->dynamic = 1;
> @@ -1912,7 +1922,7 @@ static int soc_tplg_fe_link_create(struct
> soc_tplg *tplg, dev_err(tplg->comp->dev, "ASoC: FE link loading
> failed\n"); kfree(link->name);
>  		kfree(link->stream_name);
> -		kfree(link->cpu_dai_name);
> +		kfree(link->cpus->dai_name);
>  		kfree(link);
>  		return ret;
>  	}
