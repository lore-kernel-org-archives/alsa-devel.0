From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: The ALSA Situation
Date: Thu, 11 Nov 2004 07:32:41 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411110714280.2179@pnote.perex-int.cz>
References: <200411102113.iAALDLUN001061@localhost.localdomain>
 <Pine.LNX.4.58.0411101426260.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411101426260.2301@ppc970.osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Nov 2004, Linus Torvalds wrote:

> So to avoid the popping issue, I'd suggest that the "flush on close"  
> doesn't actually wait for the sound to end, but it might wait until the
> final sound fragment has been sent to the device. So hopefully the next 
> app has a few milliseconds of time to re-open the stream and start filling 
> the buffers again, so that you don't get any popping.

Unfortunately, the application will have to settle other real-time
parameters (including stream parameters, i/o chunk sizes etc.), so we must
drain on close() the complete stream and not allow intermixing requests
from applications. I see the possibility to move the blocking from open()
to the parameter handshage stage (ioctl). In this case, new application
will block until new parameters can be applied. It can be serialized as
well.

But, in my eyes, this change is quite same from the application view, 
because the blocking will be only moved to another syscall. It will solve 
nothing from the original request - the application will block one another 
and the original user will see really same result.

The question is: What's worse?

1) delay applications (might cause problems with not-intelligent apps)
2) return -EBUSY error at open()

My final words:

For OSS API - I will turn the nonblock_open on by default.
For ALSA API - I will leave the blocking behaviour in open()
- the Posix has a definition space for STREAMS drivers - interpretation
of the O_NONBLOCK flag is upon the driver requirements, and we
documented this feature from the initial design phase.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
