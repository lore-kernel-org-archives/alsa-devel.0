From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Why do I get broken pipe on write to a pcm
 instatePREPARED?
Date: Wed, 09 Oct 2002 20:54:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA47B65.AEFFE757@libero.it>
References: <Pine.HPX.4.33n.0210090843120.2463-100000@studcom.urz.uni-halle.de> <200210091048.g99Am6029123@d1o87.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: Clemens Ladisch <clemens@ladisch.de>, Paul Davis <pbd@op.net>, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Anders Torger wrote:
> 
> On Wednesday 09 October 2002 09.52, Clemens Ladisch wrote:
> > Abramo Bagnara wrote:
> > > Clemens Ladisch wrote:
> > > > Abramo Bagnara wrote:
> > > > > The point is that stream is in bad state wrt read/write, this
> > > > > is the reason why poll should return POLLERR.
> > > >
> > > > I think the stream is _not_ in a bad state because one buffer of
> > > > data can (and has) be written. The reason for not allowing
> > > > further writes is that the buffer is full, and not that the
> > > > device wouldn't accept any data at all. This is similar to the
> > > > behaviour of a pipe with the reading end opened by an application
> > > > which currently doesn't read from the pipe, in contrast to a pipe
> > > > with the read end not opened at all.
> > >
> > > ??? With this message now I'm very confused about what you wish...
> >
> > I changed my mind about how the POSIX standard fits to our problem
> > case.
> >
> > > Can you resume to me the comparison between current and wanted
> > > behaviour wrt poll for both playback and capture.
> >
> > The behaviour of polling during capture is just fine:
> >
> > RUNNING: block until avail_min is available, then return POLLIN
> > DRAINING: return POLLIN until buffer is empty, then return POLLERR
> > (other states: POLLERR)
> >
> > The current behaviour for playback is:
> >
> > PREPARED: return POLLOUT until the buffer is full, then return
> > POLLERR RUNNING: block until avail_min can be written, then return
> > POLLOUT DRAINING: block (until state changes)
> > (other states: POLLERR)
> >
> > I want the behaviour in the PREPARED state to be similar to the
> > RUNNING state, i.e. return POLLOUT until the buffer is full, then
> > block.
> 
> Why not have the same behaviour for polling during capture? Reading
> from a not-yet-started sound card is useful in the same way that
> writing to a not-yet-started sound card is useful. Perhaps especially
> in low-latency multi-threaded applications, when you want to start
> reading (or writing) as soon as possible after the sound card has been
> started (this can be accomplished in other ways of course). If poll
> keeps returning POLLERR it is no use. Blocking in both cases is better,
> and in my humble opinion more logical behaviour. I don't think having a
> special case for the prepared state in read or write is useful.

Yes, I buy that.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
