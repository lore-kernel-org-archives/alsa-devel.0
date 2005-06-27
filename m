From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [linux-usb-devel] Fw: BUG: Kernel panic when
 disconnecting Edirol USB2 audio interface
Date: Mon, 27 Jun 2005 17:05:40 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506271650140.7308-100000@studcom.urz.uni-halle.de>
References: <42BC0D09.60507@axicon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42BC0D09.60507@axicon.com>
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
Cc: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, david-b@pacbell.net
List-Id: alsa-devel@alsa-project.org

Colin Fletcher wrote:
> Clemens Ladisch wrote:
> > There seems to be another bug in either the EHCI or the snd-usb-audio
> > driver; I'm still getting problems with high speed iso transfers.

That was a bug in snd-usb-audio; it didn't correctly handle high speed
endpoints with bInterval > 1.  Now fixed in the ALSA CVS.

> Do let me know if there's anything else you'd like me to test.

I'd like to know if playback and/or MIDI work.  It may be possible
that the driver doesn't send playback PCM data at exactly the correct
rate because the playback stream should have been synchronized to the
capture stream.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
