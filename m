From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: ALSA sequencer in user land (was: Rawmidi bug or missed feature?)
Date: Sun, 3 Mar 2002 01:34:04 +0100
Message-ID: <20020303013404.B9897@idefix.fvdpol.home.nl>
References: <20020302232211.A9897@idefix.fvdpol.home.nl> <200203022255.RAA28935@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203022255.RAA28935@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Frank van de Pol <fvdpol@home.nl>, Peter Enderborg <pme@ufh.se>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 02, 2002 at 12:55:00PM -0500, Paul Davis wrote:
> 
> >I believe it would be a good thing to reconcider the various
> >functions/responsibilities of the ALSA sequecer, and move certain parts to
> >user space (=alsa lib), leaving the IPC to device drivers in place. 
> 	
> by device drivers, i presume you mean "kernel modules". this is
> actually the least efficient part of the current design - we always
> end up copying data between user space clients. if we put the
> multiplexor/router in user space and use shm, we can move data between
> (user-space) clients without any data copying at all.

I was thinking of the alsa clients written as kernel modules, such as I/O
ports and synth drivers. Once talking about user->user messaging (which
becomes more and more common with eg. Muse's soft synths) a user space
mux/router might be a good thing.

> 							     
> >								     To the
> >user these changes would be transparant.
> 
> Yes, they will be transparent, which is the only reason I feel even
> vaguely comfortable suggesting any of this. I really mean that. I am
> not suggesting a single API change to be associated with this idea,
> and I would be alarmed if any came up.

Yeps!

> 
> >However, the application design could be a trouble maker in this case.
> >Drawing the parralel from audio streams, one could write an application
> >which is not designed for real-time performance, but does deliver good
> >results because it's relying on the kernels' buffering (or scheduling in
> >case of a sequencer). Once the scheduling becomes part of the userland
> >application, this application's implementation and real-time performance
> >becomes key for the effective timing quality of the system. Surely this can
> >be solved (perhaps by enforcing some framework?), but this is sort of a
> >concern to me.
> 
> JACK has precisely the same problem. We solve it by running the code
> from libjack (well, almost all of it) in its own thread, which when
> necessary has the correct scheduling characteristics to provide
> correct timing.
> 
> The buffering isn't really an issue i think - the code for this would
> be the same in both user space or kernel space, bar the change of
> kmalloc to malloc (i know i'm glossing over a few points here, but i
> think that its true in an important way). There would still be a
> scheduler, and it would still be doing buffering.
> 
> No, the truly enormous problem is that of permissions. SCHED_FIFO and
> mlockall() will provide the performance we want/need. But you can't
> get them without having either root euid or CAP_RESOURCE. no kernels
> from any distributor or even from the default build procedure come
> with capabilities enabled, and so CAP_RESOURCE is a dead-end for
> now. I don't anyone who is using capabilities for anything on a
> regular basis. Requiring root euid is a terrible idea. So this is a
> huge stumbling block. 

ok, don't forget to put CAPs on the 2.5 wishlist :-)

> 
> OTOH, JACK faces this too, and we "get around it" by providing
> adequate performance (more than adequate in some cases) without
> SCHED_FIFO, and say that if you want better performance, then root
> permission or a capabilities-enabled kernel is required.

Audio streams use the buffering from kernel space. If running from a process
without SCHED_FIFO et al, this is still posibile at the cost of some higher
latency, ie. more samples to be buffered by the kernel driver.

If you want to run a sequencer application, the SCHED_FIFO becomes mandatory
for getting decent timing. It's then no longer a question of "you can run
without it at the expense of higher latency", but the difference between
rock-steady or fluttering beats. Take Muse for example: you can't run in it
without SCHED_FIFO for tigh timing.

Applications generating just in time data (eg. Softwerk, and to some extend
Muse) always had, and always wil have the requirement to run SCHED_FIFO.
However most MIDI applications (including Muse) know what events should be
played ahead of time. 

I'm not certain yet how to proceed with all of this (damn... I just broke
that crystal bulb that allows me to look in the future). Some wild thoughts
going through my mind:

- ALSA sequencer kernel scheduling is good for micro scheduling [1]
- Move as much complexity as possible from alsa-driver to alsa-lib
- Using user land ipc (shm) to send data accros user land clients, avoiding
  event fiddling in kernel space
- I'm exited by the elegance of Jack's model. An ALSA sequencer (or alike)
  event interface would be great to complement Jack.
- Avoid ending up with an alsa-lib router/scheduler sitting on top of an
  alsa-kernel router/scheduler (unless there is a good reason for it). [2]

ad 1: There is a growing number of (propiatary/undocumented) USB midi
devices that perform their own timing scheme. Providing a sequencer/event
API to the applications and allow for (either alsa-lib or alsa kernel)
scheduling makes use of these devices transparent to the application. The
alsa client driver for these USB midi ports could send the events a few ms
ahead of time and let that device handle timing. Same applies for softsynths
which have a known latency hence want to receive events ahead of time.

ad 2: The vision of having similar functionality in all layers makes me
scared, and makes me wonder if that would be a good route to take. Think of
an application like Muse (seq.#1) using alsa-lib (seq.#2) and
alsa-kernel (seq.#3) driving an MOTU USB interface (seq.#4). Perhaps some
futher though would prove if I'm seeing ghosts or not.

Regards,
Frank.


btw, I'm still amazed about timing accuracy when playing with why old Atari
ST or the ALSA sequencer when comparing it to eg. Cubase VST on a Windows
PC. Fairly weird that a 1.6 GHz P4 running win2k is still audibilly worse
that the old hardware (or that same box running linux) ;-)


-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
