From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: asihpi - how much further?
Date: Sat, 23 Feb 2008 10:10:59 +1300
Message-ID: <200802231010.59448.linux@audioscience.com>
References: <200802221226.59326.linux@audioscience.com>
	<s5hskzkykuh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FC7924542
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 22:07:28 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JWN00H0WS0BG830@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Sat, 23 Feb 2008 10:07:25 +1300 (NZDT)
In-reply-to: <s5hskzkykuh.wl%tiwai@suse.de>
Content-disposition: inline
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
Cc: greg@kroah.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Takashi,

is that the light at the end of the tunnel, or a train coming towards me ;)

On Saturday 23 February 2008 06:14:30 Takashi Iwai wrote:
> At Fri, 22 Feb 2008 12:26:59 +1300,
>
> Eliot Blennerhassett wrote:
> > Hi Takashi,
> >
> > My boss has started asking how long is it going to take to get our driver
> > into mainline.  I.e. a list of things we need to do, that when all those
> > items have been dealt with, then the driver is accepted.
> > Is it possible to make such a list?
>
> I think the all coding style issues have been already listed in out
> previous mails, even about pretty picky ones.  

OK. I shall carry on chipping at the rock...


> What I personally still 
> don't think good is the infrastructure of the driver - the separate
> mangament of asihpi and hpimod.  This makes it hard to understand the
> code flow.  But, if it's your inevitable requirement, we can keep this
> as is.  

The 'inevitable' requirement is that HPI ioctl remains. (at least as an 
option, perhaps disabled by default, enabled by module option).


I'm open to merging all or part hpimod code into (alsa) asihpi.c, and 
restructuring so that the asihpi.c code is 'master'.

You also mentioned handling the ioctl via alsa hwdep.   I'm interested in 
hearing more about this.  Can it be made so that applications using HPI_IOCTL 
and using /dev/asihpi still work?  I just don't know enough about how to 
start on hwdep implementation.

> So, try to clean up the code as much as you can do now, and 
> then let's check and move to alsa-kernel tree.

OK.  As you saw, I'm working on replacing the volatile with memory barriers, 
which is the remaining major style issue that checkpatch complains about.
(There are some other complaints about macros without parentheses, but I think 
these are spurious)

> My remaining concern is the further maintenance.  If I understand
> correctly, you would like to maintain your driver code from the common
> code-base among difference OSes and convert to the linux native one
> via a script.  

This is how the patches I send to you are currently generated: I put our 
generated files into Hg sandbox, then Hg diff.  At this point I backport 
changes in Hg that came from outside.  (E.g. the various changes that Clemens 
has made - thanks) Then regenerate the files, make a patch.

I live in hope that the patches will get smaller over time ;)

> This would be difficult to pick up the upstream 
> changes.  But, again, it's your choice.  I'd just need to be careful
> about the further merge from you in order not to break the upstream
> changes...

The alternative (completely separate codebases) means that "mythical somebody" 
has to track AudioScience source releases, figure out how translate changes 
into ALSA codebase, and do it.

> > P.S. Heres a quote that I feel has some relevance:
>
> Well, the merge is easy but the maintenance is not... :)

I guess we just differ on whether any other way of doing things will make the 
maintenance any easier...


regards

-- 
--
Eliot Blennerhassett
www.audioscience.com
