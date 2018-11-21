From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 1/6] ASoC: Intel: Skylake: Add CFL-S support
Date: Wed, 21 Nov 2018 16:27:21 +0200
Message-ID: <20181121142721.GO10650@smile.fi.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181120213644.19103-2-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, liam.r.girdwood@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2018 at 03:36:39PM -0600, Pierre-Louis Bossart wrote:
> From: Takashi Iwai <tiwai@suse.de>
> 
> It's with CNP, supposed to be equivalent with CNL entry.
> 

May you consider to switch to PCI_DEVICE_DATA() first?

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/intel/skylake/skl-messages.c | 8 ++++++++
>  sound/soc/intel/skylake/skl.c          | 3 +++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
> index 8bfb8b0fa3d5..b0e6fb93eaf8 100644
> --- a/sound/soc/intel/skylake/skl-messages.c
> +++ b/sound/soc/intel/skylake/skl-messages.c
> @@ -247,6 +247,14 @@ static const struct skl_dsp_ops dsp_ops[] = {
>  		.init_fw = cnl_sst_init_fw,
>  		.cleanup = cnl_sst_dsp_cleanup
>  	},
> +	{
> +		.id = 0xa348,
> +		.num_cores = 4,
> +		.loader_ops = bxt_get_loader_ops,
> +		.init = cnl_sst_dsp_init,
> +		.init_fw = cnl_sst_init_fw,
> +		.cleanup = cnl_sst_dsp_cleanup
> +	},
>  };
>  
>  const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 3f0ac1312982..df36b8fe6d5e 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -1121,6 +1121,9 @@ static const struct pci_device_id skl_ids[] = {
>  	/* CNL */
>  	{ PCI_DEVICE(0x8086, 0x9dc8),
>  		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> +	/* CFL */
> +	{ PCI_DEVICE(0x8086, 0xa348),
> +		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, skl_ids);
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko
