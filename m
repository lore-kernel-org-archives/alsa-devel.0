From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: problems ALSA on iBook2
Date: Fri, 28 Jun 2002 12:00:29 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206281900.MAA12308@cmn29.stanford.edu>
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

> > we recently tried to install ALSA on an iBook2 with Nando at CCRMA in
> > Stanford university but we have some trouble :
> >
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

We tried this version yesterday with the same results (and it
was the correct one as the i2c-keywest <or something like
that> was no longer needed to load the driver). Everything
seems fine but we get no sound output.

-- Fernando


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
