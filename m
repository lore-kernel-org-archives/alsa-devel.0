From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [RFC PATCH] ALSA: split params refinement to
	seperated file
Date: Fri, 12 Jun 2015 09:05:58 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90554A080@SHSMSX101.ccr.corp.intel.com>
References: <1433429265-22054-1-git-send-email-yang.jie@intel.com>
 <20150604191548.GR14071@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90553DD1E@SHSMSX101.ccr.corp.intel.com>
 <s5hd216k12q.wl-tiwai@suse.de>	<20150609175711.GR14071@sirena.org.uk>
 <s5hlhfsaf79.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8852F266723
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 11:06:10 +0200 (CEST)
In-Reply-To: <s5hlhfsaf79.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zhang,
 Vivian" <vivian.zhang@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, June 10, 2015 2:51 AM
> To: Mark Brown
> Cc: Jie, Yang; alsa-devel@alsa-project.org; Girdwood, Liam R; Zhang, Vivian
> Subject: Re: [RFC PATCH] ALSA: split params refinement to seperated file
> 
> At Tue, 9 Jun 2015 18:57:11 +0100,
> Mark Brown wrote:
> >
> > On Mon, Jun 08, 2015 at 11:21:17AM +0200, Takashi Iwai wrote:
> >
> > > Just begin with adding ifdefs instead of reshuffling the code.  This
> > > will make easier to understand what you're going to change.  At
> > > least, it's good enough for RFC.  After that, we can refactor the code.
> >
> > Plus if the patches get applied it at least makes it easier for people
> > who do decide to do such major surgery.
> >
> > > Removing the hw constraints refinement is rather a radical change.
> > > It's a part of the PCM core functionality, and removing it means
> > > that the driver has no ways to refuse the incompatible parameters
> > > even if it knows it's broken.  So, IMO, this is the very last
> > > resort.  We can start from ripping off lower hanging fruits.
> >
> > Indeed, part of the reason I was asking about the split was to help me
> > figure out what takes the place of constraints - sounds like nothing?
> > I wonder if we could have cards support this by providing fixed
> > configurations that we could check against using less code or something.
> 
> I think it's possible to reduce the hw refine part.  But, the question is
> whether a kernel driver should trust user-space blindly.  The removal of
> *full* hw constraints means that, and I'm worried by lack of safety.
> 
> > But like you say, we *must* have some other room for improvement.
> 
> Yes, let's see other things we can cut off.  For example, the PCM timer is easy
> to trim.  It's used by dmix, but most apps / backends don't need it at all.  Then
> the whole ALSA timer component can be removed, too.

Thanks for pointing out that, we will investigate cutting off the PCM timer part.

~Keyon
> 
> 
> Takashi
