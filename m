From: Paul Davis <pbd@Op.Net>
Subject: Re: integrated OpenGL and realtime FX
Date: Tue, 05 Mar 2002 14:59:32 -0500
Message-ID: <200203060059.TAA28960@renoir.op.net>
In-reply-to: Your message of "Tue, 05 Mar 2002 16:38:50 PST."
             <20020306003850.39404.qmail@web9107.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "Jan P." <jipekau@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Just a note to say I have successfully integrated
>MesaGL support into my realtime FX looping software
>(aka 'Techno Primitives'). A project page is coming
>soon. Currently supported is:
>
>-Full duplex low-latency I/O using JACK

Awesome! The rest of the list of features is just as fantastic. I
can't wait to try this out!

>.. X errors 'unexpected async reply..', which I
>suspect  comes from X calls not being thread safe. Am
>I right? 

Definitely. 

>	  So I modified the code again to open two
>separate connections to the X server (XOpenDisplay
>x2). One for the GL visuals, one for the keyboard.
>This seemed to work. Then I used
>pthread_setschedpriority(...) to set my keyboard
>thread to SCHED_FIFO, which also worked. I was a
>little concerned, because the keyboard thread calls
>classes that allocate memory through the "new
>operator"... but it seems to work.

thats OK, though i would be suprised if you really need SCHED_FIFO for
the keyboard thread. still, it could be useful. the thing to recall is
that X is not running SCHED_FIFO, so you've already got a built-in
latency sucker there. 

the thing about SCHED_FIFO is that it doesn't mean "real time" per
se. it means "when i'm ready to run, i get control till i say
otherwise (unless another high-priority SCHED_FIFO thread is
ready)". the fact that you do some non-realtime stuff within it
doesn't hurt too much at all.

>Is this a good idea? Should control-source threads run
>at the same priority as audio processing threads? I

i would say generally a little lower than the audio processing
threads. some people like to run MIDI threads at a higher priority. 

BTW, JACK will probably gain a SCHED_FIFO watchdog thread at some
point, ensuring that your SCHED_FIFO threads can't runaway with the
processor.

Wow. This sounds really, really, really cool. Any clues on when we
might be able to see a snapshot?

--p


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
