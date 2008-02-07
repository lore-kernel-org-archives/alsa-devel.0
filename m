From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HG branches
Date: Thu, 7 Feb 2008 09:18:04 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0802070916040.8113@tm8103.perex-int.cz>
References: <s5hwspjzbt0.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0802061437190.8113@tm8103.perex-int.cz>
	<Pine.LNX.4.61.0802061505470.8113@tm8103.perex-int.cz>
	<20080207015923.GA14226@ubuntu-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 53846103919
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 09:18:05 +0100 (CET)
In-Reply-To: <20080207015923.GA14226@ubuntu-workstation>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seth Forshee <seth.forshee@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 6 Feb 2008, Seth Forshee wrote:

> On Wed, Feb 06, 2008 at 03:06:44PM +0100, Jaroslav Kysela wrote:
> > BTW: Does anyone know if it's possible to just pick a patch from a HG 
> > branch to another? STG (Stacked GIT) has nice 'stg pick <branch>@<patch>' 
> > command for this.
> 
>   hg update -C dest-branch
>   hg transplant -b source-branch revision
> 
> But I must say that using branches in hg is rather painful.  We tried
> it for a while at my workplace and switched to using cloned repos for
> branches (mostly).  We had several instances of bad things happening
> because of the way hg handled branches, and when those things got
> pushed it was often very difficult to get the repo back to a decent
> state.  In my opinion git handles branches much better than hg does.

Thanks for these notes.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
