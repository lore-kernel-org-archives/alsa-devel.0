From: Paul Davis <pbd@Op.Net>
Subject: Re: ALSA sequencer in user land (was: Rawmidi bug or missed feature?)
Date: Sat, 02 Mar 2002 15:18:37 -0500
Message-ID: <200203030118.UAA08398@renoir.op.net>
In-reply-to: Your message of "Sun, 03 Mar 2002 01:34:04 +0100."
             <20020303013404.B9897@idefix.fvdpol.home.nl>
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

>ok, don't forget to put CAPs on the 2.5 wishlist :-)

they are already implemented and maintained. its just that (almost)
nobody turns them on. 

>> OTOH, JACK faces this too, and we "get around it" by providing
>> adequate performance (more than adequate in some cases) without
>> SCHED_FIFO, and say that if you want better performance, then root
>> permission or a capabilities-enabled kernel is required.
>
>Audio streams use the buffering from kernel space. 

Not JACK. It (or rather, the ALSA PCM JACK driver) uses mmap mode to
write directly into the hardware buffer. There is no kernel side
buffering at all. I've therefore skipped your observations based on
this idea - its simply wrong.

>I'm not certain yet how to proceed with all of this (damn... I just broke
>that crystal bulb that allows me to look in the future). Some wild thoughts
>going through my mind:
>
>- ALSA sequencer kernel scheduling is good for micro scheduling [1]

i claim the opposite. its harder for the kernel to use hardware
interrupts as timers - this is not part of the kernel design (though
it can be done, as with the PCM timers and Takashi's RTC patch).
having h/w interrupts wake up tasks is absolutely what the kernel is
all about. by trying to do more-accurate-than-HZ scheduling in the
kernel, you are trying to get the kernel to do something it doesn't
really want to do, but its quite happy helping you to achieve this in
user space (even if it might not necessarily succeed; if it fails,
however, it would have failed in the kernel as well).

>- Move as much complexity as possible from alsa-driver to alsa-lib
>- Using user land ipc (shm) to send data accros user land clients, avoiding
>  event fiddling in kernel space
>- I'm exited by the elegance of Jack's model. An ALSA sequencer (or alike)
>  event interface would be great to complement Jack.

right, and i can see how to implement 80% of it in a day. however, my
experience tells me that the other 20% will take 80% of the time, and
that the entire 100% has already been coded as part of the sequencer.
in particular, queues and buffering are tricky, and doing them with
shm is going to be even trickier, though the nice shm-based
reimplementations of malloc should help.

the problem with JACK's model for MIDI is that JACK is built around
the idea of streaming data and synchronicity. MIDI isn't like that,
really. Well, MIDI *delivery* is like that: "at time N, deliver these
bytes to here". But MIDI *receipt* is asynchronous with respect to the
audio stream. 

i *could* just go ahead and implement this within JACK, but i still
have a gut feeling that its a bad idea.

>- Avoid ending up with an alsa-lib router/scheduler sitting on top of an
>  alsa-kernel router/scheduler (unless there is a good reason for it). [2]

Yes, this sounds like it would be a nightmare.

>ad 1: There is a growing number of (propiatary/undocumented) USB midi
>devices that perform their own timing scheme. Providing a sequencer/event
>API to the applications and allow for (either alsa-lib or alsa kernel)
>scheduling makes use of these devices transparent to the
>application. 

As I've said in several recent emails on LAD, I think this should be
added to the raw MIDI API, something like:

      snd_rawmidi_queue (snd_rawmidi_t *, char *data, size_t bytes,
			 snd_rawmidi_time_t when);

it would return -EINVAL if the handle refers to a device that cannot
do pre-queueing. its a natural complement to snd_rawmidi_{read,write},
IMHO, and involves exactly the same mechanisms inside the driver (such
devices need a delivery time of "now" for ordinary read/writes anyway).

a bigger problem is actually looming: neither USB nor IEEE1394 support
is well worked out for ALSA yet. presumably, we'll do it by having
alsa-lib call into a userspace library that accesses the USB/IEEE1394
device drivers, does protocol translation and so forth. but we don't
have any working examples of this yet, and its not clear how well it
will work. i *think* it will work well, but i'm just a little nervous,
because in a few years, these devices will totally dominate the
landscape of what's available to buy.

>ad 2: The vision of having similar functionality in all layers makes me
>scared, and makes me wonder if that would be a good route to take. Think of
>an application like Muse (seq.#1) using alsa-lib (seq.#2) and
>alsa-kernel (seq.#3) driving an MOTU USB interface (seq.#4). Perhaps some
>futher though would prove if I'm seeing ghosts or not.

I am told that MusE never uses the queuing facilities of the
sequencer. So you can make that MusE->MOTU USB. Does that make you
feel better? :))

--p


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
