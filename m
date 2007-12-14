From: Dave Dillow <dave@thedillows.org>
Subject: Re: speaker-test stalls
Date: Fri, 14 Dec 2007 12:40:04 -0500
Message-ID: <20071214174004.GA2592@thedillows.org>
References: <1197147520.3588.38.camel@obelisk.thedillows.org>
	<s5hwsrhe152.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 60FF4103840
	for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2007 18:40:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwsrhe152.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Fernando Papa <fpapa@adinet.com.uy>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 14, 2007 at 04:39:37PM +0100, Takashi Iwai wrote:
> At Sat, 08 Dec 2007 15:58:40 -0500,
> Dave Dillow wrote:
> > 
> > While working with Fernando to get the sis7019 driver working in his
> > buildroot setup, we kept running into a lockup of the PCM stream when
> > using speaker-test. aplay was fine, as was other I finally tracked it
> > down to a combination of uclibc not doing block reads, which led to
> > XRUNs, and what I thought was issue in snd_pcm_lib_write1() when trying
> > to fill up the tail of the PCM buffer with a large write, when there was
> > an intervening small write.
> > 
> > As it turns out, the lockup problem may simply be in speaker-write's
> > sw_params settings -- it calls snd_pcm_sw_params_set_avail_min() to set
> > the minium write to the period size, and
> > snd_pcm_sw_params_set_start_threshold() to start once the buffer has
> > been filled. This doesn't account for odd wave file lengths and XRUNs.
> > 
> > The problem arises when the wave data is not a multiple of the period
> > size, and you get an XRUN when there is less than buffer_size samples
> > remaining in the current loop. 
> 
> Hm, it sounds weird.  Basically XRUN means that you have *no* data in
> the buffer while the stream is running.  So, when you get XRUN, the
> data must be empty, no matter which buffer or period size is.

Right, the buffer empties, and then the loop in speaker-test::write_buffer()
starts filling the buffer again, as expected.

However, the sample data in the wave file is not a multiple of the buffer
size, so it does a small write (ie, not period sized) to finish out the file,
and the main routine calls back in to do the next loop.

So, you get a pattern (buffer_size is 32768):

write len	buffer available before write
XRUN happens	N/A
8192		32768
8192		24576
5506		16384
8192		10878
8192		2686

Because speaker-test sets avail_min to 8192, and the start threshold to
32768, snd_pcm_lib_write1() will loop forever waiting for 8192 bytes to
become available in the buffer. That will never happen, because the XRUN
stopped the channel, and we cannot reach the start threshold, as this last
write that would do it is the one that blocked.

> Anyway, could you get the same effect with another driver,
> e.g. snd-dummy?  If it can be easily reproduced, it'll be much easier
> to track down...

It won't be easy, as the problem is only present when there is an XRUN
in the last 32k (or whatever buffer size is chosen for the hardware)
of the input wave file.

I can code up an example if need be, but I've already highlighted the
cause --

1) stopped stream
2) start_threshold = buffer_size
3) min_avail = period_size (or more genericaly, > 1)
4) a write pattern that causes there to be less than min_avail room in the
	buffer for a write

The stream will never start.

Does that make sense, or would it help to code up a example?

Now, this may be desired behaviour from the kernel, and it is just a bug
in speaker-test's handling of XRUNs. That's fine, I just wanted to highlight
it.

> > Assuming that this is desired behavior from the kernel side, then I see
> > three options to fix this in speaker-test:
> > 1) snd_pcm_sw_params_set_avail_min() to 1 sample
> > 2) snd_pcm_sw_params_set_start_threshold() to start when (nperiods - 1)
> > are ready (or be even more aggressive)
> > 3) call snd_pcm_drain() at the end of each loop to clear out the buffer.
> > This won't help if the wave file has fewer samples than the buffer size.
> > 
> > Options 1 or 2 seem to be best.
