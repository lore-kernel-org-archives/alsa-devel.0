From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: New PCM API extension
Date: Sun, 23 Feb 2003 22:41:49 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302232154250.1263-100000@pnote.perex-int.cz>
References: <3E591FD3.5DA500C5@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA07285
	for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2003 22:41:52 +0100
In-Reply-To: <3E591FD3.5DA500C5@libero.it>
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

On Sun, 23 Feb 2003, Abramo Bagnara wrote:

> Jaroslav Kysela wrote:
> > 
> > On Sat, 22 Feb 2003, Abramo Bagnara wrote:
> > 
> > > Jaroslav Kysela wrote:
> > > >
> > > > Hello all,
> > > >
> > > >         I'd like to announce a new PCM API extension. Although it is
> > > > implemented, it might be changed following the discussion on this list.
> > > >         I've added the snd_pcm_forward() function. This function is
> > > > function with opposite meaning to snd_pcm_rewind() - it skips given count
> > > > of frames (note that in the ring buffer are unchanged, only the r/w
> > > > pointer is increased). The application has full control on the r/w pointer
> > > > now. It's useful mainly in the no-xrun mode where the stream runs forever.
> > >
> > > Don't we had already snd_pcm_reset for exactly the same purpose?
> > 
> > Yes and no. You cannot fill the buffer ahead without writting some
> > samples. I think that it's not bad to offer the full control on appl_ptr.
> 
> "You cannot fill the buffer without writing some samples?" ???
> 
> I don't understand what you mean.

I mean that you cannot skip some frames (move forward in the ring buffer) 
without using the standard functions to transfer samples into/from the 
ring buffer (snd_pcm_writei for example).

> > It doesn't cost us anything and I can imagine some special applications
> 
> Apart that we have better things to do than to design solutions
> searching for problem to solve.
> 
> Is not better to wait for the true problem(s) to show up and then try to
> design the better solution for a definite class of problems?

I think that I have one present problem. It was not possible to write,
something like the dmix plugin does (in the server/client model): Transfer
data to different areas in the ring buffer. Imagine that client1 wants to
write data at the end of the ring buffer (assume that server don't change
the r/w pointer). Then client2 comes with some data to be placed at the
start of the buffer later (server rewinds the stream position). Then
hardware processed a period and client1 wants to continue (server forwards
the stream position at the end of the ring buffer).

I can imagine more examples where "later" samples might be wanted to be
processed before "quick" ones.

> > where the buffer is auto-silenced that they need to write samples into the
> > specific position. Reset is nice, but you cannot tell the count of frames
> > to be skipped without filling.
> 
> However I think that auto-silence is not the best thing we've designed.
> 
> We're using an interrupt handler to do what a rt-like user space process
> should do.
> 
> We'd have many things that might be solvable (like saturation in dmix by
> example) in this way, but we've (rightly) choosen not to do it to
> respect the general principle "never do in kernel space what is doable
> in user space".
> 
> Sometimes I think that auto silence is an unfortunate exception and I'd
> prefer we'd try to move in the opposite direction.

I have sometimes the mixed feeling, too. But I still think that silencing 
is a good and clean API extension which will work for all applications 
(even without RT priorities, because it is not affected by the behaviour 
of the task scheduler).

> > I'm also going to propose next extension: Actually, the appl_ptr managing
> > routines - snd_pcm_reset(), snd_pcm_rewind(), snd_pcm_forward() always
> > uses an ioctl for it's operation. I think that it wouldn't be a bad idea
> > to implement these function in the lightweight variant, too. I mean that
> > they will operate only with the actual hw_ptr without calling the kernel
> > code. We have already functions to synchronize the hw_ptr with the
> > hardware (snd_pcm_delay(), snd_pcm_hwsync()). Because it's late to change
> > this behaviour in alsa-lib, I propose to create a function
> > 'snd_pcm_fast_rw_change()' (better name?) which tells the alsa-lib that no
> > accurate operation is required. Especially lowlatency applications will
> > benefit that we removed more 'user<->kernel' switches.
> 
> Note that the assumption of monotonic direction of appl_ptr is spread
> everywhere so I doubt that this is feasible for snd_pcm_rewind.

I don't understand here. I've looked to the ioctl implementation and there 
are no problems to change appl_ptr in the user space only as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs





-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
