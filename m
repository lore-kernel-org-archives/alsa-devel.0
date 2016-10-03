From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/7] ALSA: core: add .update_appl_ptr
	callback for pcm ops
Date: Mon, 3 Oct 2016 10:06:14 +0530
Message-ID: <20161003043613.GS2467@localhost>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
 <1475239410-16548-3-git-send-email-subhransu.s.prusty@intel.com>
 <s5h8tu934gk.wl-tiwai@suse.de> <20160930172009.GU2467@localhost>
 <s5hintdkzbl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 7410426644C
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 06:27:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hintdkzbl.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, "Babu, Ramesh" <ramesh.babu@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2016 at 08:38:38PM +0200, Takashi Iwai wrote:
> On Fri, 30 Sep 2016 19:20:10 +0200,
> Vinod Koul wrote:
> > 
> > On Fri, Sep 30, 2016 at 03:24:59PM +0200, Takashi Iwai wrote:
> > > On Fri, 30 Sep 2016 14:43:25 +0200,
> > > Subhransu S. Prusty wrote:
> > > > 
> > > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > 
> > > > When appl_ptr is updated let low-level driver know, e.g.  to let the
> > > > low-level driver/hardware pre-fetch data opportunistically.
> > > > 
> > > > The existing .ack callback could be used but it would need to be
> > > > extended with new arguments, resulting in multiple changes in legacy
> > > > code.
> > > 
> > > I wouldn't mind changing these callers.  They aren't so many, after
> > > all. 
> > 
> > Yes this was one of the discussions we had in the past. I don't recall the
> > conclusion so had recommened to keep as is and discuss here.
> > 
> > Do you think it's better to do that or use a new one :)
> 
> It's OK to change ack callback, and actually it'll be cleaner.
> But then it'll be a problem in the next patch, I suppose :)

Yes and one of the reason is that we are using one flag to advertise two
capabilities, one is no rewind and second is appl_ptr update.

We feel we should deal with them by using two flags so that code can be
made cleaner.

Thanks
-- 
~Vinod
