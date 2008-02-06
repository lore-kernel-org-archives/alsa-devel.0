From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HG branches
Date: Wed, 6 Feb 2008 15:04:12 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0802061437190.8113@tm8103.perex-int.cz>
References: <s5hwspjzbt0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 9340724449
	for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2008 15:04:13 +0100 (CET)
In-Reply-To: <s5hwspjzbt0.wl%tiwai@suse.de>
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

On Tue, 5 Feb 2008, Takashi Iwai wrote:

> Hi,
> 
> how about creating branches for HG trees for some stable trees?  This
> will make the maintenance much easier.

I agree.

> What I have in my mind are branches for:
> 
> - Kernel stable tree (2.6.xx.y)
> - Kernel head tree for push
> - ALSA stable releases
> 
> We'd need to define a naming rule if we have branches.  So far, v*.*.*
> tag is used for ALSA versions, and it can be used for the branch, too.
> But having the same name between the tag and the branch may be
> confusing.  We can name the branch as "v1.0.16.x" or "v1.0.16-branch",
> for example.

I would like to add word branch to all branches. Just for sure.

> Also, for the kernel version to track, we'd need a different prefix,
> too, such as "kernel-2.6.25".

Or "kernel-2.6.25-branch".

> The workflow with branches is pretty simple.
> 
> 	% hg branch
> 	default
> 	% hg up -rv1.0.16
> 	% hg branch v1.0.16-branch
> 	% some patch work
> 	% hg commit
> 	% hg branches
> 	v1.0.16-branch	5828:71ddf13b7a2e
> 	default		5829:950e43bff743
> 
> The resultant multiple heads can be pushed via "push -f".

You can also change back to default (main) branch with:

	hg up -C default

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
