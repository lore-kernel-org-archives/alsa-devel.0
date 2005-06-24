From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [linux-usb-devel] Fw: BUG: Kernel panic when
 disconnecting Edirol USB2 audio interface
Date: Fri, 24 Jun 2005 12:28:49 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506241154480.11588-100000@studcom.urz.uni-halle.de>
References: <42BBD3E8.5070505@axicon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42BBD3E8.5070505@axicon.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Colin Fletcher <colinf@axicon.com>
Cc: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

Colin Fletcher wrote:
> Clemens Ladisch wrote:
> > In this case, the oops apparently happens when the
> > MIDI URBs are canceled (the MIDI input URBs are active as long as the
> > driver is loaded).  Please try the attached patch; it adds two printk()s
> > around the snd_usbmidi_disconnect() function.  If my theory is correct,
> > the oops should happen immediately after the "killing MIDI URBs..."
> > message.
>
> I don't see the "killing MIDI URBs..." message at all.

OK, the kernel nowadays kills URBs of disconnected devices before it
informs the driver of this.

> > BTW: I never had the opportunity to test my code for the UA-1000.
> > Does playback/capture/MIDI work?
>
> jackd will connect to the UA-1000, at which point the 10 output state
> LEDs on the front light up, and the output meter shows signals when I
> play sound through it, but it's a bit unstable: it will stop working
> after a short while. I haven't investigated any further.

There is a bug in the EHCI driver that will corrupt memory, use this
patch:
http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg35743.html

There seems to be another bug in either the EHCI or the snd-usb-audio
driver; I'm still getting problems with high speed iso transfers.
I'm investigating this.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
