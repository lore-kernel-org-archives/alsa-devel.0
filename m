From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to use alsa API in kernel space?
Date: Mon, 18 Jul 2005 15:32:55 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507181532290.27956-100000@studcom.urz.uni-halle.de>
References: <1121461373.cc20dfa69147c@webmail.ece.unm.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1121461373.cc20dfa69147c@webmail.ece.unm.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: cundongyang@ece.unm.edu
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

cundongyang@ece.unm.edu wrote:
> how could I call alsa-API in kernel space?

Have a look at how the OSS emulation uses the native ALSA code.


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
