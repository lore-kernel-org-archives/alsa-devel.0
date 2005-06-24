From: Colin Fletcher <colinf@axicon.com>
Subject: Re: [alsa-devel] Fw: BUG: Kernel panic when disconnecting
 Edirol USB2 audio interface
Date: Fri, 24 Jun 2005 14:39:21 +0100
Message-ID: <42BC0D09.60507@axicon.com>
References: <Pine.HPX.4.33n.0506241154480.11588-100000@studcom.urz.uni-halle.de>
Reply-To: colinf@axicon.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0506241154480.11588-100000@studcom.urz.uni-halle.de>
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
Cc: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, david-b@pacbell.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
  > There is a bug in the EHCI driver that will corrupt memory, use this
> patch:
> http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg35743.html

After applying this, I can start jackd, record a couple of minutes worth 
of eight tracks in ardour, and stop jackd again with no problems.

For the record, without the patch, as soon as I start jackd I get:
ehci_hcd 0000:00:03.3: fatal command 010010 (park)=0 ithresh=1 Periodic 
period=1024 HALT
ehci_hcd 0000:00:03.3: fatal status 4008 Periodic FLR
and my computer freezes, so that's definite progress. Thank you!

> There seems to be another bug in either the EHCI or the snd-usb-audio
> driver; I'm still getting problems with high speed iso transfers.
> I'm investigating this.

Do let me know if there's anything else you'd like me to test.

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
