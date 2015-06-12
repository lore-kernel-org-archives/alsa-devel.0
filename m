From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [RFC PATCH] ALSA: split params refinement to
	seperated file
Date: Fri, 12 Jun 2015 07:38:04 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A905549F99@SHSMSX101.ccr.corp.intel.com>
References: <1433429265-22054-1-git-send-email-yang.jie@intel.com>
 <20150604191548.GR14071@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90553DD1E@SHSMSX101.ccr.corp.intel.com>
 <s5hd216k12q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 80780266723
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 09:38:09 +0200 (CEST)
In-Reply-To: <s5hd216k12q.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "Zhang, Vivian" <vivian.zhang@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, June 08, 2015 5:21 PM
> To: Jie, Yang
> Cc: Mark Brown; alsa-devel@alsa-project.org; Girdwood, Liam R; Zhang,
> Vivian
> Subject: Re: [RFC PATCH] ALSA: split params refinement to seperated file
> 
> At Mon, 8 Jun 2015 07:35:17 +0000,
> Jie, Yang wrote:
> >
> > > -----Original Message-----
> > > From: Mark Brown [mailto:broonie@kernel.org]
> > > Sent: Friday, June 05, 2015 3:16 AM
> > > To: Jie, Yang
> > > Cc: tiwai@suse.de; alsa-devel@alsa-project.org; Girdwood, Liam R;
> > > Zhang, Vivian
> > > Subject: Re: [RFC PATCH] ALSA: split params refinement to seperated
> > > file
> > >
> > > On Thu, Jun 04, 2015 at 10:47:45PM +0800, Jie Yang wrote:
> > >
> > > > The change moves refinement functions from original pcm_native.c
> > > > and pcm_lib.c, to pcm_refine.c(similarly the declaration from
> > > > pcm.h to pcm_refine.h), so it is not so big as it looks like.
> > >
> > > I'd suggest that for review it'd be easier to have one patch for the
> > > move and another for the change in behaviour: it's a bit hard to
> > > find the actual change in what the kernel does in this diff and
> > > that's the bit that needs most careful consideration.
> > >
> > > git format-patch -M may also help.
> >
> > Umm, Liam also suggested that, it's really hard for reviewing, but I
> > found that "git format-patch -M" doesn't help for partially
> > splitting/moving from a file to another/new file, I even tried '-M5%',
> > but no luck. :(
> >
> > I can't find good way to make it better, any suggestion?
> 
> Just begin with adding ifdefs instead of reshuffling the code.  This will make
> easier to understand what you're going to change.  At least, it's good enough
> for RFC.  After that, we can refactor the code.
 
That make sense.

> 
> But, before going further, I'd like to know the exact measurement you've
> done, the target and the goal.  Measuring only the static code size doesn't
 
Our target the minimum memory footprint usage for ALSA on small(e.g. IoT)
devices, and using 'lsmod' to check the status(including memory footprint)
of the modules.

> help much from the whole system POV.  Also, it's not clear which
> functionality has to be kept with which drivers and which configuration.
 
We suppose the bspoke application will pass down the specific params to
ALSA on those small devices, then hw refinement may be not needed.

We also made adapted change in tinyplay, did some testing and verified it works
in this case.

> 
> Removing the hw constraints refinement is rather a radical change.
> It's a part of the PCM core functionality, and removing it means that the
> driver has no ways to refuse the incompatible parameters even if it knows
 
Can we just return error and refuse doing stream playback/capture when we
know it's broken?

> it's broken.  So, IMO, this is the very last resort.  We can start from ripping off
> lower hanging fruits.
 
Agree that it is very last resort, I realized that it is a radical change and impact a
lot before sending this RFC. :|

thanks,
~Keyon
> 
> 
> thanks,
> 
> Takashi
