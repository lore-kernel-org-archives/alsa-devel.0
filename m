From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: TWL4030 low-latency
Date: Sat, 15 Oct 2011 15:28:51 -0500
Message-ID: <4E99ED03.30001@gmail.com>
References: <B4E3E481-AEFC-4E2E-A5FA-A63908D8DE12@ccrma.Stanford.EDU>
	<CAPo=G1yzBxH3FL=Y5yqmR+REVawPV7eAdO5jmrxEJ6RRkndgxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E8E6524690
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Oct 2011 22:28:57 +0200 (CEST)
Received: by gyg8 with SMTP id 8so2186314gyg.38
	for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2011 13:28:56 -0700 (PDT)
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
Cc: Edgar Berdahl <eberdahl@ccrma.stanford.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/14/2011 02:45 PM, Ujfalusi, Peter wrote:
>> 1) To get the drivers to run at particularly low latencies (e.g. 20ms), it is necessary to operate the drivers in NON-realtime mode. It would interest me to know whether this means that the realtime functionality of the Beagle Board xM hardware or OS is hampered, or whether the TWL4030 driver is not operating up to specification. (If instead the TWL4030 driver is operating in realtime mode, then Jack stops running when an unrelated low-latency USB-serial device is opened.)
>
> I'm not sure what you mean under realtime/non-realtime. Is it
> something to do with jack?

That's probably what he means.  When you run JACK in "realtime mode", it 
runs the audio thread with SCHED_FIFO (realtime scheduling).

> It is possible that jack does not like if the pcm period interrupt has
> been delayed.

Yes, when running RT... jack will not like this at all.  If the 
interrupt comes too late for the audio cycle, then the whole audio cycle 
is compromised.

> This can hapen due to some driver disables the interrupts for a long
> time, thus delaying the
> DMA interrupt handler, etc.
> Not easy to figure out what is happening.

Edgar, are you guys running a vanilla kernel or an -rt kernel?

>> 2) Some audio software (e.g. Pure Data, ChucK, etc.) will not connect to the TWL4030 ALSA drivers directly, instead they will only start when jack intermediates between the audio software and the TWL4030 ALSA drivers.
>
> No comment.
> I have used mplayer, pulseaudio, ecasound on Beagle without issues.

It's probably some manner of format negotiation that's the problem here. 
  I.e. pd or ChucK is probably asking for an audio format that the 
device doesn't support.  (E.g. they might be asking for F32_LE or an 
unsupported sample rate.)  In contrast "consumer" type apps tend to me 
less picky / more flexible about the sound card format.

>
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
> We place constraint that the ALSA buffer must not be smaller than this, because
> if it is smaller we can end up spinning on the buffer at stream start:
> sDMA will fill up the FIFO, and if the buffer is smaller than the
> FIFO, it will copy
> the buffer several times, or partially. Depending on the size you
> would have chosen.

Hrm, yuck.  Is S32_LE an option?  This may be one way to compensate.

>
> You are requesting 128 frames long period size, which occupy 256 words (I assume
> stereo samples)
> With that period size you will need at least 5 periods to cover the McBSP2 FIFO:
> 1280 / 256 = 5
> It is another question, why jack selects 8 periods, while it could use
> 6, if it likes to
> have even number of periods...
>

No, jack only requires that it be more than 2.  E.g. a lot of usb 
devices require 3.  The suggestion that it should be 8 is probably just 
a best guess on behalf of jack's code.

-gabriel
