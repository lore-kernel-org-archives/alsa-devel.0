From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v2] ASoC: topology: Add callback for DAPM
 route load/unload
Date: Tue, 19 Jun 2018 10:17:21 +0530
Message-ID: <20180619044721.GQ25852@vkoul-mobl>
References: <20180614195359.12027-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 772FA266D4C
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 06:47:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180614195359.12027-1-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 14-06-18, 20:53, Liam Girdwood wrote:
> Add a callback fro clients for notification about DAPM route loading and

/s/fro/for ?

> unloading.

It would help to add motivation for callback, how is this useful and
user as well

> 
> Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> ---
> 
> Changes since V1:
>  - Fixed merge conflict with recent component model update.
> 
> ---
>  include/sound/soc-topology.h |  7 +++++++
>  sound/soc/soc-topology.c     | 13 +++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
> index e1f265e21ee1..401ef2c45d6c 100644
> --- a/include/sound/soc-topology.h
> +++ b/include/sound/soc-topology.h
> @@ -32,6 +32,7 @@ struct snd_kcontrol_new;
>  struct snd_soc_dai_link;
>  struct snd_soc_dai_driver;
>  struct snd_soc_dai;
> +struct snd_soc_dapm_route;
>  
>  /* object scan be loaded and unloaded in groups with identfying indexes */
>  #define SND_SOC_TPLG_INDEX_ALL	0	/* ID that matches all FW objects */
> @@ -116,6 +117,12 @@ struct snd_soc_tplg_ops {
>  	int (*control_unload)(struct snd_soc_component *,
>  		struct snd_soc_dobj *);
>  
> +	/* DAPM graph route element loading and unloading */
> +	int (*dapm_route_load)(struct snd_soc_component *, int index,
> +		struct snd_soc_dapm_route *route);
> +	int (*dapm_route_unload)(struct snd_soc_component *,
> +		struct snd_soc_dobj *);
> +
>  	/* external widget init - used for any driver specific init */
>  	int (*widget_load)(struct snd_soc_component *, int index,
>  		struct snd_soc_dapm_widget *,
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index a30bb94fc800..ed8c00b43ef9 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -1105,6 +1105,17 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
>  	return 0;
>  }
>  
> +/* optionally pass new dynamic kcontrol to component driver. */
> +static int soc_tplg_add_route(struct soc_tplg *tplg,
> +	struct snd_soc_dapm_route *route)

Align with preceding please

> +{
> +	if (tplg->comp && tplg->ops && tplg->ops->dapm_route_load)
> +		return tplg->ops->dapm_route_load(tplg->comp, tplg->index,
> +			route);
> +
> +	return 0;
> +}
> +
>  static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
>  	struct snd_soc_tplg_hdr *hdr)
>  {
> @@ -1153,6 +1164,8 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
>  		else
>  			route.control = elem->control;
>  
> +		soc_tplg_add_route(tplg, &route);

it is not really add_route right, so notify_load or something?

-- 
~Vinod
