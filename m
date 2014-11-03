From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [Question about DPCM] dpcm_run_new_update races
	again xrun
Date: Mon, 03 Nov 2014 17:16:09 +0000
Message-ID: <1415034969.2471.22.camel@loki>
References: <B2A7C617B3AB7F44B7B44C7D374B431E38E5070E70@sc-vexch3.marvell.com>
 <1415021524.2471.16.camel@loki> <s5htx2g1h2v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E2A4D260578
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 18:21:03 +0100 (CET)
In-Reply-To: <s5htx2g1h2v.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wilbur Wang <wwang27@marvell.com>, Qiao Zhou <zhouqiao@marvell.com>, Mark Brown <broonie@kernel.org>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-11-03 at 15:42 +0100, Takashi Iwai wrote:
> At Mon, 03 Nov 2014 13:32:04 +0000,
> Liam Girdwood wrote:
> > 
> > On Mon, 2014-11-03 at 03:28 -0800, Qiao Zhou wrote:
> > > Hi Mark, Liam
> > > 
> > > I met one BE not-function issue when developing DPCM feature, and found
> > > dpcm_run_new_update is not protected well against xrun(interrupt context).
> > > Could you help to give some suggestions?
> > > 
> > 
> > I'm wondering if this would be better solved by improving the locking so
> > that an XRUN could not run at the same time as the runtime update. Both
> > functions are async, but are only protected by a mutex atm (like the
> > rest of PCM ops except trigger which is atomic). We maybe need to add a
> > spinlock to both runtime_update() and dpcm_fe_dai_trigger() 
> 
> Be careful, you cannot take spinlock while hw_params, for example.
> 
> Why do you need to set runtime_update to NO in the trigger callback in
> the first place?  The trigger may influence on the FE streaming state,
> but not on the FE/BE connection state, right?
> 

The XRUN trigger will propagate to the BE atm, but the BE DSP DAIs
should never really XRUN (since the DSP does the IO) meaning the XRUN
will have no influence on the BE.

I guess we could ignore the XRUN on the BE if that's what you are
meaning ?

Liam
> 
> Takashi


---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
