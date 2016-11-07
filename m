From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ASoC: Intel: atom: save FW version
Date: Tue, 8 Nov 2016 02:31:18 +0530
Message-ID: <20161107210117.GO3000@localhost>
References: <20161104080411.12410-1-sebastien.guiriec@intel.com>
 <20161104080411.12410-2-sebastien.guiriec@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EE202266731
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 21:52:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161104080411.12410-2-sebastien.guiriec@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <sebastien.guiriec@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vind.koul@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 04, 2016 at 09:04:10AM +0100, Sebastien Guiriec wrote:
> After the boot of the SST FW the firmware version is send back
> to the driver. This patch is saving the FW version inside the
> driver.
> 
> Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
> ---
>  sound/soc/intel/atom/sst/sst.h     | 1 +
>  sound/soc/intel/atom/sst/sst_ipc.c | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
> index 3f49386..5c9a51cc 100644
> --- a/sound/soc/intel/atom/sst/sst.h
> +++ b/sound/soc/intel/atom/sst/sst.h
> @@ -436,6 +436,7 @@ struct intel_sst_drv {
>  	 */
>  	char firmware_name[FW_NAME_SIZE];
>  
> +	struct snd_sst_fw_version fw_version;

Can you check if this is initialzed to zero, otherwise we should reset it..


>  	struct sst_fw_save	*fw_save;
>  };
>  
> diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
> index 92ffeaa..8e88211 100644
> --- a/sound/soc/intel/atom/sst/sst_ipc.c
> +++ b/sound/soc/intel/atom/sst/sst_ipc.c
> @@ -240,6 +240,11 @@ static void process_fw_init(struct intel_sst_drv *sst_drv_ctx,
>  			init->fw_version.type, init->fw_version.major,
>  			init->fw_version.minor, init->fw_version.build);
>  
> +	/* Save FW version */
> +	sst_drv_ctx->fw_version.type = init->fw_version.type;
> +	sst_drv_ctx->fw_version.major = init->fw_version.major;
> +	sst_drv_ctx->fw_version.minor = init->fw_version.minor;
> +	sst_drv_ctx->fw_version.build = init->fw_version.build;
>  ret:
>  	sst_wake_up_block(sst_drv_ctx, retval, FW_DWNL_ID, 0 , NULL, 0);
>  }
> -- 
> 2.9.3
> 
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris, 
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
> 
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
