From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 04/35] ASoC: Intel: Skylake: Unify firmware
 loading mechanism
Date: Fri, 23 Aug 2019 13:40:30 -0500
Message-ID: <90bbda82-3988-d02d-0d5d-e63890db81dc@linux.intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-5-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 799BEF80306
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 22:28:02 +0200 (CEST)
In-Reply-To: <20190822190425.23001-5-cezary.rojewski@intel.com>
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


> -int skl_sst_init_fw(struct device *dev, struct skl_dev *skl)
> +int skl_sst_init_fw(struct skl_dev *skl)
>   {
> -	int ret;
>   	struct sst_dsp *sst = skl->dsp;
> +	struct device *dev = skl->dev;
> +	int (*lp_check)(struct sst_dsp *dsp, bool state);
> +	int ret;
> +
> +	lp_check = skl->ipc.ops.check_dsp_lp_on;
> +	skl->enable_miscbdcge(dev, false);
> +	skl->clock_power_gating(dev, false);
>   
>   	ret = sst->fw_ops.load_fw(sst);
>   	if (ret < 0) {
>   		dev_err(dev, "Load base fw failed : %d\n", ret);
> -		return ret;
> +		goto exit;
> +	}
> +
> +	if (!skl->is_first_boot)
> +		goto library_load;
> +	/* Disable power check during cfg setup */
> +	skl->ipc.ops.check_dsp_lp_on = NULL;

It's very odd to play with .ops callback dynamically. Usually ops are 
constant, and if you want to disable them you add a flag.

> +
> +	ret = skl_ipc_fw_cfg_get(&skl->ipc, &skl->fw_cfg);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get fw cfg: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	ret = skl_ipc_hw_cfg_get(&skl->ipc, &skl->hw_cfg);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get hw cfg: %d\n", ret);
> +		goto exit;
>   	}
>   
>   	skl_dsp_init_core_state(sst);
>   
> +library_load:
>   	if (skl->lib_count > 1) {
>   		ret = sst->fw_ops.load_library(sst, skl->lib_info,
>   						skl->lib_count);
>   		if (ret < 0) {
> -			dev_err(dev, "Load Library failed : %x\n", ret);
> -			return ret;
> +			dev_err(dev, "Load library failed : %x\n", ret);
> +			goto exit;
>   		}
>   	}
> +
>   	skl->is_first_boot = false;
> +exit:
> +	skl->ipc.ops.check_dsp_lp_on = lp_check;
> +	skl->enable_miscbdcge(dev, true);
> +	skl->clock_power_gating(dev, true);
>   
> -	return 0;
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(skl_sst_init_fw);
