From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 7/9] ASoC: Intel: move PCI probe to a
 seprate	file
Date: Thu, 30 Oct 2014 21:29:47 +0530
Message-ID: <20141030155947.GF28745@intel.com>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
 <1414666312-4657-8-git-send-email-vinod.koul@intel.com>
 <s5hmw8d4n1c.wl-tiwai@suse.de> <20141030143444.GA28745@intel.com>
 <s5hh9yl4lyq.wl-tiwai@suse.de> <20141030153719.GE28745@intel.com>
 <s5h7fzh4j3n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A4B29260632
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 17:40:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7fzh4j3n.wl-tiwai@suse.de>
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

On Thu, Oct 30, 2014 at 05:29:00PM +0100, Takashi Iwai wrote:
> At Thu, 30 Oct 2014 21:07:19 +0530,
> Vinod Koul wrote:
> > 
> > On Thu, Oct 30, 2014 at 04:27:09PM +0100, Takashi Iwai wrote:
> > > > > The standard way is something like
> > > > > 
> > > > > snd-intel-sst-y := sst.o sst_ipc.o sst_stream.o sst_drv_interface.o sst_loader.o sst_pvt.o
> > > > > snd-intel-sst-$(CONFIG_SND_SST_IPC_PCI) += sst_pci.o
> > > > > 
> > > > > But, when looking at the later patch, you try to build ACPI stuff into
> > > > > snd-intel-sst, too, and both are implemented as exclusive.  This
> > > > > doesn't work well in general.
> > > > The hardware, firmware so the driver is pretty same. So either it gets probed
> > > > as PCI device is SFI platforms and as APCI device on ACPI ones.
> > > > Since the probe method is the only one differing, the machine will select
> > > > either PCI or ACPI. That one would get compiled in.
> > > 
> > > ... and this exclusion mechanism is missing in your patches.
> > > Your current code doesn't allow to mix them.
> > > 
> > > > Am okay to change if we have better method which works for both
> > > 
> > > In general, it's better to provide individual modules for different
> > > interfaces and a common module that is referred by them.  The
> > > selective build makes the build tests more difficult and is rather
> > > error-prone.
> > Hmmm, that makes me wonder why cant we do (based on your input above)
> > 
> > snd-intel-sst-y := sst.o sst_ipc.o sst_stream.o sst_drv_interface.o sst_loader.o sst_pvt.o
> > 
> > then either this:
> > snd-intel-sst-$(CONFIG_SND_SST_IPC_PCI) += sst_pci.o
> > snd-intel-sst-$(CONFIG_SND_SST_IPC_ACPI) += sst_acpi.o
> 
> This may compile both sst_pci.c and sst_acpi.c into snd-intel-sst
> module, so it doesn't work unless both Kconfigs are really exclusive.
> 
> > Or:
> > snd-intel-sst-pci-y += snd-intel-sst.o sst_pci.o
> > snd-intel-sst-acpi-y += snd-intel-sst.o sst_acpi.o
> 
> This is wrong in two ways.  First off, you can't link a module against
> another module.
> 
> Second, this causes the problem when user build one driver as a module
> and another as built-in.  Then you'll get the doubly symbols.
oh no, the core is not a module. the PCI and ACPI will be modules and
allowed to be selected.
Can we prevent the module/built-in by making depends. If one is built-in
other cant be module. That way it would be okay

> So, snd-intel-sst.o must be an individual module.
Since only probe and apci/pci resource setup code is different I would still
like to keep the core lib as same and PCI/ACPI as modules.

-- 
~Vinod
