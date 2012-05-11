From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ALSA calling pcm_pointer excessively?
Date: Fri, 11 May 2012 15:02:37 +0100
Message-ID: <20120511140237.GB6220@n2100.arm.linux.org.uk>
References: <20120510160601.GC12727@n2100.arm.linux.org.uk>
	<20120510162930.GA17361@n2100.arm.linux.org.uk>
	<4FABF574.7090804@ladisch.de> <s5h62c2alpf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 68E6224466
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 16:02:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h62c2alpf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, May 11, 2012 at 03:31:08PM +0200, Takashi Iwai wrote:
> At Thu, 10 May 2012 19:05:56 +0200,
> Clemens Ladisch wrote:
> > 
> > Russell King - ARM Linux wrote:
> > > I think what's happening is that snd_pcm_lib_write1() is looping, and
> > > each time it updates the hardware position, it finds that it can
> > > transfer 8 or 16 bytes to the buffer.  Once it's transferred that,
> > > it re-updates the hardware position which has now advanced by another
> > > 8 or 16 bytes.  Repeat, and you find that snd_pcm_lib_write1() spends
> > > a lot of time inefficiently copying the buffer.
> > >
> > > It seems that it will only sleep if the hardware pointer stops making
> > > progress.
> > 
> > I'd guess that most existing hardware is fast enough to transfer
> > samples and has a big enough granularity (typically 32 byte bursts
> > for PCI) that the pointer doesn't change in consecutive loop
> > iterations.
> > 
> > This (untested) patch tries to avoid too many busy looping.
> 
> Hmm...  I still can't follow why such a busy loop happens when
> avail_min > 1.  If avail_min = 1, a busy loop can't be avoided.
> But if avail_min is set (typically equal with period_size),
> runtime->twake is either the rest size or the period size, and
> wait_for_avail() should wait until that sufficiently.

It's exaclty as I explained.  Lets take avail_min = 4096, as it is in my
case.

In snd_pcm_lib_write1(), we loop - here's the simplified version:

        while (size > 0) {
                if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
                        snd_pcm_update_hw_ptr(substream);
                avail = snd_pcm_playback_avail(runtime);
                if (!avail) {
			/* Sleep until avail >= avail_min */
		}
		/* Transfer up to max(avail,size) bytes to buffer */
	}

The problem is this.  On entry to the loop, say, we calculate that we
can transfer 4096 bytes into the buffer, and we do that.  While we're
transferring those bytes, the hardware DMA position has advanced.

So, the second time around the loop, avail will be non-zero - let's
say that the DMA position has advanced 32 bytes.  So avail will be
32 bytes, and we transfer 32 bytes.  Again, while transferring those
bytes, the DMA position has advanced, but not as far.  Let's say 8
bytes.

So, we repeat the loop, and again, we find avail is non-zero.  We
omit sleeping, instead, dropping through to transfer 8 bytes.

Meanwhile, the DMA position has advanced another 8 bytes.

Repeat, endlessly, wasting lots of CPU cycles transferring very small
sets of sample data to the buffer.

That happens because of the requirement for the above code to sleep is
that there has been _no_ advancement of the DMA position while copying
data to the buffer.  Unfortunately, that's not always a realistic
expectation, especially if you have a high data rate.

At no point in the above scenario does avail_min come into it, until
we're lucky enough that we copy data into the buffer without the DMA
position changing.  At that point, we're then allowed to sleep.  The
decision to sleep is based purely upon there being _zero_ bytes of
available buffer space.
