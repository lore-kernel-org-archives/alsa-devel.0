From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Sun, 26 Sep 2004 23:00:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409270300.i8R30Ro1016070@localhost.localdomain>
References: <41574105.8090804@pg.gda.pl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out008.verizon.net (out008pub.verizon.net [206.46.170.108])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B4A1C2D4
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2004 05:00:36 +0200 (MEST)
In-reply-to: Your message of "Mon, 27 Sep 2004 00:21:57 +0200."
             <41574105.8090804@pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>First of all in OSS GETOPTR call returns hw_ptr and number of bytes 
>processed by device so xrun detection is not a problem! The number of 
>bytes value wraps after about an hour but this is not the case.

no, thats not the type of wrapping that matters. suppose the h/w
buffer is 4096 frames in size. suppose that a rogue PCI driver or
device prevents receipt of an interrupt for an entire buffer's worth
of time, maybe even longer. looking at the value of the h/w ptr by
itself doesn't tell you anything about whether there is an xrun. you
have to constantly monitor the *expected* time of the next interrupt
along with the *expected* position of the h/w ptr in order to
establish if there was an xrun or not (at least for the class of xruns
caused by this kind of delay).

>Comparing previous values with the obtained one xrun detection is easy.
>You can even use a GETODELAY call if you don't want to calculate it.
>So your arguments about OSS are just not true.

user-space is not in a position to determine this, because the
interrupt handler is the only place where the value of the h/w ptr can
be reliably determined (even though on many cards, there are other
ways and times as well).

>OK but we could simply emulate this in a kernel driver with continous 
>memory buffer and copying from it to real hw device period by period.
>We could modify data which is not sent to the hw device. Latency could 
>be as small as 1-1.5 of period size. With small enough periods it could 
>be a quite nice solution. It should be in kernel to obtain proper 
>scheduling and memory locking. An app using this approach may be a 
>normal app because it could modify data with a few samples after current
>playing position (minimal delay is one period) and write big chunks of data.

ALSA and the entire kernel development team have spent the last 5
years moving things *out* of kernel space. forget ALSA - you will have
a very, very hard time explaining to the kernel crew why this is
actually a good idea.

moreover, you are completely forgetting that the non-hw PCM devices
that i've mentioned where this "contiguous buffer" doesn't necessarily
exist are *in user space*. the kernel knows nothing about them.

>Also old or proprietary closed source apps will never work correctly 
>using this approach under big system load or when switching big apps
>- rescheduling and swapping effects will broke sound stream processing 
>and will make cracling and noises.

this is entirely orthogonal.

>> if you decide you don't want this "overwrite data previously written"
>> functionality, then there is nothing in the existing ALSA API that
>> will cause you any problems. if you believe that the kernel will never
>> screw up scheduling, ignore snd_pcm_avail() and go with your
>> assumptions. if you don't care about xrun detection, ignore
>> snd_pcm_forward() and it should work fine.
>I need this functionality and xrun detection too. This is a multiuser, 
>multitasking system so I can't assume that schedulling is always
>on time. Generally nobody can assume this.

but you haven't offered any information about what you propose to do
with the fact that scheduling may go wrong or that an xrun may
happen. the information that ALSA provides appears completely useless
to you. it seems to me that all you want to know is the delta between
the hw ptr and the appl ptr, plus the ability to write "behind" the
appl ptr.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
