From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] Fw: BUG: Kernel panic when
 disconnecting Edirol USB2 audio interface
Date: Tue, 28 Jun 2005 15:39:41 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506280857430.5280-100000@studcom.urz.uni-halle.de>
References: <20050628020344.C5075C8944@blackbox.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050628020344.C5075C8944@blackbox.site>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: david-b@pacbell.net
Cc: colinf@axicon.com, linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

david-b@pacbell.net wrote:
> > With kernel 2.6.12 + "[PATCH] ehci-hcd - fix page pointer allocation in
> > itd_patch()"), using jackd in realtime mode at 44.1kHz with 64
> > frames/period and 4 periods/buffer, I get a stream of xruns of about
> > 0.020 ms, several per second.
>
> In USB, one frame == 1 msec.  Most EHCI silicon using the 2.6.12 code
> will get unhappy with 256 msec per ISO URB, so I hope you're using
> "frame" without a necessary adjective ... ;)
> ...
> I discourage drivers from using more than 64 msec per ISO URB.

The URBs used by the snd-usb-audio driver are mostly independent of
ALSA's period size, and use between 1 and 20 ms.

> Thanks for the status info ... it's seeming that ISO-OUT through
> EHCI is probably usable now.  ISO-IN is a different story.  :)

Recording on both Edirol UA-1000 and Audigy 2 NX seems to work, and
frequency feedback for the async out endpoints, too.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
