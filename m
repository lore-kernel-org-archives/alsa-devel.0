From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: add Component level struct
 snd_compr_ops
Date: Mon, 19 Dec 2016 11:12:35 +0000
Message-ID: <20161219111235.GO1867@localhost.localdomain>
References: <87a8bs74t5.wl%kuninori.morimoto.gx@renesas.com>
 <8737hk74l7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id B6121266B7E
 for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2016 12:11:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8737hk74l7.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 19, 2016 at 07:38:18AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> In current ALSA SoC, Platform has struct snd_compr_ops feature,
> but it should be supported on Component level. This patch adds it.
> 
> If component level has it, many snd_pcm_ops can be called,
> but, 1st ops function only will be used now. It should/will be
> fixed in the future.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/soc.h      |   4 +
>  sound/soc/soc-compress.c | 246 ++++++++++++++++++++++++++++++++---------------
>  sound/soc/soc-core.c     |   2 +
>  3 files changed, 175 insertions(+), 77 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 5db4a90..225e9b6 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -777,6 +777,8 @@ struct snd_soc_component_driver {
>  	const struct snd_soc_dapm_route *dapm_routes;
>  	unsigned int num_dapm_routes;
>  
> +	const struct snd_compr_ops *compr_ops;
> +
>  	int (*probe)(struct snd_soc_component *);
>  	void (*remove)(struct snd_soc_component *);
>  	int (*suspend)(struct snd_soc_component *);
> @@ -855,6 +857,8 @@ struct snd_soc_component {
>  	unsigned int num_dapm_routes;
>  	struct snd_soc_codec *codec;
>  
> +	const struct snd_compr_ops *compr_ops;
> +
>  	int (*probe)(struct snd_soc_component *);
>  	void (*remove)(struct snd_soc_component *);
>  	int (*suspend)(struct snd_soc_component *);
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index bfd71b8..0362dd7 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -29,7 +29,7 @@
>  static int soc_compr_open(struct snd_compr_stream *cstream)
>  {
>  	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> -	struct snd_soc_platform *platform = rtd->platform;
> +	struct snd_soc_component *component;
>  	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>  	int ret = 0;
>  
> @@ -44,14 +44,22 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
>  		}
>  	}
>  
> -	if (platform->driver->compr_ops && platform->driver->compr_ops->open) {
> -		ret = platform->driver->compr_ops->open(cstream);
> -		if (ret < 0) {
> -			pr_err("compress asoc: can't open platform %s\n",
> -				platform->component.name);
> -			goto plat_err;
> +	ret = 0;
> +	for_each_component(component, rtd->card) {
> +		const struct snd_compr_ops *compr_ops = component->compr_ops;
> +
> +		if (compr_ops && compr_ops->open) {
> +			int _ret = compr_ops->open(cstream);
> +
> +			if (_ret < 0) {
> +				pr_err("compress asoc: can't open component %s\n",
> +				       component->name);
> +				ret |= _ret;
> +			}

Apologies if I am missing something but this really doesn't look
like equivalent code? The old code calls the ops for the platform
associated with the stream, the new code looks like it will call
the ops for every single component in the system that has
compressed ops, which would definitely cause issue. Am I missing
something here?

Thanks,
Charles
