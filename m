From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: HG -> GIT migration
Date: Wed, 21 May 2008 15:04:53 +0200
Message-ID: <48341DF5.4090307@keyaccess.nl>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>	<200805211430.06653.linux@audioscience.com>	<Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz>	<s5hve18vtml.wl%tiwai@suse.de>	<483415E7.5080402@keyaccess.nl>
	<s5hfxsbx27f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 647A22454C
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 15:02:26 +0200 (CEST)
In-Reply-To: <s5hfxsbx27f.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 21-05-08 14:37, Takashi Iwai wrote:

> At Wed, 21 May 2008 14:30:31 +0200,
> Rene Herman wrote:

>> $ git remote show sound-2.6
>> * remote sound-2.6
>>    URL: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>>    Tracked remote branches
>>      master
>>
>> What's the status of that one now? Should I continue pulling that one or 
>> should I switch to the new alsa-kernel GIT repo? I want to pull it into 
>> a Linus clone tree...
> 
> We are working on this right now.  alsa.git is far currently behind my
> tree.
> 
> One problem we hit is about multiple committers and rebase.  If you do
> git-rebase, the commiter information is touched although the sign-off
> isn't updated.  git-rebase looks apparently designed for the
> single-commiter model.

It's "worse" than that; rebasing is designed for a _private_ development 
model. git-rebase is a very handy tool for people like myself (people 
without a downstream that is) and it basically enables the quilt model 
of a stack of patches on top of git but public trees that have people 
pulling from them should generally not rebase or everyone who _is_ 
pulling finds a different tree each time.

Linus is vehement about this also. There have a few threads about it and 
the most recent was:

http://lkml.org/lkml/2008/5/17/190

I'm also not an experienced git user (not other than in my own leafnode 
developer mode, certainly) but I expect Linus might not terribly mind 
answering a few questions about the model -- ALSA is a significant 
subsystem and it switching to GIT might even make for a nice "this is 
how you do that as a subsystem" treatise...

(ie, also added linux-kernel)

Rene.
