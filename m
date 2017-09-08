From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/3] ASoC: intel: Kill BUG_ON() usage
Date: Fri, 8 Sep 2017 14:14:05 +0530
Message-ID: <20170908084404.GD3053@localhost>
References: <20170907085918.4496-1-tiwai@suse.de>
 <20170907085918.4496-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 307D0266A89
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 10:40:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170907085918.4496-4-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 07, 2017 at 10:59:18AM +0200, Takashi Iwai wrote:
> Don't use BUG_ON() for a non-critical sanity check on production
> systems.  This patch either removes useless BUG_ON() calls.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/soc/intel/atom/sst/sst_loader.c | 1 -
>  sound/soc/intel/atom/sst/sst_stream.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
> index 33917146d9c4..a686eef2cf7f 100644
> --- a/sound/soc/intel/atom/sst/sst_loader.c
> +++ b/sound/soc/intel/atom/sst/sst_loader.c
> @@ -415,7 +415,6 @@ int sst_load_fw(struct intel_sst_drv *sst_drv_ctx)
>  			return ret_val;
>  	}
>  
> -	BUG_ON(!sst_drv_ctx->fw_in_mem);
>  	block = sst_create_block(sst_drv_ctx, 0, FW_DWNL_ID);
>  	if (block == NULL)
>  		return -ENOMEM;
> diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
> index 83d8dda15233..65e257b17a7e 100644
> --- a/sound/soc/intel/atom/sst/sst_stream.c
> +++ b/sound/soc/intel/atom/sst/sst_stream.c
> @@ -45,7 +45,6 @@ int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params)
>  	void *data = NULL;
>  
>  	dev_dbg(sst_drv_ctx->dev, "Enter\n");
> -	BUG_ON(!params);
>  
>  	str_params = (struct snd_sst_params *)params;
>  	memset(&alloc_param, 0, sizeof(alloc_param));
> -- 
> 2.14.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
