From: Paul Davis <pbd@op.net>
Subject: Re: Underruns (borken pipes)
Date: Sat, 13 Jul 2002 09:58:33 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17TNOs-00033Q-00@usw-sf-list1.sourceforge.net>
References: <3D2F85CC.24A88F5@tele-ip.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sat, 13 Jul 2002 11:43:40 +1000."
             <3D2F85CC.24A88F5@tele-ip.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Bruce Paterson <bruce@tele-ip.com>
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>I did, but the Jack introduction frankly scared me off a bit. I'm
>sure that it's not its intention, but the talk about necessary mods
>to the kernel and synchronisation issues between channels (I&O)
>seemed a huge amount of bother to go to at the time.

no kernel mods are necessary for JACK. kernel mods (1 patch) are
necessary if you want really low latency, but this is true for ALSA
and OSS as well.

the channel synchronisation issue is a basic design feature. when run
in full-duplex mode, JACK wants its clients to be able to do both
input and output in the same amounts at the same time (rather than say
"you can do N frames of input now" and then later "you can do M frames
of output now" - most programs would find this very difficult to
do; the other alternative is to provide much smaller frame counts to
the process() callback (ie. the smaller of the current data/space
available for playback/capture at a given interrupt), but this is much
less efficient since it means you have to invoke the clients much more
often.)

this design is based (like a lot of JACK's API) on the way just about
every non-Unix audio API works. it also models the way all the better
hardware works. and finally, although JACK works on most
consumer-level software, it wasn't designed as a general purpose
consumer sound server. if you are using it on crappy h/w, yes, this
channel sync issue will cause problems. you have a choice: you can
either write a custom ALSA interface that handles the lack of full
duplex sync, or you can get a decent audio interface for US$60 or so
and then be able to hook into the other applications (more added every
week) that use JACK. you're in luck: you already have a decent interface.

>> the first suggestion will reveal quite a bit. you additionally will
>> need to know that you can't avoid underruns with small buffer sizes
>> unless you run with SCHED_FIFO or SCHED_RR scheduling, and not without
>
>You know nothing in the alsa docs even hints at this, well certainly
>not in all the PCM bits I went through. Actually it IS working 90% of
>the time at present, as long

precisely what would be expected. its not the average case scheduling
latency that is bad in the regular kernel, its the worst case. thats
why it works 90% of the time.

its not documented in the alsa docs because almost nothing is
documented in the alsa docs. :) :(
 
>Could you possibly give me some pointers as to where to look in the
>Jack code ? I am totally unfamilier with it.

the relevant code is all in the ALSA driver/client, which lives in
jack/drivers/alsa/alsa_driver.c. what's there is fairly complex,
because of the full duplex requirement and the use of poll/mmap
access. however, it works very well, at least on soundcards that have
their playback and capture streams pretty well in sync (i.e. the same
requirement needed for ASIO and probably EASI as well).

>> a kernel with Andrew Morton's low latency patches. you didn't say what
>> buffer sizes you were using, so its hard to know if this is an issue.
>
>I did actually:
>>>Output frame buffer size is 6553, and input 5461, as returned by the
>>>hardware.
>Nothing bigger can be assigned.

sorry, i missed that. if thats in frames, they are pretty big, and
you're just facing the inevitable poor scheduling latency of the
regular linux kernel. if its in bytes, its still fairly large. they
are really odd values however, and they would normally be power-of-2
figures no matter what the unit.

>Also, if my plughw:0,0 interface to the envy24 doesn't work (segfault
>in the plug code), whereas the hw:0,0 does, will Jack even work ??

since your application doesn't have any control over the hardware, and
since JACK is known to work on ice1712-based hardware, there should be
no problem.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
