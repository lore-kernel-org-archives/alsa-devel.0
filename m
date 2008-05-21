From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-devel] HG -> GIT migration
Date: Wed, 21 May 2008 15:48:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0805211517290.1798@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
 <200805211430.06653.linux@audioscience.com> <Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz>
 <s5hve18vtml.wl%tiwai@suse.de> <483415E7.5080402@keyaccess.nl>
 <s5hfxsbx27f.wl%tiwai@suse.de> <48341DF5.4090307@keyaccess.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935624AbYEUNsr@vger.kernel.org>
In-Reply-To: <48341DF5.4090307@keyaccess.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 May 2008, Rene Herman wrote:

> > > What's the status of that one now? Should I continue pulling that one
> > > or should I switch to the new alsa-kernel GIT repo? I want to pull it
> > > into a Linus clone tree...
> > 
> > We are working on this right now.  alsa.git is far currently behind my
> > tree.
> > 
> > One problem we hit is about multiple committers and rebase.  If you do
> > git-rebase, the commiter information is touched although the sign-off
> > isn't updated.  git-rebase looks apparently designed for the
> > single-commiter model.
> 
> It's "worse" than that; rebasing is designed for a _private_ development 
> model. git-rebase is a very handy tool for people like myself (people 
> without a downstream that is) and it basically enables the quilt model 
> of a stack of patches on top of git but public trees that have people 
> pulling from them should generally not rebase or everyone who _is_ 
> pulling finds a different tree each time.

I don't see big obstacles with this model. You can do changes in your 
local tree and when 'git pull' fails from the subsystem tree, pull new 
subsystem tree to a new branch and do rebasing in your local tree, too.

Rebasing can keep the subsystem tree more clean I think. It's only 
about to settle an appropriate workflow.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
