From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Why do I get broken pipe on write to a pcm in
 statePREPARED?
Date: Tue, 17 Sep 2002 16:40:54 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0209171615490.1084-100000@studcom.urz.uni-halle.de>
References: <200209171301.g8HD1W026658@d1o87.telia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200209171301.g8HD1W026658@d1o87.telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Anders Torger wrote:
> On Tuesday 17 September 2002 14.52, you [Takashi] wrote:
> > At Tue, 17 Sep 2002 13:55:10 +0200 (CEST),
> > tomasz motylewski wrote:
> > > P.S. ALSA has more possible states of fd than pipes which may be
> > > just open/closed by the other side, and eventually full. This makes
> > > direct comparision difficult.
> >
> > i feel like that, too.
> > but comparing the behavior gives us better understanding, at least.
> > so let's try a bit yet more.
> >
> >
> > if we regard the prepare state as "not ready", then write() should
> > return EPIPE.  this is the current implementation.

Yes. But I've just realized that in this case write() must _always_ return
EPIPE, i.e. it would not allow filling the first buffer.

> > but at the same time, we can regard the perpare state as "ready for
> > write but waiting for trigger".   again from the citation:
> > | The write() function shall fail if:
> > | (...)
> > | [EPIPE]
> > | An attempt is made to write to a pipe or FIFO that is not open for
> > | reading by any process, or that only has one end open.
> > | (...)
> >
> > in the latter interpretation, the pipe/fifo is opened for reading
> > (already configured) and obviously it's not end open.  the pcm stream
> > is not shut down.   the stream is simply "not started".
> > this is the case in which the opposite reader process opened fifo but
> > don't start reading at all yet.

And the stream will start if the start threshold has been set (I think;
I've never used it).

> > i.e. we can say that the prepare state doesn't match with the case
> > above -- therefore write() should be blocked.
> >
> > or, is this the absolutely wrong interpretation?
>
> I feel that one can interpret both ways, so it is a quite open choice.
> Either way, one can state POSIX behaviour. Then the question becomes:
> what is the most usable behaviour?

I think we have only two choices for POSIX-compliant write() behaviour in
the prepared state:

1) Don't allow any writes. Always return EPIPE.
   (my interpretation above)

2) Allow writes until the buffer is full, then block.
   (Takashi's second interpretation)

The current ALSA implementation is an inconsistent mixture of both:
returning EPIPE means that it is impossible to write, but then it should
not have been possible for the first bufferfull to succeed.

And we want to be able to fill the first buffer, so IMHO 2) is the way to
go.


Regards,
Clemens



-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
