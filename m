From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Why do I get broken pipe on write to a pcm in statePREPARED?
Date: Tue, 17 Sep 2002 15:01:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209171301.g8HD1W026658@d1o87.telia.com>
References: <s5hhegoswi7.wl@alsa2.suse.de> <Pine.LNX.4.21.0209171341410.2859-100000@mailserver.intern.bfad.de> <s5helbssrqc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5helbssrqc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 September 2002 14.52, you wrote:
> At Tue, 17 Sep 2002 13:55:10 +0200 (CEST),
>
> tomasz motylewski wrote:
> > On Tue, 17 Sep 2002, Takashi Iwai wrote:
> > > but are you sure that this feature is really implemented?
> > > on my system, write() to an FIFO which is not opened for read
> > > doesn't fail, for example,
> > > 	% mkfifo /tmp/foo
> > > 	% cat /dev/random > /tmp/foo
> > > and cat is blocked, not failed.
> >
> > No, in this case open() blocks. cat is even not started, because
> > the shell waits for open().
>
> ah, ok.  thanks for clarification.
>
> > If you open /tmp/foo for reading, then open() suceeds, cat starts
> > and may write. If you close the other end, the next write() from
> > cat will return -1.
>
> yes.  clearly.
>
> > P.S. ALSA has more possible states of fd than pipes which may be
> > just open/closed by the other side, and eventually full. This makes
> > direct comparision difficult.
>
> i feel like that, too.
> but comparing the behavior gives us better understanding, at least.
> so let's try a bit yet more.
>
>
> if we regard the prepare state as "not ready", then write() should
> return EPIPE.  this is the current implementation.
>
> but at the same time, we can regard the perpare state as "ready for
>
> write but waiting for trigger".   again from the citation:
> | The write() function shall fail if:
> | (...)
> | [EPIPE]
> | An attempt is made to write to a pipe or FIFO that is not open for
> | reading by any process, or that only has one end open.
> | (...)
> | A write was attempted on a socket that is shut down for writing, or
> | is no longer connected.
>
> in the latter interpretation, the pipe/fifo is opened for reading
> (already configured) and obviously it's not end open.  the pcm stream
> is not shut down.   the stream is simply "not started".
> this is the case in which the opposite reader process opened fifo but
> don't start reading at all yet.
>
> i.e. we can say that the prepare state doesn't match with the case
> above -- therefore write() should be blocked.
>
> or, is this the absolutely wrong interpretation?

I feel that one can interpret both ways, so it is a quite open choice. 
Either way, one can state POSIX behaviour. Then the question becomes: 
what is the most usable behaviour? I think blocking/EAGAIN is the 
simpler and more usable. The current behaviour can only be used to show 
that a program is buggy by generating a broken pipe instead of 
dead-lock (a trivial bug also), while blocking/EAGAIN can be used in 
threaded programs, and seems quite logical for many/most.

It would be interesting to know what the kernel mailing list would say 
about this issue.

/Anders Torger


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
