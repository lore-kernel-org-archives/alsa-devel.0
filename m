From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Why do I get broken pipe on write to a pcm
 instatePREPARED?
Date: Wed, 09 Oct 2002 09:52:44 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210090843120.2463-100000@studcom.urz.uni-halle.de>
References: <3DA328DA.C1B836EE@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3DA328DA.C1B836EE@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Paul Davis <pbd@op.net>, Anders Torger <torger@ludd.luth.se>, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Abramo Bagnara wrote:
>
> Clemens Ladisch wrote:
> >
> > Abramo Bagnara wrote:
> > >
> > > The point is that stream is in bad state wrt read/write, this is the
> > > reason why poll should return POLLERR.
> >
> > I think the stream is _not_ in a bad state because one buffer of data can
> > (and has) be written. The reason for not allowing further writes is that
> > the buffer is full, and not that the device wouldn't accept any data at
> > all. This is similar to the behaviour of a pipe with the reading end
> > opened by an application which currently doesn't read from the pipe, in
> > contrast to a pipe with the read end not opened at all.
>
> ??? With this message now I'm very confused about what you wish...

I changed my mind about how the POSIX standard fits to our problem case.

> Can you resume to me the comparison between current and wanted behaviour
> wrt poll for both playback and capture.

The behaviour of polling during capture is just fine:

RUNNING: block until avail_min is available, then return POLLIN
DRAINING: return POLLIN until buffer is empty, then return POLLERR
(other states: POLLERR)

The current behaviour for playback is:

PREPARED: return POLLOUT until the buffer is full, then return POLLERR
RUNNING: block until avail_min can be written, then return POLLOUT
DRAINING: block (until state changes)
(other states: POLLERR)

I want the behaviour in the PREPARED state to be similar to the RUNNING
state, i.e. return POLLOUT until the buffer is full, then block.

My reason for this is that a buffer overflow in the PREPARED state is
similar to a pipe connected to an application which currently doesn't read
from the pipe (-> blocking), and not a pipe which isn't connected at all
(-> EPIPE). And as Anders pointed out at the start of this thread, there
are situations where this case isn't an error.


Regards,
Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
