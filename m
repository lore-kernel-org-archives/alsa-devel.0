From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Mon, 13 Sep 2004 19:24:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040913172434.GC26354@sunrise.pg.gda.pl>
References: <20040910190443.GI4584@sunrise.pg.gda.pl> <200409131305.i8DD5udm014503@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2FA31295
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2004 19:25:38 +0200 (MEST)
Received: from sunrise.pg.gda.pl (atlka@localhost [127.0.0.1])
	by sunrise.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i8DHPaB0007732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2004 19:25:37 +0200 (CEST)
Received: (from atlka@localhost)
	by sunrise.pg.gda.pl (8.12.11/8.12.11/Submit) id i8DHPZ8p007731
	for alsa-devel@alsa-project.org; Mon, 13 Sep 2004 19:25:35 +0200 (CEST)
Resent-Message-Id: <200409131725.i8DHPZ8p007731@sunrise.pg.gda.pl>
Content-Disposition: inline
In-Reply-To: <200409131305.i8DD5udm014503@localhost.localdomain>
Resent-To: alsa-devel@alsa-project.org
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 13, 2004 at 09:05:56AM -0400, Paul Davis wrote:
>   [ JACK ]
> realtime programming is realtime programming. either you use a
> programming approach that doesn't require realtime (which is what the
> "overwrite the older part of the hardware buffer" is all about), or
> you have to follow the requirements for RT, which include
> SCHED_FIFO/RR scheduling and locking all memory.
> 
> and anyway, what JACK does is not at all unusual. its code was taken
> from within an older implementation of ardour, and currently ecasound
> and others do something very very similar.
Those are rather specialized sound apps. But I take a look at them.

> For the third time, it is *NOT* lost. What is lost is the ability to
> pretend that the h/w buffer is just a single contiguous chunk of
> physical RAM that is always accessible to the application. As Jaroslav
> and I have explained, you don't need to use the ALSA API "extras" for
> mmap mode. The cost of not doing so is that you lose the ability to
> get xrun detection, just as in OSS.
If I am not using snd_pcm_mmap_begin and snd_pcm_mmap_commit I can't
get ALSA buffer address and pointer so I can't also properly fill it.
So how do you suggest I should use mmapped mode without using this API?
 
> then why keep pushing for a (c)-style solution (i.e. compatible with
> all possible ALSA devices), when you clearly want either (a) or (b)?
I am using dmix plugin with card which has not hardware mixing.

> >mode. I allocate the buffer in AOSS lib so it is one chunk of mem.
> 
> no, you don't allocate the real buffer at all. 
look at pcm.c:1344 in alsa-oss/alsa:
 assert(!str->mmap_buffer);
 result = malloc(len);
OSS simulated ring buffer is allocated here ;-).

> AFAICT, the key functionality that you require is the ability to
> overwrite parts of the buffer that are outside the range of the
> current "period". but the buffer in question is not one allocated by
> libaoss or any other userspace software. it may not even be
> "allocated" by the kernel because it may correspond to memory
> physically located on the audio interface. 
OK.

> if you decide you don't want this "overwrite data previously written"
> functionality, then there is nothing in the existing ALSA API that
> will cause you any problems. if you believe that the kernel will never
> screw up scheduling, ignore snd_pcm_avail() and go with your
> assumptions. if you don't care about xrun detection, ignore
> snd_pcm_forward() and it should work fine.
requested feature should work from OSS aps point of view but of course
will not really exist in ALSA implementation. So I must have as small
period size as possible on ALSA size. The app_ptr should be pushed by
calback fuction. Of course this is not an ideal soultion but if period
size will be small enough we should have proper sound.

Generally speaking ALSA AOSS lib is a partial solution. It doesn't
emulate all needed features of OSS and doesn't work with all apps -
statically compiled and disabling LD_PRELOAD variable.
LD_PRELOAD variable usage is a security violation IMHO.
Also poll/select call is not working fast enough for some apps
(those using SDL for example).

So there should be a kernel module which emulates OSS /dev calls
and routes them to some sound daemon using RT sched and memory locking
to do accurate mixing and other special sound processing.
An OSS app should not even know about these all so simple
cat file.wav > /dev/dsp will work properly.
Also proprietary apps with closed code will work properly.

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
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
