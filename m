From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 27/35] ASoC: Intel: Skylake: Define
 platform descriptors
Date: Fri, 23 Aug 2019 14:50:38 -0500
Message-ID: <6369d711-8eb2-2664-412b-3de286bb3ca8@linux.intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-28-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07F0CF805F9
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 22:28:18 +0200 (CEST)
In-Reply-To: <20190822190425.23001-28-cezary.rojewski@intel.com>
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
> Make use of sst_pdata and declare platform descriptors for all existing
> cAVS platforms. Each carries information about base_fw filename,
> platform specific operations and boards supported.

if you use a constant base_fw name that cannot be made board-specific 
for specific usages, you will restrict the ability to deal with quirks 
and custom cases.

real-life example: not so long ago there were two SST firmwares for 
'regular' solutions and ultra-low-latency ones, so by having a single 
name for all APL-based platforms you will generate issues that don't 
exist today, or you will force users to patch something in the core.

> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>   sound/soc/intel/skylake/bxt-sst.c |  4 ++--
>   sound/soc/intel/skylake/cnl-sst.c |  4 ++--
>   sound/soc/intel/skylake/skl-sst.c |  4 ++--
>   sound/soc/intel/skylake/skl.c     | 38 ++++++++++++++++++++++++++++++-
>   sound/soc/intel/skylake/skl.h     |  3 +++
>   5 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
> index a547fb84eee9..06da822790a5 100644
> --- a/sound/soc/intel/skylake/bxt-sst.c
> +++ b/sound/soc/intel/skylake/bxt-sst.c
> @@ -531,7 +531,7 @@ static const struct skl_dsp_fw_ops bxt_fw_ops = {
>   	.load_library = bxt_load_library,
>   };
>   
> -static struct sst_ops skl_ops = {
> +struct sst_ops apl_sst_ops = {
>   	.irq_handler = skl_dsp_sst_interrupt,
>   	.thread_fn = skl_dsp_irq_thread_handler,
>   	.write = sst_shim32_write,
> @@ -542,7 +542,7 @@ static struct sst_ops skl_ops = {
>   };
>   
>   static struct sst_pdata skl_dev = {
> -	.ops = &skl_ops,
> +	.ops = &apl_sst_ops,
>   };
>   
>   int bxt_sst_dsp_init(struct skl_dev *skl, const char *fw_name)
> diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
> index 5be0a8eb154d..c4dbf6655097 100644
> --- a/sound/soc/intel/skylake/cnl-sst.c
> +++ b/sound/soc/intel/skylake/cnl-sst.c
> @@ -408,7 +408,7 @@ static int cnl_ipc_init(struct device *dev, struct skl_dev *cnl)
>   	return 0;
>   }
>   
> -static struct sst_ops cnl_ops = {
> +struct sst_ops cnl_sst_ops = {
>   	.irq_handler = cnl_dsp_sst_interrupt,
>   	.thread_fn = cnl_dsp_irq_thread_handler,
>   	.write = sst_shim32_write,
> @@ -419,7 +419,7 @@ static struct sst_ops cnl_ops = {
>   };
>   
>   static struct sst_pdata cnl_dev = {
> -	.ops = &cnl_ops,
> +	.ops = &cnl_sst_ops,
>   };
>   
>   int cnl_sst_dsp_init(struct skl_dev *cnl, const char *fw_name)
> diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
> index 8ae7fe73534e..122c07290440 100644
> --- a/sound/soc/intel/skylake/skl-sst.c
> +++ b/sound/soc/intel/skylake/skl-sst.c
> @@ -503,7 +503,7 @@ static const struct skl_dsp_fw_ops skl_fw_ops = {
>   	.unload_mod = skl_unload_module,
>   };
>   
> -static struct sst_ops skl_ops = {
> +struct sst_ops skl_sst_ops = {
>   	.irq_handler = skl_dsp_sst_interrupt,
>   	.write = sst_shim32_write,
>   	.read = sst_shim32_read,
> @@ -513,7 +513,7 @@ static struct sst_ops skl_ops = {
>   };
>   
>   static struct sst_pdata skl_dev = {
> -	.ops = &skl_ops,
> +	.ops = &skl_sst_ops,
>   };
>   
>   int skl_sst_dsp_init(struct skl_dev *skl, const char *fw_name)
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 54e1f957121d..d6d099aba834 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -27,6 +27,7 @@
>   #include <sound/hda_i915.h>
>   #include <sound/hda_codec.h>
>   #include <sound/intel-nhlt.h>
> +#include "../common/sst-dsp.h"
>   #include "skl.h"
>   #include "skl-sst-dsp.h"
>   #include "skl-sst-ipc.h"
> @@ -1063,7 +1064,6 @@ static int skl_probe(struct pci_dev *pci,
>   
>   	pci_set_drvdata(skl->pci, bus);
>   
> -
>   	err = skl_find_machine(skl, (void *)pci_id->driver_data);
>   	if (err < 0) {
>   		dev_err(bus->dev, "skl_find_machine failed with err: %d\n", err);
> @@ -1153,6 +1153,42 @@ static void skl_remove(struct pci_dev *pci)
>   	dev_set_drvdata(&pci->dev, NULL);
>   }
>   
> +static struct sst_pdata skl_desc = {
> +	.fw_name = "intel/dsp_fw_release.bin",
> +	.ops = &skl_sst_ops,
> +	.boards = snd_soc_acpi_intel_skl_machines,
> +};
> +
> +static struct sst_pdata kbl_desc = {
> +	.fw_name = "intel/dsp_fw_kbl.bin",
> +	.ops = &skl_sst_ops,
> +	.boards = snd_soc_acpi_intel_kbl_machines,
> +};
> +
> +static struct sst_pdata apl_desc = {
> +	.fw_name = "intel/dsp_fw_bxtn.bin",
> +	.ops = &apl_sst_ops,
> +	.boards = snd_soc_acpi_intel_bxt_machines,
> +};
> +
> +static struct sst_pdata glk_desc = {
> +	.fw_name = "intel/dsp_fw_glk.bin",
> +	.ops = &apl_sst_ops,
> +	.boards = snd_soc_acpi_intel_glk_machines,
> +};
> +
> +static struct sst_pdata cnl_desc = {
> +	.fw_name = "intel/dsp_fw_cnl.bin",
> +	.ops = &cnl_sst_ops,
> +	.boards = snd_soc_acpi_intel_cnl_machines,
> +};
> +
> +static struct sst_pdata icl_desc = {
> +	.fw_name = "intel/dsp_fw_icl.bin",
> +	.ops = &cnl_sst_ops,
> +	.boards = snd_soc_acpi_intel_icl_machines,
> +};
> +
>   /* PCI IDs */
>   static const struct pci_device_id skl_ids[] = {
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
> diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
> index 9f5aa53df9f8..2f2b5a141abf 100644
> --- a/sound/soc/intel/skylake/skl.h
> +++ b/sound/soc/intel/skylake/skl.h
> @@ -42,6 +42,9 @@
>   #define AZX_REG_VS_EM2_L1SEN		BIT(13)
>   
>   struct skl_debug;
> +extern struct sst_ops skl_sst_ops;
> +extern struct sst_ops apl_sst_ops;
> +extern struct sst_ops cnl_sst_ops;
>   
>   struct skl_astate_param {
>   	u32 kcps;
> 
