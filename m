From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Disabling buffer fill level preprocessing by ALSA
Date: Mon, 7 Jan 2008 19:33:15 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801071916450.22730@tm8103.perex-int.cz>
References: <20071231171226.GA17953@tango.0pointer.de>
	<s5hfxx9ao8b.wl%tiwai@suse.de>
	<20080107160706.GE14386@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B59F2497C
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 19:33:16 +0100 (CET)
In-Reply-To: <20080107160706.GE14386@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Jan 2008, Lennart Poettering wrote:

> On Mon, 07.01.08 12:07, Takashi Iwai (tiwai@suse.de) wrote:
> 
> > > In PulseAudio I want to schedule on my own when I need to write audio
> > > data into the device and when not. To achieve that I want to be
> > > notified via poll() whenever a period boundary is passed (i.e. when an
> > > IRQ happens), but only then. That's different from the usual mode
> > > where you are notified via poll() whether there is space in the
> > > playback buffer that needs to be filled up. 
> > > 
> > > On OSS the mmap() mode enables a mode like I described above. After
> > > enabling mmap() the application can decide by itself what it considers
> > > full and what empty in the dma buffer, and use GETOPTR to query the
> > > playback position. poll() on the OSS fd will directly reflect the
> > > sound card IRQs and is not influenced if you ever wrote data to device
> > > or not.
> > > 
> > > I assume that I can enable a mode like that with one of the SW
> > > params. But quite frankly the docs for it are not enlighening at all.
> > 
> > Set the stop_threshould sw_params to the boundary size.
> > 
> > 	snd_pcm_sw_params_get_boundary(sw_params, &boundary);
> > 	snd_pcm_sw_params_set_stop_threshold(pcm, sw_params, boundary);
> > 
> > then the driver behaves in the "freewheel" mode.  The dmix plugin uses
> > this technique.
> 
> That's not what I was looking for. This will only disable automatic
> stopping on buffer underrun. I am using that already in PA (however I
> pass -1 as stop threshold, which should work, too, shouldn't it?)
> 
> What I am really looking for is a way to disable that ALSA reports via
> poll() the buffer fill level, but instead only reports whether an
> interrupt happened.

Note that you can control fill level using snd_pcm_forward/rewind 
without any R/W calls (of course if supported in whole chain).
ALSA supports only "controlled" I/O not dumb I/O as OSS driver for mmap.

If you look for timing source, use timer API - you may try 
alsa-lib/test/timer.c:

./timer class=3 card=0 device=0 subdevice=0

> The background why I want this is this: As mentioned I am now
> scheduling audio in PA mostly based on system timers. To be able to do
> that I need to be able to translate timespans from the sound card
> clock to the system clock. Which requires me to get the sample time
> from the sound card from time to time and filter it through some code
> that estimates how the sound card clock and the system clock
> deviates. I'd prefer to do that only once or maybe twice everytime the
> playback buffer is fully played, and only shortly after an IRQ
> happened, under the assumption that this is the best time to get the
> most accurate timing information from the sound card.

It's not really necessary. You can use only one timing source (system 
timer) and use position timestamps to do corrections.

But your example does not explain, why you don't move r/w pointer in the 
ring buffer (use mmap_commit), thus why you don't fullfill the avail_min 
requirement for poll wakeup. It seems to me that you're trying to do some 
crazy things with the ring buffer which are not allowed.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
