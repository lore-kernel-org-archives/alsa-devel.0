From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Why do I get broken pipe on write to a pcm in
 statePREPARED?
Date: Tue, 08 Oct 2002 09:30:50 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210080901090.20533-100000@studcom.urz.uni-halle.de>
References: <3DA27602.969C3174@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3DA27602.969C3174@libero.it>
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
> > >No data may be read/written in current stream state in the case we are
> > >discussing.
> (...)
>
> The point is that stream is in bad state wrt read/write, this is the
> reason why poll should return POLLERR.

I think the stream is _not_ in a bad state because one buffer of data can
(and has) be written. The reason for not allowing further writes is that
the buffer is full, and not that the device wouldn't accept any data at
all. This is similar to the behaviour of a pipe with the reading end
opened by an application which currently doesn't read from the pipe, in
contrast to a pipe with the read end not opened at all.


Regards
Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
