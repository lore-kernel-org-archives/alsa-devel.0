From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: MIDI+USB - one way?
Date: Mon, 5 Aug 2002 18:37:46 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208051837340.775-100000@pnote.perex-int.cz>
References: <s5hk7n5ebo5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7n5ebo5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Aug 2002, Takashi Iwai wrote:

> At Mon, 05 Aug 2002 12:40:19 +0200,
> Clemens Ladisch wrote:
> > 
> > To quote one of the standards (I think IEEE 1003.1 is POSIX)
> > <http://www.opengroup.org/onlinepubs/007904975/functions/read.html>:
> > | When attempting to read a file (other than a pipe or FIFO) that
> > | supports non-blocking reads and has no data currently available:
> > |
> > | If O_NONBLOCK is set, read() shall return -1 and set errno to [EAGAIN].
> > |
> > | If O_NONBLOCK is clear, read() shall block the calling thread until
> > | some data becomes available.
> > |
> > | The use of the O_NONBLOCK flag has no effect if there is some data
> > | available.
> > | [...]
> > | Upon successful completion, where nbyte is greater than 0, read()
> > | (...) shall return the number of bytes read. This number shall never
> > | be greater than nbyte. The value returned may be less than nbyte if
> > | (...) the file is a (...) special file and has fewer than nbyte bytes
> > | immediately available for reading. For example, a read() from a file
> > | associated with a terminal may return one typed line of data.
> 
> ok, it's clearly mentioned here.
> then we should fix this behavior.

Fixed.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
