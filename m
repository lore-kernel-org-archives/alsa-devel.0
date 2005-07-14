From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio - Silence
Date: Thu, 14 Jul 2005 16:33:46 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507141632060.29646-100000@studcom.urz.uni-halle.de>
References: <1121351269.4535.9.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1121351269.4535.9.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Smery <luca_ing@libero.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Thu, 2005-07-14 at 16:21 +0200, Clemens Ladisch wrote:
> > Please note that ALSA versions earlier than 1.0.9 might synchronize
> > with a wrong sample rate with USB 2.0 devices, and that Linux kernels
> > earlier than 2.6.13
>
> Do you really mean 2.6.12, or the not yet released 2.6.13?

The latter.

It's this patch:
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=c2104cad4033ec58f2ec650c78b58b1cebd44934;hp=2fa1ffee5ff3bfea6428d4fb488dff8e1ab32fec;hb=77078570abe0848c3076b4f7d42f79b1407f3e8f;f=drivers/usb/host/ehci-sched.c


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
