From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: MIDI getting killed by Jack?
Date: Thu, 11 Sep 2003 09:06:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309111306.h8BD6Tfv007234@oud>
References: <Pine.HPX.4.33n.0309111007270.28640-100000@studcom.urz.uni-halle.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 11 Sep 2003 10:18:39 +0200."
             <Pine.HPX.4.33n.0309111007270.28640-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Mark Knecht <mknecht@controlnet.com>, Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>When an interrupt for MIDI input occurs, the hdsp driver disables all
>further MIDI interrupts until the current input data has been read. I
>don't know why it does this, but you may try to remove/disable lines
>3181, 3182, 3188, and 3189 in hdsp.c.

the hdsp driver is one of the first alsa drivers to use tasklets to
handle MIDI without impacting audio latency (that is, we can continue
processing audio i/o even while MIDI i/o is pending). once we have
launched a tasklet to handle MIDI input, there is no point handling
more interrupts that tell us the same thing.

the tasklet stuff relies on the kernel scheduler, but AFAIK, the
tasklet effectively runs like the kernel equivalent of a SCHED_FIFO
thread. i don't know at what priority, however.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
