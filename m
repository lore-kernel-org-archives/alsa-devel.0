From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [RFC PATCH] ALSA: split params refinement to
	seperated file
Date: Mon, 8 Jun 2015 07:35:17 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90553DD1E@SHSMSX101.ccr.corp.intel.com>
References: <1433429265-22054-1-git-send-email-yang.jie@intel.com>
 <20150604191548.GR14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C0339260569
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 09:35:29 +0200 (CEST)
In-Reply-To: <20150604191548.GR14071@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zhang,
 Vivian" <vivian.zhang@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, June 05, 2015 3:16 AM
> To: Jie, Yang
> Cc: tiwai@suse.de; alsa-devel@alsa-project.org; Girdwood, Liam R; Zhang,
> Vivian
> Subject: Re: [RFC PATCH] ALSA: split params refinement to seperated file
> 
> On Thu, Jun 04, 2015 at 10:47:45PM +0800, Jie Yang wrote:
> 
> > The change moves refinement functions from original pcm_native.c and
> > pcm_lib.c, to pcm_refine.c(similarly the declaration from pcm.h to
> > pcm_refine.h), so it is not so big as it looks like.
> 
> I'd suggest that for review it'd be easier to have one patch for the move and
> another for the change in behaviour: it's a bit hard to find the actual change
> in what the kernel does in this diff and that's the bit that needs most careful
> consideration.
> 
> git format-patch -M may also help.
 
Umm, Liam also suggested that, it's really hard for reviewing, but I found that 
"git format-patch -M" doesn't help for partially splitting/moving from a file
to another/new file, I even tried '-M5%', but no luck. :(

I can't find good way to make it better, any suggestion?

~Keyon
