From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Pull request for alsa-plugins
Date: Thu, 4 Sep 2008 16:03:39 +0200
Message-ID: <20080904140339.GC31516@tango.0pointer.de>
References: <20080903191741.GA13536@tango.0pointer.de>
	<s5h63pcnygu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C56110380B
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 16:03:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h63pcnygu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 04.09.08 09:48, Takashi Iwai (tiwai@suse.de) wrote:

> > please pull and merge a series of 26 patches for alsa-plugins'
> > PulseAudio driver which I prepared in this repository of mine:
> > 
> >     git://git.0pointer.de/alsa-plugins.git
> 
> Thanks, pulled in, pushed out now.
> 
> At the next time, could you add our sign-off to each commit?
> I don't care much about it for non-kernel codes, but certainly better
> with it.

Sure, will do.

> Also, please add the branch name in the same line of git://... above.
> The recent git requires the branch name explicitly to pull.

Will do.

> One of my concerns in the current pulse code is the many use of
> assert().  In many cases, assert() is a wrong choice.  For example,
> checking the return value of malloc in assert() is definitely wrong.
> It should be always checked, and should return an error instead of
> aborting the program.

I think I fixed every single assert() on malloc, OOM should now be
handled in similar way to most other code in in
alsa-lib/-plugins. 

Still, there are quite a few asserts left in the pulse driver which
check validity of function parameters. But they should only be hit on
internal programming errors and as such I think it makes a lot of
sense to leave them in.

> > Those patches only touch the pulse/ subdir. 
> > 
> > The tree is freshly rebased against current alsa-plugins master.
> > 
> > May I ask you to make me the "semi-official" maintainer of this
> > driver? I.e. I'd like to be consulted (as in 'Signed-Off-by') before
> > any patches for it are merged?
> 
> Well, the patches can go in by any ALSA developers, so it can't be
> forced *always* through you.  But, I'll mail you pulse-related patches
> before reviewing and merging.

Thanks a lot!

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
