From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] Fw: BUG: Kernel panic when
 disconnecting Edirol USB2 audio interface
Date: Tue, 28 Jun 2005 08:56:35 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506280853210.5280-100000@studcom.urz.uni-halle.de>
References: <42C07072.1050105@axicon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Colin Fletcher <colinf@axicon.com>
Cc: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, david-b@pacbell.net
List-Id: alsa-devel@alsa-project.org

Colin Fletcher wrote:
> Clemens Ladisch wrote:
> > I'd like to know if playback and/or MIDI work.
>
> I don't have any MIDI hardware to hand at the moment: I can try to dig
> out my old Roland drum machine next week if that will help.

You could just use a MIDI cable for loopback.

> > It may be possible
> > that the driver doesn't send playback PCM data at exactly the correct
> > rate because the playback stream should have been synchronized to the
> > capture stream.
>
> At 128 frames/period, both kernels have a crackling background noise: I
> haven't experimented with any other settings yet.

This seems to be this synchronization issue.

To be able to handle this correctly, the driver would need to be
extended to always capture data so that it can determine the exact
rate for playback.


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
