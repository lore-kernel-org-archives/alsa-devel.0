From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Why do I get broken pipe on write to a
 pcminstatePREPARED?
Date: Wed, 9 Oct 2002 21:33:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210092124170.512-100000@pnote.perex-int.cz>
References: <3DA47B20.4F880B4D@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DA47B20.4F880B4D@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Clemens Ladisch <clemens@ladisch.de>, Paul Davis <pbd@op.net>, Anders Torger <torger@ludd.luth.se>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 9 Oct 2002, Abramo Bagnara wrote:

> Clemens Ladisch wrote:
> > 
> > The current behaviour for playback is:
> > 
> > PREPARED: return POLLOUT until the buffer is full, then return POLLERR
> > RUNNING: block until avail_min can be written, then return POLLOUT
> > DRAINING: block (until state changes)
> > (other states: POLLERR)
> > 
> > I want the behaviour in the PREPARED state to be similar to the RUNNING
> > state, i.e. return POLLOUT until the buffer is full, then block.
> 
> Please reread with me SusV3:
> 
> POLLOUT: Normal data may be written without blocking.
> 
> When buffer is not full we have to return POLLOUT, but when buffer is
> full the point is *not* that file cannot be written without blocking,
> the point is that file cannot be written (because we'd return an error)
> 
> See?
> 
> Now the point is another: it's correct to return an error when buffer is
> full or it's better to block?
> 
> My answer is that proposed behaviour is illogical if the programmer take
> in account single-threading (i.e. my application have exclusive control
> of PCM):
> - in blocking mode we should delay (waiting for what?)
> - in nonblocking mode we should return -EAGAIN (why try again?)
> 
> OTOH I agree that if the programmer consider multi-threading all the
> illogicity goes away.
> 
> I think this could be faced with an appropriate documentation.
> 
> I've still some residual doubts:
> - how many applications out there we will break?
> - I'm almost sure that alsa-lib need to be changed in several places to
> follow this: who will do that? I'm thinking expecially to PCM chains and
> pcm_share.
> 
> Ok, iff:
> - Jaroslav agrees too
> - somebody do the patch for write *and* poll, correct the documentation
> and add a special paragraph explaining multithreading POV, correct
> alsa-lib and test *all* the PCM classes
> 
> you'll have my vote (FWIW of course ;-).

Thank you for your summary. I must admit that my silence in this thread
was caused that I see advantages for both behaviours. Anyway, we should
keep things as simple as possible, so I also prefer to choose only one
solution. Because the new proposal enhances usage possibilities, I take 
it.

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
