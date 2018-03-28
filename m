From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] ALSA: hda_intel: mark PM functions as __maybe_unused
Date: Wed, 28 Mar 2018 16:31:50 +0200
Message-ID: <20180328143150.GA17992@wunner.de>
References: <20180328142020.3275989-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180328142020.3275989-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hans de Goede <hdegoede@redhat.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 28, 2018 at 04:19:29PM +0200, Arnd Bergmann wrote:
> Two callsites of azx_suspend/azx_resume were removed, leaving these
> functions only called from the optional SET_SYSTEM_SLEEP_PM_OPS()
> and causing a warning without CONFIG_PM_SLEEP:
> 
> sound/pci/hda/hda_intel.c:1029:12: error: 'azx_resume' defined but not used [-Werror=unused-function]
>  static int azx_resume(struct device *dev)
>             ^~~~~~~~~~
> sound/pci/hda/hda_intel.c:994:12: error: 'azx_suspend' defined but not used [-Werror=unused-function]
>  static int azx_suspend(struct device *dev)
>             ^~~~~~~~~~~
> 
> Keeping track of the correct #ifdef checks is hard, so this removes
> all the #ifdefs for power management in this file and instead uses
> __maybe_unused annotations that let the compiler do the job right
> by itself.

Ugh, this isn't as hard as it may seem, just replace

	#if defined(CONFIG_PM_SLEEP) || defined(SUPPORT_VGA_SWITCHEROO)

with

	#if defined(CONFIG_PM_SLEEP)

That way it's just a simple one line change which is less intrusive.

Care to respin like this?

Thanks for the report,

Lukas
