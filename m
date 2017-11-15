From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [GIT PULL] sound updates for 4.15-rc1
Date: Wed, 15 Nov 2017 16:13:46 +0530
Message-ID: <20171115104346.GH3187@localhost>
References: <s5h4lpwap7p.wl-tiwai@suse.de>
 <CA+55aFw0PPt3T1DG9HL_x_wH56D-5R_CoOy=rnRJduDo_Qp6nQ@mail.gmail.com>
 <s5hmv3oatce.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 49955266E65
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 11:40:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hmv3oatce.wl-tiwai@suse.de>
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

On Wed, Nov 15, 2017 at 08:34:09AM +0100, Takashi Iwai wrote:
> [Adding more people and alsa-devel to Cc]
> 
> On Wed, 15 Nov 2017 03:40:09 +0100,
> Linus Torvalds wrote:
> > 
> > On Tue, Nov 14, 2017 at 6:51 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > please pull sound updates for v4.15-rc1 from:
> > 
> > Hmm. Making "oldconfig" on my laptop with this, my
> > SND_SOC_INTEL_SKYLAKE went away.
> > 
> > And the reason seems to be that new SND_SOC_INTEL_SST_TOPLEVEL config option.
> > 
> > Which has no help associated with it.
> > 
> > This is not a friendly thing to do to people. It basically breaks
> > existing setups for no documented reason, and with no explanation.
> > 
> > Please fix the config situation. At the very least, add documentation.
> 
> Sorry about that.  I saw Vinod already submitted a patch to add the
> help text to CONFIG_SND_SOC_INTEL_SST_TOPLEVEL, so the least fix
> should go in soon.
> 
> But now looking at these changes, I noticed a few things, too:
> 
> - With the introduction of SND_SOC_INTEL_SST_TOPLEVEL, keeping
>   SND_SOC_INTEL_COMMON and SND_SOC_INTEL_MACH individually doesn't
>   make much sense.  They can be dropped and replaced with
>   SND_SOC_INTEL_SST_TOPLEVEL as a further cleanup.
> 
> - ... or, make SND_SOC_INTEL_SST_TOPLEVEL=y as default, if this is
>   considered to be a top-level filter config (like the network vendor
>   kconfig items).  In that case, the reverse-selection of
>   SND_SOC_INTEL_COMMON and SND_SOC_INTEL_MACH should be avoided, but
>   they should be selected from the actual drivers instead.

both make sense to me. Sometimes back I also was thinking of having single
user config for a group of machine configs. I dont know if people really
care about various types of skylake audio machines so enabling all of
them with a single option maynot be a very bad idea... thoughts?

This way we can have a skylake based, legacy BYT, HSW group, Atom BYT-CHT
group. Distro anyway enable all and having all drivers selected works fine
This way our expanding kconfig can be limited.

> And I believe there are a few more possible cleanups / fixes in the
> messy Intel ASoC Kconfigs.  For example, SND_SOC_INTEL_SST is almost
> always set.  The only exception is via SND_SST_ATOM_HIFI2_PLATFORM.
> But all machine drivers using Atom Hifi2 do set SND_SST_IPC_ACPI,
> which also requires SND_SOC_INTEL_SST.
> 
> Further looking at this, we see that the only entry that does *not*
> require SND_SOC_INTEL_SST is the case with SND_MFLD_MACHINE in
> sound/soc/intel/boards.  And now more interesting part -- there is no
> corresponding entry in Makefile.  That is, this kconfig is effectively
> dead!  The source code mfld_machine.c exists, but it's just a place
> holder now.  The code was supposed to be integrated into atom
> directory by the commit b97169da0699, but it seems forgotten to be
> updated.

Looks like it was missed indeed, I will send this one out too and lets
discuss which way all like to solve this and I shall send patches :)

-- 
~Vinod
