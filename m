From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 28/35] ASoC: Intel: Skylake: Update skl_ids
 table
Date: Fri, 23 Aug 2019 15:15:14 -0500
Message-ID: <91852fc6-6bef-9a1d-f380-da7a3985b637@linux.intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-29-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0AB54F80141
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 22:28:21 +0200 (CEST)
In-Reply-To: <20190822190425.23001-29-cezary.rojewski@intel.com>
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
> With platform descriptors defined, update PCI ID table together with
> skl_probe to retrieve supported boards from saved sst_pdata objects
> instead.

I don't get what you are trying to do here. the only 'benefit' seems to 
duplicate the firmware name, which as I mentioned earlier isn't such a 
good idea.

> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>   sound/soc/intel/skylake/skl.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index d6d099aba834..53a6befd5d68 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -985,6 +985,7 @@ static int skl_probe(struct pci_dev *pci,
>   {
>   	struct skl_dev *skl;
>   	struct hdac_bus *bus = NULL;
> +	struct sst_pdata *desc;
>   	int err;
>   
>   	switch (skl_pci_binding) {
> @@ -1064,7 +1065,8 @@ static int skl_probe(struct pci_dev *pci,
>   
>   	pci_set_drvdata(skl->pci, bus);
>   
> -	err = skl_find_machine(skl, (void *)pci_id->driver_data);
> +	desc = (struct sst_pdata *)pci_id->driver_data;
> +	err = skl_find_machine(skl, desc->boards);
>   	if (err < 0) {
>   		dev_err(bus->dev, "skl_find_machine failed with err: %d\n", err);
>   		goto out_nhlt_free;
> @@ -1194,42 +1196,42 @@ static const struct pci_device_id skl_ids[] = {
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
>   	/* Sunrise Point-LP */
>   	{ PCI_DEVICE(0x8086, 0x9d70),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_skl_machines},
> +		.driver_data = (unsigned long)&skl_desc },
>   #endif
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
>   	/* BXT-P */
>   	{ PCI_DEVICE(0x8086, 0x5a98),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_bxt_machines},
> +		.driver_data = (unsigned long)&apl_desc },
>   #endif
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
>   	/* KBL */
>   	{ PCI_DEVICE(0x8086, 0x9D71),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_kbl_machines},
> +		.driver_data = (unsigned long)&kbl_desc },
>   #endif
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_GLK)
>   	/* GLK */
>   	{ PCI_DEVICE(0x8086, 0x3198),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_glk_machines},
> +		.driver_data = (unsigned long)&glk_desc },
>   #endif
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CNL)
>   	/* CNL */
>   	{ PCI_DEVICE(0x8086, 0x9dc8),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> +		.driver_data = (unsigned long)&cnl_desc },
>   #endif
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CFL)
>   	/* CFL */
>   	{ PCI_DEVICE(0x8086, 0xa348),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> +		.driver_data = (unsigned long)&cnl_desc },
>   #endif
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML_LP)
>   	/* CML-LP */
>   	{ PCI_DEVICE(0x8086, 0x02c8),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> +		.driver_data = (unsigned long)&cnl_desc },
>   #endif
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML_H)
>   	/* CML-H */
>   	{ PCI_DEVICE(0x8086, 0x06c8),
> -		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> +		.driver_data = (unsigned long)&cnl_desc },
>   #endif
>   	{ 0, }
>   };
> 
