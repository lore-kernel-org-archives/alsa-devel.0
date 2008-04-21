From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Buffering issues
Date: Mon, 21 Apr 2008 23:30:59 +0200
Message-ID: <20080421213059.GA31343@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 82557243A7
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 23:31:00 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Heya!

As you might now I am currently working on something called
"glitch-free playback model" for PulseAudio:
http://0pointer.de/blog/projects/pulse-glitch-free.html

One of the central ideas is to schedule audio via timer interrupts, no
longer via period-based interrupts. To acomplish this I need to be
able to estimate in advance how long (in time) it will take until the
playback buffer runs empty at a certain point. Then I can set myself a
system timer to wakeup a certain margin earlier than this and fill the
buffer up again. That way I minimize wakeups and should always have
enough safety margin to never get an xrun.

Now, the way I implemented this right now is: in each iteration of my
playback loop I first fill up the playback buffer completely if it is
not fully filled up yet. After that I obviously can go to sleep for
the time it takes to play buffer_size samples minus some safety
margin, which i set to 20ms. Apparently this is actually not as
obvious as I thought. This works fine on many soundcards but it
apparently doesn't work on USB hardware. There, ALSA detects a buffer
underrun much earlier than when my timer elapses. My loop wakes up due
to activity on the ALSA fd, not because of the timer.

My code then goes and asks _avail_update() for the free space in the
buffer and sees that the full buffer is available, thus assuming a
xrun happened. This will cause PA to double the safety margin and do
some other things to make sure an XRUN doesn't happen the next time
again.

So, how do I properly estimate how long the filled up buffer will take
to play? Or to word it differently: how do I properly estimate how
much time will pass until an XRUN would occur?

[My interpretation of what's going on here with lots of guessing how
things work is this: the buffer exposed by ALSA is merely a send
buffer and just one of the buffers involved before the data actually
reaches the speakers. ALSA just takes the data out of this buffer and
sends it to the device via USB block-by-block. Thus the send buffer
maintained by ALSA is much quicker empty than the audio data is
actually played. And Boom! -- If that should actually be the case then
I'd like to request an API that allows me to query an upper limit for
how much buffering/latency actually happens after the audio data left
the ALSA buffer. I could then use this an subtract it from my time to
sleep.]

Thanks, 

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
