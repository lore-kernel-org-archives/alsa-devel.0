From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Correct modules for Bay Trail MAX98090 soc?
Date: Thu, 11 Aug 2016 18:31:27 -0500
Message-ID: <3a548725-5b52-4b3e-457a-f6ca93645b15@linux.intel.com>
References: <88774f89-ce4a-1877-db49-b018d725f1cd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <88774f89-ce4a-1877-db49-b018d725f1cd@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>, Jie Yang <yang.jie@intel.com>, Takashi Iwai <tiwai@suse.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 8/11/16 3:42 PM, Laura Abbott wrote:
> Hi,
>
> Fedora got a bug report[1] that sound was failing on Intel Bay Trail Socs
> that use the MAX98090 module. I found
>
> Author: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Date:   Mon Feb 8 10:45:38 2016 +0530
>
>     ASoC: Intel: Load the atom DPCM driver only
>         DPCM driver is recommended for BYT, CHT based platforms, so if
>     CONFIG_SND_SST_IPC_ACPI is selected then don't compile the BYT
>     Device IDs in common ACPI driver to avoid probe conflicts.
>         Signed-off-by: Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com>
>     Acked-by: Jie Yang <yang.jie@intel.com>
>     Signed-off-by: Vinod Koul <vinod.koul@intel.com>
>     Signed-off-by: Mark Brown <broonie@kernel.org>
>
>
> which changed the dependencies for CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH.
> The set of options Fedora selects means that
> CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH
> can't be selected. Is there another driver that's supposed to replace
> CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH on Bay Trail or do the dependencies
> need to be updated? The bugzilla has alsa-info for working and non-
> working cases and the Fedora config is attached.

If you remove support for all other baytrail options this driver should 
still be there and selectable. We just can't support both this driver 
for Chromebooks and the rest for other machines with the same 
distribution at the moment.
