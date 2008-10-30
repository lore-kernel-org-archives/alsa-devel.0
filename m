From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: Re: Ubuntu - Alsa Installation Script
Date: Thu, 30 Oct 2008 17:25:29 +0100
Message-ID: <d9690f190810300925v5f2480e9vc7342a343c4290b1@mail.gmail.com>
References: <d9690f190810300103x31492740r9aa31830ea233f36@mail.gmail.com>
	<200810310200.00960.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.154])
	by alsa0.perex.cz (Postfix) with ESMTP id E8C4B2449A
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 17:25:30 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so427715yxh.2
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 09:25:29 -0700 (PDT)
In-Reply-To: <200810310200.00960.wishie@wishie.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Travis Place <wishie@wishie.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have some issues I am thinking of to improve the script - perhaps somebody
can get me directions:

1. To avoid inconsistencies in the system I first run configure and make
    on the packages.
    If one of these fails the script exits out and the system stays as it
is,
    because I run all make install in one function at the end.
    There seems to be one problem. If Alsa-revisions differ heavily.
    utils won't compile.
    The alsa-lib needs to be installed, prior to compilation of the utils -
otherwise
    utils compilation won't succeed.
    Is there a way around this?
2. If I got two or more  kernels on the system I don't know how to install
Alsa manually on both of them
3. It seems that I have to install the (older) alsalib-dev package prior to
running the script from Ubuntu repositories to get
    the environment properly settled. Can I avoid this?

THX


On Thu, Oct 30, 2008 at 5:00 PM, Travis Place <wishie@wishie.net> wrote:

> On Thursday 30 October 2008 6:03:55 pm Klaus Schulz wrote:
> > Hi folks.
> >
> > I prepared an unofficial Alsa-Installation (now 1.0.18) script for the
> > Ubuntu Community.
> > The intention is mainly to be up2date on the drivers, since this - the
> lack
> > or limited functionality
> > of drivers (I am aware of the reasons behind it) is IMO still one of the
> > biggest
> > weaknesses within Linux. Therefore it is IMO crucial to have the latest
> > driver available.
> > As you know most of the distributions make things worse since these are
> > usually one major release behind.
> >
> > http://ubuntuforums.org/showthread.php?t=962695
> >
> I will check this out, and see if i can make any suggestions.. also, you
> could
> specify a seperate dir to hold the NEW modules, and update the depmod
> search
> path (this is how i frequently tell ubuntu users to install alsa, from
> source).
>
> > For standard installations the script seems to work fine.
>
> We should be able to do a few tests, to determine things, and handle them
> differently etc.. If you've ever looked at the alsa-info.sh script, you'll
> know what i mean.. When originally writing that script, i wanted to take
> into
> account what 'interface' (if any) to use to display the output.. what
> information to collect (ac97/hda-intel) etc..
>
> > Quite some people have been/are using it.
> > And of course responding to it - mainly about problems on specific sound
> > cards.
> >
> > I am wondering if things can be improved in the script. I would
> appreciate
> > if
> > somebody of the designers around here could have a quick look at it.
>
> Im certainly no real expert, but it sounds like it would be a handy script,
> so
> worth a look into.
>
> >
> > I am not so deep into Alsa that I can cover severe problems brought up
> over
> > there. How would you recommend to handle this?
> >
> > THX.
> >
> > Cheers
> > Klaus
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> Thanks,
> Travis Place (wishie)
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
