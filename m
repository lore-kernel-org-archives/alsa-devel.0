From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 21/35] ASoC: Intel: Expose ACPI loading
 members
Date: Fri, 23 Aug 2019 14:32:11 -0500
Message-ID: <30929d7b-787d-3b6e-d806-02487b85ab8d@linux.intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-22-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8734FF805E0
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 22:28:12 +0200 (CEST)
In-Reply-To: <20190822190425.23001-22-cezary.rojewski@intel.com>
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


> diff --git a/sound/soc/intel/common/sst-dsp.h b/sound/soc/intel/common/sst-dsp.h
> index 63c29bb45cf1..a2ac7998fbdb 100644
> --- a/sound/soc/intel/common/sst-dsp.h
> +++ b/sound/soc/intel/common/sst-dsp.h
> @@ -166,6 +166,27 @@
>   #define SST_PMCS_PS_MASK	0x3
>   
>   struct sst_dsp;
> +struct platform_device;

that should be handled with an include, not redefining a type here.

> +
> +/* Descriptor for setting up SST platform data */
> +struct sst_acpi_desc {
> +	const char *drv_name;
> +	struct snd_soc_acpi_mach *machines;
> +	/* Platform resource indexes. Must set to -1 if not used */
> +	int resindex_lpe_base;
> +	int resindex_pcicfg_base;
> +	int resindex_fw_base;
> +	int irqindex_host_ipc;
> +	int resindex_dma_base;
> +	/* Unique number identifying the SST core on platform */
> +	int sst_id;
> +	/* DMA only valid when resindex_dma_base != -1*/
> +	int dma_engine;
> +	int dma_size;
> +};
> +
> +int sst_acpi_probe(struct platform_device *pdev);
> +int sst_acpi_remove(struct platform_device *pdev);
>   
>   /*
>    * SST Platform Data.
> 
