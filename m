From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [linux-usb-devel] Fw: BUG: Kernel panic when
 disconnecting Edirol USB2 audio interface
Date: Thu, 7 Jul 2005 13:07:16 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507071305230.21603-100000@studcom.urz.uni-halle.de>
References: <42CC21C8.10505@axicon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42CC21C8.10505@axicon.com>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Colin Fletcher wrote:
> Clemens Ladisch wrote:
> >>>I'd like to know if playback and/or MIDI work.
>
> I've now tried this, and it seems to work (kernel 2.6.12.2 + the
> ALSA CVS from 27/06/2005 that I was using before). I haven't
> stressed it: I just sent a few note on/note off events and
> continuous controllers to the "UA-1000 MIDI" out, and saw that
> they came back in again. Is there anything more elaborate I should
> try?

You could try a SysEx, but it seems to work just fine.

Do you (or the manual) know what the control port is good for?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
