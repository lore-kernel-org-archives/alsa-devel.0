From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: "Unexpected hw_pointer value - wrong interrupt
	acknowledge?" with emu10k1
Date: Tue, 13 Jul 2004 14:56:13 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1089744973.20381.53.camel@mindpipe>
References: <1089679085.10777.83.camel@mindpipe>
	 <s5hu0wban64.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0wban64.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-07-13 at 12:26, Takashi Iwai wrote:
> At Mon, 12 Jul 2004 20:38:05 -0400,
> Lee Revell wrote:
> > 
> > > On Sun, 2004-07-11 at 01:25, Andrew Morton wrote:
> > > > What we need to do is to encourage audio testers to use ALSA drivers, to
> > > > enable CONFIG_SND_DEBUG in the kernel build and to set
> > > > /proc/asound/*/*/xrun_debug and to send us the traces which result from
> > > > underruns.
> > > > 
> > > 
> > > OK, here goes.  The following traces result from running JACK overnight
> > > like so, on an otherwise idle system.  Hardware is a VIA EPIA 6000, with
> > > a 600Mhz C3 processor.  Kernel is 2.6.7 + volunatary_preempt patch. 
> > > voluntary_preempt and kernel_preemption are both on.
> > > 
> > > jackd -v --realtime -d alsa --outchannels 2 --rate 48000 --shorts
> > > --playback --period 32  --nperiods 2
> > > 
> > > These settings require less than 666 microseconds scheduler latency. 
> > > The average performance is quite good - 5-20 *microseconds*!
> > > 
> > 
> > While running the above test, I also noticed these messages from the
> > ALSA driver.  These messages did not occur during the overnight test;
> > they began when I sat down at the console to check the results.
> > 
> > Jul 12 17:31:43 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -16, max jitter = 32): wrong interrupt acknowledge?
> 
> The message appears when an unexpected DMA pointer is read in the
> interrupt handler.  Either the handling of irq was delayed more than
> the buffer size, an irq is issued at the wrong timing, or the DMA
> pointer reigster is somehow screwed up.
> 
> Since you're using quite small buffer, I guess the former case.
> 

I thought this was what an XRUN was, when the handling of the irq is
delayed more than the buffer size.  Sometimes these messages are
associated with XRUNs, sometimes not.

Is this a kernel issue, ALSA midlevel issue, or driver issue?

Lee




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
