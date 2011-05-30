From: Caleb Crome <caleb@crome.org>
Subject: Re: AudioArduino - an ALSA soundcard driver for
 FTDI-based Arduinos
Date: Mon, 30 May 2011 14:51:53 -0700
Message-ID: <BANLkTi=K5AA8CNcoEwqM7TUHS+qhfyaP6Q@mail.gmail.com>
References: <4DE31FE4.4040807@imi.aau.dk> <4DE3EF4A.7090306@blueyonder.co.uk>
	<4DE40025.4010108@imi.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 31D1024406
	for <alsa-devel@alsa-project.org>;
	Mon, 30 May 2011 23:51:57 +0200 (CEST)
Received: by pwi9 with SMTP id 9so1837748pwi.38
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2011 14:51:54 -0700 (PDT)
In-Reply-To: <4DE40025.4010108@imi.aau.dk>
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
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, sboyce@blueyonder.co.uk
List-Id: alsa-devel@alsa-project.org

FYI, if you can raise the PWM rate on the arduino output, you can use
modulation tricks to increase the resolution.  There are a lot of
limitations here, but there is probably some degree of improvement possible.
 Virtually all modern codecs do this to the extreme -- they sample really
fast, like 12 MHz, but only use 1 bit of resolution.  Modern 24-bit codecs
are really only 1 bit on the business end, but really fast.  Search for
delta-sigma or sigma-delta modulators if you're not familiar.

If you can transmit, say, 10 bits and run your sample rate at ~4x your
intended rate, you can probably get about 10-bits of resolution on the
output.  It requires a lowpass (antialiasing) filter though -- which gets
really nasty at sample rates below 40khz -- because then they need to be
sharp so you don't hear the aliasing.  Modern codecs manage this by shoving
all the aliasing noise up at a few MHz, so a simple RC filter is enough to
eliminate aliasing issues.  And not even necessary if driving
speakers/headphones directly.

Anyway, 9-bits is going to be much better than 8, so if you can run the
arduino at 88.2k, you could probably get roughly 9 bits of resolution.
 You'd probably do the upsampling on the linux side -- since the AVR is not
exactly bursting with MIPS.

Hmmm, or another idea:  what if you use 2 PWM channels and mix the outputs
together with an op-amp?
You could potentially get much improved resolution that way.  Basically, use
a summing node on your op-amp with one signal at unity, and the other signal
at 1/256*unity.  I doubt that you'd ever get near 96 dB SNR (the ideal for
16-bits), but you'd probably do better than 1 channel PWM at 8-bits could do
(theoretical best is 48 dB).

Of course, if you're going through the trouble to add an op-amp, you might
as well skip the arduino all together and put a USB <-> audio chip in. :-)

-caleb



On Mon, May 30, 2011 at 1:37 PM, Smilen Dimitrov <sd@imi.aau.dk> wrote:

> Hi Sid,
>
> > Are there any possibilities of extending it beyond 8-bit / 44.1 kHz?
>
> The driver currently exposes a stereo, 16-bit, 44.1 kHz on the ALSA
> side, since that is the lowest quality with which Audacity works in the
> playback direction.
>
> However, Arduino Duemillanove's ATMega328 is not really capable of
> 16-bit reproduction in this context: it has one 16-bit and two 8-bit
> counters, and the 16-bit one is used to derive the 44.1 kHz (PCM) rate,
> so the only thing available for PWM (analog) reproduction are the 8-bit
> counters (there is a bit more on this in the paper on the webpage).
>
> So what happens during stereo, 16-bit, 44.1 kHz playback, is that the
> driver simply extracts the MSB of the left channel, and sends it as an
> 8-bit sample representation to the Arduino for PWM reproduction.
>
> So in brief - as far as ALSA interfaces are concerned, I believe it is
> possible to specify any rate you want (which is supported) - however,
> "by default", it would be easy to only get 8-bit resolution (hardware)
> reproduction on the Arduino (however, higher rates should in principle
> be possible; as I think there should still some of bandwidth left, since
> a duplex operation can be demonstrated at 2Mbps).
>
>
> Hope this helps,
> Cheers!
>
>
>
>
>
> > Regards
> > Sid.
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
