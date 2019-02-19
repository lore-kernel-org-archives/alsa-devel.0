From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: topology: free created components in
 tplg load error
Date: Tue, 19 Feb 2019 09:28:21 -0600
Message-ID: <25e9c53e-afa8-8ce3-874e-c683c9cdd552@linux.intel.com>
References: <20190217132347.12593-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id A93DE265525
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 16:28:24 +0100 (CET)
In-Reply-To: <20190217132347.12593-1-yung-chuan.liao@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard liao <yung-chuan.liao@linux.intel.com>, broonie@kernel.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org


On 2/17/19 7:23 AM, Bard liao wrote:
> Topology resources are no longer needed if any element failed to load.
>
> Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>   sound/soc/soc-topology.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index c5638e15a2dd..25fca7055464 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -2587,6 +2587,7 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
>   	struct snd_soc_tplg_ops *ops, const struct firmware *fw, u32 id)
>   {
>   	struct soc_tplg tplg;
> +	int ret;
>   
>   	/* setup parsing context */
>   	memset(&tplg, 0, sizeof(tplg));
> @@ -2600,7 +2601,12 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
>   	tplg.bytes_ext_ops = ops->bytes_ext_ops;
>   	tplg.bytes_ext_ops_count = ops->bytes_ext_ops_count;
>   
> -	return soc_tplg_load(&tplg);
> +	ret = soc_tplg_load(&tplg);
> +	/* free the created components if fail to load topology */
> +	if (ret)
> +		snd_soc_tplg_component_remove(comp, SND_SOC_TPLG_INDEX_ALL);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(snd_soc_tplg_component_load);
>   
