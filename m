From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: problems ALSA on iBook2
Date: Thu, 27 Jun 2002 11:37:45 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206271837.LAA10678@cmn29.stanford.edu>
References: <1025146642.3236.16.camel@localhost.localdomain>
	<s5hbs9x59y8.wl@alsa2.suse.de>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbs9x59y8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alexander Carot <Alexander_Carot@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > The whole installation went pretty fine without any trouble, the module
> > is installed and loaded and we finally set up the mixer but there's no
> > sound (neither speakers nor headphone).
> >
> > Chipset : Tumbler
> > OS      : YellowDog 2.2 (Rome)
> > PPC     : iBook2 600MHz
> >
> > For us everything looks like a bug. Does anyone have any experiences
> > with ALSA on iBook ?
>
> there was a change about daca and tumbler since rc1 to use the
> kernel's standard i2c interface instead of alsa's own one.
>
> you might try the older code if you need it urgently.
> the change was committed at June 11, so you can check out the cvs with
> the date option June 10, i.e.
>
> % cd alsa-kernel/ppc
> % cvs co -D20020610

We'll try this latter (hopefully today). To expand on the
description of the problem, everything seems to work fine
except there is no sound output from either the speaker or
heaphones (for example: automute works, pluging in a heaphone
mutes the speaker in alsamixer, applications "play" for the
expected time and so on and so forth). The standard oss free
driver that comes with the yellow dog 2.2 kernel (2.4.18
something) works fine.

> i'll check this problem later.

Thanks!
-- Fernando


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
