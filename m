From: "Jeffrey W. Baker" <jwbaker@acm.org>
Subject: Re: ALSA drivers for USB audio devices
Date: 19 Mar 2002 14:48:25 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1016578105.23423.52.camel@heat>
References: <200203192236.RAA26515@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200203192236.RAA26515@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2002-03-19 at 14:39, Paul Davis wrote:
> >Recently on this very list, Paul Barton-Davis proposed that one could
>                              ^^^^^^^^^^^^^^^^^
> 			     Paul        Davis (op.net/~pbd/name.html)

My mistake.  Sorry.

> >build a driver for a USB audio device entirely in user space.  I think
> >this is an interesting idea, as I own an Edirol UA-5 USB audio device. 
> 
> Pray that it follows the "tandards" The existing OSS-based driver is
> full of special case code for just about every device so far
> supported.

It supposedly uses some Steinberg driver that supports a number of USB
devices, not all from Roland.  That gives me hope.  However, the ASIO
driver doesn't support 24/96 operation, so this may be a
device-by-device extension.  Duplex operation is limited to 24/48 anyway
because of USB bandwidth.  I won't care as long as it works on my
hardware :)

> there are two approaches:
> 
>       1) a new low-level ALSA driver that handles interactions
>              with a USB audio device, and presents the ALSA "midlevel"
> 	     code with the normal *internal* ALSA API
> 
>       2) a shared library that would be loaded by alsa-lib, based
>              on a description in an asoundrc file. this library 
> 	     would use an existing USB driver that allowed raw
> 	     "USB packet" I/O - it would format the USB packets
> 	     in user space based on requests from alsa-lib,
> 	     and then deliver them to the kernel USB driver.

The latter sounds more workable -- building packets is userspace is not
hard at all, and profiling for performance is more practical.

> the userspace implementation is only a translation layer between the
> ALSA PCM API and the USB audio packet standard. it would be an
> existing USB kernel driver that would take care of streaming the data
> to and from the h/w. i don't think the user space code would have any
> problems with this. the kernel driver might, but if so, its a crock
> anyway, and needs reimplementing. i don't know either way.
> 
> i suspect that it would be faster to write the low-level module, but
> more interesting and potentially more flexible to write the user space
> library. 

Probably less duplication of code as well.

-jwb


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
