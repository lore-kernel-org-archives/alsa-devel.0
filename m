From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Why do I get broken pipe on write to a pcm in
 statePREPARED?
Date: Tue, 17 Sep 2002 11:05:44 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0209171012400.10979-100000@studcom.urz.uni-halle.de>
References: <200209162014.g8GKEc014124@d1o87.telia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200209162014.g8GKEc014124@d1o87.telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: Abramo Bagnara <abramo.bagnara@libero.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Anders Torger wrote:
> On Monday 16 September 2002 21.31, you [Abramo Bagnara] wrote:
> > I think that the best behaviour is the current and it's also the
> > simplest to describe and to understand: poll/select never blocks when
> > there is nothing to wait.
> >
> > ... and in PREPARED state definitely there's nothing to wait from
> > sound card.
>
> I don't agree. (...)
>
> Also, as we have noted, there is no real use for the current behaviour
> (at least no-one has said what it is), while there is use for the
> proper work-as-all-other-file-descriptors behaviour.

IMHO the current behaviour is the proper behaviour as implemented by other
file descriptors, and as mandated by POSIX.

<http://www.opengroup.org/onlinepubs/007904975/functions/write.html>
says regarding pipes, FIFOs and sockets:
| The write() function shall fail if:
| (...)
| [EPIPE]
| An attempt is made to write to a pipe or FIFO that is not open for
| reading by any process, or that only has one end open.
| (...)
| A write was attempted on a socket that is shut down for writing, or is
| no longer connected.


> It makes sense to block, there may be another thread, or even another
> process starting the sound card.

In the cases cited above, there may be another thread/process which will
open the other end of the FIFO, or connect to the socket. But write() only
looks at the state of the file descriptor at the time the call is made,
and does not take into regard what _might_ happen in the future.

The 'prepared' state is equivalent to the EPIPE cases above because it's a
state in which the pcm device is _not_ reading data.

> And it makes sense to return EAGAIN when writing to a non-blocking
> socket when it is not ready to accept data.

write() (or send()) blocks or returns EAGAIN if the local buffer is full
and data is being sent away, but fails if there isn't somebody listening
at the other end.

> * It simplifies multi-threaded programming

This might be true in a general sense, but the semantics of the
Linux/Unix/POSIX/whateverix API have not been designed with multi-
threading in mind, and ALSA tries to be compatible/consistent with that.


Regards,
Clemens



-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
