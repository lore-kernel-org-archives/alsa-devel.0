From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Bug in serial-u16550.c
Date: Mon, 7 Mar 2005 14:35:27 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503071421520.27740-100000@studcom.urz.uni-halle.de>
References: <opsm9kjq1un0kn27@linux.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <opsm9kjq1un0kn27@linux.site>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bill Adair <adair@gotadsl.co.uk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Bill Adair wrote:
> The only flag ever tested in the driver is SERIAL_MODE_INPUT_OPEN,
> the others are just set.

The other flags are checked when the driver compares against
SERIAL_MODE_NOT_OPEN, i.e., it checks that none of these flags is set.

> > However, it filemode is the only variable that is protected, it might
> > be possible to change it to use atomic bit operations.
>
> Have you a sample of code for this?

msnd_midi.c and mpu401_uart.c do something like this.

> >> Can anyone describe the function of the up parameter passed to
> >> snd_uart16550_input_trigger ()?
> >
> > It enables/disables input from the port.
>
> This is interesting - can the sequencer code in alsa tell the
> driver not to accept further input?

Yes.  (Well, no -- it's the rawmidi code, but that could be called by
the sequencer code. :-)

> There is no support in this driver for this if that is the case.

snd_uart16550_input_trigger clears the SERIAL_MODE_INPUT_TRIGGERED
bit, which is checked ...

Oops.  Which should be checked by the io_loop.


Oh, just BTW:  I fixed the deadlock by moving the event call into a
tasklet.  The change should be on the public CVS server shortly.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
