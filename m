From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI+USB - one way?
Date: Mon, 05 Aug 2002 12:40:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4E5613.96D45644@ladisch.de>
References: <Pine.LNX.4.33.0208042048550.951-100000@pnote.perex-int.cz>
 <3D4E3AB0.563AB976@ladisch.de> <s5hn0s1ehzp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > No, the size of the input buffer must not prevent read() from returning
> > data which is available immediately.  IOW: if some data is available,
> > read() mustn't block.  ALSA's current read() implementation is wrong in
> > this regard.
> >
> > This isn't only incompatible to OSS, but also to any other implementation
> > of read() in Linux (or any other Unix-like OS, not to mention POSIX or
> > SUS).
> 
> how about pcm?  it must be blocked unless O_NONBLOCK is specified.
> 
> this issue is regardless how the other unix-like os are, but we need
> to refer to _only_ posix here.  eventually, linux is not a unix clone
> :)
> 
> imo, in the case of midi, this blocking behavior is nothting but
> annoying.  hence i agree to change this behavior, as long as the
> change doesn't break the posix standard.

O_NONBLOCK specifies the behaviour only in the case when no data is
available at the time read() is called. When some data is available
later, read() must not block (again), regardless of this flag.

To quote one of the standards (I think IEEE 1003.1 is POSIX)
<http://www.opengroup.org/onlinepubs/007904975/functions/read.html>:
| When attempting to read a file (other than a pipe or FIFO) that
| supports non-blocking reads and has no data currently available:
|
| If O_NONBLOCK is set, read() shall return -1 and set errno to [EAGAIN].
|
| If O_NONBLOCK is clear, read() shall block the calling thread until
| some data becomes available.
|
| The use of the O_NONBLOCK flag has no effect if there is some data
| available.
| [...]
| Upon successful completion, where nbyte is greater than 0, read()
| (...) shall return the number of bytes read. This number shall never
| be greater than nbyte. The value returned may be less than nbyte if
| (...) the file is a (...) special file and has fewer than nbyte bytes
| immediately available for reading. For example, a read() from a file
| associated with a terminal may return one typed line of data.

> (and i believe that no applications suffer by this change.)

Yes, because applications expect the OSS behaviour.

I didn't really look at the OSS PCM read() implementation, but the
sequencer read() already implements the correct POSIX behaviour.


Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
