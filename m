From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA skipping samples
Date: Fri, 6 Jun 2003 11:05:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306061059080.2783-100000@pnote.perex-int.cz>
References: <20030606005423.B27256@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030606005423.B27256@flint.arm.linux.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Russell King <rmk+alsa@arm.linux.org.uk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, rmk@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Fri, 6 Jun 2003, Russell King wrote:

> Hi,
> 
> I'm working on some drivers for some custom AC'97 hardware on a
> development platform, and am seeing some weird behaviour.
> 
> The development platform is mostly FPGA-based, so it isn't the worlds
> most fastest machine.  However, running madplay against the OSS
> emulation results in the following:
> 
> # time madplay sample.mp3
> ...
> 8670 frames decoded (0:03:46.4), +2.2 dB peak amplitude, 3882 clipped samples
> 133.99user 19.92system 2:33.95elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (1498major+69minor)pagefaults 0swaps
> 
> Note that the mp3 is 3mins46 long, but we took only 2mins33 to play it!
> 
> When listening to the output, it appears that we're randomly missing
> chunks of samples; when I added a printk into my PCM's trigger function,
> I noticed that we were frequently calling it with TRIGGER_START/
> TRIGGER_STOP.  I suspect this is because the mp3 player can't keep
> ALSAs buffers full.
> 
> The driver source can be found at:
> 
>   http://patches.arm.linux.org.uk/alsa/aaci.c
> 
> (its not ready for release yet tho.  oh, and yes, dma is missing off
> the hardware implementation so its currently using PIO, but it is
> expected that in real CPUs the device will have DMA available.)

It seems that application is not fast enough to fill the right buffer or
the ring buffer pointer is wrong (I think that it is later case because of
measured time). I suggest to update ring buffer pointer at the beginning
of the interrupt routine to value "just played" rather than "moved to
FIFO". Yes, it creates a small window where the samples might be wrong in
the ring buffer, but it is better than recover from underruns. Also, FIFO
should be pre-filled in trigger-START, too.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
