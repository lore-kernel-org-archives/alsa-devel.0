From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Disabling buffer fill level preprocessing by ALSA
Date: Mon, 7 Jan 2008 17:07:06 +0100
Message-ID: <20080107160706.GE14386@tango.0pointer.de>
References: <20071231171226.GA17953@tango.0pointer.de>
	<s5hfxx9ao8b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id E399024348
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 17:07:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfxx9ao8b.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 07.01.08 12:07, Takashi Iwai (tiwai@suse.de) wrote:

> > In PulseAudio I want to schedule on my own when I need to write audio
> > data into the device and when not. To achieve that I want to be
> > notified via poll() whenever a period boundary is passed (i.e. when an
> > IRQ happens), but only then. That's different from the usual mode
> > where you are notified via poll() whether there is space in the
> > playback buffer that needs to be filled up. 
> > 
> > On OSS the mmap() mode enables a mode like I described above. After
> > enabling mmap() the application can decide by itself what it considers
> > full and what empty in the dma buffer, and use GETOPTR to query the
> > playback position. poll() on the OSS fd will directly reflect the
> > sound card IRQs and is not influenced if you ever wrote data to device
> > or not.
> > 
> > I assume that I can enable a mode like that with one of the SW
> > params. But quite frankly the docs for it are not enlighening at all.
> 
> Set the stop_threshould sw_params to the boundary size.
> 
> 	snd_pcm_sw_params_get_boundary(sw_params, &boundary);
> 	snd_pcm_sw_params_set_stop_threshold(pcm, sw_params, boundary);
> 
> then the driver behaves in the "freewheel" mode.  The dmix plugin uses
> this technique.

That's not what I was looking for. This will only disable automatic
stopping on buffer underrun. I am using that already in PA (however I
pass -1 as stop threshold, which should work, too, shouldn't it?)

What I am really looking for is a way to disable that ALSA reports via
poll() the buffer fill level, but instead only reports whether an
interrupt happened.

In default ALSA mode, if poll() tells us that the ALSA device is
ready, and we don't subsequently write any data to it, the next poll()
will immediately return, still telling us the device is ready. As long
as we don't write anything to the audio device and we call poll() we
will be stuck in a busy loop. Basically, some kind of _write() acts as
reset the ready state of the ALSA device.

In contrast to that on OSS+mmap the poll() call itself will already
reset the ready state. I.e. if you poll() and then poll() again --
without any intermediate write to the device, it will wait for the
next IRQ to happen, and we would not enter a busy loop if we did this
repeatedly. I am looking for a way to do something like this on ALSA,
too.

An example:

int main() {
  fd = open("/dev/dsp", ...);
  /* 
    add some code here to enter mmap mode 
  */
 
  for (;;) {
    struct pollfd pfd = { .fd = fd, events = POLLIN };
    poll(&pfd, 1, -1);
    printf("IRQ!\n");
  }
}

On OSS a program like this would print "IRQ" every time a sound card
interrupt is triggered - but not more often.

A similar program in ALSA mmap mode would behave differently:

int main() {
  snd_pcm_open(&pcm, ...);

  /* 
    add some code here to enter mmap mode 
  */

  for (;;) {
    struct pollfd pfds[...];
    snd_pcm_poll_descriptors(pcm, pfs, ...);
    poll(pfds, ..., -1);
    snd_pcm_poll_descriptors_revents(pcm, pfs, ..., &revents);
    printf("Eating CPU");
  }
}

This application would eat 100% CPU. What I am looking for is a way to
make ALSA behave more like OSS in this case. Some mode I can enable to
disable the management in ALSA that decides if a playback buffer is
full or empty.

This is completely unrelated to start/stop thresolds.

The background why I want this is this: As mentioned I am now
scheduling audio in PA mostly based on system timers. To be able to do
that I need to be able to translate timespans from the sound card
clock to the system clock. Which requires me to get the sample time
from the sound card from time to time and filter it through some code
that estimates how the sound card clock and the system clock
deviates. I'd prefer to do that only once or maybe twice everytime the
playback buffer is fully played, and only shortly after an IRQ
happened, under the assumption that this is the best time to get the
most accurate timing information from the sound card.

Is there any way to enable a mode like that on ALSA?

Right now I chose to completely disable that ALSA informs me about
ready states via poll(). To achieve that I called
snd_pcm_sw_params_set_avail_min() with INT_MAX. THis seems to work,
but the system still gets 2 interrupts per buffer loop, but my program
cannot really make any use of them anymore.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
