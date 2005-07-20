From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 0x10b9:0x5461 not supported?
Date: Wed, 20 Jul 2005 16:08:15 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507201607110.21951-100000@studcom.urz.uni-halle.de>
References: <42DE4DB5.5010709@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42DE4DB5.5010709@gmx.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dirk <noisyb@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dirk wrote:
> http://pciids.sourceforge.net/iii/?i=10b95461
>
> Doesn't work with snd_hda_intel or anything else I tried...

We don't have any documentation for this chip.

The CVS version of this driver assumes that this chip is compatible
with the Intel HDA controller; please test it.


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
