From: Paul Davis <pbd@Op.Net>
Subject: Re: ALSA sequencer in user land (was: Rawmidi bug or missed feature?)
Date: Sat, 02 Mar 2002 12:55:00 -0500
Message-ID: <200203022255.RAA28935@renoir.op.net>
In-reply-to: Your message of "Sat, 02 Mar 2002 23:22:11 +0100."
             <20020302232211.A9897@idefix.fvdpol.home.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Frank van de Pol <fvdpol@home.nl>
Cc: Peter Enderborg <pme@ufh.se>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Frank - 

thanks for writing. I don't want to suggest for one moment that there
is any "blame" to be attached to the current sequencer design. None of
us knew what we know now, and as you point out the hardware state of
affairs has changed considerably.

>Pentium 60 MHz (though faster iron was available by then). At that time the
>only way to get reliable, audibily tight timing from a sequencer was to do
>scheduling triggered by a hardware interrupt in kernel space. Since then the
>hardware and Linux kernel evolved, making similar things possible from
>userland code.

i'm not actually sure that this is true - i have a feeling that
SCHED_FIFO was supported back then, and wakeups of a user space thread
from a device driver interrupt would probably have been just as fast
(bar a couple of usecs). the point is, we didn't know about this back
then (or at least, the people involved didn't know, including me).

however, whether its true or not, its irrelevant. we know that right
now user space can do the job in an absolute sense - the question is:
is there an acceptable way to use this fact?

>I believe it would be a good thing to reconcider the various
>functions/responsibilities of the ALSA sequecer, and move certain parts to
>user space (=alsa lib), leaving the IPC to device drivers in place. 
	
by device drivers, i presume you mean "kernel modules". this is
actually the least efficient part of the current design - we always
end up copying data between user space clients. if we put the
multiplexor/router in user space and use shm, we can move data between
(user-space) clients without any data copying at all.
							     
>								     To the
>user these changes would be transparant.

Yes, they will be transparent, which is the only reason I feel even
vaguely comfortable suggesting any of this. I really mean that. I am
not suggesting a single API change to be associated with this idea,
and I would be alarmed if any came up.

>However, the application design could be a trouble maker in this case.
>Drawing the parralel from audio streams, one could write an application
>which is not designed for real-time performance, but does deliver good
>results because it's relying on the kernels' buffering (or scheduling in
>case of a sequencer). Once the scheduling becomes part of the userland
>application, this application's implementation and real-time performance
>becomes key for the effective timing quality of the system. Surely this can
>be solved (perhaps by enforcing some framework?), but this is sort of a
>concern to me.

JACK has precisely the same problem. We solve it by running the code
from libjack (well, almost all of it) in its own thread, which when
necessary has the correct scheduling characteristics to provide
correct timing.

The buffering isn't really an issue i think - the code for this would
be the same in both user space or kernel space, bar the change of
kmalloc to malloc (i know i'm glossing over a few points here, but i
think that its true in an important way). There would still be a
scheduler, and it would still be doing buffering.

No, the truly enormous problem is that of permissions. SCHED_FIFO and
mlockall() will provide the performance we want/need. But you can't
get them without having either root euid or CAP_RESOURCE. no kernels
from any distributor or even from the default build procedure come
with capabilities enabled, and so CAP_RESOURCE is a dead-end for
now. I don't anyone who is using capabilities for anything on a
regular basis. Requiring root euid is a terrible idea. So this is a
huge stumbling block. 

OTOH, JACK faces this too, and we "get around it" by providing
adequate performance (more than adequate in some cases) without
SCHED_FIFO, and say that if you want better performance, then root
permission or a capabilities-enabled kernel is required.

Even so, I recognize that for most people this represents a step
backwards. They associate the kernel with rock solid timing (even
though it isn't), and then they find out that not only have we
provided worse performance by default, but that to get back the good
stuff, their programs need to run as root ... :((

Its not quite that bad here, however, since the majority of programs
that use MIDI pre-generate the data and are not subject to the same
kinds of continuous real-time parameter changes that invalid
already-delivered or computed data. As a result, most applications
will not upset the operation of a real-time scheduler because they
don't have to do things in a real-time way. Programs like playmidi and
pmidi basically just convert MIDI data streams to a long list of
sequencer events and then deliver that to the sequencer. This will
work just fine without these programs having RT scheduling. 

Programs like MusE, SoftWerk, KeyKit and so forth are more difficult
because they generate their data on a just-in-time basis, and hence
will need RT-scheduling if they are going to work correctly with an RT
scheduler. 

The reason this interests me so much is that the next obvious step for
JACK is to add MIDI support. I don't really want to do this when the
sequencer does everything we would want to add, but OTOH, the
sequencer's basic premise - kernel space operation - doesn't work well
for JACK. Reinventing the wheel is not without its appeal for me (:))
but it seems like a real waste of effort. I'd much rather figure out
how to take all the good work that you, Takashi, Jaroslav and Abramo
have done and be able to use it within JACK as a routing mechanism
(perhaps scheduling too, but I am not sure).

--p


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
