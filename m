From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: New PCM API extension
Date: Mon, 24 Feb 2003 16:20:55 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302241605410.1142-100000@pnote.perex-int.cz>
References: <3E59562F.62929578@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA24210
	for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2003 16:21:11 +0100
In-Reply-To: <3E59562F.62929578@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Feb 2003, Abramo Bagnara wrote:

> Jaroslav Kysela wrote:
> > 
> > I think that I have one present problem. It was not possible to write,
> > something like the dmix plugin does (in the server/client model): Transfer
> > data to different areas in the ring buffer. Imagine that client1 wants to
> > write data at the end of the ring buffer (assume that server don't change
> > the r/w pointer). Then client2 comes with some data to be placed at the
> > start of the buffer later (server rewinds the stream position). Then
> > hardware processed a period and client1 wants to continue (server forwards
> > the stream position at the end of the ring buffer).
> > 
> > I can imagine more examples where "later" samples might be wanted to be
> > processed before "quick" ones.
> 
> Your examples appears a little confused at my eyes, but if I've
> understood correctly don't you think this might be solved by
> snd_pcm_rewind done by server?

And you'll need to commit the same samples later which seems to me quite 
ineffective (extra copy + processing (if required)).

I probably don't explain clearly my point:

We have data for time T, T+1 and T+2. The application might want to write
data in this order: T+1, T, T+2. While we going back to T position, we can
use snd_pcm_rewind(), but going to T+2 (without changing T+1 data)  
requires writting (or commiting) of same samples now. That's exactly what
I want to eliminate.

> At least this is how it works in pcm_share.
> 
> > > > I'm also going to propose next extension: Actually, the appl_ptr managing
> > > > routines - snd_pcm_reset(), snd_pcm_rewind(), snd_pcm_forward() always
> > > > uses an ioctl for it's operation. I think that it wouldn't be a bad idea
> > > > to implement these function in the lightweight variant, too. I mean that
> > > > they will operate only with the actual hw_ptr without calling the kernel
> > > > code. We have already functions to synchronize the hw_ptr with the
> > > > hardware (snd_pcm_delay(), snd_pcm_hwsync()). Because it's late to change
> > > > this behaviour in alsa-lib, I propose to create a function
> > > > 'snd_pcm_fast_rw_change()' (better name?) which tells the alsa-lib that no
> > > > accurate operation is required. Especially lowlatency applications will
> > > > benefit that we removed more 'user<->kernel' switches.
> > >
> > > Note that the assumption of monotonic direction of appl_ptr is spread
> > > everywhere so I doubt that this is feasible for snd_pcm_rewind.
> > 
> > I don't understand here. I've looked to the ioctl implementation and there
> > are no problems to change appl_ptr in the user space only as well.
> 
> Have you thought what happens if appl_ptr is changed backward during
> interrupt handler?

I see only one problem: XRUN detection might fail, but we can add a check 
to the user space the after appl_ptr change, so we will eliminate this 
problem. There might be a problem with hardware using indirect ring 
buffers (CS46xx, emufx), but the slow function will be still available to 
solve these problems as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
