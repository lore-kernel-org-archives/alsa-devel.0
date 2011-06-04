From: Caleb Crome <caleb@crome.org>
Subject: Re: AudioArduino - an ALSA soundcard driver for
	FTDI-based Arduinos
Date: Fri, 3 Jun 2011 17:34:31 -0700
Message-ID: <BANLkTimwNeO0nbbkbruM5AbH1X70J52h-g@mail.gmail.com>
References: <4DE31FE4.4040807@imi.aau.dk> <20110530074204.GA7806@kroah.com>
	<4DE3B7B4.8000805@imi.aau.dk> <20110603053728.GA20937@kroah.com>
	<4DE9266D.70503@imi.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id B99B2244A1
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jun 2011 02:34:32 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1063164pzk.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Jun 2011 17:34:31 -0700 (PDT)
In-Reply-To: <4DE9266D.70503@imi.aau.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sd@imi.aau.dk
Cc: Greg KH <greg@kroah.com>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, sboyce@blueyonder.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 3, 2011 at 11:22 AM, sdaau <sd@imi.aau.dk> wrote:

> On 2011-05-30 23:51, Caleb Crome wrote:
>
>> FYI, if you can raise the PWM rate on the arduino output, you can use
>>> modulation tricks to increase the resolution.
>>>
>>
> On the Arduino Duemillanove , there is 16 MHz clock and ATmega328 - as far
> as I could gather, the highest possible PWM frequency there is 62.5 kHz (in
> Fast PWM mode - achievable by setting the correct prescalers).


Ah, so that's not going to let you get too far in terms of oversampling.
 You could set your audio bandwidth to 62.5 / 2 / 2 ~= 15kHz and try for
~9-bit resolution.  Here's the basic procedure:

On your host, resample the audio file to 62.5 kHz, lowpass filter it, and
convert it to 8-bits.  You can do this all as preprocessing steps until you
get it into your application.  It looks something like this:
> sox input.wav -r 31250 i1.wav      # This resamples to 31250 Hz.  This
includes a built-in antialiasing filter, so will limit bandwidth to
somewhere below 15kHz
> sox i1.wav -r 62500    i2.wav      # This resamples to 62500 Hz.  It
creates samples between all the 31250Hz samples that are interpolated.  This
is the important bit!
> sox i2.wav --bits 8 i3.wav          # This converts   to 8-bit samples.
(these sox command not tested ;-)

Now, you have a band-limited signal, with 8-bit samples.  However, the
sample rate is double what it would need to be for the limited bandwidth
(<15kHz).

Now, just play this i3.wav file out to your arduino at 62.5 kHz.  This
*should* give you somewhat improved SNR on your signal.  Theoretical best
would be .... hmmm I don't recall, either 3 dB or 6 dB, or maybe 4.2 dB :-)
   Somewhere between 3 and 6 for sure.


>
>  If you can transmit, say, 10 bits and run your sample rate at ~4x your
>>> intended rate, you can probably get about 10-bits of resolution on the
>>> output.
>>>
>>
> Interesting - I'm not sure if I understand that statement correctly: in
> this case, an output compare (OC) unit of an 8-bit timer/counter of the
> Arduino's ATMega328 is used to produce PWM output; and since I by default
> can only write 8-bit values there in the microcontroller code, I have a hard
> time seeing how I could squeeze out 10 bits on output in that context; but
> maybe you had a different context in mind?


Sorry, your PWM will still be 8-bits.  The point is that *somebody* needs to
upsample and lowpass filter the data.  Forget this idea, and look to the sox
example above.  You could try different varients of that to get better
resoltuion in the band of interest.




>  It requires a lowpass (antialiasing) filter though -- which gets
>>> really nasty at sample rates below 40khz -- because then they need to be
>>> sharp so you don't hear the aliasing.
>>>
>>
> Heh, this is where I got surprised :)
>
> I too expected that at least I would hear some high-frequency "buzz" due to
> the 'hard edges' of the PWM signal - which would assume that I don't have a
> low pass filter which is sharp enough, as you state. But the surprising bit
> for me was that I could just stick this 62.5 kHz (carrying a 44.1 kHz data)
> PWM signal raw in a loudspeaker - and I can *not* hear a high-frequency
> "buzz" that I expected :) Obviously, the loudspeaker itself performs low
> pass filtering - I just thought originally it would not be sharp enough :)


Yep, the loudspeaker does a descent job of lowpass filtering.  Also, if your
sample rate is above ~40kHz, any aliasing is inaudible (because you only
hear to 20kHz at best).  Unfortunately, if you take the output and drive an
amplifier with it, the amplifier will be slew-rate limited on the hard PWM
edges, and it'll start distorting.  That's why you need an antialiasing
filter if running into an opamp, but don't necessarily need one if going
directly to a speaker or headphone.


>
>  Modern codecs manage this by shoving
>>> all the aliasing noise up at a few MHz, so a simple RC filter is enough
>>> to
>>> eliminate aliasing issues.  And not even necessary if driving
>>> speakers/headphones directly.
>>>
>>>
> Thanks for mentioning this too - I have often heard about the technique of
> "pushing aliasing noise up to MHz", however, still do not understand it
> practically yet. And interesting that you state it is "not necessary" for
> speakers/headphones - I'd agree with that (based on my above experience),
> but I wander if that is mainly due to the mechanical inertia of the
> loudspeaker membrane - or because of presence of coil/inductor?
>
>
As long as the aliased signals are above the audible range, it's okay even
if your loudspeaker/headphone *does* reproduce them.  Who cares if your
speaker also produces ultrasonic noise at 1 MHz?  Reality is that speakers
do act as lowpass filters (even good tweeters ;-), so it's really not
something that you need to worry about.

But, you do need to worry about it if going to another amplifier because of
the slew rate limitations above.

>
>
>  Anyway, 9-bits is going to be much better than 8, so if you can run the
>>> arduino at 88.2k, you could probably get roughly 9 bits of resolution.
>>>  You'd probably do the upsampling on the linux side -- since the AVR is
>>> not
>>> exactly bursting with MIPS.
>>>
>>>
> I could send a data stream at 88.2 kHz, and there would be available data
> bandwidth too - however, since I have only an 8-bit timer/counter OC as a
> PWM generator, I still cannot see how I could get 9-bit resolution out of
> that.


It's the oversampling technique I demonstrated above.  By running at a
faster rate, the lowpass filter (i.e. speaker) smooths the 8-bit samples out
to get better-than-8-bit resoltuion.  It's a type of averaging.

Think of it this way:  at 88.2kHz, you have 2 samples for every 1 time slice
that you care about. (you care about only 20kHz audio bandwidth or 1/40kHz
slices)  If sample 1 is 34 and sample 2 is 35 (both 8-bit values), the
AVERAGE sample, for that 1/40kHz time slice is (34+35) /2 = 34.5.  This is
how oversampling helps you.  Lowpass filters *are* averagers.

>
>  Hmmm, or another idea:  what if you use 2 PWM channels and mix the outputs
>>> together with an op-amp?
>>> You could potentially get much improved resolution that way.  Basically,
>>> use
>>> a summing node on your op-amp with one signal at unity, and the other
>>> signal
>>> at 1/256*unity.
>>>
>>
> Heh, that's exactly what I was thinking too :) (I think its mentioned very
> briefly in the end of the paper) - basically, one 8-bit PWM reproduces the
> MSB of the 16-bit sample; and the other PWM reproduces the LSB of this
> 16-bit simple, and they are appropriately mixed in the analog domain.
> However, as you say:


BTW, another limitation is the cleanlieness of your 5V power supply.  It's
probably extremely dirty, which will translate directly into noise on the
output because your HIGH levels can only be as clean as the VCC rail.  Low
levels will be pretty clean (limited by the Ron of the AVR's output stage).

> For instance, before this, I've always had the misconception that when,
> say, Audacity plays a file, it sends the value for each sample (say, 16-bit)
> one-by-one to the soundcard, and so the soundcard plays back the samples
> one-by-one. And that is not what happens: ALSA does its own chunking, then
> USB does its own chunking - which means that, at least for playback, as a
> code for the device (soundcard) you better be storing those incoming bursts
> of data in an array somewhere, and *then* reproduce sample-by-sample (from
> the stored data) at the requested reproduction rate.
>

:-)  Yep.  It would be really inefficient to have a 1 sample block size :-)


I believe that USB is fixed on 1mS block size, so the block size depends on
your sample rate.  I could be mistaken here.


>
> Of course, in such a system, one needs to think about the analog domain as
> well - I tried to document a simple board, that would take the AudioArduino
> as is, and try to provide an analog line in/out interface to it with the
> simplest approaches (e.g. a discrete ramp-and-hold circuit, to convert the
> PWM signal to analog voltage levels); however, all I could conclude was that
> simple approaches actually produce slightly worse results (than just having
> the AudioArduino PWM out going directly into a speaker)


I think that the project is pretty neat, and a good demonstration project.

Take care,

-Caleb
