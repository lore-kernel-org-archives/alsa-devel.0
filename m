From: Paul Davis <pbd@op.net>
Subject: Re: Timer?
Date: Wed, 06 Mar 2002 12:20:57 -0500
Message-ID: <200203061724.MAA26665@renoir.op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA19802
	for <alsa-devel@alsa-project.org>; Wed, 6 Mar 2002 18:24:26 +0100
In-reply-to: Your message of "Wed, 06 Mar 2002 17:57:54 +0100."
             <Pine.LNX.4.33.0203061741300.2187-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Ulrich Zadow <ulrich.zadow@ARTCOM.DE>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

>You're right. But it would be really nice to have a continuous timer 
>source in some resolution (microseconds?) available for all platforms
>to satisfy synchronization requirements. 

its often called "UST" (Unadjusted System Time). Its part of the POSIX
CLOCK_MONOTONIC specification. this is supported (apparently) as part
of glibc. i don't know what kind of kernel support is offered; it
almost certainly isn't of the resolution that UST has under IRIX or
BeOS (where it appears to be based on a cycle counter).

>It's not probably required exactly for this example where timing from one
>audio target is sufficient, but I can imagine several applications
>synchronized together. 

jaroslav, as you know, this has been the subject of much discussion on
alsa-devel; the presence of a UST source doesn't permit
multi-application synchronization in and of itself. you have to have
a scheme that uses either:

  a) synchronous client execution (the JACK/CoreAudio model)
  b) timestamped buffers with client-side drift correction (the dmSDK/OpenML
		 model)

UST is useful for (b), but its not necessary for (a). the kernel
provides no specific support for (a) or (b).

			As far as I know, Linux has not a continous timer.
>I am ready to work on this issue. It is very simple to create an interface
>with one ioctl returning struct timeval with the absolute timer value
>measured from system boot on i386 using rdtsc instruction.
>
>Perhaps, I'm trying to reinvent wheel, so please, let me know, if someone 
>solved this issue.

i think this is reinventing the wheel. however, AFAIK, at this time,
its not *reimplementing* the wheel, since Linux doesn't appear to
offer this facility at this time. Having CLOCK_MONOTONIC properly
supported by the cycle counter would be good.

But notice: this also does not provide proper synchronization, since
it actually *adds* a clock source. Without it, you've the clock
attached to each hardware i/o device (audio, video, MIDI). With it,
those clocks continue to exist, but you add the UST one. Its
incredibly unlikely that the UST source will run in sync with any of
the others, and so now you have to do client-side drift correction for
*every* stream type.

If instead, you just pick one of the existing stream clocks
(e.g. audio) and sync to that, you reduce the number of instances of
drift correction that have to be done.

as a result, i'm ambivalent about its use for synchronization. it
would be nice, however, to use a UST source for other things.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
