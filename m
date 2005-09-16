From: Horms <horms@debian.org>
Subject: Re: [Alsa-devel] Problems with Hercules DJ Console and the usb-audio driver
Date: Fri, 16 Sep 2005 13:17:15 +0900
Message-ID: <20050916041715.GB18431@verge.net.au>
References: <Pine.HPX.4.33n.0509151401160.21623-100000@studcom.urz.uni-halle.de> <1126807842.3185.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <1126807842.3185.3.camel@mindpipe>
Resent-Message-ID: <ytNI-.A._HD.KjkKDB@murphy>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Daniel Svensson <nano@nittionio.nu>, debian-kernel@lists.debian.org, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2005 at 02:10:41PM -0400, Lee Revell wrote:
> On Thu, 2005-09-15 at 14:13 +0200, Clemens Ladisch wrote:
> > Horms wrote:
> > > On Wed, Sep 14, 2005 at 03:29:13PM +0200, Daniel Svensson wrote:
> > > > CONFIG_USB_BANDWIDTH is enabled by default in the debian kernel. Could
> > > > this be changed? According to the alsa developer who helped me debug the
> > > > problem with my usb soundcard CONFIG_USB_BANDWIDTH should be disabled.
> > > > The original email is forwarded here:
> > >
> > > That sounds fair enough to me, as long there are no objections
> > > from the rest of the kernel-team.
> > >
> > > Clemens, could you provide a little more information on
> > > the problems that CONFIG_USB_BANDWIDTH causes?
> > 
> > The code that implements it computes wrong values for the bandwidth
> > utilization.  This doesn't seem to matter much for full speed stereo
> > devices, but we have several bug reports for multichannel and/or high
> > speed devices where usb_submit_urb() incorrectly returns -ENOSPC
> > errors.
> > 
> > The comment above the usb_check_bandwidth() function in hcd.c lists
> > several of the known bugs.
> > 
> > Perhaps CONFIG_USB_BANDWIDTH should have been marked BROKEN instead of
> > just EXPERIMENTAL.

Thanks for the clarification.

> Has this been reported upstream?  Possibly the USB maintainers don't
> know that this is causing real problems for users.

That would be a good idea if it hasn't been done,
but I know nought about this sistuation, so my
comments are close to worthless.

-- 
Horms
