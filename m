From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 1/6] ASoC: Intel: Skylake: Add CFL-S support
Date: Thu, 22 Nov 2018 11:56:11 +0200
Message-ID: <20181122095611.GV10650@smile.fi.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-2-pierre-louis.bossart@linux.intel.com>
 <20181121142721.GO10650@smile.fi.intel.com>
 <414b4c3a-7e04-2775-7d87-16a236b5b4e8@linux.intel.com>
 <20181121173841.GS10650@smile.fi.intel.com>
 <s5hh8gaaxdm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hh8gaaxdm.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org, liam.r.girdwood@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 21, 2018 at 11:17:41PM +0100, Takashi Iwai wrote:
> On Wed, 21 Nov 2018 18:38:41 +0100, Andy Shevchenko wrote:

> > Compare:
> > 
> > 	/* CFL */
> > 	{ PCI_DEVICE(0x8086, 0xa348),
> > 		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> > 
> > to something like:
> > 
> > #define PCI_DEVICE_ID_INTEL_AUDIO_CFL	0xa348
> > ...
> > 
> > 	{PCI_DEVICE_DATA(INTEL, AUDIO_CFL, &snd_soc_acpi_intel_cnl_machines)},
> 
> The former gives a better grep-ability, though.
> 
> I have no big preference over two, just want to mention that both have
> merits and demerits.

True.
So, up to you, guys, what to choose.

-- 
With Best Regards,
Andy Shevchenko
