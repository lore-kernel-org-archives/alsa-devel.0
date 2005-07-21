From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 0x10b9:0x5461 not supported?
Date: Thu, 21 Jul 2005 16:49:29 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507211645080.22387-100000@studcom.urz.uni-halle.de>
References: <42DFB2E2.7000603@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42DFB2E2.7000603@gmx.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dirk wrote:
> Maybe this does help a little:
> http://dlsvr01.asus.com/pub/ASUS/mb/socket775/P5RD1-V/Audio_Linux.zip
>
> It's the driver (with sources) from the mainboard manufacturer

It tries to access the ALi controller in the same way as the Intel
controller.

It may be possible that the ALi chip was designed to be compatible
with Intel's, but that they got some detail wrong.  Or that the driver
gets some detail wrong.  There's no way to know without docs


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
