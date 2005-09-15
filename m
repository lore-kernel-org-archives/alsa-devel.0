From: Horms <horms@debian.org>
Subject: Re: [Alsa-devel] Problems with Hercules DJ Console and the usb-audio driver
Date: Thu, 15 Sep 2005 12:00:27 +0900
Message-ID: <20050915030027.GN2012@verge.net.au>
References: <20050914132913.GB18354@nittionio.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <20050914132913.GB18354@nittionio.nu>
Resent-Message-ID: <abjBsB.A.j4D.ZPOKDB@murphy>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
To: Daniel Svensson <nano@nittionio.nu>
Cc: debian-kernel@lists.debian.org, Clemens Ladisch <clemens@ladisch.de>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 14, 2005 at 03:29:13PM +0200, Daniel Svensson wrote:
> Hi 
> 
> CONFIG_USB_BANDWIDTH is enabled by default in the debian kernel. Could
> this be changed? According to the alsa developer who helped me debug the
> problem with my usb soundcard CONFIG_USB_BANDWIDTH should be disabled.
> The original email is forwarded here:

That sounds fair enough to me, as long there are no objections
from the rest of the kernel-team.

Clemens, could you provide a little more information on 
the problems that CONFIG_USB_BANDWIDTH causes?

Thanks

-- 
Horms

> ----- Forwarded message from Clemens Ladisch <clemens@ladisch.de> -----
> 
> From: Clemens Ladisch <clemens@ladisch.de>
> To: Daniel Svensson <nano@nittionio.nu>
> Subject: Re: [Alsa-devel] Problems with Hercules DJ Console and the usb-audio
>  driver
> 
> Daniel Svensson wrote:
> > Here is the output of "amixer scontents":
> > ...
> > Which doesn't match alsamixer controls very well (in count and names).
> 
> What is the output of "amixer contents"?
> 
> > Ok, so some progress. The device accepts S16, 6 channels, 48kHz.
> > Still no output, fails with kernel message:
> >
> > ALSA /hom.../usbaudio.c:807: cannot submit datapipe for urb 5, err = -28
> 
> 28 = ENOSPC.  Please disable bandwidth checking in the kernel
> configuration.  (This is a bug of your distribution unless you
> compiled the kernel yourself.)
> 
> 
> HTH
> Clemens
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 
> ----- End forwarded message -----
> 
> -- 
> Daniel Svensson <nano@nittionio.nu>
> 
> 
> -- 
> To UNSUBSCRIBE, email to debian-kernel-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
