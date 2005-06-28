From: david-b@pacbell.net
Subject: Re: [alsa-devel] Fw: BUG: Kernel panic when
 disconnecting Edirol USB2 audio interface
Date: Mon, 27 Jun 2005 19:03:44 -0700
Message-ID: <20050628020344.C5075C8944@blackbox.site>
References: <Pine.HPX.4.33n.0506271650140.7308-100000@studcom.urz.uni-halle.de>
 <42C07072.1050105@axicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <42C07072.1050105@axicon.com>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: colinf@axicon.com, clemens@ladisch.de
Cc: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> With kernel 2.6.12 + "[PATCH] ehci-hcd - fix page pointer allocation in 
> itd_patch()"), using jackd in realtime mode at 44.1kHz with 64 
> frames/period and 4 periods/buffer, I get a stream of xruns of about 
> 0.020 ms, several per second.

In USB, one frame == 1 msec.  Most EHCI silicon using the 2.6.12 code
will get unhappy with 256 msec per ISO URB, so I hope you're using
"frame" without a necessary adjective ... ;)


> Using the same kernel and jackd settings, but with the sound/ and 
> include/sound directories from ALSA CVS of about 7:30 this evening, it 
> seems to work fine, at least for a couple of minutes of stereo playback.
>
> At 128 frames/period, both kernels have a crackling background noise: I 
> haven't experimented with any other settings yet.

I discourage drivers from using more than 64 msec per ISO URB.

Thanks for the status info ... it's seeming that ISO-OUT through
EHCI is probably usable now.  ISO-IN is a different story.  :)

- Dave



This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error please notify the system manager. This message contains confidential information and is intended only for the individual named. If you are not the named addressee you should not disseminate, distribute or copy this e-mail.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
