From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 7/9] ASoC: Intel: move PCI probe to a
 seprate	file
Date: Thu, 30 Oct 2014 20:04:44 +0530
Message-ID: <20141030143444.GA28745@intel.com>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
 <1414666312-4657-8-git-send-email-vinod.koul@intel.com>
 <s5hmw8d4n1c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CE4E326060C
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 16:18:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hmw8d4n1c.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 30, 2014 at 04:03:59PM +0100, Takashi Iwai wrote:
> At Thu, 30 Oct 2014 16:21:50 +0530,
> Vinod Koul wrote:
> > 
> > From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > 
> > This allow the sst.c to be common across PCI and APCI usages
> > 
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > 
> > Author:    Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > ---
> >  sound/soc/intel/Kconfig       |    4 +
> >  sound/soc/intel/sst/Makefile  |    4 +
> >  sound/soc/intel/sst/sst.c     |  200 +------------------------------------
> >  sound/soc/intel/sst/sst.h     |    6 +
> >  sound/soc/intel/sst/sst_pci.c |  225 +++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 240 insertions(+), 199 deletions(-)
> >  create mode 100644 sound/soc/intel/sst/sst_pci.c
> > 
> > diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> > index 2a3af88..cbc987e 100644
> > --- a/sound/soc/intel/Kconfig
> > +++ b/sound/soc/intel/Kconfig
> > @@ -4,6 +4,7 @@ config SND_MFLD_MACHINE
> >  	select SND_SOC_SN95031
> >  	select SND_SST_MFLD_PLATFORM
> >  	select SND_SST_IPC
> > +	select SND_SST_IPC_PCI
> >  	help
> >            This adds support for ASoC machine driver for Intel(R) MID Medfield platform
> >            used as alsa device in audio substem in Intel(R) MID devices
> > @@ -16,6 +17,9 @@ config SND_SST_MFLD_PLATFORM
> >  config SND_SST_IPC
> >  	tristate
> >  
> > +config SND_SST_IPC_PCI
> > +	bool
> > +
> >  config SND_SOC_INTEL_SST
> >  	tristate "ASoC support for Intel(R) Smart Sound Technology"
> >  	select SND_SOC_INTEL_SST_ACPI if ACPI
> > diff --git a/sound/soc/intel/sst/Makefile b/sound/soc/intel/sst/Makefile
> > index 4d0e79b..b3fbccd 100644
> > --- a/sound/soc/intel/sst/Makefile
> > +++ b/sound/soc/intel/sst/Makefile
> > @@ -1,3 +1,7 @@
> >  snd-intel-sst-objs := sst.o sst_ipc.o sst_stream.o sst_drv_interface.o sst_loader.o sst_pvt.o
> >  
> > +ifneq ($(CONFIG_SND_SST_IPC_PCI),)
> > +snd-intel-sst-objs += sst_pci.o
> > +endif
> 
> The standard way is something like
> 
> snd-intel-sst-y := sst.o sst_ipc.o sst_stream.o sst_drv_interface.o sst_loader.o sst_pvt.o
> snd-intel-sst-$(CONFIG_SND_SST_IPC_PCI) += sst_pci.o
> 
> But, when looking at the later patch, you try to build ACPI stuff into
> snd-intel-sst, too, and both are implemented as exclusive.  This
> doesn't work well in general.
The hardware, firmware so the driver is pretty same. So either it gets probed
as PCI device is SFI platforms and as APCI device on ACPI ones.
Since the probe method is the only one differing, the machine will select
either PCI or ACPI. That one would get compiled in.

Am okay to change if we have better method which works for both

-- 
~Vinod
