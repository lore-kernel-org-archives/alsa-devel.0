From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Mon, 13 Sep 2004 09:05:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409131305.i8DD5udm014503@localhost.localdomain>
References: <20040910190443.GI4584@sunrise.pg.gda.pl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out011.verizon.net (out011pub.verizon.net [206.46.170.135])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 63036188
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2004 15:06:00 +0200 (MEST)
In-reply-to: Your message of "Fri, 10 Sep 2004 21:04:43 +0200."
             <20040910190443.GI4584@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  [ JACK ]

>Nice but jack is not a normal user land app. It's a sound daemon program
>with suid or working with specially patched kernel so it have set
>realtime scheduler and memory locked so it colud not be swapped out.
>Are you saying that a game should meet this requirements to generate
>proper sound in mmapped mode? It is not an advantage of the API.

realtime programming is realtime programming. either you use a
programming approach that doesn't require realtime (which is what the
"overwrite the older part of the hardware buffer" is all about), or
you have to follow the requirements for RT, which include
SCHED_FIFO/RR scheduling and locking all memory.

and anyway, what JACK does is not at all unusual. its code was taken
from within an older implementation of ardour, and currently ecasound
and others do something very very similar.

>> i do recognize that the approach that game programmers have typically
>> taken has some benefits. working with large buffer sizes but then
>> being able to retroactively overwrite data anywhere in the buffer does
>> mean that realtime scheduling becomes less necessary and reduces the
>> CPU load associated with audio processing somewhat.
>Yes and with ALSA API approach this functionality is lost. I just can

For the third time, it is *NOT* lost. What is lost is the ability to
pretend that the h/w buffer is just a single contiguous chunk of
physical RAM that is always accessible to the application. As Jaroslav
and I have explained, you don't need to use the ALSA API "extras" for
mmap mode. The cost of not doing so is that you lose the ability to
get xrun detection, just as in OSS.

>> will not be portable to non-hardware devices or hardware that doesn't
>> implement its hardware buffer in the way that this design
>> assumes. why? precisely because there really *isn't* a single
>> contiguous hardware buffer that works in the way that this programming
>> model assumes.
>OK, I understand that.

then why keep pushing for a (c)-style solution (i.e. compatible with
all possible ALSA devices), when you clearly want either (a) or (b)?

>> i don't agree with this. your model of "full functionality" for mmaped
>> mode is based on a single conception of the hardware buffer for the
>> device the application is talking to. as explained by both myself and
>> jaroslav, ALSA supports devices where this conception is invalid. if
>> you want to work with such devices, you have to modify your conception
>> of what the hardware buffer is and how it works, and thats precisely
>> what mmap_begin/commit/avail_update/forward/rewind are there to assist
>> with.
>Yes that's correct. I want support above but in OSS emulation behave
>as it have automatically running continous buffer in memory mmapped
>mode. I allocate the buffer in AOSS lib so it is one chunk of mem.

no, you don't allocate the real buffer at all. 

AFAICT, the key functionality that you require is the ability to
overwrite parts of the buffer that are outside the range of the
current "period". but the buffer in question is not one allocated by
libaoss or any other userspace software. it may not even be
"allocated" by the kernel because it may correspond to memory
physically located on the audio interface. 

there are audio interfaces (the RME/Marion PAD series come to mind, as
well as any non-busmaster devices) that will not let even the kernel
access the full range of the buffer at arbitrary times. your design
model can't handle these.

so once again, the first question that you need to answer in an
unambiguous way is: do i want my code to support any and all ALSA PCM
devices, or just some specific subset of them? if the latter, which
specific subset?

if you decide you don't want this "overwrite data previously written"
functionality, then there is nothing in the existing ALSA API that
will cause you any problems. if you believe that the kernel will never
screw up scheduling, ignore snd_pcm_avail() and go with your
assumptions. if you don't care about xrun detection, ignore
snd_pcm_forward() and it should work fine.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
