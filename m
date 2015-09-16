From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH BAT V1 0/7] BAT: Add Basic Audio Tester
 command line tool
Date: Wed, 16 Sep 2015 09:43:12 -0700
Message-ID: <CAG5mAdzt-zYX7mp5Nhnmdr_874KhtoRdBMXSmG1JkMvTTB54rA@mail.gmail.com>
References: <cover.1442298607.git.han.lu@intel.com>
 <CAG5mAdwkSn4975waeUrpp6Bm5yBk2217Oa6+gQH-=toLu7OMxQ@mail.gmail.com>
 <1442403626.10528.50.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f179.google.com (mail-yk0-f179.google.com
 [209.85.160.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 321432616EF
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 18:43:33 +0200 (CEST)
Received: by ykdt18 with SMTP id t18so204664741ykd.3
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 09:43:32 -0700 (PDT)
In-Reply-To: <1442403626.10528.50.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, han.lu@intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, bernard.gautier@intel.com
List-Id: alsa-devel@alsa-project.org

;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

>> So, the test is pretty simple:  Set up a hardware  (digital) loopback
>> between output and input.  Then send out a 'ramp', i.e. just keep a
>> counter that increments each frame, and send out the counter value out
>> to the audio port and watch the values that come back.  In our work
>> it's quite important that every sample come back bit-perfect with no
>> samples added or dropped.
>>
>> Once this test is up and running, you then bang on the system to
>> ensure the audio stream doesn't break even under heavy load.
>>
>>
>> The benefit of the ramp test is that it's a 100% bit-perfect test.
> But this would be a good test to add into BAT too :) There are many DSPs
> and codecs that can do digital loopback so we should look at adding this
> to BAT too.

Yep, many don't as well.  In those cases we recommend that there is a
resistor stuffing option on the PCB to allow for digital loopback.

>
> We also have some plans for testing gain changes and channel mappings.
> Fwiw, during our testing it did pick up some driver bugs with incorrect
> BIAS setting (signal went to DC after 10 hours of testing)

Ah Ha!  So I'm not crazy asking our customers to run for days!  :-)  I
knew there was good reason for that.

> We have also used BAT for stress testing audio over D0 -> D3 -> D0 transitions.

Sorry, I'm not familiar with that terminology.  Are those the
different power states?

>
>> What kind of failure modes do we see in linux?    Do all failures end
>> up with underrun or overrun, or are there more subtle errors, like
>> frames lost or gained without the software knowing about it?  Or
>> perhaps whole blocks that get duplicated or deleted?
>>
>> i.e. is the user level always notified of an error?
>>
>
> No, not for every error. Userspace usually does not know about FIFO
> underruns/overrruns. It does know about DMA overrruns/underruns though.
> Userspace mainly has some difficulty with errors caused in the analog
> domain.


So, it sounds to me like there are definitely several tests that would
be useful, both for digital loopback testing and analog loopback
testing.

Since we run microphone arrays, it's imperative that all the ADC
channels are perfectly time-aligned.  It's definitely non-trivial to
do that on some codecs, and impossible on others.  It's definitely not
good enough to just 'start the codecs at the same time' because that's
not well defined on some codecs.

Here are some of the tests I can think of:

Digital Loopback
---------------------------------
Setup:  Either configure the serial port or PCB for digital loopback
        form out->in.

Test:  Ramp test.   This will do bit-perfect, very simple, very
reliable test that when passed will guarantee:
* No samples lost/added/duplicated.
* Show latency from out -> in.  This should be the SAME latency at
  every startup under all load conditions.
* This is essentially the gold standard test for Linux+Driver+serial
  port configuration.
* Does not test codec startup/phase alignment.

Analog Loopback
--------------------------------
Setup: Loop back one output to all inputs (up to 32 on my board!) in
the analog domain.

Test:  Impulse response.  There are many ways to measure impulse
       responses.  I can help with this :-)  It's something I do quite
       often.
The impulse response test will let us gather:
   * Frequency response of analog system, and compare channel-to-channel
     component matching.
   * Phase response of the analog system, which will let us see any
     component matching issues, but more importantly, codec
startup/phase issues.
   * Can also show latency from out->in
   * does test codec phase alignment

Test: Time domain testy thingy.
   * This is one that we don't normally do because its not needed if you
     do the digital ramp test, but would be useful for finding
     single/few sample defects in systems that can't do digital
     loopback.
   * Run a sine wave out
   * use a (software) PLL to lock on to the received sine wave.  This
     PLL will lock on to frequency, phase, and magnitude (essentially
     a 2 tap adaptive phasor).  Then you simply use the PLL output
     to subtract from the input signal, and you should end up with no
     signal, but just noise.  If you get any pops or samples higher
     than the expected noise floor, then you know you have a problem.
   * Definitely an imperfect test, especially if the Fs/2 is much
     higher than the analog bandwidth. (i.e. 20kHz analog bandwidth,
     but 96kHz sampling), but it's not terrible.


If you're unfamiliar with the codec time alignment problem, the issue
is that codecs don't use the WCLK as the sample-time source, but
rather some number of MCLKs from when they turn on.  In my system I
have to turn on and configure up to 16 stereo codecs, but if MCLK is
running during configuration, there is literally no way to get all the
codecs to start at once because they are turned on via I2C.  So, on
the TLV320AIC3x series of parts the way to do it is:  Make sure MCLK
is turned off, then configure and enable all the codecs.  Then, and
only then, do you turn the MCLK clock on.  That way all codecs start
in synchrony and are cycle-locked together.

If you wish to use a PLL on the AIC3x, the problem gets even trickier
-- you can't use the PLL for multiple codecs unless you run the source
clock in on GPIO2, and the PLL output (MCLK) out on GPIO1, then to all
the codecs in the system (include the PLL).  It takes a bit of time
staring at the datasheet to work that out :-/

On the CS53L30 (4 channel ADC), there is a dedicated signal to
synchronize multiple codec chips, so the startup is much easier, but
still requires thought.

I've seen at least one codec with 3 stereo ADCs on-chip with literally
no way to synchronize them.  The vendor's response was... "use another
part".  Unfortunately, I can't remember which part it was that had the
problem.  Just beware if you're doing multi-channel arrays!

Anyway, in summary, the tests I'm thinking of are:
* Ramp test:  the gold standard for driver/SoC testing.
* Impulse response test:  the gold standard for phase/alignment
  issues.
* Time domain testy thingy:  a less good ramp test if you can't manage
  digital loopback in your system.

In addition, maybe there should be a 'load' parameter in the test tool
to add system load until things start breaking.

I wonder, will these tests capture all failure modes?

-Caleb
