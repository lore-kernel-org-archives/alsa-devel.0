From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Bug in serial-u16550.c
Date: Thu, 24 Feb 2005 13:48:24 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502241331070.300-100000@studcom.urz.uni-halle.de>
References: <opsmo54p0sn0kn27@linux.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <opsmo54p0sn0kn27@linux.site>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bill Adair wrote:
> There is a bug in serial-u16550.c that has been causing my PC to lock up
> solid. The three chunks of code
> should explain the nature of it. Basically a lock is taken out on
> interrupt and is still held on calling
> snd_rawmidi_receive (). snd_rawmidi_receive () eventually calls back into
> the driver code at snd_uart16550_input_trigger ()
> where an attempt is made to take out the same lock again. Other pieces of
> code using the same construction avoid
> this problem by unlocking before calling snd_rawmidi_receive () and
> relocking e.g. mtpav.c - though this does
> not seem a good solution ;-).

This depends on what data the lock is supposed to protect.

> Do you want a patch for this? In the Opcode driver I've been writing
> based on this I've checked to see if the kernel is in an interrupt using
> the in_interrupt ()
> call before locking or unlocking in snd_uart16550_input_trigger ().

Not locking could, in theory, lead to problems on SMP machines.

However, it filemode is the only variable that is protected, it might
be possible to change it to use atomic bit operations.

> Can anyone describe the function of the up parameter passed to
> snd_uart16550_input_trigger ()?

It enables/disables input from the port.

> Should I be using this to determine if the call came from an interrupt?

It has nothing to do with in-interruptness.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
