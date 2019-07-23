From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Skylake: Recover BXT FW on
 DSP boot timeout error
Date: Tue, 23 Jul 2019 17:14:06 +0200
Message-ID: <8842953f-32ad-6318-9de0-8410dc1f95e1@intel.com>
References: <20190708140248.14304-1-pawel.harlozinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11C6EF800E8
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 17:14:14 +0200 (CEST)
In-Reply-To: <20190708140248.14304-1-pawel.harlozinski@linux.intel.com>
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
To: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Szymon Mielczarek <szymonx.mielczarek@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 2019-07-08 16:02, Pawel Harlozinski wrote:
> When DSP boots with timeout error try to reload firmware
> to keep best user expeirience.
> 
> Signed-off-by: Szymon Mielczarek <szymonx.mielczarek@intel.com>
> Signed-off-by: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
> ---
>   sound/soc/intel/skylake/bxt-sst.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
> index 440bca7afbf1..dd0260557530 100644
> --- a/sound/soc/intel/skylake/bxt-sst.c
> +++ b/sound/soc/intel/skylake/bxt-sst.c
> @@ -455,13 +455,19 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
>   	/* If core 1 was turned on for booting core 0, turn it off */
>   		skl_dsp_core_power_down(ctx, SKL_DSP_CORE_MASK(1));
>   		if (ret == 0) {
> -			dev_err(ctx->dev, "%s: DSP boot timeout\n", __func__);
> -			dev_err(ctx->dev, "Error code=0x%x: FW status=0x%x\n",
> +			dev_warn(ctx->dev,
> +				"DSP boot timeout: Error code=0x%x: FW status=0x%x\n",
>   				sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE),
>   				sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS));
> -			dev_err(ctx->dev, "Failed to set core0 to D0 state\n");
> -			ret = -EIO;
> -			goto err;
> +			dev_warn(ctx->dev,"Reloading FW\n");
> +
> +			ret = bxt_sst_init_fw(skl->dev, skl);
> +			if (ret < 0) {
> +				dev_err(ctx->dev, "Reload fw failed: %d\n", ret);
> +				dev_err(ctx->dev, "Failed to set core0 to D0 state\n");
> +				ret = -EIO;
> +				goto err;
> +			}

First, I'm sorry for the delay in response.

Now, where were we..
I'd combine there dump messages together - that is both dev_warns and 
both dev_errs. No need to spam 2 lines when there is single a message to 
communicate on each occasion.

Any reason for ignoring return code of bxt_sst_init_fw and overwriting 
it with -EIO? If the reason is _good_ then you can skip assignment an do 
if (bxt_sst_init_fw()) directly.

Apart from that, I'd like to see a FIXME comment or something of that 
sort. FW preparation is being updated in patches to come and if this fix 
cannot wait, it's good to mention it targets BXT platforms only, while 
SKL/ CNL descendants are left alone.

Czarek

>   		}
>   	}
>   
> @@ -486,7 +492,6 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
>   	if (core_id == SKL_DSP_CORE0_ID)
>   		core_mask |= SKL_DSP_CORE_MASK(1);
>   	skl_dsp_disable_core(ctx, core_mask);
> -
>   	return ret;
>   }
>   
> 
