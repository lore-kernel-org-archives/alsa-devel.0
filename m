From: Edgar Berdahl <eberdahl@ccrma.Stanford.EDU>
Subject: Re: TWL4030 low-latency
Date: Sun, 16 Oct 2011 18:39:01 -0700
Message-ID: <7C8103E9-A683-4FCA-9E55-9D81A3CA3439@ccrma.Stanford.EDU>
References: <B4E3E481-AEFC-4E2E-A5FA-A63908D8DE12@ccrma.Stanford.EDU>
	<CAPo=G1yzBxH3FL=Y5yqmR+REVawPV7eAdO5jmrxEJ6RRkndgxg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-roam.stanford.edu (smtp-roam2.Stanford.EDU [171.67.219.89])
	by alsa0.perex.cz (Postfix) with ESMTP id B8CAE24517
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 03:39:07 +0200 (CEST)
In-Reply-To: <CAPo=G1yzBxH3FL=Y5yqmR+REVawPV7eAdO5jmrxEJ6RRkndgxg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Peter,

On Oct 14, 2011, at 12:45 PM, Ujfalusi, Peter wrote:
> As the first question: what is the kernel versions in these distros?
> Just one clarification: the twl4030 driver itself is passive during
> audio activity - we set it up,
> and let it run. It needs no interaction.
> omap-pcm, and omap-mcbsp is "running" during audio.
> McBSP feeds the audio via I2S bus to twl4030, sDMA takes care of the samples
> coming/going to SDRAM.
Thanks for clarifying that!


>> 1) To get the drivers to run at particularly low latencies (e.g. 20ms), it is necessary to operate the drivers in NON-realtime mode. It would interest me to know whether this means that the realtime functionality of the Beagle Board xM hardware or OS is hampered, or whether the TWL4030 driver is not operating up to specification. (If instead the TWL4030 driver is operating in realtime mode, then Jack stops running when an unrelated low-latency USB-serial device is opened.)
> I'm not sure what you mean under realtime/non-realtime. Is it
> something to do with jack?
> It is possible that jack does not like if the pcm period interrupt has
> been delayed.
> This can hapen due to some driver disables the interrupts for a long
> time, thus delaying the
> DMA interrupt handler, etc.
> Not easy to figure out what is happening.
I'm just starting to get experience with embedded linux systems. I assume that since they have less computational power, interrupt processing could use up a larger percentage of that CPU power on average.


>> 2) Some audio software (e.g. Pure Data, ChucK, etc.) will not connect to the TWL4030 ALSA drivers directly, instead they will only start when jack intermediates between the audio software and the TWL4030 ALSA drivers.
> No comment.
> I have used mplayer, pulseaudio, ecasound on Beagle without issues.
Yes, as far as I know these programs work great! Audio latency is probably less of a concern for them.


>> 3) In some situations, the TWL4030 drivers appear not to start using the requested settings. For example, when we start jack requesting two periods per buffer, it is apparently getting initialized at eight periods per buffer, see the final lines below:
>> Calling
>> $ jackd -r -dalsa -dhw:0 -p128 -n2 -i2 -o2 -s -S -r
>> on the Beagle under Ubuntu 10.10 and Angstrom demo image results in the following
>> 
>> jackd 0.118.0
>> Copyright 2001-2009 Paul Davis, Stephane Letz, Jack O'Quinn, Torben Hohn and ot.
>> jackd comes with ABSOLUTELY NO WARRANTY
>> This is free software, and you are welcome to redistribute it
>> under certain conditions; see the file COPYING for details
>> 
>> JACK compiled with System V SHM support.
>> loading driver ..
>> apparent rate = 44100
>> creating alsa driver ... hw:0|hw:0|128|2|44100|2|2|nomon|swmeter|soft-mode|16bit
>> control device hw:0
>> configuring for 44100Hz, period = 128 frames (2.9 ms), buffer = 2 periods
>> ALSA: final selected sample format for capture: 16bit little-endian
>> ALSA: use **8** periods for capture
>> ALSA: final selected sample format for playback: 16bit little-endian
>> ALSA: use **8** periods for playback
> 
> I think I can explain this:
> McBSP2 has 1280 word long buffer.
Wow, that is a long buffer! There is no way to reduce the buffer size?

> We place constraint that the ALSA buffer must not be smaller than this, because
> if it is smaller we can end up spinning on the buffer at stream start:
> sDMA will fill up the FIFO, and if the buffer is smaller than the
> FIFO, it will copy
> the buffer several times, or partially. Depending on the size you
> would have chosen.
> 
> You are requesting 128 frames long period size, which occupy 256 words (I assume
> stereo samples)
> With that period size you will need at least 5 periods to cover the McBSP2 FIFO:
> 1280 / 256 = 5
> It is another question, why jack selects 8 periods, while it could use
> 6, if it likes to
> have even number of periods...
I bet this is where a lot of the latency comes from!

Best,
Edgar

PS. We have tried several USB audio interfaces with the Beagle, with varying degrees of success. For one of them, I put it on a scope just to check that the Beagle could actually go as low as 6ms of input-output audio latency (Guitar Link UCG102), with a USB audio interface. For that interface, the Pure Data software was able to open the audio interface directly using ALSA.
