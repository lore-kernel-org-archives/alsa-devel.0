From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsamixer on cvs (works!)
Date: Fri, 13 Sep 2002 09:57:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209130956340.647-100000@pnote.perex-int.cz>
References: <200209122221.PAA20818@cmn29.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200209122221.PAA20818@cmn29.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Sep 2002, Fernando Pablo Lopez-Lezcano wrote:

> > > > I just tried cvs and I'm getting an unresolved symbol error
> > > > on snd.o, pci_alloc_consistent
> > >
> > > this is likely because of my last change.
> > > which kernel are you using?
> > > perhaps pci_alloc_consistent() is defined as a macro for some other
> > > function in your kernel.
> >
> > I'm using 2.4.20-pre4 + lowlat + preempt + capabilities + acpi
> > (I think that's all)
> >
> > > anyway, i changed the relevant part on cvs.  please try once to
> > > update.
> >
> > I'll try again...
> 
> Compiles fine and seems to be working ok (intel8x0). I don't
> know what the situation was before because I did not look at
> it, but now there are two ac97 codecs recognized (I guess the
> second one corresponds to the modem - I'll have to find time
> to test the modem so verify it works). There is no delay in
> recognizing them as far as I can tell.

Note that modem codecs are only detected. You might send me contents of 
/proc/asound/card0/intel8x0 and ac97* files to verify, if everything is 
ok.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
