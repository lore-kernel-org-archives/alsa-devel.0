From: "Jan P." <jipekau@yahoo.com>
Subject: integrated OpenGL and realtime FX
Date: Tue, 5 Mar 2002 16:38:50 -0800 (PST)
Message-ID: <20020306003850.39404.qmail@web9107.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E16iMZx-0002mm-00@usw-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi everyone-

Just a note to say I have successfully integrated
MesaGL support into my realtime FX looping software
(aka 'Techno Primitives'). A project page is coming
soon. Currently supported is:

-Full duplex low-latency I/O using JACK
-Multiple channel simultaneous record and playback of
arbitrary length audio phrases, cued by keyboard
-Jam on samples you just captured, while capturing
more
-Fully object-oriented, realtime signal rerouting..
modular design
-OpenGL synchronized 3D visuals that show a 3D
keyboard with twirling loops.

Coming next:

-Support for synchronization between loops,
quantization, synchronization to external timesources
(AXIS class)

-Automatic conversion to frequency-domain-based
samples, for realtime freq-domain FX.

-Building of object-oriented primitives, where
sequences of phrases played themselves become
primitives that can be played.

-Support for LADSPA plugins

-Support for external MIDI controllers (first I need a
working multichannel MIDI interface-- Timepiece? still
no word on that)... building of external MIDI
controllers (PIC-based, BASICSTAMP based?)

-Possible grant funding? STEIM?

......

The intention behind Techno Primitives is to build
bridges from the technological back to old ways of
making music. Like the circle, the tribe, and the
channel. To bring ancient wisdom back into 'new
music', 'old music' style. A way of organizing the
magic of music creation that is spontaneous,
unobtrusive, yet robust, and intuitive. A way that
honors the power of digital signal processing
judiciously, with temperence.  A way that honors the
tribe (free software), the body (core functionality
exposed by interfaces for dancers, drummers,
keyboardists)

This will ultimately be a multidisciplinary project
incorporating realtime system and user interface
design, shamanism and dreamwork, patience and
presence. Its not in the product, its in the process.

--

But I have a practical question for y'all
alsa-devel-lerz:

For keyboard and window handling, I grabbed code from
the glX demo 'glxgears.c' in the Mesa library.
Basically, the keyboard and video are handled in a
single event loop like this:

while (running) {
  while (XPending(display) > 0) {
    XNextEvent(...);
    // Process keyboard events

    // Visuals update
    draw();
    glXswapbuffers(...);
  }
}

But this introduces noticeable latency in the keyboard
control, since we have to wait for a GL frame to
render before processing those keyboard events. So I
created a keyboard handler thread which blocks on
XNextEvent and executes in parallel with the GL
library calls. 

This caused problems.

.. X errors 'unexpected async reply..', which I
suspect  comes from X calls not being thread safe. Am
I right? So I modified the code again to open two
separate connections to the X server (XOpenDisplay
x2). One for the GL visuals, one for the keyboard.
This seemed to work. Then I used
pthread_setschedpriority(...) to set my keyboard
thread to SCHED_FIFO, which also worked. I was a
little concerned, because the keyboard thread calls
classes that allocate memory through the "new
operator"... but it seems to work.

Is this a good idea? Should control-source threads run
at the same priority as audio processing threads? I
have an allocation block manager that talks to the
audio thread, so that no allocation is done in the
audio thread. It's very clean. But with control source
stuff, can I get away with this? Not nearly as much
throughput, so I think its OK.


Best,
Jan Pekau



__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
