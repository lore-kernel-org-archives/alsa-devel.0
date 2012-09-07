From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA release cycle
Date: Fri, 07 Sep 2012 14:53:30 +0200
Message-ID: <5049EE4A.4090704@perex.cz>
References: <5049DCA4.6000607@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id AD6ED2616B5
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 14:53:30 +0200 (CEST)
In-Reply-To: <5049DCA4.6000607@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 7.9.2012 13:38, David Henningsson wrote:
> Hi,
> 
> At Plumber's we discussed the ALSA release cycle. Our releases recently 
> have been irregular, and the reasoning behind why a release was done at 
> that time, has not been very obvious.

It is not. I depends mostly on my free time to do so.

> IIRC, we kind of leaned towards releasing every six months. I don't 
> remember if there was any consensus about whether to try to align this 
> cycle to something else (e g Gnome, KDE, Fedora, Ubuntu, etc), or not.

I would prefer to keep the releases on demand. If you look to the 25->26
user space changes, there are just few of them. Now, when the API will
be enhanced, I will do more releases.

For the driver stuff, we can talk what's best to do. The correlation
with the kernel releases are mostly only by the release date, but the
driver repositories contains the latest code (which is more related to
the linux-next tree than the stable linux trees). The alsa-lib tries to
be compatible with all previous code using the kernel<->user space API
versioning, so there is no potential problem in this area.

Because the most of changes are in the drivers now, I'm thinking to do
more driver releases (probably using the fourth version number) between
the standard releases of all packages. But I'm not sure if it's worth to
do these releases, because the tar-balls with the actual code for all
packages are available immediately
(http://www.alsa-project.org/snapshot/). Users have a way to get the
latest code. I see only issues with the kernel interface changes - it
may make the driver code non-compilable on older kernels. Actually, I'm
trying to create a self-testing framework which will be triggered after
each repo commit and it will notify developers to the alsa-devel list
that the alsa-driver repository is broken for some kernels.

> We also said that we should discuss this on the mailinglist as the ALSA 
> release manager (Jaroslav Kysela) was not present during Plumber's. So 
> this effectively is a mail to kick off that discussion. Any opinions?
> 
> Also, as a side note (or perhaps proof of the problem!), it seems ALSA 
> 1.0.26 was just released without even a notification on this mailinglist...?

I'm sorry, I was testing the packages in the Fedora build system. I
found some issues with the alsa-tools package (missing header files for
hdajackretast in the tar-ball) yesterday and I was able to finish my
tests today. I postponed the e-mail notification for this reason.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
