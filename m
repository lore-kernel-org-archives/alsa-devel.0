From: Paul Davis <pbd@Op.Net>
Subject: Re: ALSA drivers for USB audio devices
Date: Tue, 19 Mar 2002 17:39:36 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203192236.RAA26515@renoir.op.net>
References: <1016576646.23423.40.camel@heat>
In-Reply-To: Your message of "19 Mar 2002 14:24:06 PST."
             <1016576646.23423.40.camel@heat>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Recently on this very list, Paul Barton-Davis proposed that one could
                             ^^^^^^^^^^^^^^^^^
			     Paul        Davis (op.net/~pbd/name.html)

>build a driver for a USB audio device entirely in user space.  I think
>this is an interesting idea, as I own an Edirol UA-5 USB audio device. 

Pray that it follows the "tandards" The existing OSS-based driver is
full of special case code for just about every device so far
supported.

>Naturally I would like to use it with ALSA to acheive the best
>performance and lowest latency.
>
>I hope someone on this list can describe how such a driver would work. 
>I am not aware of any user-space drivers for ALSA.  If there is one,
>that would be a nice example.  Would the driver take the form of a
>userspace daemon?  How would the ALSA library communicate with the
>daemon?  Or, would the driver instead take the form of a shared library
>which ALSA libraries would load?

there are two approaches:

      1) a new low-level ALSA driver that handles interactions
             with a USB audio device, and presents the ALSA "midlevel"
	     code with the normal *internal* ALSA API

      2) a shared library that would be loaded by alsa-lib, based
             on a description in an asoundrc file. this library 
	     would use an existing USB driver that allowed raw
	     "USB packet" I/O - it would format the USB packets
	     in user space based on requests from alsa-lib,
	     and then deliver them to the kernel USB driver.

>In any case, it seems almost MORE straightforward to write an kernel
>driver like the other supported output devices use.  A 24-bit/96KHz
>stereo audio stream requires driving the USB bus at nearly full
>throttle.  I doubt a userspace implementation could deal with it.

the userspace implementation is only a translation layer between the
ALSA PCM API and the USB audio packet standard. it would be an
existing USB kernel driver that would take care of streaming the data
to and from the h/w. i don't think the user space code would have any
problems with this. the kernel driver might, but if so, its a crock
anyway, and needs reimplementing. i don't know either way.

i suspect that it would be faster to write the low-level module, but
more interesting and potentially more flexible to write the user space
library. 

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
