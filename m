From: Colin Fletcher <colinf@axicon.com>
Subject: Re: [alsa-devel] Fw: BUG: Kernel panic when disconnecting
 Edirol USB2 audio interface
Date: Mon, 27 Jun 2005 22:32:34 +0100
Message-ID: <42C07072.1050105@axicon.com>
References: <Pine.HPX.4.33n.0506271650140.7308-100000@studcom.urz.uni-halle.de>
Reply-To: colinf@axicon.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0506271650140.7308-100000@studcom.urz.uni-halle.de>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, david-b@pacbell.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

> I'd like to know if playback and/or MIDI work.  It may be possible
> that the driver doesn't send playback PCM data at exactly the correct
> rate because the playback stream should have been synchronized to the
> capture stream.

I don't have any MIDI hardware to hand at the moment: I can try to dig 
out my old Roland drum machine next week if that will help.

Meanwhile, I've tried playback (with jack 0.100.1, ardour, & 
realtime_lsm loaded).

With kernel 2.6.12 + "[PATCH] ehci-hcd - fix page pointer allocation in 
itd_patch()"), using jackd in realtime mode at 44.1kHz with 64 
frames/period and 4 periods/buffer, I get a stream of xruns of about 
0.020 ms, several per second.

Using the same kernel and jackd settings, but with the sound/ and 
include/sound directories from ALSA CVS of about 7:30 this evening, it 
seems to work fine, at least for a couple of minutes of stereo playback.

At 128 frames/period, both kernels have a crackling background noise: I 
haven't experimented with any other settings yet.

I hope this is useful: I'm afraid I'm not going to have time to try much 
more until next week now.

Colin Fletcher

-- 




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
