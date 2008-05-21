From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HG -> GIT migration
Date: Wed, 21 May 2008 10:07:46 -0700
Message-ID: <1211389666.8312.127.camel@razman>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
	<200805211430.06653.linux@audioscience.com>
	<Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz>
	<s5hve18vtml.wl%tiwai@suse.de> <483415E7.5080402@keyaccess.nl>
	<s5hfxsbx27f.wl%tiwai@suse.de> <48341DF5.4090307@keyaccess.nl>
	<s5habijww7r.wl%tiwai@suse.de> <48344271.3090700@keyaccess.nl>
	<s5hy763ve5n.wl%tiwai@suse.de>
	<alpine.LFD.1.10.0805210908460.3081@woody.linux-foundation.org>
	<s5htzgrvbvo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id C318B243DA
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 19:07:49 +0200 (CEST)
In-Reply-To: <s5htzgrvbvo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Rene Herman <rene.herman@keyaccess.nl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I updated the Developers Zone wiki to reflect the new source repository,
making it a little easier to find.

Question:  How do we get rss feeds?  Is it similar to the HG method?  I
like being able to monitor the updates via rss, to determine when I need
to refresh my tree, as I only really work on the hda-intel stuff at the
moment.

Tobin

On Wed, 2008-05-21 at 18:51 +0200, Takashi Iwai wrote:

> At Wed, 21 May 2008 09:16:05 -0700 (PDT),
> Linus Torvalds wrote:
> > 
> > 
> > 
> > On Wed, 21 May 2008, Takashi Iwai wrote:
> > > 
> > > But, this means that the fixes done outside the subsystem tree cannot
> > > be in the subsystem tree itself until the next release.  It's a pretty
> > > weird situation.
> > 
> > No it is NOT.
> > 
> > Why should you have stuff from outside the subsystem tree?
> 
> Well, what I meant is about the fixes to the subsystem (say, ALSA) by
> people in the outside.  Not every ALSA-bugfix patch goes into the
> upstream from ALSA tree.  You, Andrew and others pick individually
> ALSA-fix patches.  They will be missing in the ALSA subsystem tree.
> 
> And, what if that you need a fix for the fix that isn't in ALSA
> tree...?  IMO, either a rebase or a merge is better than
> cherry-picks.
> 
> > And quite frankly, the only reason to *need* those fixes in the first 
> > place is if you merge random test-kernels during the merge window. What 
> > you should strive for is to merge at the stable point, not random kernels 
> > to keep you "up-to-date", and suddenly you don't need to make more merges 
> > just to get (possibly) new fixes.
> > 
> > See?
> > 
> > If it's the ALSA tree, then what is it doing pulling all the random other 
> > stuff that I merge?
> > 
> > In other words - merging my random stuff, THAT is the "weird situation". 
> > You should be doing ALSA development, not "random kernel" development.
> 
> Hmm, that makes me thinking of the development model.
> We can leave ALSA tree without upstream fixes as is if user always
> pull both ALSA and upstream trees.  This works for users that are
> using the latest development kernel.
> 
> > > The method Linus suggested is suitable for random patches like tirival
> > > tree, but apparently not for every case.
> > 
> > Umm. Bigger subsystems than ALSA are successfully using it and have no 
> > problems, and don't think they need to merge backwards:
> > 
> > 	[torvalds@woody linux]$ git rev-list v2.6.25.. drivers/net/ | wc -l
> > 	739
> > 	[torvalds@woody linux]$ git rev-list v2.6.25.. sound/ | wc -l
> > 	291
> > 
> > iow, the only reason you seem to think that you need to merge more is that 
> > you merged too much, or from a too-unstable base, to begin with.
> > 
> > Aim for basing things on releases, or at least for merging just at stable 
> > points (and only when you *need* to, and it will make your life much 
> > easier. And the history will automatically be cleaner and less confusing.
> 
> Yes, I see the point.
> 
> But, my question is about the divergence between the development and
> for-linus branches: how to apply patches that exist only in for-linus
> tree back.
> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis 


What PROGRAM are they watching?
