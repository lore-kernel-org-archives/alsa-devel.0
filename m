From: Frank van de Pol <fvdpol@home.nl>
Subject: ALSA sequencer in user land (was: Rawmidi bug or missed feature?)
Date: Sat, 2 Mar 2002 23:22:11 +0100
Message-ID: <20020302232211.A9897@idefix.fvdpol.home.nl>
References: <3C8124E0.4FDDECD1@ufh.se> <200203021931.OAA16335@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203021931.OAA16335@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: Peter Enderborg <pme@ufh.se>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Paul,

I must admit that looking at the current state of things a move or migration
of the ALSA sequencer to user space (either fully or partially) would be a
good thing. 

At the time I came up with the ALSA sequencer we were talking about alsa
0.0.12. It was 1998, yet only 4 years ago and my development machine was a
Pentium 60 MHz (though faster iron was available by then). At that time the
only way to get reliable, audibily tight timing from a sequencer was to do
scheduling triggered by a hardware interrupt in kernel space. Since then the
hardware and Linux kernel evolved, making similar things possible from
userland code.

I believe it would be a good thing to reconcider the various
functions/responsibilities of the ALSA sequecer, and move certain parts to
user space (=alsa lib), leaving the IPC to device drivers in place. To the
user these changes would be transparant.

However, the application design could be a trouble maker in this case.
Drawing the parralel from audio streams, one could write an application
which is not designed for real-time performance, but does deliver good
results because it's relying on the kernels' buffering (or scheduling in
case of a sequencer). Once the scheduling becomes part of the userland
application, this application's implementation and real-time performance
becomes key for the effective timing quality of the system. Surely this can
be solved (perhaps by enforcing some framework?), but this is sort of a
concern to me.


Cheers,
Frank.


On Sat, Mar 02, 2002 at 02:31:50PM -0500, Paul Davis wrote:
> >How can we get the same performance i userspace? For me it is the
> >processor/OS schedule that gives the limit for that, and in kernel we
> >get
> >the hardware as the limit.
> 
> there are two things done by the sequencer:
> 
>      a) routing/multiplexing
> 	
> 	this is mostly a matter of code design and memory management,
> 	and can be handled just as well in user space as in the
> 	kernel, perhaps even better (other libs can be used, for
> 	instance). there is almost nothing i can think of relating to
> 	this work that requires or even benefits from a kernel side
> 	location. 
> 
>      b) scheduling
>      
>         the kernel has no special access to system hardware for timing
> 	that is not available to a root-enabled or CAP_RESOURCE-enabled	
> 	task. the default system timer that the vast majority of
> 	sequencer users will use is of much worse resolution than some
> 	of the alternatives such as the RTC and a PCM audio
> 	clock.	
> 
> 	however, both of these sources (as well as the default system
> 	timer) are available to user space processes. there is a
> 	small overhead involved, on the order of 2-10 microseconds, if
> 	that. 
> 
> 	Since the sequencer would have to run with these permissions
> 	to be useful, as a user space process it has the same
> 	scheduling capabilities as it does in the kernel (for our
> 	purposes; obviously, it can't schedule processes in the same
> 	way as the OS task scheduler, but then for that matter,
> 	neither can the existing kernel sequencer).
> 
> 	the processor has no part to play in scheduling except for
> 	executing code. fast processors don't schedule faster other
> 	than in the sense that they execute the scheduling code
> 	(whether its in user space or not) more or less quickly.
> 	
> By putting the sequencer in user space we:
> 
>   a) remove a large and necessarily complex piece of code from the
>        kernel, nearly always a good thing
>   b) allow it to be developed more flexibly (code errors don't
>        cause system panics or hangs)
>   c) can make it more modular
>   d) can port it to non-Linux systems more easily
>   e) can extend it to work within or alongside other designs more easily
> 
> --p
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

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
