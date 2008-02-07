From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HG vs GIT
Date: Thu, 7 Feb 2008 13:03:18 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0802071256090.8113@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>
	<s5habmdknw0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BA49C245B6
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 13:03:18 +0100 (CET)
In-Reply-To: <s5habmdknw0.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 7 Feb 2008, Takashi Iwai wrote:

> At Thu, 7 Feb 2008 10:37:29 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > Hi,
> > 
> > 	it seems that GIT matured somewhat. git-push has been implemneted. 
> > It was main reason to not use GIT when we made decision between HG and 
> > GIT.
> 
> Hm, I thought it simply because you prefer python...

Yes, it was one reason. But I must also admit, that GIT evolution seems to 
be faster than Marcurial.

> > 	As we could have potential problems with branches in HG 
> > repository, I would like to consider a switch to GIT althought it means 
> > some changes in my scripts on ALSA server and my ksync tool.
> > 	I just successfully tried (a bit modified hg-to-git.py script) and 
> > it seems to be working properly.
> > 	Any objections?
> 
> I don't mind to move to git, but IMHO, it's no urgent issue.
> Let's get things out (e.g. concentrate on 2.6.25 merge) right now, and
> then change the infrastructure in the right way.
> 
> 
> BTW, one big annoying thing is that developers have no complete kernel
> tree to access, and thus the patches that touch outside the ALSA
> subdirectory cannot be merged easily.  People often send patches
> fixing together with OSS, etc, and I had to skip them.  So, frankly,
> I'd love to have an access to the whole kernel tree.  But, OTOH, this
> would make harder for other naive guys to give it a try because they
> need to download the big linux kernel tree git.
> 
> Maybe we can think reversely.  Keep the kernel git tree as the primary
> development tree and generate the subset as the alsa-kernel package
> from the kernel tree automatically.  In this way, you can avoid also 
> sign-off messes, too.
> 
> In this scheme, you don't have to stick with stgit.  The normal git
> can handle patches well enough (via occasional rebase), and it's much
> much faster than stgit.  Of course, stgit is still good for small
> number of patches, but it's not true for shared devel trees.

As GIT matured, I can imagine to drop the alsa-kernel repository and 
manage only one ALSA GIT tree. I only hope, that GIT is the final SCM 
system for Linux :-) (At least for several years.)

Ok, let's wait for 2.6.25 and then try to migrate.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
