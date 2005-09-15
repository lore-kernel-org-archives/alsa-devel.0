From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems with Hercules DJ Console and the usb-audio
 driver
Date: Thu, 15 Sep 2005 14:13:50 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509151401160.21623-100000@studcom.urz.uni-halle.de>
References: <20050915030027.GN2012@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050915030027.GN2012@verge.net.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Horms <horms@debian.org>
Cc: Daniel Svensson <nano@nittionio.nu>, debian-kernel@lists.debian.org, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Horms wrote:
> On Wed, Sep 14, 2005 at 03:29:13PM +0200, Daniel Svensson wrote:
> > CONFIG_USB_BANDWIDTH is enabled by default in the debian kernel. Could
> > this be changed? According to the alsa developer who helped me debug the
> > problem with my usb soundcard CONFIG_USB_BANDWIDTH should be disabled.
> > The original email is forwarded here:
>
> That sounds fair enough to me, as long there are no objections
> from the rest of the kernel-team.
>
> Clemens, could you provide a little more information on
> the problems that CONFIG_USB_BANDWIDTH causes?

The code that implements it computes wrong values for the bandwidth
utilization.  This doesn't seem to matter much for full speed stereo
devices, but we have several bug reports for multichannel and/or high
speed devices where usb_submit_urb() incorrectly returns -ENOSPC
errors.

The comment above the usb_check_bandwidth() function in hcd.c lists
several of the known bugs.

Perhaps CONFIG_USB_BANDWIDTH should have been marked BROKEN instead of
just EXPERIMENTAL.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
