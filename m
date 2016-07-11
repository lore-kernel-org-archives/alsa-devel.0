From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ALSA - hda: Add support for link audio
	time reporting
Date: Mon, 11 Jul 2016 19:41:59 +0530
Message-ID: <20160711141159.GI9681@localhost>
References: <1468232009-14130-1-git-send-email-vinod.koul@intel.com>
 <1468232009-14130-3-git-send-email-vinod.koul@intel.com>
 <s5h60scv520.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E1FAC261615
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 16:04:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h60scv520.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Hardik T Shah <hardik.t.shah@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 11, 2016 at 12:32:07PM +0200, Takashi Iwai wrote:
> On Mon, 11 Jul 2016 12:13:28 +0200,
> Vinod Koul wrote:
> > 
> > From: Guneshwor Singh <guneshwor.o.singh@intel.com>
> > 
> > Skylake onwards HDA controller supports reprting link audio
> > time, so add support for that.
> 
> It's way too few description, the text is almost same as the previous
> patch.  Please give more information.

Sure will add.

> >  #define CREATE_TRACE_POINTS
> >  #include "hda_controller_trace.h"
> >  
> > +#define SEC_TO_NSEC	1000000000LL
> 
> Can we use a definition in time64.h?

Yes NSEC_PER_SEC seems right, will update. Thanks for pointing

> >  
> > +static u64 azx_scale64(u64 base, u32 num, u32 den)
> > +{
> > +	u64 rem;
> > +
> > +	rem = do_div(base, den);
> > +
> > +	base *= num;
> > +	rem *= num;
> > +
> > +	do_div(rem, den);
> > +
> > +	return base + rem;
> > +}
> 
> What is this function supposed to do?

It is supposed to scale the timestamp values. Will try to add more comments
on this one.

> > +		ll_counter = (ll_counter_h << LLPC_CCU_SHIFT) |	ll_counter_l;
> > +		wallclk_cycles = wallclk_ctr & WALFCC_CIF_MASK;
> > +
> > +		if (wallclk_cycles < HDA_MAX_CYCLE_VALUE - HDA_MAX_CYCLE_OFFSET
> > +		    && wallclk_cycles > HDA_MAX_CYCLE_OFFSET)
> > +			break;
> 
> Is this condition really correct...?  It's hard to understand.

Looks so, i will double check

> > +	*device = ktime_add_ns(*device, (wallclk_cycles * SEC_TO_NSEC) /
> > +			       ((HDA_MAX_CYCLE_VALUE+1) * runtime->rate));
> 
> Hmm, the calculation here looks as if there can be an optimization...

Hmmm, let me try to optimize this bit

-- 
~Vinod
