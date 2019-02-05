From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 1/2] ASoC: core: don't increase
 component module refcount unconditionally
Date: Tue, 5 Feb 2019 09:55:09 +0530
Message-ID: <20190205042509.GQ4296@vkoul-mobl>
References: <20190201172224.14549-1-pierre-louis.bossart@linux.intel.com>
 <20190201172224.14549-2-pierre-louis.bossart@linux.intel.com>
 <20190201181204.GA4296@vkoul-mobl>
 <4f43e2f691044d70048f0929c873f991fe13c69b.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 546D926743A
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 05:25:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4f43e2f691044d70048f0929c873f991fe13c69b.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 01-02-19, 12:07, Ranjani Sridharan wrote:
> On Fri, 2019-02-01 at 23:42 +0530, Vinod Koul wrote:
> > On 01-02-19, 11:22, Pierre-Louis Bossart wrote:
> > > The ASoC core has for the longest time increased the module
> > > reference
> > > counts, even before the transition to the component model. This is
> > > probably fine on most platforms, but it introduces a deadlock case
> > > on
> > > Intel devices with the Skylake and SOF drivers which cannot be
> > > removed
> > > due to their reference counts being modified by the core.
> > > 
> > > In these 2 cases, the PCI or ACPI driver .probe creates a platform
> > > device to let the machine driver .probe register the audio
> > > card. Conversely the PCI or ACPI driver .remove will unregister the
> > > platform device which results in the card being removed by the
> > > machine
> > > driver .remove.
> > > 
> > > With ascii art, this can be represented as
> > > 
> > > modprobe
> > > snd_soc_skl/
> > > soc-pci-dev/sof-acpci-dev  ----------> pci/acpi probe
> > >        ^                                    |
> > >        |                     ---------------|
> > >        |                    |               |
> > >        |                    V               V
> > >     increase            register        register machine
> > >     refcount            component       platform_device
> > >        ^                                    |
> > >        |                                    |
> > >        |                                    V
> > >     component <----   register card  <---- probe
> > >     probe
> > > 
> > > The issue is that by playing with the component's module reference
> > > counts during the card registration, it's no longer possible to
> > > remove
> > > the module which controls the component. This can be shown, e.g.
> > > with
> > > the following error:
> > > 
> > > root@plb-XPS-13-9350:~# lsmod | grep snd_soc_skl
> > > snd_soc_skl           110592  1
> > > 
> > > root@plb-XPS-13-9350:~# rmmod snd_soc_skl
> > > rmmod: ERROR: Module snd_soc_skl is in use
> > 
> > Yup, that would be correct, the inuse is due to the fact the sound
> > card
> > is up and someone needs to unload the sound card to remove the
> > reference.
> > 
> > That can be done by doing the rmmod of machine driver first and IIRC
> > that would remove the sound card and drop the reference and then
> > snd_soc_skl can be unloaded.
> 
> This doesnt seem to be the case though. The machine driver module
> cannot be removed either because its refcnt is also > 0.

At least this used to be the case when I used to try removal of modules
on skl, doing the reverse of load order seemed to work for me back then.

-- 
~Vinod
