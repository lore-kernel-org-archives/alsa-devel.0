From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: alsamixer on cvs (works!)
Date: Thu, 12 Sep 2002 15:21:09 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209122221.PAA20818@cmn29.stanford.edu>
References: <Pine.LNX.4.33.0209110931080.607-100000@pnote.perex-int.cz>
	<200209112032.NAA19147@cmn29.stanford.edu>
	<s5helbzpoh6.wl@alsa2.suse.de>
	<200209121800.LAA20487@cmn29.stanford.edu>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200209121800.LAA20487@cmn29.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > > I just tried cvs and I'm getting an unresolved symbol error
> > > on snd.o, pci_alloc_consistent
> >
> > this is likely because of my last change.
> > which kernel are you using?
> > perhaps pci_alloc_consistent() is defined as a macro for some other
> > function in your kernel.
>
> I'm using 2.4.20-pre4 + lowlat + preempt + capabilities + acpi
> (I think that's all)
>
> > anyway, i changed the relevant part on cvs.  please try once to
> > update.
>
> I'll try again...

Compiles fine and seems to be working ok (intel8x0). I don't
know what the situation was before because I did not look at
it, but now there are two ac97 codecs recognized (I guess the
second one corresponds to the modem - I'll have to find time
to test the modem so verify it works). There is no delay in
recognizing them as far as I can tell.

Thanks for the help!
-- Fernando


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
