From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: Some problems with snd-au8830
Date: Sun, 12 Sep 2004 15:22:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1095015988.2056.9.camel@localhost>
References: <20040912084204.GA22712@darjeeling.triplehelix.org>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040912084204.GA22712@darjeeling.triplehelix.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joshua Kwan <joshk@triplehelix.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sun, 2004-09-12 at 04:42, Joshua Kwan wrote:
> Hello ALSA developers (cc: LKML for any inspiration),
> 
> Some snd-au8830 concerns..
> 
> I've recently been using my Aureal Vortex2 SQ2500 with ALSA's snd-au8830
> to do some recording, and I got a humongous pile of these in my dmesg:
> 
> vortex: IRQ reg error
> vortex: IRQ fifo error
> vortex: IRQ dma error

That are hardware error flags. Normally, one "IRQ fifo error" occurrs
for the first time playback ocurrs. But more than one message of those
plus the others certainly is odd. I Would try to change the PCI slot. By
the way, do you mind sending a lspci output, and some general
information about your system ?

> and at the end of each batch:
> 
> vortex: 0 virt=0, real=0, delta=-1

This means that there where severe xrun condition. delta is the
difference between the previous and current DMA subbuffer (directly
mapped to periods). It could be due to missing interrupts (bad
mainboard) or due to system overload. If you are using 2 periods,
delta=-1 would mean you are one period behind realtime.

> Also, I can't seem to start up JACK using the ALSA backend:
> 
> loading driver ..
> creating alsa driver ...
> hw:0|hw:0|1024|2|48000|0|0|nomon|swmeter|-|32bit
> control device hw:0
> configuring for 48000Hz, period = 1024 frames, buffer = 2 periods
> Couldn't open hw:0 for 32bit samples trying 24bit instead
> Couldn't open hw:0 for 24bit samples trying 16bit instead
> ALSA: cannot set period size to 1024 frames for capture
> ALSA: cannot configure capture channel
> cannot load driver module alsa
> 
> It only works when I use -p 512 (512 frames/period) and disable capture
> outputs:
> 
> $ jackd -d alsa -p512 -P
> 
> creating alsa driver ... hw:0|-|512|2|48000|0|0|nomon|swmeter|-|32bit
> control device hw:0
> configuring for 48000Hz, period = 512 frames, buffer = 2 periods
> Couldn't open hw:0 for 32bit samples trying 24bit instead
> Couldn't open hw:0 for 24bit samples trying 16bit instead
> 
> It all works perfectly with my other machine which uses snd-intel8x0.
> (Except, of course, that there's no nice hardware mixing.) Any ideas?

Cool that you actually got jackd working :P, i never got it working on
whatever hardware i have tried it (intel8x0, ESS maestro 2e, au8820 and
au8830). The aureal driver does support any period size power of 2 upto
4096 bytes; that includes 1024 (4096 if that where 16bit stereo frames
instead bytes). Why jackd was unable to set that up ? I guess the error
message is somewhat wrong; probably some other parameter could not be
met.

Best Regards

Manuel Jander




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
