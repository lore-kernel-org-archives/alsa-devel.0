From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: echoaudio.c, Revision 1.6
Date: Tue, 15 Mar 2005 22:33:38 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503152151220.22860@denise.shiny.it>
References: <Pine.HPX.4.33n.0503140909500.15356-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.HPX.4.33n.0503140909500.15356-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



On Mon, 14 Mar 2005, Clemens Ladisch wrote:

> Giuliano Pochini wrote:
> > I'm a bit confused about the latest changes to pci/echoaudio/echoaudio.c
> >
> > The CVS interface says: "Use spin_lock_irqsave() instead of spin_lock() in
> > places where we could be interrupted by another hardware interrupt that
> > could call the rawmidi trigger callback that could try to take the same
> > lock."
> >
> > But in snd_echo_interrupt() we are running in hard irq context, so we know
> > irqs are already disabled.
>
> Only the sound card interrupt itself is disabled.  It is architecture-
> specific whether other interrupts are disabled.

Yes, but chip_t->mylock is per device, it's not the same lock even if I
have 2 identical cards. And the driver calls snd_pcm_period_elapsed() and
snd_rawmidi_receive() when the lock is not held. I really can't see why
the irq handler requires _irqsave spinlocks.


> > Then: "Additionally, remove locking code that is no longer needed now that
> > the trigger callback is no longer called recursively from the rawmidi
> > "event" handler."
> >
> > Your patch does not remove anything.
>
> It removed code in some other files.

I diff'd all the files and only echoaudio.c was changed.


--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
