From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Fri, 10 Sep 2004 07:44:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409101144.i8ABit16014190@localhost.localdomain>
References: <20040910071614.GH4584@sunrise.pg.gda.pl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out010.verizon.net (out010pub.verizon.net [206.46.170.133])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E5B261B6
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2004 13:45:05 +0200 (MEST)
In-reply-to: Your message of "Fri, 10 Sep 2004 09:16:14 +0200."
             <20040910071614.GH4584@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> Actually, ALSA PCM API meets all these points.
>Yes, but mmaped mode is different then it seems to be. If I just don't
>use it all is perfect. I am waiting for example of good working user app
>using this mode.

as mentioned previously, JACK uses mmap mode and supports latencies as
low as the hardware can support. it never tries to rewrite existing
data, and i believe this is the correct design. if you say you care
about latency, then you should just do what JACK does - use the ASIO
double buffered model (the app works on one half of the hardware
buffer while the hardware works on the other), and set the size of the
buffer to be small enough that you never need to rewrite
already-written data. given that we use JACK with latencies on the
order of 2-5ms, this is clearly feasible. 

i do recognize that the approach that game programmers have typically
taken has some benefits. working with large buffer sizes but then
being able to retroactively overwrite data anywhere in the buffer does
mean that realtime scheduling becomes less necessary and reduces the
CPU load associated with audio processing somewhat. if you want to do
that then jaroslav's (a) option will provide the equivalent, but it
will not be portable to non-hardware devices or hardware that doesn't
implement its hardware buffer in the way that this design
assumes. why? precisely because there really *isn't* a single
contiguous hardware buffer that works in the way that this programming
model assumes.

>Unified API for all modes means that some functionality of mmaped mode
>is lost because we must push the appl_pointer forward so snd_pcm_delay

i don't agree with this. your model of "full functionality" for mmaped
mode is based on a single conception of the hardware buffer for the
device the application is talking to. as explained by both myself and
jaroslav, ALSA supports devices where this conception is invalid. if
you want to work with such devices, you have to modify your conception
of what the hardware buffer is and how it works, and thats precisely
what mmap_begin/commit/avail_update/forward/rewind are there to assist
with.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
