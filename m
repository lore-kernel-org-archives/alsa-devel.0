From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: snd-usb-audio Buffer Sizes and Round Trip Latency
Date: Mon, 22 Oct 2018 11:40:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1810221112460.1530-100000@iolanthe.rowland.org>
References: <5fb8650f-5a55-d895-f7b3-bc8a3b1af31b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id C1DBD2677D0
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2018 17:40:59 +0200 (CEST)
In-Reply-To: <5fb8650f-5a55-d895-f7b3-bc8a3b1af31b@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jonathan Liu <net147@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 22 Oct 2018, Pierre-Louis Bossart wrote:

> On 10/17/18 7:58 AM, Jonathan Liu wrote:
> > Hi,
> >
> > I want to start a discussion regarding round trip latency for class
> > compliant USB audio interfaces on Linux. In particular, I am noticing
> > with my USB 2.0 RME Babyface Pro audio interface that the round trip
> > latency is considerably higher on Linux than on macOS High Sierra and
> > Windows 10.
> >
> > I tested the round trip latency using a loopback audio cable and the
> > ReaInsert plugin included with Reaper DAW (www.reaper.fm) that can be
> > downloaded for Windows/macOS/Linux to calculate the additional delay.
> >
> > Here are the results for 48000 Hz, 24-bit on my RME Babyface Pro:
> > ===
> > block_size/periods block_size*periods + additional_delay ~ round_trip_latency
> > round_trip_latency = (block_size*periods + additional_delay) / 48000 * 1000

I'm with Pierre-Louis on this; I can't make heads or tails out of these 
formulas.

To begin with, I'm accustomed to talking about frames, periods, and 
buffers.  What are "block"s?  Are they the same as buffers?

What do these formulas mean?  Is the first supposed to be a definition 
of round_trip_latency?  If it isn't, then how do you define or measure 
round_trip_latency?

What is additional_delay?  How is it measured or calculated?

> > Linux 4.17.14, Class Compliant Mode (snd-usb-audio, ALSA backend):
> > 16/2 32 + 80 ~ 2.333 ms

What are these numbers?  Are these lines supposed to in the format
expressed by the first formula above?  If they are, how come
"block_size/periods" shows up as a pair of numbers "16/2" but
"block_size*periods" shows up as a single number "32"?

> > 16/3 48 + 109 ~ 3.271 ms
> > 32/2 64 + 129 ~ 4.021 ms
> > 32/3 96 + 166 ~ 5.458 ms
> > 64/2 128 + 205 ~ 6.938 ms
> > 64/3 192 + 242 ~ 9.042 ms
> > 128/2 256 + 352 ~ 12.667 ms
> > 128/3 384 + 496 ~ 18.334 ms
> > 256/2 512 + 650 ~ 24.208 ms
> > 256/3 768 + 650 ~ 29.542 ms
> > 512/2 1024 + 634 ~ 34.542 ms
> > 512/3 1536 + 634 ~ 45.208 ms
> > 1024/2 2048 + 650 ~ 56.208 ms
> > 1024/3 3072 + 650 ~ 77.542 ms
> > 2048/2 4096 + 633 ~ 98.521 ms
> > 2048/3 6144 + 633 ~ 141.188 ms
> >
> > macOS High Sierra, Class Compliant Mode (Apple Driver):
> > 16/2 32 + 205 ~ 4.938 ms
> > 32/2 64 + 205 ~ 5.604 ms
> > 64/2 128 + 205 ~ 6.938 ms
> > 128/2 256 + 205 ~ 9.604 ms
> > 256/2 512 + 205 ~ 14.938 ms
> > 512/2 1024 + 205 ~ 25.604 ms
> > 1024/2 2048 + 205 ~ 46.938 ms
> > 2048/2 4096 + 205 ~ 89.604 ms

What are the USB parameters for these tests?  How many bytes/frame?  
What is the endpoint's maxpacket size?  What is the speed of the USB 
bus?

> I couldn't figure out how to analyze your data, not sure what the extra 
> delays mean nor how you conclude that Linux is worse than MacOS or 
> Windows10 for small buffers?
> 
> At any rate, I looked into this some time back but had to put the work 
> on the back burner due to other priorities. What I do remember is that 
> there is a built-in latency due to the fact that on playback the driver 
> submits a number of zero-filled URBs and will only add valid audio data 
> when the first URB is retired, which means you get a constant startup 
> latency you will never be able to catch up.

In theory the number of zero-filled URBs could be reduced, maybe even 
eliminated.

> I also vaguely remember that at some point the buffer/period sizes don't 
> matter, each period will be broken up in a series of URBs and hence you 
> will have more wake-ups than what is configured by the period size. In 
> short I would look into the way the data is spread on multiple URBs and 
> check how latency is impacted by the software design.

Agreed.

> the last thing I have in mind is that for latency analysis and 
> comparisons, using simple devices make sense. Latency can be affected by 
> extra processing that might be enabled in the USB device depending on 
> user configurations or parameters. Ideally to focus on the ALSA/xHCI 
> interaction/latency we'd want to look at really dumb devices with just 
> an input and output terminal and no processing.
> 
> -Pierre
> 
> >
> > macOS High Sierra, PC Mode (RME Driver v3.08):
> > 16/2 32 + 59 ~ 1.896 ms
> > 32/2 64 + 59 ~ 2.563 ms
> > 64/2 128 + 59 ~ 3.896 ms
> > 128/2 256 + 59 ~ 6.563 ms
> > 256/2 512 + 59 ~ 11.596 ms
> > 512/2 1024 + 59 ~ 22.563 ms
> > 1024/2 2048 + 59 ~ 43.896 ms
> > 2048/2 4096 + 59 ~ 86.563 ms
> >
> > Windows 10, PC Mode (RME Driver 1.099):
> > 48/2 96 + 63 ~ 3.313 ms
> > 64/2 128 + 63 ~ 3.979 ms
> > 96/2 192 + 63 ~ 5.313 ms
> > 128/2 256 + 63 ~ 6.646 ms
> > 256/2 512 + 63 ~ 11.979 ms
> > 512/2 1024 + 63 ~ 22.646 ms
> > 1024/2 2048 + 63 ~ 43.979 ms
> > 2048/2 4096 + 63 ~ 86.646 ms
> > ===
> >
> > Some things in particular I noticed on Linux:
> > - additional_delay varies a bit if I close and open the audio device again
> > - additional_delay seems to increase as the block_size increases. I
> > can make the additional_delay stay about the same rather than
> > increasing by setting MAX_PACKS and MAX_PACKS_HS to 1 in
> > sound/usb/card.h. In Linux versions before 3.13 there was a nrpacks
> > parameter for snd-usb-audio to control this but it was removed with
> > commit https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v3.13&id=976b6c064a957445eb0573b270f2d0282630e9b9
> > - additional_delay is not constant as block_size is increased like on
> > macOS and Windows

Perhaps this additional_delay is caused by the zero-filled URBs 
mentioned earlier.

We can't say anything about the effect of setting MAX_PACKS to 1 
without knowing how the driver is currently fitting packets into frames 
and URBs.  In any case, you should be able to reduce the number of 
packets in each URB simply by reducing the period size, since the 
driver strives to keep each URB not much larger than a period (as I 
recall -- it's been a long time since I worked on this (2013)).

> > I made a patch to snd-usb-audio to expose the snd-usb-audio constants
> > as runtime adjustable module parameters
> > (/sys/module/snd_usb_audio/parameters/) for testing (takes effect when
> > the device is disconnected+reconnected and logs the parameter values
> > to dmesg):
> > https://aur.archlinux.org/cgit/aur.git/plain/parameters.patch?h=snd-usb-audio-lowlatency-dkms
> >
> > The patch is used in my Arch Linux AUR package for convenience (using
> > DKMS to avoid having to recompile entire kernel):
> > https://aur.archlinux.org/packages/snd-usb-audio-lowlatency-dkms/
> >
> > Can snd-usb-audio be improved so the additional_delay is always the
> > same when closing/opening/reconfiguring the audio device and does not
> > increase as the block_size increases?
> >
> > I noticed using USB audio on Linux at lower latencies (block_size <=
> > 128) is more prone to audio dropouts under load compared to macOS and
> > Windows, even with CPU power management disabled (writing 0 to
> > /dev/cpu_dma_latency). What can be done about this?

You can reduce the CPU load.  :-)

Seriously, how can you compare loads between different operating 
systems?

Also, note the Linux's scheduler has a number of adjustable parameters, 
which I am not familiar with.

Alan Stern
