From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v1 1/2] ASoC: SOF: Add Comet Lake PCI ID
Date: Mon, 6 May 2019 20:40:53 -0500
Message-ID: <74e8cfcd-b99f-7f66-48ce-44d60eb2bbca@linux.intel.com>
References: <20190506225321.74100-1-evgreen@chromium.org>
 <20190506225321.74100-2-evgreen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190506225321.74100-2-evgreen@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Naveen M <naveen.m@intel.com>, Sathya Prakash <sathya.prakash.m.r@intel.com>, Ben Zhang <benzh@chromium.org>, Rajat Jain <rajatja@chromium.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 5/6/19 5:53 PM, Evan Green wrote:
> Add support for Intel Comet Lake platforms by adding a new Kconfig
> for CometLake and the appropriate PCI ID.

This is odd. I checked internally a few weeks back and the CML PCI ID 
was 9dc8, same as WHL and CNL, so we did not add a PCI ID on purpose. To 
the best of my knowledge SOF probes fine on CML and the known issues can 
be found on the SOF github [1].

Care to send the log of sudo lspci -s 0:1f.3 -vn ?

[1] 
https://github.com/thesofproject/sof/issues?q=is%3Aopen+is%3Aissue+label%3ACML
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
>   sound/soc/sof/intel/Kconfig | 16 ++++++++++++++++
>   sound/soc/sof/sof-pci-dev.c |  4 ++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
> index 32ee0fabab92..0b616d025f05 100644
> --- a/sound/soc/sof/intel/Kconfig
> +++ b/sound/soc/sof/intel/Kconfig
> @@ -24,6 +24,7 @@ config SND_SOC_SOF_INTEL_PCI
>   	select SND_SOC_SOF_CANNONLAKE  if SND_SOC_SOF_CANNONLAKE_SUPPORT
>   	select SND_SOC_SOF_COFFEELAKE  if SND_SOC_SOF_COFFEELAKE_SUPPORT
>   	select SND_SOC_SOF_ICELAKE     if SND_SOC_SOF_ICELAKE_SUPPORT
> +	select SND_SOC_SOF_COMETLAKE   if SND_SOC_SOF_COMETLAKE_SUPPORT
>   	help
>   	  This option is not user-selectable but automagically handled by
>   	  'select' statements at a higher level
> @@ -179,6 +180,21 @@ config SND_SOC_SOF_ICELAKE
>   	  This option is not user-selectable but automagically handled by
>   	  'select' statements at a higher level
>   
> +config SND_SOC_SOF_COMETLAKE
> +	tristate
> +	select SND_SOC_SOF_CANNONLAKE
> +	help
> +	  This option is not user-selectable but automagically handled by
> +	  'select' statements at a higher level
> +
> +config SND_SOC_SOF_COMETLAKE_SUPPORT
> +	bool "SOF support for CometLake"
> +	help
> +	  This adds support for Sound Open Firmware for Intel(R) platforms
> +	  using the Cometlake processors.
> +	  Say Y if you have such a device.
> +	  If unsure select "N".
> +
>   config SND_SOC_SOF_HDA_COMMON
>   	tristate
>   	select SND_SOC_SOF_INTEL_COMMON
> diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
> index b778dffb2d25..5f0128337e40 100644
> --- a/sound/soc/sof/sof-pci-dev.c
> +++ b/sound/soc/sof/sof-pci-dev.c
> @@ -353,6 +353,10 @@ static const struct pci_device_id sof_pci_ids[] = {
>   #if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
>   	{ PCI_DEVICE(0x8086, 0x34C8),
>   		.driver_data = (unsigned long)&icl_desc},
> +#endif
> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE)
> +	{ PCI_DEVICE(0x8086, 0x02c8),
> +		.driver_data = (unsigned long)&cnl_desc},
>   #endif
>   	{ 0, }
>   };
> 
