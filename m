From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [alsa-devel] HG -> GIT migration
Date: Wed, 21 May 2008 09:16:05 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805210908460.3081@woody.linux-foundation.org>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz> <200805211430.06653.linux@audioscience.com> <Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz> <s5hve18vtml.wl%tiwai@suse.de> <483415E7.5080402@keyaccess.nl> <s5hfxsbx27f.wl%tiwai@suse.de>
 <48341DF5.4090307@keyaccess.nl> <s5habijww7r.wl%tiwai@suse.de> <48344271.3090700@keyaccess.nl> <s5hy763ve5n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934898AbYEUQRB@vger.kernel.org>
In-Reply-To: <s5hy763ve5n.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Rene Herman <rene.herman@keyaccess.nl>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On Wed, 21 May 2008, Takashi Iwai wrote:
> 
> But, this means that the fixes done outside the subsystem tree cannot
> be in the subsystem tree itself until the next release.  It's a pretty
> weird situation.

No it is NOT.

Why should you have stuff from outside the subsystem tree?

And quite frankly, the only reason to *need* those fixes in the first 
place is if you merge random test-kernels during the merge window. What 
you should strive for is to merge at the stable point, not random kernels 
to keep you "up-to-date", and suddenly you don't need to make more merges 
just to get (possibly) new fixes.

See?

If it's the ALSA tree, then what is it doing pulling all the random other 
stuff that I merge?

In other words - merging my random stuff, THAT is the "weird situation". 
You should be doing ALSA development, not "random kernel" development.

> The method Linus suggested is suitable for random patches like tirival
> tree, but apparently not for every case.

Umm. Bigger subsystems than ALSA are successfully using it and have no 
problems, and don't think they need to merge backwards:

	[torvalds@woody linux]$ git rev-list v2.6.25.. drivers/net/ | wc -l
	739
	[torvalds@woody linux]$ git rev-list v2.6.25.. sound/ | wc -l
	291

iow, the only reason you seem to think that you need to merge more is that 
you merged too much, or from a too-unstable base, to begin with.

Aim for basing things on releases, or at least for merging just at stable 
points (and only when you *need* to, and it will make your life much 
easier. And the history will automatically be cleaner and less confusing.

			Linus
