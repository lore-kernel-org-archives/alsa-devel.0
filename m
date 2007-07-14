From: stan <stanl@cox.net>
Subject: Re: Install of alsa 1.0.14.final on Fedora 7
Date: Sat, 14 Jul 2007 07:27:01 -0700
Message-ID: <20070714072701.057106a3@localhost.localdomain>
References: <20070713124843.59729a4b@localhost.localdomain>
	<20070714000931.hqd2n4icam20ow8g@webmail.dsl-only.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao105.cox.net (fed1rmmtao105.cox.net [68.230.241.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 83FF210389E
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jul 2007 16:27:03 +0200 (CEST)
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao105.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
	id <20070714142701.FSDC1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>
	for <alsa-devel@alsa-project.org>; Sat, 14 Jul 2007 10:27:01 -0400
In-Reply-To: <20070714000931.hqd2n4icam20ow8g@webmail.dsl-only.net>
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

On Sat, 14 Jul 2007 00:09:31 -0700
tdavis@dsl-only.net wrote:

> Quoting stan <stanl@cox.net>:
> 
> > On Fri, 13 Jul 2007 08:53:47 -0700
> > tdavis@dsl-only.net wrote:
> >
> >> For RPM based systems, I have a build environment for the drivers,
> >> libs, and utils packages at
> >> http://members.dsl-only.net/~tdavis/my-build.tar.bz2.  You need to
> >> be root to build them, but they won't interfere with your rpm
> >> distribution.  THe driver rpm will also make a backup of your
> >> current drivers prior to installation.
> >>
> >> Tobin
> >>
> >
> > Hi Tobin,
> >
> > I unpacked the archive and typed make.  It created 4 RPMs.
> > Two of them installed, alsa-lib and alsa-lib-devel.  When I run a
> > test on the drivers rpm, there are conflicts with the kernel
> > headers already on the box.  And I have no sound now, except in the
> > audio configuration screen which is using the 14.rc3 packages.  The
> > packages are named with rh7 instead of fc7 as well.
> >
> > Do I have to run make install to get everything working, or is the
> > header incompatability in the drivers a show stopper?
> >
> >
> >
> > Thanks.
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> 
> I'll have to look at the rpm build process to see why they are named  
> RH7 instead of FC7.  To install, you should just type "audio_install".
> 
> If there is a conflict, just type "rpm -Uvh <package> --force".
> 
Thanks Tobin.  I was going to upgrade to the latest kernel to see if
the header conflicts would go away.  All of the conflicts seem to be
alsa related (surprise, surprise) so should have only positive effect
on compiles.  I was concerned about a package update for alsa and what
these different files would do.  Should I remove the alsa 14.rc3
packages?

And thank you for your help.
