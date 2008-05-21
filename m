From: david@lang.hm
Subject: Re: [alsa-devel] HG -> GIT migration
Date: Wed, 21 May 2008 11:25:25 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0805211121170.6420@asgard.lang.hm>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz> <200805211430.06653.linux@audioscience.com> <Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz> <s5hve18vtml.wl%tiwai@suse.de> <483415E7.5080402@keyaccess.nl> <s5hfxsbx27f.wl%tiwai@suse.de>
 <48341DF5.4090307@keyaccess.nl> <s5habijww7r.wl%tiwai@suse.de> <48344271.3090700@keyaccess.nl> <s5hy763ve5n.wl%tiwai@suse.de> <alpine.LFD.1.10.0805210908460.3081@woody.linux-foundation.org> <s5htzgrvbvo.wl%tiwai@suse.de> <alpine.LFD.1.10.0805211003170.3081@woody.linux-foundation.org>
 <alpine.LFD.1.10.0805211043590.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936775AbYEUSTj@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0805211043590.3081@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 May 2008, Linus Torvalds wrote:

> [ The corrollary to this all is that when downstream does a merge, think
>  about what the merge message can say. How would you descibe the merge?
>
>  Can you give a good description of what you merged, and why? That's one
>  thing that merging with releases can give you: you can say "merge with
>  release 'xyz'", and people actually understand the *meaning* of it. Your
>  merge message makes sense - and that implies that the merge itself
>  likely made sense.
>
>  If you cannot explain what and why you merged, you probably shouldn't be
>  merging - that's a good rule of thumb right there! Maybe that rule in
>  itself should already be seen as sufficient ]

one thing that you have missed in your explination in this thread 
(although you have made the point in other threads) is that subsystem 
maintainers have the fear that there are other changes that will interfere 
with their stuff and want to catch it early.

per your instructions in prior threads, what they should do is to have a 
seperate branch on their system that they use as a throw-away branch to 
pull from your tree, and from their tree to spot problems. As they find 
problems they can then address them (cherry pick, or whatever)

so it's not that the ALSA people should only look at your tree at the 
merge points, it's that they shouldn't pollute their tree that they are 
going to publish to you with this checking.

David Lang
