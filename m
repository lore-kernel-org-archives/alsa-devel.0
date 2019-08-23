From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 15/35] ASoC: Intel: Skylake: Use dsp
 loading functions directly
Date: Fri, 23 Aug 2019 14:17:45 -0500
Message-ID: <d334cfab-34c9-a75b-598a-8527ffc89f54@linux.intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-16-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F5EDF80518
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 22:28:08 +0200 (CEST)
In-Reply-To: <20190822190425.23001-16-cezary.rojewski@intel.com>
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
> None of skl_dsp_loader_ops are actually extended as any parameter that
> could be "extended" is already part of given function's parameter list.
> Rather than obfustace non-derived calls with ops and dereferences, make

A typo on obfuscate could be intentional?

> use of said operation directly. Takes part in remal of

removal?

> skl_dsp_loader_ops structure.
> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>   sound/soc/intel/skylake/bxt-sst.c       | 18 +++++++++---------
>   sound/soc/intel/skylake/cnl-sst.c       | 10 +++++-----
>   sound/soc/intel/skylake/skl-messages.c  | 10 +++++-----
>   sound/soc/intel/skylake/skl-sst-cldma.c | 10 +++++-----
>   sound/soc/intel/skylake/skl-sst-dsp.h   |  9 +++++++++
>   5 files changed, 33 insertions(+), 24 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
> index a8a2783f9b37..1ca4fba0f35f 100644
> --- a/sound/soc/intel/skylake/bxt-sst.c
> +++ b/sound/soc/intel/skylake/bxt-sst.c
> @@ -60,7 +60,7 @@ bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
>   		if (ret < 0)
>   			goto load_library_failed;
>   
> -		stream_tag = ctx->dsp_ops.prepare(ctx->dev, 0x40,
> +		stream_tag = skl_dsp_prepare(ctx->dev, 0x40,
>   					stripped_fw.size, &dmab);

fits on one line now?

>   		if (stream_tag <= 0) {
>   			dev_err(ctx->dev, "Lib prepare DMA err: %x\n",
> @@ -72,14 +72,14 @@ bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
>   		dma_id = stream_tag - 1;
>   		memcpy(dmab.area, stripped_fw.data, stripped_fw.size);
>   
> -		ctx->dsp_ops.trigger(ctx->dev, true, stream_tag);
> +		skl_dsp_trigger(ctx->dev, true, stream_tag);
>   		ret = skl_sst_ipc_load_library(&skl->ipc, dma_id, i, true);
>   		if (ret < 0)
>   			dev_err(ctx->dev, "IPC Load Lib for %s fail: %d\n",
>   					linfo[i].name, ret);

indent?

>   
> -		ctx->dsp_ops.trigger(ctx->dev, false, stream_tag);
> -		ctx->dsp_ops.cleanup(ctx->dev, &dmab, stream_tag);
> +		skl_dsp_trigger(ctx->dev, false, stream_tag);
> +		skl_dsp_cleanup(ctx->dev, &dmab, stream_tag);
>   	}
>   
>   	return ret;
> @@ -100,7 +100,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
>   {
>   	int stream_tag, ret;
>   
> -	stream_tag = ctx->dsp_ops.prepare(ctx->dev, 0x40, fwsize, &ctx->dmab);
> +	stream_tag = skl_dsp_prepare(ctx->dev, 0x40, fwsize, &ctx->dmab);
>   	if (stream_tag <= 0) {
>   		dev_err(ctx->dev, "Failed to prepare DMA FW loading err: %x\n",
>   				stream_tag);
> @@ -162,7 +162,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
>   	return ret;
>   
>   base_fw_load_failed:
> -	ctx->dsp_ops.cleanup(ctx->dev, &ctx->dmab, stream_tag);
> +	skl_dsp_cleanup(ctx->dev, &ctx->dmab, stream_tag);
>   	skl_dsp_core_power_down(ctx, SKL_DSP_CORE_MASK(1));
>   	skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);

those macros look confusing. COREx_MASK or CORE_MASK(x), choose one.
