From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 03/35] ASoC: Intel: Skylake: Add
 HARDWARE_CONFIG IPC request
Date: Fri, 23 Aug 2019 13:32:12 -0500
Message-ID: <dd4c705a-1d75-b71c-8cd9-eec020b57c52@linux.intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-4-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 792BDF802FB
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 22:28:00 +0200 (CEST)
In-Reply-To: <20190822190425.23001-4-cezary.rojewski@intel.com>
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


> +	while (offset < bytes) {
> +		tlv = (struct skl_tlv *)(payload + offset);
> +
> +		switch (tlv->type) {
> +		case SKL_HW_CFG_CAVS_VER:
> +			cfg->cavs_version = *tlv->value;
> +			break;
> +
> +		case SKL_HW_CFG_DSP_CORES:
> +			cfg->dsp_cores = *tlv->value;
> +			break;
> +
> +		case SKL_HW_CFG_MEM_PAGE_BYTES:
> +			cfg->mem_page_bytes = *tlv->value;
> +			break;
> +
> +		case SKL_HW_CFG_TOTAL_PHYS_MEM_PAGES:
> +			cfg->total_phys_mem_pages = *tlv->value;
> +			break;
> +
> +		case SKL_HW_CFG_I2S_CAPS:
> +			cfg->i2s_caps.version = tlv->value[0];
> +			size = tlv->value[1];
> +			cfg->i2s_caps.ctrl_count = size;
> +			if (!size)
> +				break;
> +
> +			size *= sizeof(*cfg->i2s_caps.ctrl_base_addr);
> +			cfg->i2s_caps.ctrl_base_addr =
> +				kmemdup(&tlv->value[2], size, GFP_KERNEL);

shouldn't the size be that of the source buffer instead of the destination?

> +			if (!cfg->i2s_caps.ctrl_base_addr) {
> +				ret = -ENOMEM;
> +				goto exit;
> +			}
> +			break;
> +
> +		case SKL_HW_CFG_GATEWAY_COUNT:
> +			cfg->gateway_count = *tlv->value;
> +			break;
> +
> +		case SKL_HW_CFG_HP_EBB_COUNT:
> +			cfg->hp_ebb_count = *tlv->value;
> +			break;
> +
> +		case SKL_HW_CFG_LP_EBB_COUNT:
> +			cfg->lp_ebb_count = *tlv->value;
> +			break;
> +
> +		case SKL_HW_CFG_EBB_SIZE_BYTES:
> +			cfg->ebb_size_bytes = *tlv->value;
> +			break;
> +
> +		case SKL_HW_CFG_GPDMA_CAPS:
> +		case SKL_HW_CFG_UAOL_CAPS:
> +			break;
> +
> +		default:
> +			dev_info(ipc->dev, "Unrecognized hw param: %d\n",
> +				tlv->type);
> +			break;

same feedback, it's usually better to list all values and skip them, and 
fail big if you see something unexpected.

> +		}
> +
> +		offset += sizeof(*tlv) + tlv->length;
> +	}
> +
> +exit:
> +	kfree(payload);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(skl_ipc_hw_cfg_get);
> diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
> index ebc5852e15d0..eefa52f7f97a 100644
> --- a/sound/soc/intel/skylake/skl-sst-ipc.h
> +++ b/sound/soc/intel/skylake/skl-sst-ipc.h
> @@ -77,6 +77,7 @@ enum skl_basefw_runtime_param {
>   	SKL_BASEFW_ASTATE_TABLE = 4,
>   	SKL_BASEFW_DMA_CONTROL = 5,
>   	SKL_BASEFW_FIRMWARE_CONFIG = 7,
> +	SKL_BASEFW_HARDWARE_CONFIG = 8,
>   };
>   
>   enum skl_fw_cfg_params {
> @@ -141,6 +142,50 @@ struct skl_fw_cfg {
>   	u32 power_gating_policy;
>   };
>   
> +enum skl_hw_cfg_params {
> +	SKL_HW_CFG_CAVS_VER,
> +	SKL_HW_CFG_DSP_CORES,
> +	SKL_HW_CFG_MEM_PAGE_BYTES,
> +	SKL_HW_CFG_TOTAL_PHYS_MEM_PAGES,
> +	SKL_HW_CFG_I2S_CAPS,
> +	SKL_HW_CFG_GPDMA_CAPS,
> +	SKL_HW_CFG_GATEWAY_COUNT,
> +	SKL_HW_CFG_HP_EBB_COUNT,
> +	SKL_HW_CFG_LP_EBB_COUNT,
> +	SKL_HW_CFG_EBB_SIZE_BYTES,
> +	SKL_HW_CFG_UAOL_CAPS
> +};
> +
> +enum skl_cavs_version {
> +	SKL_CAVS_VER_1_5 = 0x10005,
> +	SKL_CAVS_VER_1_8 = 0x10008,
> +};
> +
> +enum skl_i2s_version {
> +	SKL_I2S_VER_15_SKYLAKE   = 0x00000,
> +	SKL_I2S_VER_15_BROXTON   = 0x10000,
> +	SKL_I2S_VER_15_BROXTON_P = 0x20000,
> +	SKL_I2S_VER_18_KBL_CNL   = 0x30000,
> +};

The encoding is odd.
Do these values mean anything (e.g. tied to firmware definitions?)
