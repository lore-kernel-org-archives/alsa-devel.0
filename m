From: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Mon, 27 Sep 2004 00:21:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41574105.8090804@pg.gda.pl>
References: <200409131305.i8DD5udm014503@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 91C932D6
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2004 00:22:48 +0200 (MEST)
In-Reply-To: <200409131305.i8DD5udm014503@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[2004-09-13 15:05] Paul Davis:
> ...What is lost is the ability to
> pretend that the h/w buffer is just a single contiguous chunk of
> physical RAM that is always accessible to the application. As Jaroslav
> and I have explained, you don't need to use the ALSA API "extras" for
> mmap mode. The cost of not doing so is that you lose the ability to
> get xrun detection, just as in OSS.
First of all in OSS GETOPTR call returns hw_ptr and number of bytes 
processed by device so xrun detection is not a problem! The number of 
bytes value wraps after about an hour but this is not the case.
Comparing previous values with the obtained one xrun detection is easy.
You can even use a GETODELAY call if you don't want to calculate it.
So your arguments about OSS are just not true.

>>>will not be portable to non-hardware devices or hardware that doesn't
>>>implement its hardware buffer in the way that this design
>>>assumes. why? precisely because there really *isn't* a single
>>>contiguous hardware buffer that works in the way that this programming
>>>model assumes.
OK but we could simply emulate this in a kernel driver with continous 
memory buffer and copying from it to real hw device period by period.
We could modify data which is not sent to the hw device. Latency could 
be as small as 1-1.5 of period size. With small enough periods it could 
be a quite nice solution. It should be in kernel to obtain proper 
scheduling and memory locking. An app using this approach may be a 
normal app because it could modify data with a few samples after current
playing position (minimal delay is one period) and write big chunks of data.

Current in lib mixing means that all this kind of apps needs root 
priviledges or specially patched kernel and capabilities to obtain RT 
scheduling and memory locking - they should be specially written.
So this is rather a disadvantage and probaly a security risk to promote 
this kind of solution as a better then OSS future design.
Also old or proprietary closed source apps will never work correctly 
using this approach under big system load or when switching big apps
- rescheduling and swapping effects will broke sound stream processing 
and will make cracling and noises.

> there are audio interfaces (the RME/Marion PAD series come to mind, as
> well as any non-busmaster devices) that will not let even the kernel
> access the full range of the buffer at arbitrary times. your design
> model can't handle these.
As I wrote before it could be simulated by sending small periods of
data to the real device. If the device could use continous DMA buffer 
then use it and if not then emulate this behaviour.

> if you decide you don't want this "overwrite data previously written"
> functionality, then there is nothing in the existing ALSA API that
> will cause you any problems. if you believe that the kernel will never
> screw up scheduling, ignore snd_pcm_avail() and go with your
> assumptions. if you don't care about xrun detection, ignore
> snd_pcm_forward() and it should work fine.
I need this functionality and xrun detection too. This is a multiuser, 
multitasking system so I can't assume that schedulling is always
on time. Generally nobody can assume this.

Regards

-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
