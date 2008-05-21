From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: HG -> GIT migration
Date: Wed, 21 May 2008 12:02:29 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805211155130.3081@woody.linux-foundation.org>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
	<200805211430.06653.linux@audioscience.com>
	<Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz>
	<s5hve18vtml.wl%tiwai@suse.de> <483415E7.5080402@keyaccess.nl>
	<s5hfxsbx27f.wl%tiwai@suse.de>
	<48341DF5.4090307@keyaccess.nl> <s5habijww7r.wl%tiwai@suse.de>
	<48344271.3090700@keyaccess.nl> <s5hy763ve5n.wl%tiwai@suse.de>
	<alpine.LFD.1.10.0805210908460.3081@woody.linux-foundation.org>
	<s5htzgrvbvo.wl%tiwai@suse.de>
	<alpine.LFD.1.10.0805211003170.3081@woody.linux-foundation.org>
	<s5hfxsbo5nv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	by alsa0.perex.cz (Postfix) with ESMTP id B7CC624489
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 21:03:04 +0200 (CEST)
In-Reply-To: <s5hfxsbo5nv.wl%tiwai@suse.de>
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
Cc: Rene Herman <rene.herman@keyaccess.nl>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On Wed, 21 May 2008, Takashi Iwai wrote:
> 
> >  - cherry-pick it. Is it a small, simple patch that you want, but that 
> >    isn't really worth pulling in all the other stuff that you simply don't 
> >    know?
> > 
> >    This isn't wrong. It shouldn't be *common*, but it's not wrong to have 
> >    the same patch in two different branches. It makes sense if it is 
> >    something you really want, but it's still not important or complex 
> >    enough to actually mege everything else!
> 
> Hm, that's what I didn't consider seriously.  I thought cherry-picking
> patches may cause merge errors easily.

Cherry-picking can certainly cause merge errors, but not generally very 
often.

Cherry-picking by definition will obviously apply the *same* patch to two 
different branches, and as a result, when you merge, that merge will 
generally be totally clean. So a trivial merge that succeeds without you 
even noticing is actually the common case.

But you can certainly get merge failures where you then have to fix things 
up if there were *other* changes to that same area. At that point, you end 
up with two different branches that changed the same few lines 
differently, and it doesn't matter if then _some_ of the changes were 
identical - the fact that others were not is enough to cause a merge 
conflict.

If cherry-picking is an uncommon situation, the merge problems are not 
going to show up (and when they do, they'll generally be simple to 
resolve, especially if you limit cherry-picking to simple fixes). But if 
you do a *lot* of cherry-picking, and you cherry-pick big changes, then 
yes, you'll start hitting merge problems.

So cherry-picking is fine if you do it (a) fairly seldom and (b) just to 
small patches, because then the upsides of cherry-picking (easy to get a 
single fix without merging everything else) are bigger than the downsides 
(the potential merge problems later).

IOW, think of cherry-picking as just another tool. It has upsides and 
downsides. It's not "wrong" per se, but you can use it the wrong way. You 
shouldn't use a hammer on a screw, and you shouldn't use cherry-picking 
for big and complex stuff.

			Linus
