From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: echoaudio.c, Revision 1.6
Date: Mon, 21 Mar 2005 09:33:43 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503210931220.6471-100000@studcom.urz.uni-halle.de>
References: <20050319193125.72329fad.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20050319193125.72329fad.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini wrote:
> Clemens Ladisch <clemens@ladisch.de> wrote:
> > When MIDI files are played, some timer interrupt (which can be the
> > timer of another sound card) can cause some MIDI data to be written to
> > the MIDI port.
>
> Which causes the rawmidi (in my case) callbacks to be called from irq
> context, so they must use _irqsave locks.

Not anymore, I just moved the callbacks call into tasklet.

> But in the irq handler what's the difference between
>
> spin_lock()
> card_io
> spin_unlock()
> snd_rawmidi_receive()
> return
>
> and
>
> spin_lock_irqsave()
> card_io
> spin_unlock_irqrestore()
> snd_rawmidi_receive()
> return
>
> ? IMHO they're the same from the viewpoint of snd_rawmidi_receive().

Indeed they are.  In the old version, snd_rawmidi_receive() would
recursively call the trigger callback (which could try to take the
same lock), but that call was moved to a tasklet, too.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
