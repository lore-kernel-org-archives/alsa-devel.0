From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/9] ALSA: compress offfload fixes
Date: Tue, 27 Aug 2013 15:39:55 +0530
Message-ID: <20130827100955.GX2748@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <s5heh9fjtrn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D530E265041
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 12:55:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5heh9fjtrn.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 27, 2013 at 12:46:36PM +0200, Takashi Iwai wrote:
> At Tue, 27 Aug 2013 12:10:30 +0530,
> Vinod Koul wrote:
> > 
> > Hi Takashi,
> > 
> > Here is the patch series which fixes various issues being reported by users (out
> > of tree sadly)
> > 
> > The first three and and last one are marked to stable as would like these to be
> > fixed in older kernels as well. It would be good if you can send them as fixes
> > to linus for 3.11.
> 
> Sorry, no go.  If it's only about out-of-tree drivers, it's even
> questionable whether it worth for stable kernel, because we have no
> real test case for our own.
Since lot of embedded folks will be on 3.10 then would have been nicer if it
went to stable. I know users will backport, but if a kernel provided the desired
functionalty then would have been great. 

> > Fixes:
> >  - using lock for all operation was a very bad idead. This is bad as some of the
> >    ioctls like drain, partial drain can be time consuming and thus prevent any
> > other operation while these are ongoing like Pause, Stop or timestamp query, so
> > fix this be removing bunch of ioctls not to use device lock.
> 
> Although not all of them need locks, it's easier to manage in most
> cases to perform in the lock.  For drain or such operation, you can
> simply unlock and re-lock in the call itself, as your patch in the
> series does.a
> 
> >  - Now we dont have lock for pointer updates so this maybe racy, so use lock
> >    for doing lowest level calculation. 
> 
> Similarly, introducing yet another lock would just choke you neck.
Well i thought that pointer updates are orthogonal to other triggers so there is
no issue if we seprate the two. How do you think in long run will this impact..?

> >  - As disscused on our sample rate problem, lets move to use rate values and I
> >    will fix the lib too. Since the driver are not upstream the impact of this
> > change wont be huge.
> 
> I see no code touching sampling_rate field.
Yes its passed directly to the drivers, where tehy use values to prgram
decoders. Only meaning of the field is changing now.

> >  - Plus few fix like use snprintf, state chacks for pause, write etc..
> 
> I don't like to merge irrelevant space changes into a patch if it's a
> fix patch, especially if it's targeted to stable.  The fix is the fix.
> Please separate.
Sure makes sense...

So do you want these to be sent to stable or not. I would prefer to be sent

Thanks
~Vinod
