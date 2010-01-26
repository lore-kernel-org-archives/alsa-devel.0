From: Tobias Schneider <tobsnyder@gmx.de>
Subject: Re: overrun in second capture device after stopping
 first capture device
Date: Tue, 26 Jan 2010 15:23:03 +0100
Message-ID: <4B5EFAC7.6050402@gmx.de>
References: <4B584B38.9030000@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 4C95B103844
	for <Alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 15:23:05 +0100 (CET)
In-Reply-To: <4B584B38.9030000@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobias Schneider <tobsnyder@gmx.de>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

After searching a lot concerning underrun and xrun, I am still not satisfied
with the results, meaning I still have those problems. I figured out 
that increasing
buffer_size will reduce overruns. First I used 3*1284 byte, now with 
12*1284 byte
(each period_size is 1284 byte) the overruns occur only very very 
seldom...but a
buffer_size of 15408 Byte is very big, isn't it? I guess it also 
introduces more latency...


As it seems that there are a lot of new ALSA driver developers encountering
such a problem, I thought it might be a good idea to collect as many as 
possible
information related to this issue.

Please feel free to add / correct the following "FAQ". I will also keep 
track of
it and if it seems to satisfy most requests I would prefer adding a wiki 
page...


So what I have found about the underrun / overrun issue:

################################################################################
#01 What means underrun and overrun?
------------------------------------
Underrun means that you are playing audio and the device runs out of 
frames to
play. That means the hardware buffer is empty.
Overrun means you are recording audio, and the device runs out of buffer 
space
to put the audio.
 
(from 
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg22803.html)

An "xrun" can be either a buffer underrun or a buffer overrun. In both 
cases an
audio app was either not fast enough to deliver data to the ALSA audio 
buffer or
not fast enough to process data from the ALSA audio buffer. Usually 
xruns are
audible as crackles or pops.

(from http://alsa.opensrc.org/index.php/Xruns)

Underrun means that the driver is consuming data more quickly than aplay
is able to provide it. This may mean that there's some system
performance problem or it may be due to your driver is consuming data
more quickly than it should and causing problems further up the stack.

(from http://thread.gmane.org/gmane.linux.alsa.devel/65035/focus=65147)

################################################################################
#02 Where is a buffer underrun or overrun detected?
---------------------------------------------------
XRUN will be reported in either of these functions

static inline int snd_pcm_update_hw_ptr_interrupt(struct
snd_pcm_substream *substream)

...
pos = substream->ops->pointer(substream);
    if (pos == SNDRV_PCM_POS_XRUN)
    xrun(substream);
        return -EPIPE;
...

or

static inline int snd_pcm_update_hw_ptr_post(struct snd_pcm_substream
*substream, struct snd_pcm_runtime *runtime)

...
if (avail >= runtime->stop_threshold) {
        if (substream->runtime->status->state == SNDRV_PCM_STATE_DRAINING)
            snd_pcm_drain_done(substream);
        else
            xrun(substream);
        return -EPIPE;
...

All these functions are in sound/core/pcm_lib.c

* PCM is automatically stopped in #SND_PCM_STATE_XRUN state when available
  frames is >= stop_threshold. If the stop_threshold is equal to 
boundary (also
  software parameter - sw_param) then automatic stop will be disabled
  (thus device will do the endless loop in the ring buffer).

STATES concerning XRUN:
  SND_PCM_STATE_XRUN
  SNDRV_PCM_STATE_XRUN
  SNDRV_PCM_POS_XRUN

Another description says, that an XRUN is detected if hw_ptr > appl_ptr.

################################################################################
#03 What means the xrun duration, how is it calculated?
--------------------------------------------------------------------------------
In aplay.c the duration of underrun or overrun is calculated via the 
trigger
tstamp and current time value:

    struct timeval now, diff, tstamp;
        gettimeofday(&now, 0);
        snd_pcm_status_get_trigger_tstamp(status, &tstamp);
        timersub(&now, &tstamp, &diff);
        fprintf(stderr, _("%s!!! (at least %.3f ms long)\n"),
            stream == SND_PCM_STREAM_PLAYBACK ? _("underrun") : 
_("overrun"),
            diff.tv_sec * 1000 + diff.tv_usec / 1000.0);

################################################################################
#04 What causes such a buffer underrun or overrun?
--------------------------------------------------------------------------------
There are various possibilities that can generate a xrun:

underrun:
  - The source is not able to deliver data as fast as it is required to
    - e.g. host system is busy, filesystem is busy, sheduling problem...
    - disk overload
  - the buffer DMA isn't properly updated or set up
  - the calculation of the current pointer doesn't match with the actual 
position
    - check return of pcm_pointer callback
  - the buffer and period setup is somehow weird
    - for example, it's set to very small period or buffer size, which can
      easily result in buffer underrun.

(from http://thread.gmane.org/gmane.linux.alsa.devel/55038
      http://thread.gmane.org/gmane.linux.alsa.devel/58921/focus=58922
      http://thread.gmane.org/gmane.linux.alsa.devel/58955/focus=58958)


Another hint:

Look at the order of measured (least) latency in both cases.
You case is almost 1 second delay while the previous one is less
than 1 ms.  Thus, in your case, it's either really a system latency
such as disk overload or that the buffer DMA isn't properly updated or
set up.

In the previous case, less than 1 ms latency, it implies that the
buffer and period setup is somehow weird.  For example, it's set to
the very small period or buffer size, which can easily result in
buffer underrun.  Check the hw_params constraints and snd_pcm_hardware
setting.


################################################################################
#05 What should be the return of pcm_pointer callback?
--------------------------------------------------------------------------------
The pointer callback is supposed to give the currently played position
offset in a ring buffer, and ranged from 0 to buffer_size-1.
When the first snd_pcm_period_elapsed() is called, it should be
(ideally) pointing at period_size, at the succeeding calls,
period_size*2, period_size*3, then 0 again (if buffer_size = 4*period_size).

Try to track the value returned from the pointer callback.

(from http://thread.gmane.org/gmane.linux.alsa.devel/65035/focus=65147)

The pointer callback reports the sane position as the current position;
not below the previous position and not above the next period boundary.

(from http://thread.gmane.org/gmane.linux.alsa.devel/61280/focus=62055)

pcm_pointer: This value and the timing of snd_pcm_period_elapsed() is 
the only
information the PCM core checks.

The ALSA PCM core just relies upon two things from the lowlevel driver:

1. The lowlevel driver calls snd_pcm_period_elapsed() at each time
   when the set-up period size has been processed by the hardware.
2. The pointer callback reports the sane position as the current
   position; not below the previous position and not above the next
   period boundary.

(from http://thread.gmane.org/gmane.linux.alsa.devel/61280/focus=62055)

################################################################################
#06 When is substream->dma_area used for playback or capture?
--------------------------------------------------------------------------------
 When is substream->dma_area used for capture or playback? (probably 
never, as
 snd_pcm_lib_malloc_pages() seems to imply that one should only use
 substream->runtime->dma_area)

It's used when the data is copied via copy_from/to_user(), or when the
buffer is mmapped.

Please note that you don't need this always. If you define copy and
silence callbacks, and if they don't handle any dma buffer on the cpu
side (e.g. buffers on a card), then you don't need this.
In such a case, mmap cannot be used.
