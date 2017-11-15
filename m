From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [GIT PULL] sound updates for 4.15-rc1
Date: Wed, 15 Nov 2017 20:54:11 +0530
Message-ID: <20171115152411.GI3187@localhost>
References: <s5h4lpwap7p.wl-tiwai@suse.de>
 <CA+55aFw0PPt3T1DG9HL_x_wH56D-5R_CoOy=rnRJduDo_Qp6nQ@mail.gmail.com>
 <s5hmv3oatce.wl-tiwai@suse.de>
 <20171115113742.27b2nvfsbtvv7gfs@sirena.org.uk>
 <s5ha7zn69e7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B8D0F266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 16:20:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5ha7zn69e7.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 12:58:40PM +0100, Takashi Iwai wrote:
> On Wed, 15 Nov 2017 12:37:42 +0100,
> Mark Brown wrote:
> > 
> > On Wed, Nov 15, 2017 at 08:34:09AM +0100, Takashi Iwai wrote:
> > 
> > > And I believe there are a few more possible cleanups / fixes in the
> > > messy Intel ASoC Kconfigs.  For example, SND_SOC_INTEL_SST is almost
> > > always set.  The only exception is via SND_SST_ATOM_HIFI2_PLATFORM.
> > > But all machine drivers using Atom Hifi2 do set SND_SST_IPC_ACPI,
> > > which also requires SND_SOC_INTEL_SST.
> > 
> > I'm not 100% convinced that the recent changes away from just having the
> > only user selectable options be the board ones have really helped that
> > much.
> 
> Yeah, now it resulted in a mixture of selects and depends, which is a
> bad sign.  I'm not against this kind of reorganization but we need to
> sort out more.
> 
> > Though transitioning back would probably just create more misery.
> > It's a real shame that ACPI doesn't have standards for the machine
> > descriptions here like DT does, it'd cut down on the amount of stuff
> > that needs configuring.
> 
> True.  Although I don't think ACPI is the center of the mess in this
> case, but rather too many kconfigs is it.
> 
> In soc/intel/*, we have the following entries:
> 
> as non-selectable ones:
> - SND_SST_IPC
> - SND_SST_IPC_PCI
> - SND_SST_IPC_ACPI
> - SND_SOC_INTEL_COMMON
> - SND_SOC_INTEL_SST
> - SND_SOC_INTEL_SST_FIRMWARE
> - SND_SOC_INTEL_SST_ACPI
> - SND_SOC_ACPI_INTEL_MATCH
> 
> and the selectable ones:
> - SND_SOC_INTEL_SST_TOPLEVEL
> - SND_SOC_INTEL_HASWELL
> - SND_SOC_INTEL_BAYTRAIL
> - SND_SST_ATOM_HIFI2_PLATFORM
> - SND_SOC_INTEL_SKYLAKE
> 
> And yet, there are tons of machine drivers as selectable kconfigs:
> - SND_SOC_INTEL_MACH

this will be top level menu entry no select/default here as Takashi
suggested.

> - SND_MFLD_MACHINE

this would be a lone ranger

> - SND_SOC_INTEL_HASWELL_MACH
> - SND_SOC_INTEL_BDW_RT5677_MACH
> - SND_SOC_INTEL_BROADWELL_MACH

we can bucket this in SND_SOC_INTEL_HSW_MACHS

> - SND_SOC_INTEL_BYT_MAX98090_MACH
> - SND_SOC_INTEL_BYT_RT5640_MACH

SND_SOC_INTEL_LEGACY_BYT

> - SND_SOC_INTEL_BYTCR_RT5640_MACH
> - SND_SOC_INTEL_BYTCR_RT5651_MACH
> - SND_SOC_INTEL_CHT_BSW_RT5672_MACH
> - SND_SOC_INTEL_CHT_BSW_RT5645_MACH
> - SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
> - SND_SOC_INTEL_BYT_CHT_DA7213_MACH
> - SND_SOC_INTEL_BYT_CHT_ES8316_MACH
> - SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH

SND_SOC_INTEL_BYT_MACHS

> - SND_SOC_INTEL_SKL_RT286_MACH
> - SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
> - SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
> - SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
> - SND_SOC_INTEL_BXT_RT298_MACH
> - SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
> - SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH

SND_SOC_INTEL_SKL_MACHS

This set is growing and will keep growing. One machine is already posted and
it's cousins should follow soon. I don't see a point in having options for
these ad distro's would be enabling all of them and having all of them
enabled works fine for me

> We should begin with thinking of which entries (and layer) to be
> selectable, and which not.

Trickier part is non selectable ones, I am going to take a stab at them and
see if we can merge few which can help is making lesser options and clean
that part a bit, maybe a common SST_IPC symbol which adds IPC, MATCH etc.

Stay tuned ... :)

-- 
~Vinod
