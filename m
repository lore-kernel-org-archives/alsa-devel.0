From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 1/6] ASoC: Intel: Skylake: Add CFL-S support
Date: Wed, 21 Nov 2018 19:38:41 +0200
Message-ID: <20181121173841.GS10650@smile.fi.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-2-pierre-louis.bossart@linux.intel.com>
 <20181121142721.GO10650@smile.fi.intel.com>
 <414b4c3a-7e04-2775-7d87-16a236b5b4e8@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <414b4c3a-7e04-2775-7d87-16a236b5b4e8@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, liam.r.girdwood@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 21, 2018 at 11:16:50AM -0600, Pierre-Louis Bossart wrote:
> On 11/21/18 8:27 AM, Andy Shevchenko wrote:

> > May you consider to switch to PCI_DEVICE_DATA() first?
> 
> Is this really the recommended path?
> 
> The macro generates PCI_DEVICE_ID_##vend##_##dev, and I don't have a turn
> key #define PCI_DEVICE_ID_INTEL_AUDIO_CFL 0xa348 I can use. In a number of
> cases we have multiple variants of the same hardware, and it starts being
> painful to use a 20-letter macro to differentiate between INTEL_AUDIO_CFL_Y
> and INTEL_AUDIO_CFL_H. The explicit code and a short comment are more
> readable really.
> 
> git grep PCI_DEVICE_ID_INTEL gives me hundreds of definitions, some global,
> some local to specific drivers, doesn't seem like there is a well-agreed
> usage of this macro, is there? I don't mind making the change but I don't
> sense an strong argument for it?

Compare:

	/* CFL */
	{ PCI_DEVICE(0x8086, 0xa348),
		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},

to something like:

#define PCI_DEVICE_ID_INTEL_AUDIO_CFL	0xa348
...

	{PCI_DEVICE_DATA(INTEL, AUDIO_CFL, &snd_soc_acpi_intel_cnl_machines)},


Macro is recently introduced, that's why not many users of it. At least I'm
planning to clean up dwc3-pci.c using it.

-- 
With Best Regards,
Andy Shevchenko
