From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: PM issue with Intel SST Atom driver
Date: Mon, 24 Apr 2017 16:32:29 +0530
Message-ID: <20170424110228.GQ6263@localhost>
References: <s5hpog5dgh8.wl-tiwai@suse.de> <20170424050144.GG6263@localhost>
 <s5ho9vmjmyv.wl-tiwai@suse.de> <s5hpog2b2o2.wl-tiwai@suse.de>
 <20170424091213.GO6263@localhost> <s5hh91eb0oc.wl-tiwai@suse.de>
 <20170424095244.GP6263@localhost> <s5hefwib075.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FB0C2669CD
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 13:00:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hefwib075.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 24, 2017 at 11:54:06AM +0200, Takashi Iwai wrote:
> On Mon, 24 Apr 2017 11:52:44 +0200,
> Vinod Koul wrote:
> > 
> > On Mon, Apr 24, 2017 at 11:43:47AM +0200, Takashi Iwai wrote:
> > > On Mon, 24 Apr 2017 11:12:14 +0200,
> > > Vinod Koul wrote:
> > > > 
> > > > On Mon, Apr 24, 2017 at 11:00:45AM +0200, Takashi Iwai wrote:
> > > >  
> > > > > Removing ignore_suspend makes the PM succeeds.  But it hits some other
> > > > > ugly kernel bugs.
> > > > 
> > > > Okay have you marked .nonatomic = true for the machine DAIs?
> > > 
> > > Ah that's it.  The patch below seems fixing the PM and the nonatomic
> > > problems.  I'm not sure about the nonatomic flag for the compress
> > > stream, though.
> > 
> > Well we dont have upstream decoders so it wont be used in this case.
> > 
> > > Also I fiddled only with FE.  Do we need the same flags for BE?  The
> > > others don't look setting like that, so I left so.
> > 
> > I dont remember if BE needs or not FE should suffice.
> 
> OK then I leave it as is.
> 
> When I submit the fix, I should put Cc to stable, and wonder which
> version we assure the nonatomic ops in SST driver.  Did the code base
> support nonatomic ops from the beginning?

4.1 onwards.

The PM was supported thru below commit which went into 4.1.  The nonatomic
was always a requirement for us due to nature of IPC. Non atomic support
went into 3.18 so 4.1 onwards would make sense :)

commit 4a8448d4289d7210053a43f9f21e42929beb159b
Author: Vinod Koul <vinod.koul@intel.com>
Date:   Tue Feb 24 11:39:44 2015 +0530

    ASoC: Intel: add pm support in sst ipc driver

    This adds support for system pm support. We need to save the dsp memory
    which gets lost on suspend and restore that on resume

    Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
    Signed-off-by: Vinod Koul <vinod.koul@intel.com>
    Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks
-- 
~Vinod
