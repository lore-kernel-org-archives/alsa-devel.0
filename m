From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: echoaudio.c, Revision 1.6
Date: Sat, 19 Mar 2005 19:31:25 +0100
Message-ID: <20050319193125.72329fad.pochini@shiny.it>
References: <Pine.LNX.4.58.0503152151220.22860@denise.shiny.it>
	<Pine.HPX.4.33n.0503160915080.28424-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.HPX.4.33n.0503160915080.28424-100000@studcom.urz.uni-halle.de>
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
Cc: pochini@denise.shiny.it, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 16 Mar 2005 09:20:49 +0100 (MET)
Clemens Ladisch <clemens@ladisch.de> wrote:

> > Yes, but chip_t->mylock is per device, it's not the same lock even if I
> > have 2 identical cards. And the driver calls snd_pcm_period_elapsed() and
> > snd_rawmidi_receive() when the lock is not held. I really can't see why
> > the irq handler requires _irqsave spinlocks.
>
> When MIDI files are played, some timer interrupt (which can be the
> timer of another sound card) can cause some MIDI data to be written to
> the MIDI port.

Which causes the rawmidi (in my case) callbacks to be called from irq
context, so they must use _irqsave locks. But in the irq handler what's the
difference between

spin_lock()
card_io
spin_unlock()
snd_rawmidi_receive()
return

and

spin_lock_irqsave()
card_io
spin_unlock_irqrestore()
snd_rawmidi_receive()
return

? IMHO they're the same from the viewpoint of snd_rawmidi_receive().


--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
