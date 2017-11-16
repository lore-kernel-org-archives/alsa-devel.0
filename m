From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [GIT PULL] sound updates for 4.15-rc1
Date: Thu, 16 Nov 2017 08:55:35 -0600
Message-ID: <8bcf9060-92b9-8058-cdee-4a222e796b3e@linux.intel.com>
References: <s5h4lpwap7p.wl-tiwai@suse.de>
 <CA+55aFw0PPt3T1DG9HL_x_wH56D-5R_CoOy=rnRJduDo_Qp6nQ@mail.gmail.com>
 <s5hmv3oatce.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E0DF426716A
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 15:55:38 +0100 (CET)
In-Reply-To: <s5hmv3oatce.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11/15/17 1:34 AM, Takashi Iwai wrote:
> [Adding more people and alsa-devel to Cc]
> 
> On Wed, 15 Nov 2017 03:40:09 +0100,
> Linus Torvalds wrote:
>>
>> On Tue, Nov 14, 2017 at 6:51 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>>
>>> please pull sound updates for v4.15-rc1 from:
>>
>> Hmm. Making "oldconfig" on my laptop with this, my
>> SND_SOC_INTEL_SKYLAKE went away.
>>
>> And the reason seems to be that new SND_SOC_INTEL_SST_TOPLEVEL config option.
>>
>> Which has no help associated with it.
>>
>> This is not a friendly thing to do to people. It basically breaks
>> existing setups for no documented reason, and with no explanation.
>>
>> Please fix the config situation. At the very least, add documentation.
> 
> Sorry about that.  I saw Vinod already submitted a patch to add the
> help text to CONFIG_SND_SOC_INTEL_SST_TOPLEVEL, so the least fix
> should go in soon.
> 
> But now looking at these changes, I noticed a few things, too:
> 
> - With the introduction of SND_SOC_INTEL_SST_TOPLEVEL, keeping
>    SND_SOC_INTEL_COMMON and SND_SOC_INTEL_MACH individually doesn't
>    make much sense.  They can be dropped and replaced with
>    SND_SOC_INTEL_SST_TOPLEVEL as a further cleanup.
> 
> - ... or, make SND_SOC_INTEL_SST_TOPLEVEL=y as default, if this is
>    considered to be a top-level filter config (like the network vendor
>    kconfig items).  In that case, the reverse-selection of
>    SND_SOC_INTEL_COMMON and SND_SOC_INTEL_MACH should be avoided, but
>    they should be selected from the actual drivers instead.

This level was introduced as a shortcut to help select the platform 
drivers associated with the closed-source audio firmware.
There will be a follow-up set of patches coming soon, and we'll need to 
have the corresponding top-level selector for the drivers handling the 
open-source audio firmware. Please don't make too many assumptions on 
this SND_SOC_INTEL_SST_TOPLEVEL, it is not going to be true for everyone 
moving forward.

If you want look at the Kconfig setup, the latest code cherry-picked on 
top of v4.14 is here
https://github.com/plbossart/sound/tree/backport/intel-audio-stable-v4.14

the menuconfig options are still in device drivers/sound/ASoC but now 
you have SST and SOF menus.

> 
> 
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
> 
> Hmm...
> 
> 
> Takashi
> 
