From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Fri, 10 Sep 2004 21:04:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040910190443.GI4584@sunrise.pg.gda.pl>
References: <20040910071614.GH4584@sunrise.pg.gda.pl> <200409101144.i8ABit16014190@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D645A27C
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2004 21:04:51 +0200 (MEST)
Received: from sunrise.pg.gda.pl (atlka@localhost [127.0.0.1])
	by sunrise.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i8AJ4jJR021659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2004 21:04:46 +0200 (CEST)
Received: (from atlka@localhost)
	by sunrise.pg.gda.pl (8.12.11/8.12.11/Submit) id i8AJ4iqV021649
	for alsa-devel@alsa-project.org; Fri, 10 Sep 2004 21:04:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200409101144.i8ABit16014190@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2004 at 07:44:55AM -0400, Paul Davis wrote:
> as mentioned previously, JACK uses mmap mode and supports latencies as
> low as the hardware can support. it never tries to rewrite existing
> data, and i believe this is the correct design. if you say you care
> about latency, then you should just do what JACK does - use the ASIO
> double buffered model (the app works on one half of the hardware
> buffer while the hardware works on the other), and set the size of the
> buffer to be small enough that you never need to rewrite
> already-written data. given that we use JACK with latencies on the
> order of 2-5ms, this is clearly feasible. 
Nice but jack is not a normal user land app. It's a sound daemon program
with suid or working with specially patched kernel so it have set
realtime scheduler and memory locked so it colud not be swapped out.
Are you saying that a game should meet this requirements to generate
proper sound in mmapped mode? It is not an advantage of the API.

> 
> i do recognize that the approach that game programmers have typically
> taken has some benefits. working with large buffer sizes but then
> being able to retroactively overwrite data anywhere in the buffer does
> mean that realtime scheduling becomes less necessary and reduces the
> CPU load associated with audio processing somewhat.
Yes and with ALSA API approach this functionality is lost. I just can
say that mmaped ALSA mode is not any better then normal read/write mode.
Only difference is that we need not copy the sound data from our buffer
to device buffer. We writting it directly to device - theoretically,
because if there are plugins in the path some copying will be done.
But it is hidden inside the ALSA lib so an app thinks that is is
writting data directly. So we only omit one copying and writting data to
first plugin buffer on the path. That's only difference.

> that then jaroslav's (a) option will provide the equivalent, but it
a) option is not my option because I want many simultaniously working
sound apps. Only c) ;-)

> will not be portable to non-hardware devices or hardware that doesn't
> implement its hardware buffer in the way that this design
> assumes. why? precisely because there really *isn't* a single
> contiguous hardware buffer that works in the way that this programming
> model assumes.
OK, I understand that.

> 
> 
> i don't agree with this. your model of "full functionality" for mmaped
> mode is based on a single conception of the hardware buffer for the
> device the application is talking to. as explained by both myself and
> jaroslav, ALSA supports devices where this conception is invalid. if
> you want to work with such devices, you have to modify your conception
> of what the hardware buffer is and how it works, and thats precisely
> what mmap_begin/commit/avail_update/forward/rewind are there to assist
> with.
Yes that's correct. I want support above but in OSS emulation behave
as it have automatically running continous buffer in memory mmapped
mode. I allocate the buffer in AOSS lib so it is one chunk of mem.
It's size is not always same as ALSA buffer size because OSS has some
restrictions buffer_size == 2^N (so oss_buffer >= alsa_buffer).
Also OSS locks buffer size after some ioctls while ALSA could still 
change its buffer size (OSS buffer size should be big enough at the start).
Actually it works quite good but sometimes sound is distorted and ALSA
does not report any errors. I have also small problems with
snd_pcm_forward. It reports 0 or value previusly reported by
snd_pcm_avail_update call not depending on requested frames to forward.
Also with current AOSS approach data is transfered only while an app is
doing sound ioctl. In other case we have buffer underrun.
Maybe I should use callback to transfer data from one buffer to another?

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
