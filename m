From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Why do I get broken pipe on write to a
 pcminstatePREPARED?
Date: Wed, 09 Oct 2002 20:53:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA47B20.4F880B4D@libero.it>
References: <Pine.HPX.4.33n.0210090843120.2463-100000@studcom.urz.uni-halle.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Paul Davis <pbd@op.net>, Anders Torger <torger@ludd.luth.se>, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> 
> The current behaviour for playback is:
> 
> PREPARED: return POLLOUT until the buffer is full, then return POLLERR
> RUNNING: block until avail_min can be written, then return POLLOUT
> DRAINING: block (until state changes)
> (other states: POLLERR)
> 
> I want the behaviour in the PREPARED state to be similar to the RUNNING
> state, i.e. return POLLOUT until the buffer is full, then block.

Please reread with me SusV3:

POLLOUT: Normal data may be written without blocking.

When buffer is not full we have to return POLLOUT, but when buffer is
full the point is *not* that file cannot be written without blocking,
the point is that file cannot be written (because we'd return an error)

See?

Now the point is another: it's correct to return an error when buffer is
full or it's better to block?

My answer is that proposed behaviour is illogical if the programmer take
in account single-threading (i.e. my application have exclusive control
of PCM):
- in blocking mode we should delay (waiting for what?)
- in nonblocking mode we should return -EAGAIN (why try again?)

OTOH I agree that if the programmer consider multi-threading all the
illogicity goes away.

I think this could be faced with an appropriate documentation.

I've still some residual doubts:
- how many applications out there we will break?
- I'm almost sure that alsa-lib need to be changed in several places to
follow this: who will do that? I'm thinking expecially to PCM chains and
pcm_share.

Ok, iff:
- Jaroslav agrees too
- somebody do the patch for write *and* poll, correct the documentation
and add a special paragraph explaining multithreading POV, correct
alsa-lib and test *all* the PCM classes

you'll have my vote (FWIW of course ;-).

Thanks for your patience anyway.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
