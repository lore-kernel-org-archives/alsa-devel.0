From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: MIDI getting killed by Jack?
Date: Thu, 11 Sep 2003 06:56:10 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGEEPPDCAB.mknecht@controlnet.com>
References: <200309111306.h8BD6Tfv007234@oud>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309111306.h8BD6Tfv007234@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul,
   I'm pretty sure that I was not the intended audience for this level of
technical data, but it does raise the question (for me) as to whether this
problem might be created by using the 'wrong' (I.e. - undocumented
requirements) kernel?

   The machine exhibiting the problem is running a pretty much vanilla
Gentoo 2.4.20 kernel with preemptive multitasking and low latency scheduling
turned on. This kernel does not have the capabilities patch. The problem
occurs when I run Jack as a user.

   I have not investigated what happens as root.

   However, as I stated in my second message yesterday, none of the above
seems to impact the system if I get my MIDI input through the MidiSport vs.
the HDSP 9652, so my presumption is that the first-order problem lies with
that driver and not the kernel.

   Please let me know specifically if there is anything you would like me to
try.

Thanks,
Mark

> -----Original Message-----
> From: Paul Davis [mailto:paul@linuxaudiosystems.com]
> Sent: Thursday, September 11, 2003 6:06 AM
> To: Clemens Ladisch
> Cc: Mark Knecht; Alsa-Devel
> Subject: Re: [Alsa-devel] MIDI getting killed by Jack?
>
>
> >When an interrupt for MIDI input occurs, the hdsp driver disables all
> >further MIDI interrupts until the current input data has been read. I
> >don't know why it does this, but you may try to remove/disable lines
> >3181, 3182, 3188, and 3189 in hdsp.c.
>
> the hdsp driver is one of the first alsa drivers to use tasklets to
> handle MIDI without impacting audio latency (that is, we can continue
> processing audio i/o even while MIDI i/o is pending). once we have
> launched a tasklet to handle MIDI input, there is no point handling
> more interrupts that tell us the same thing.
>
> the tasklet stuff relies on the kernel scheduler, but AFAIK, the
> tasklet effectively runs like the kernel equivalent of a SCHED_FIFO
> thread. i don't know at what priority, however.
>
> --p
>
>




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
