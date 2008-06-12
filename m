From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Thu, 12 Jun 2008 22:52:25 +0200
Message-ID: <20080612205225.GB20818@tango.0pointer.de>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 85F8D24A82
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jun 2008 22:52:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1w333o7r.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 11.06.08 18:56, Takashi Iwai (tiwai@suse.de) wrote:

> > could you please explain what exactly snd_pcm_delay() returns? 
> > 
> > Some applications (such as WINE) assume it is the time that would pass
> > until we reach an underrun if we would stop writing any further data
> > to the PCM device.
> > 
> > Other applications (such as most media players) use it for time
> > synchronisation. i.e. assume that it is the time that passes until a
> > sample I write to a PCM device now would take to be played.
> 
> As James already pointed, the correct answer is the latter.
> In the driver implementation level, snd_pcm_delay() simply returns the
> difference between appl_ptr and hw_ptr.  It means how many samples are
> ahead on the buffer from the point currently being played.
> 
> However, if you stop feeding samples now, snd_pcm_delay() returns the
> least time XRUN occurs.  So the first understanding isn't 100% wrong.

uh? I think we have a misunderstanding here. What you are explaining
here would suggest that the first answer is the right one, but you
actually claim it is the second one? This doesn't make sense to me.

As far as I understood the "hw_ptr" is the index where the PCM data is
*read* from the playback buffer, While "appl_ptr" is where the data is
*written* to the playback buffer. Right?

In the USB audio case, the playback buffer is in normal memory, right?
Every now and then a bit of it is dma'd to the usb controller and sent
over the USB wire, then on the receiving side it is buffered again and
then passed to the DAC. Correct? The hw_ptr in this case is the
pointer into the system memory buffer where the data will be read from
next and sent to the usb wire. However, since the data is not dma'd
sample-by-sample but in a block at a time, the sample that is
currently hearable is still quite a bit before this index. Right? And
hence would snd_pcm_delay() when always defined as "appl_ptr - hw_ptr"
not really be suitable for synchronization because the hw_ptr is
always a bit ahead of what is actually being played -- and WINE's
interpretation would be right and the media player's (and mine)
wrong. In contrast to what James and you just said.

Or again, in other words: is the delay that is caused by the fact that
after the data is read from the DMA buffer it still has quite a
bit time to travel to the speakers included in snd_pcm_delay(), or is
it not?

In the USB case this extra time might be small. However, using PA as
backend for libasound is surprisingly similar to the USB case: we
maintain a buffer in memory, and PA reads from that, mixes it, does
some other things with it. The time the data still has to travel after
it was read from the playback buffer is much longer than for the USB
case. The WINE people and I now disagree if the extra delay should be
included in snd_pcm_delay() or not. I say, yes, absolutely,
snd_pcm_delay() is for synchronization, not for calculating when the
next xrun is going to happen. The WINE people say no, it's right the
other way. You now claim the first but explain it like the latter was
true.

> > However, the USB audio driver actually seems to return the total time
> > delay as it is useful for synchronization, so follows what media
> > players expect. (i.e. take the extra time into account)
> 
> The implementation of snd_pcm_delay() (at least in the driver level)
> purely depends on the accuracy of PCM pointer callback of each
> driver.  So, if the driver returns more accurate hw_ptr via pointer
> callback, you'll get more accurate value of snd_pcm_delay().  In the
> worst case, it may be bigger up to one period size than the real
> delay.

Yes, but the question is whether hw_ptr is actually that useful for
synchronization at all, if there is still some latency *after* the
data was read from the playback buffer.

Is it clear now, what I actually try to explain here? This sure is
tricky stuff, I am not sure how I should explain better what I
mean. Please ask for clarifications if I am not clear enough with
what I try to point out!

You didn't respond to my suggesion to add a second function, so that
we'd have two: one that includes the extra delay after hw_ptr, and the
other that does not. The former would then be useful for audio/video
sync, the latter for estimating when an underrun will happen. Would it
be possible to add this?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
