From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: echoaudio.c, Revision 1.6
Date: Wed, 16 Mar 2005 09:20:49 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503160915080.28424-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0503152151220.22860@denise.shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.58.0503152151220.22860@denise.shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini wrote:
>
> On Mon, 14 Mar 2005, Clemens Ladisch wrote:
>
> > Giuliano Pochini wrote:
> >
> > > The CVS interface says: "Use spin_lock_irqsave() instead of spin_lock() in
> > > places where we could be interrupted by another hardware interrupt that
> > > could call the rawmidi trigger callback that could try to take the same
> > > lock."
> > >
> > > But in snd_echo_interrupt() we are running in hard irq context, so we know
> > > irqs are already disabled.
> >
> > Only the sound card interrupt itself is disabled.  It is architecture-
> > specific whether other interrupts are disabled.
>
> Yes, but chip_t->mylock is per device, it's not the same lock even if I
> have 2 identical cards. And the driver calls snd_pcm_period_elapsed() and
> snd_rawmidi_receive() when the lock is not held. I really can't see why
> the irq handler requires _irqsave spinlocks.

When MIDI files are played, some timer interrupt (which can be the
timer of another sound card) can cause some MIDI data to be written to
the MIDI port.

> > It removed code in some other files.
>
> I diff'd all the files and only echoaudio.c was changed.

Revision 1.33 of alsa-kernel/drivers/mpu401/mpu401_uart.c is one of
these changes.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
