From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v2 2/5] ALSA: hda: move parts of NHLT code
 to new module
Date: Sat, 20 Jul 2019 23:06:46 +0200
Message-ID: <daaa01dc-d963-f215-90b1-132fde8e489a@intel.com>
References: <20190719203752.11151-1-pierre-louis.bossart@linux.intel.com>
 <20190719203752.11151-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0EAFF800AE
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2019 23:06:51 +0200 (CEST)
In-Reply-To: <20190719203752.11151-3-pierre-louis.bossart@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Daniel Drake <drake@endlessm.com>, Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 2019-07-19 22:37, Pierre-Louis Bossart wrote:
> Move parts of the code outside of the Skylake driver to help detect
> the presence of DMICs (which are not supported by the HDaudio legacy
> driver).
> 
> No functionality change (except for the removal of useless OR
> operations), only indentation and checkpatch fixes, and making sure
> that the code compiles without ACPI
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   include/sound/intel-nhlt.h | 41 ++++++++++++----
>   sound/hda/Kconfig          |  3 ++
>   sound/hda/Makefile         |  3 ++
>   sound/hda/intel-nhlt.c     | 98 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 137 insertions(+), 8 deletions(-)
>   create mode 100644 sound/hda/intel-nhlt.c
> 

The relocation of nhlt is much appreciated - it shouldn't be _reserved_ 
for /skylake in the first place. Thanks Pierre for this update.

> diff --git a/include/sound/intel-nhlt.h b/include/sound/intel-nhlt.h
> index f85fbf9c7ce4..857922f03931 100644
> --- a/include/sound/intel-nhlt.h
> +++ b/include/sound/intel-nhlt.h
> @@ -1,18 +1,17 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
>   /*
> - *  skl-nhlt.h - Intel HDA Platform NHLT header
> + *  intel-nhlt.h - Intel HDA Platform NHLT header
>    *
> - *  Copyright (C) 2015 Intel Corp
> - *  Author: Sanjiv Kumar <sanjiv.kumar@intel.com>
> - *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - *
> - * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *  Copyright (c) 2015-2019 Intel Corporation
>    */
> -#ifndef __SKL_NHLT_H__
> -#define __SKL_NHLT_H__
> +
> +#ifndef __INTEL_NHLT_H__
> +#define __INTEL_NHLT_H__
>   
>   #include <linux/acpi.h>
>   
> +#if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_SND_INTEL_NHLT)
> +

Is it really valid to have NHLT without ACPI? Correct me if I'm wrong, 
but I doubt it is. In such case, _INTEL_NHLT check alone should suffice.

>   struct wav_fmt {
>   	u16 fmt_tag;
>   	u16 channels;
> @@ -116,4 +115,30 @@ enum {
>   	NHLT_MIC_ARRAY_VENDOR_DEFINED = 0xf,
>   };
>   
> +struct nhlt_acpi_table *intel_nhlt_init(struct device *dev);
> +
> +void intel_nhlt_free(struct nhlt_acpi_table *addr);
> +
> +int intel_nhlt_get_dmic_geo(struct device *dev, struct nhlt_acpi_table *nhlt);
> +
> +#else
> +
> +struct nhlt_acpi_table;
> +
> +static inline struct nhlt_acpi_table *intel_nhlt_init(struct device *dev)
> +{
> +	return NULL;
> +}
> +
> +static inline void intel_nhlt_free(struct nhlt_acpi_table *addr)
> +{
> +}
> +
> +static inline int intel_nhlt_get_dmic_geo(struct device *dev,
> +					  struct nhlt_acpi_table *nhlt)
> +{
> +	return 0;
> +}
> +#endif
> +
>   #endif
> diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
> index f6feced15f17..c20145552cc3 100644
> --- a/sound/hda/Kconfig
> +++ b/sound/hda/Kconfig
> @@ -29,3 +29,6 @@ config SND_HDA_PREALLOC_SIZE
>   
>   	  Note that the pre-allocation size can be changed dynamically
>   	  via a proc file (/proc/asound/card*/pcm*/sub*/prealloc), too.
> +
> +config SND_INTEL_NHLT
> +	tristate

If above is true, "depends on ACPI" would be expected.

> diff --git a/sound/hda/Makefile b/sound/hda/Makefile
> index 2160202e2dc1..8560f6ef1b19 100644
> --- a/sound/hda/Makefile
> +++ b/sound/hda/Makefile
> @@ -13,3 +13,6 @@ obj-$(CONFIG_SND_HDA_CORE) += snd-hda-core.o
>   
>   #extended hda
>   obj-$(CONFIG_SND_HDA_EXT_CORE) += ext/
> +
> +snd-intel-nhlt-objs := intel-nhlt.o
> +obj-$(CONFIG_SND_INTEL_NHLT) += snd-intel-nhlt.o
> diff --git a/sound/hda/intel-nhlt.c b/sound/hda/intel-nhlt.c
> new file mode 100644
> index 000000000000..7ba871e470f2
> --- /dev/null
> +++ b/sound/hda/intel-nhlt.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2015-2019 Intel Corporation
> +
> +#include <linux/acpi.h>
> +#include <sound/intel-nhlt.h>
> +
> +#define NHLT_ACPI_HEADER_SIG	"NHLT"
> +
> +/* Unique identification for getting NHLT blobs */
> +static guid_t osc_guid =
> +	GUID_INIT(0xA69F886E, 0x6CEB, 0x4594,
> +		  0xA4, 0x1F, 0x7B, 0x5D, 0xCE, 0x24, 0xC5, 0x53);
> +
> +struct nhlt_acpi_table *intel_nhlt_init(struct device *dev)
> +{
> +	acpi_handle handle;
> +	union acpi_object *obj;
> +	struct nhlt_resource_desc  *nhlt_ptr = NULL;

Superfluous space. In fact, its initialization is too.

> +	struct nhlt_acpi_table *nhlt_table = NULL;
> +
> +	handle = ACPI_HANDLE(dev);
> +	if (!handle) {
> +		dev_err(dev, "Didn't find ACPI_HANDLE\n");
> +		return NULL;
> +	}
> +
> +	obj = acpi_evaluate_dsm(handle, &osc_guid, 1, 1, NULL);
> +	if (obj && obj->type == ACPI_TYPE_BUFFER) {

Personally, I always favor code with lower indentation over the one with 
higher tabs - makes it easier for reader to well.. read.
You could simply revert the behavior of if-statement and bail out 
immediately with below dev_dbg and return NULL. Afterward, entire block 
can be shifted left.

> +		nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
> +		if (nhlt_ptr->length)
> +			nhlt_table = (struct nhlt_acpi_table *)
> +				memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
> +					 MEMREMAP_WB);
> +		ACPI_FREE(obj);
> +		if (nhlt_table &&
> +		    (strncmp(nhlt_table->header.signature,
> +			     NHLT_ACPI_HEADER_SIG,
> +			     strlen(NHLT_ACPI_HEADER_SIG)) != 0)) {
> +			memunmap(nhlt_table);
> +			dev_err(dev, "NHLT ACPI header signature incorrect\n");
> +			return NULL;
> +		}
> +		return nhlt_table;
> +	}
> +
> +	dev_dbg(dev, "No NHLT table found\n");
> +	return NULL;

While at it, don't we leak obj here? Shouldn't we ACPI_FREE(obj) 
regardless of "obj->type == ACPI_TYPE_BUFFER" check's outcome?

> +}
> +EXPORT_SYMBOL_GPL(intel_nhlt_init);
> +
> +void intel_nhlt_free(struct nhlt_acpi_table *nhlt)
> +{
> +	memunmap((void *)nhlt);
> +}
> +EXPORT_SYMBOL_GPL(intel_nhlt_free);
> +
> +int intel_nhlt_get_dmic_geo(struct device *dev, struct nhlt_acpi_table *nhlt)
> +{
> +	struct nhlt_endpoint *epnt;
> +	struct nhlt_dmic_array_config *cfg;
> +	unsigned int dmic_geo = 0;
> +	u8 j;
> +
> +	if (!nhlt)
> +		return 0;

Should this handler even assume possibility of nhlt param being null?
