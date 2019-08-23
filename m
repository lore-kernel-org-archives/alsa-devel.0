From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 12/35] ASoC: Intel: Skylake: Reuse
 sst_dsp_free
Date: Fri, 23 Aug 2019 14:07:03 -0500
Message-ID: <d902a188-f870-6745-be42-9df637c7634e@linux.intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-13-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A30EF8036A
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 22:28:06 +0200 (CEST)
In-Reply-To: <20190822190425.23001-13-cezary.rojewski@intel.com>
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
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 8/22/19 2:04 PM, Cezary Rojewski wrote:
> Skylake is sst_dsp descendant. Rather than bypassing framework's flow,
> embrace it. sst_dsp_free invokes sst specific handler internally so
> nothing is missed.

for clarity you should also add the free_irq is also handled internally 
in sst_dsp_free(), otherwise this looks like a mistake to the reviewer 
that's not even half-way through the series...

> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>   sound/soc/intel/skylake/cnl-sst-dsp.c | 1 -
>   sound/soc/intel/skylake/skl-sst-dsp.c | 1 -
>   sound/soc/intel/skylake/skl-sst.c     | 2 +-
>   3 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/cnl-sst-dsp.c b/sound/soc/intel/skylake/cnl-sst-dsp.c
> index 189c1c7086e3..48b465939ef8 100644
> --- a/sound/soc/intel/skylake/cnl-sst-dsp.c
> +++ b/sound/soc/intel/skylake/cnl-sst-dsp.c
> @@ -215,7 +215,6 @@ void cnl_dsp_free(struct sst_dsp *dsp)
>   	sst_ipc_fini(&skl->ipc);
>   	cnl_ipc_int_disable(dsp);
>   
> -	free_irq(dsp->irq, dsp);
>   	cnl_dsp_disable_core(dsp, SKL_DSP_CORE0_MASK);
>   }
>   EXPORT_SYMBOL_GPL(cnl_dsp_free);
> diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
> index 348e69226e46..1c4ecbcd7db7 100644
> --- a/sound/soc/intel/skylake/skl-sst-dsp.c
> +++ b/sound/soc/intel/skylake/skl-sst-dsp.c
> @@ -468,7 +468,6 @@ void skl_dsp_free(struct sst_dsp *dsp)
>   	sst_ipc_fini(&skl->ipc);
>   	skl_ipc_int_disable(dsp);
>   
> -	free_irq(dsp->irq, dsp);
>   	skl_dsp_disable_core(dsp, SKL_DSP_CORE0_MASK);
>   }
>   EXPORT_SYMBOL_GPL(skl_dsp_free);
> diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
> index 72ee3d8a1d7d..e55523826346 100644
> --- a/sound/soc/intel/skylake/skl-sst.c
> +++ b/sound/soc/intel/skylake/skl-sst.c
> @@ -622,7 +622,7 @@ void skl_sst_dsp_cleanup(struct skl_dev *skl)
>   	skl_clear_module_table(dsp);
>   
>   	skl_freeup_uuid_list(skl);
> -	dsp->ops->free(dsp);
> +	sst_dsp_free(dsp);
>   
>   	if (skl->boot_complete && dsp->cl_dev.bufsize) {
>   		dsp->cl_dev.ops.cl_cleanup_controller(dsp);
> 
