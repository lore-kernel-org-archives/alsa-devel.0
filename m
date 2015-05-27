From: "Jie, Yang" <yang.jie@intel.com>
Subject: RE: [PATCH v2 2/2] ALSA: set no sound proc fs for reduced memory
 footprint
Date: Wed, 27 May 2015 08:35:44 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90553B006@SHSMSX101.ccr.corp.intel.com>
References: <1432646037-23803-1-git-send-email-yang.jie@intel.com>
	<1432646037-23803-3-git-send-email-yang.jie@intel.com>
	<20150527044955.GB3096@sudip-PC>
	<E7B1D079BA13FB44A978CC8F69C7D6A90553AED2@SHSMSX101.ccr.corp.intel.com>
	<s5hd21mee6g.wl-tiwai@suse.de>
	<E7B1D079BA13FB44A978CC8F69C7D6A90553AF54@SHSMSX101.ccr.corp.intel.com>
	<s5h4mmyeb7i.wl-tiwai@suse.de>
	<E7B1D079BA13FB44A978CC8F69C7D6A90553AF9C@SHSMSX101.ccr.corp.intel.com>
 <s5hzj4qcvjw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hzj4qcvjw.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Zhang, Vivian" <vivian.zhang@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, May 27, 2015 3:46 PM
> To: Jie, Yang
> Cc: Sudip Mukherjee; broonie@kernel.org; alsa-devel@alsa-project.org;
> linux-kernel@vger.kernel.org; Girdwood, Liam R; Zhang, Vivian
> Subject: Re: [PATCH v2 2/2] ALSA: set no sound proc fs for reduced memory
> footprint
> 
> At Wed, 27 May 2015 07:40:24 +0000,
> Jie, Yang wrote:
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Wednesday, May 27, 2015 3:23 PM
> > > To: Jie, Yang
> > > Cc: Sudip Mukherjee; broonie@kernel.org;
> > > alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; Girdwood,
> > > Liam R; Zhang, Vivian
> > > Subject: Re: [PATCH v2 2/2] ALSA: set no sound proc fs for reduced
> > > memory footprint
> > >
> > > At Wed, 27 May 2015 07:09:24 +0000,
> > > Jie, Yang wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > Sent: Wednesday, May 27, 2015 2:19 PM
> > > > > To: Jie, Yang
> > > > > Cc: Sudip Mukherjee; broonie@kernel.org;
> > > > > alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org;
> > > > > Girdwood, Liam R; Zhang, Vivian
> > > > > Subject: Re: [PATCH v2 2/2] ALSA: set no sound proc fs for
> > > > > reduced memory footprint
> > > > >
> > > > > At Wed, 27 May 2015 05:38:01 +0000, Jie, Yang wrote:
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Sudip Mukherjee [mailto:sudipm.mukherjee@gmail.com]
> > > > > > > Sent: Wednesday, May 27, 2015 12:50 PM
> > > > > > > To: Jie, Yang
> > > > > > > Cc: tiwai@suse.de; broonie@kernel.org;
> > > > > > > alsa-devel@alsa-project.org;
> > > > > > > linux- kernel@vger.kernel.org; Girdwood, Liam R; Zhang,
> > > > > > > Vivian
> > > > > > > Subject: Re: [PATCH v2 2/2] ALSA: set no sound proc fs for
> > > > > > > reduced memory footprint
> > > > > > >
> > > > > > > On Tue, May 26, 2015 at 09:13:57PM +0800, Jie Yang wrote:
> > > > > > > > Disable sound proc fs, when CONFIG_SND_NO_PROC_FS is
> > > selected,
> > > > > > > > which can save about 9KB memory size for reducing memory
> > > > > > > > footprint
> > > > > purpose.
> > > > > > > > ---
> > > > > > > missing Signed-off-by.
> > > > > >
> > > > > > Thanks for pointing out.
> > > > > >
> > > > > > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > > > > >
> > > > > > Takashi, do I need to resend them?
> > > > >
> > > > > Yes, but you seen to have missed my first comment.  Here again:
> > > >
> > > > Sorry about the missing. :)
> > > >
> > > > >
> > > > >
> > >
> ==========================================================
> > > > > ======
> > > > > > +menuconfig SND_REDUCED_MEMORY_FOOTPRINT
> > > > > > +	bool "Reduced Memory Footprint Support"
> > > > > > +	default n
> > > > > > +	help
> > > > > > +	  Say 'Y' to enable Reduced Memory Footprint Support, which
> may
> > > > > > +	  reduce code size and data footprint as much as possible.
> > > > >
> > > > > I'd like to move this into sound/core.
> > > > > Also, the kconfig name appears a bit too lengthy to me.
> > > > >
> > >
> ==========================================================
> > > > > ======
> > > > >
> > > > > And, after reading this again, I wonder whether we just take the
> > > > > existing CONFIG_EXPERT for allowing the selection of more knobs
> > > > > like CONFIG_SND_PROC_FS.
> > > > >
> > > > > SND_PROC_FS
> > > > > 	bool "Sound proc file" if EXPERT
> > > >
> > > > Sounds good. Then we don't need
> 'SND_REDUCED_MEMORY_FOOTPRINT'
> > > > any more? Or we can keep it as root menu of the set of items, just
> > > > as
> > > below?
> > > > (I changed it to SND_SMALL_FOOTPRINT, as your comment above)
> > >
> > > I originally thought to select items from SND_SMALL_FOOTPRINT, but
> > > this doesn't seem to work.  At least, "de"selecting isn't supported by
> Kconfig (i.e.
> > > set SND_PROC_FS=n when SND_SMALL_FOOTPRINT=y).
> > > We may have SND_NO_PROC_FS and select it, but it's too bad.
> > >
> > > So, IMO, we can drop SND_SMALL_FOOTPRINT but let users choose each
> > > knob when EXPERT=y.
> >
> > Firstly, I used sound/Kconfig but not sound/core/Kconfig, because some
> > efforts for reducing footprint are based on sound/asoc/(e.g. dapm,
> > dpcm, ...).
> 
> sound/core/Kconfig defines the core sound components and configurations,
> so it's more appropriate.
 
OK.

> 
> > Secondly, if we drop SND_SMALL_FOOTPRINT, then we have to add
> > several(may up to ~10) knobs under the sound menu(Sound Card Support),
> > which looks messy and not neat.
> 
> The question is whether we want more selectable knobs.  If you got for
> simplicity, SND_PROC_FS shouldn't be selectable either, but just give
> SND_SMALL_FOOTPRINT selectable.
 
OK, then I will drop this SND_SMALL_FOOTPRINT and keep SND_PROC_FS,
and resend soon.

~Keyon

> 
> 
> Takashi
