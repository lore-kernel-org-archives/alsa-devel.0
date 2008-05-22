From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alsa-devel] HG -> GIT migration
Date: Thu, 22 May 2008 10:23:00 -0400
Message-ID: <20080522102021.ZZRA012@mailhub.coreip.homeip.net>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz> <200805211430.06653.linux@audioscience.com> <Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz> <s5hve18vtml.wl%tiwai@suse.de> <483415E7.5080402@keyaccess.nl> <s5hfxsbx27f.wl%tiwai@suse.de> <48341DF5.4090307@keyaccess.nl> <s5habijww7r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752833AbYEVOXV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5habijww7r.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Rene Herman <rene.herman@keyaccess.nl>, alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 21, 2008 at 04:47:04PM +0200, Takashi Iwai wrote:
> At Wed, 21 May 2008 15:04:53 +0200,
> Rene Herman wrote:
> > 
> > On 21-05-08 14:37, Takashi Iwai wrote:
> > 
> > > At Wed, 21 May 2008 14:30:31 +0200,
> > > Rene Herman wrote:
> > 
> > >> $ git remote show sound-2.6
> > >> * remote sound-2.6
> > >>    URL: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> > >>    Tracked remote branches
> > >>      master
> > >>
> > >> What's the status of that one now? Should I continue pulling that one or 
> > >> should I switch to the new alsa-kernel GIT repo? I want to pull it into 
> > >> a Linus clone tree...
> > > 
> > > We are working on this right now.  alsa.git is far currently behind my
> > > tree.
> > > 
> > > One problem we hit is about multiple committers and rebase.  If you do
> > > git-rebase, the commiter information is touched although the sign-off
> > > isn't updated.  git-rebase looks apparently designed for the
> > > single-commiter model.
> > 
> > It's "worse" than that; rebasing is designed for a _private_ development 
> > model. git-rebase is a very handy tool for people like myself (people 
> > without a downstream that is) and it basically enables the quilt model 
> > of a stack of patches on top of git but public trees that have people 
> > pulling from them should generally not rebase or everyone who _is_ 
> > pulling finds a different tree each time.
> > 
> > Linus is vehement about this also. There have a few threads about it and 
> > the most recent was:
> > 
> > http://lkml.org/lkml/2008/5/17/190
> > 
> > I'm also not an experienced git user (not other than in my own leafnode 
> > developer mode, certainly) but I expect Linus might not terribly mind 
> > answering a few questions about the model -- ALSA is a significant 
> > subsystem and it switching to GIT might even make for a nice "this is 
> > how you do that as a subsystem" treatise...
> > 
> > (ie, also added linux-kernel)
> 
> Theoretically we can work only using merges.  However, the resultant
> tree will look too complex with lots of merge points at the time of
> the next merge window.  This is also a nightmare for bisecting.  Thus,
> most subsystem trees do rebase before the merge window in practice,
> AFAIK.
> 
> It'd be appreciated if someone can tell me any good workflow to keep a
> good-shaped tree without rebasing...
> 

With input I used to sync with mainline (pull from Linus) once per
release, just before sending a pull request to him. Now I gonna have 3
branches, for-linus and next that I expect to sync only when I need to
resolve conflicts or again in merge window and master for -mm which is
rebased on top of Linus's tree frequently. We'll see how that works.

-- 
Dmitry
