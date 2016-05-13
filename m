From: Caleb Crome <caleb@crome.org>
Subject: Re: i.MX6 SGTL5000 hangs with EIO error
Date: Fri, 13 May 2016 15:01:15 -0700
Message-ID: <CAG5mAdzZSSmAFosZfmZXXYAwLn2rLGNhiDyXo8ywb+MSKyUeqQ@mail.gmail.com>
References: <201605121154.48951.audio@cornerbrick.com>
 <201605131056.41115.audio@cornerbrick.com>
 <CAG5mAdyCTE=MGWGVEpUD_tZknd-Tr0=oznJHkQkz_2zziR9Z4g@mail.gmail.com>
 <201605131445.12110.audio@cornerbrick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B9EE2651A3
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 00:01:36 +0200 (CEST)
Received: by mail-oi0-f48.google.com with SMTP id x19so191453866oix.2
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 15:01:36 -0700 (PDT)
In-Reply-To: <201605131445.12110.audio@cornerbrick.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ross Wille <audio@cornerbrick.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 13, 2016 at 1:45 PM, Ross Wille <audio@cornerbrick.com> wrote:

> Caleb,
>
> Yes, it's a Jensen JT-11P-1HPC (10k 1:1) line transformer.
>
> I have a custom isolation PC board, which includes the XLR jack, isolation
> transformer, variable attenuator, and transient protection.  The board has
> separate "shield" and analog grounds.  The output of this board feeds into
> a standard, unmodified Wandboard via the 3.5mm LINEIN1 jack.
>
> I'm not plugging/unplugging the Wandboard connector (well, I started out
> that way, but the results were terrible).  With the transformer and the TVS
> diode the problem is MUCH better than it was initially.  When I was driving
> the LINEIN1 jack directly from the signal generator plugging/unplugging the
> audio connector had a significant chance of making this happen.
>
> Now, the isolation board is always connected to the Wandboard.  And
> plugging/unplugging the XLR connector is pretty reliable.  The easiest way
> I've found to make the problem happen is by keeping everything connected
> and toggling the power switch on my signal generator repeatedly.
>


Ah Ha!   Hint hint!  Yes, not ESD, but electrical overstress -- too much
current I think.  There is still some nonzero inter-winding capacitance
even in the Jensen transformer, and flipping that power switch gives a nice
big 340 V p-p (120Vrms) shove across those inter-widning capacitances &
impedances, (plus who knows what kind of currenets due to inductive
switching) and even with the protection you have, there isn't enough
protection to prevent latchup.


> I don't think I'm getting any ESD during my tests, although when this
> device
> gets put into service I'd expect to get some ESD when they plug into the
> XLR jack while the device is powered.  (Maybe I'll tell them not to do
> that, but they're talking heads, not geeks.)
>
> Most of the time a reboot fixes the problem, but I've seen rare occasions
> when it does require a power cycle.
>
> The SGTL5000 doesn't have an external reset.  It has an internal reset
> circuit which waits 8 clock cycles after power-on before it comes out of
> reset.  So, a hardware reset of this chip requires a power cycle.
>

Ah, bad on the designers of STL5000.


>
> There may be a way to force a software reset if I can still talk to the
> chip, but if the chip is latched up only a power cycle is going to fix
> that.
>

Who knows, maybe not latchup then.  May simply be a glitch that causes it
to stop functioning.  I hadn't looked and noticed there was no hardware
reset.  A friend of mine once had a similar problem and was able to force
the chip to come back to life by toggling the I2C SDA and SCL lines a bunch
of times (upon advice from the chip maker).  You might have  a hard time
getting Linux to give you back the pins and toggle them like GPIOs, rather
than treat them as an I2C bus.




>
> The LINEIN1 is capacitively coupled to the SGTL5000 (I assume that's
> because
> the SGTL5000 input has a DC bias on it).


Correct.


>   I'm clamping +/-1V relative to
> the Wandboard's signal ground, but that's on the AC-coupled side of the
> signal.


Right, which should get the job done.  The bias is probably something like
1.3V or something, so your clamp should do a decent job of preventing much
negative voltage getting through.


> It'd be better to clamp it going into the codec as you've shown in
> your sketch.
>

Right, but you need access to VDDA.


>
> You asked where the TVS diode is located.  It's a ESDARF01-1BM2 on the
> custom isolation PCB and it's connected between signal and ground just
> before it goes out the cable (which is only 6 inches long) and into the
> Wandboard's LINEIN1 connector.  It would definitely be better if the
> protection was on the Wandboard itself, especially after the coupling
> capacitor.
>
> No, breathing on it doesn't affect it. :-)  I can run all night with a
> nearly full-swing sine wave at 1kHz and it never fails.  It used to fail
> regularly when I messed with the audio connections, but now it's much
> harder to reproduce it.
>

so, it's definitely due to the transient of connecting the signal generator.

Can I ask why you're using a signal generator?  I've found that a good
pro-audio sound card (like RME, or any of the other pro-audio stuff) do a
much better job of creating and capturing audio signals than most lab gear
(except the audio-specific lab gear like Audio Precision, etc).

For that matter, you can probably do just great using your iPhone with
AudioTools as your signal generator.  Then you definitely won't have this
problem. :-)


>
> Thanks again for all your thoughts and ideas.  It's close to being good
> enough, but it's not very professional for a piece of gear to stop working
> just because someone plugged in an XLR cable.
>

No problem!  I'm glad I could help.

-Caleb






>
> -Ross
>
> On Friday 13 May 2016 13:23, Caleb Crome wrote:
> > On Fri, May 13, 2016 at 9:56 AM, Ross Wille <audio@cornerbrick.com>
> wrote:
> >
> > > Hi Caleb,
> > >
> > > Thank you for your response!
> > >
> > > The LINEIN1 protection on the Wandboard kicks in at around 5 to 5.5
> Volts
> > > and, as you pointed out, doesn't include a current-limiting resistor.
> The
> > > max-voltage range for the SGTL5000 audio input is spec'd at GND-0.3 to
> > > Vdda+0.3.  I believe the Wandboard Vdda is 2.5V, so the on-board
> protection
> > > is likely insufficient to limit the input voltage to the datasheet
> specs.
> > >
> > > To mitigate this I have done the following:
> > >
> > > 1. I've isolated the audio between the signal generator and the codec
> chip
> > > using a professional-grade audio transformer having a breakdown voltage
> of
> > > 250 V RMS, so ground loops should not be an issue, but it might not
> > > eliminate ESD completely.
> > >
> >
> > Ah, a Jensen Transformer I assume?  Those things are great.  And the guy
> > (Bill Whitlock) really knows about dealing with hum issues.  His license
> > plate reads MR CMRR.  The DMV initially wouldn't give him that plate.
> > Until he explained that CMRR stands for 'common-mode rejection ratio' :-)
> > The stuff you learn at AES conventions...
> >
> >
> > >
> > > 2. For transient protection, I have a bidirectional TVS diode with a
> > > breakdown voltage of 1.0V(typ) between the transformer output and
> ground.
> > > The TVS diode meets IEC 61000-4-2 for contact discharge of 8 kV and air
> > > discharge of 15 kV and I don't believe its an ESD problem (see #3).
> The
> > > circuit impedance at the TVS diode is about 10 kohms.
> > >
> >
> >
> >
> > >
> > > 3. I'm working on a static mat and I'm grounded.
> > >
> > > In spite of doing all this, I still get the error.  If latch-up is the
> > > culprit (which is possible) I am running out of things to try.  I may
> need
> > > to add an active buffer stage to ensure the audio voltage never exceeds
> the
> > > voltage rails (but that'll require a new PCB design--sigh).
> > >
> >
> > Is this your custom board + wandboard, or is it the standard wandboard?
> >
> > Is it possible that the GND of the audio connector (which is what should
> > get hit first if you're plugging into the jack at the board side) isn't a
> > very good ground, and is letting ESD couple to some other lines?  ESD is
> > icky that way.    But, if you're ESD grounded, then this shouldn't be the
> > issue anyway.
> >
> >
> > >
> > > I was hoping to find a software recovery solution because rebooting and
> > > power-cycling the board are a rather drastic measures.
> > >
> >
> > I doubt that's possible if a reset doesn't recover it -- it seems to be
> > really broken if you need a power cycle.  That's also a hint that it's
> > latchup causing the problem.
> >
> >
> >
> > > Thanks!
> > >
> > > -Ross
> > >
> > >
> > Looks like you've got most of it covered :-)
> >
> > Can you do some protection like this?
> >
>
> https://drive.google.com/file/d/0B0FeiEiLS9DzMVpTWm9QcDY5UHM/view?usp=sharing
> >
> > using something like a BAT54S?  That should do a very good job of
> limiting
> > the voltage to the codec.  but, a 1V TVS should do the job too I think if
> > it's placed on the wandboard.  Where is your TVS diode placed?  Soldered
> in
> > close on the connector of the wandboard, or floating out in space.
> But...
> > ESD just shouldn't be the problem if you're properly grounded.
> >
> > What else could be the culprit I wonder?  This happens as soon as you
> plug
> > in, right?  Does the problem ever happen when nobody is near by and
> > breathing on it?  Or is always in response to some body coming close and
> > touching things?
> >
> > I'm kind of out of ideas without actually getting in close to it and
> seeing
> > what happens and when.
> >
> > Let me know if you can figure out any more details of when the problem
> > happens.  I just think it's got to be a hardware problem, but I've seen
> > stranger things end up being software problems.  :-)
> >
> > Cheers,
> >   -Caleb
> >
> >
> >
> > > On Thursday 12 May 2016 14:13, Caleb Crome wrote:
> > > > On Thu, May 12, 2016 at 10:54 AM, Ross Wille <audio@cornerbrick.com>
> > > wrote:
> > > >
> > > > > Hello all,
> > > > >
> > > > > I am doing an ALSA capture on a Wandboard Quad (i.MX6 quad core
> with
> > > > > SGTL5000 codec chip) from the LINEIN1 jack.  I'm using a
> > > 4.6.0-rc3-armv7-x0
> > > > > kernel.
> > > > >
> > > > > Sometimes when the audio glitches (for example, when I plug/unplug
> the
> > > > > audio
> > > > > cable or adjust my signal generator) the snd_pcm_readi() function
> will
> > > > > start returning -5 (EIO).
> > > > >
> > > >
> > > > This sounds like an ESD strike. (when you plug in the cable the ESD
> on
> > > the
> > > > cable wacks some electronics internally).
> > > >
> > > > See if you can ground yourself, the signal generator, the wand board,
> and
> > > > anything else with some ESD straps, and see if you can reproduce the
> > > error.
> > > >
> > > >
> > > > Looking at the wandboard baseboard, the linein1 jack *does* have ESD
> > > > protection diodes on it.
> > > >
> > > > Interestingly, the mic1 jack does not have ESD diodes.  not sure why.
> > > >
> > > > This shouldn't be a software issue, because there's no microphone
> > > detection
> > > > going on in hardware -- the software doesn't know you've inserted
> > > anything.
> > > >
> > > >
> > > > Another possibility is a different type of electrical over stress.
> There
> > > > might be a large voltage between your wandboard GND and generator
> GND.
> > > > This is common, and is a result of the inter-widing capacitance on
> the
> > > > respective 'isolated' power supplies.  If that capacitance is large
> > > enough,
> > > > it might be able to drive enough current into the pins to wreck up
> the
> > > > SGTL5000 until re-power.   But... the wandboard's transient
> suppression
> > > > should be enough to deal with that.
> > > >
> > > > Oh, looking at the schematic again, there are TVS, diodes D36/D37,
> but
> > > > there is *no* series resistance between the connector and the codec!
> > > That
> > > > could easily be the problem -- an external signal can drive lots of
> (ac)
> > > > current in through those lines and cause latch-up.  That's why you
> > > require
> > > > a power off/on to reset it.   Even a hard reset won't fix latchup.
> > > >
> > > > See if your codec starts to get warm when in this state :-/
> Definitely
> > > > damaging to the codec though.
> > > >
> > > > -Caleb
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > >
> > > > > Once this happens, the only way I've been able to recover is to
> reboot
> > > the
> > > > > computer.  Calling snd_pcm_close(), snd_pcm_prepare(),
> snd_pcm_start(),
> > > > > etc. doesn't help.  When in this state, running arecord returns IO
> > > errors
> > > > > as well.
> > > > >
> > > > > It's interesting that, on rare occasions, I must do a power cycle
> in
> > > order
> > > > > to recover.  When a reboot is not effective I've noticed that the
> > > capture
> > > > > device doesn't appear in /proc/asound/devices.
> > > > >
> > > > > I don't believe my specific ALSA settings are important, but I'm
> > > calling
> > > > > snd_pcm_readi() with ALSA set to a sample rate of 48000, format of
> > > S16_LE,
> > > > > channels=1, frames per period of 960 (20 mS periods), and 4 periods
> per
> > > > > buffer.
> > > > >
> > > > > This same problem happens on two different Wandboards, so I don't
> think
> > > > > it's
> > > > > a defective board or chip.  It has happened on older kernels as
> well.
> > > > >
> > > > > Any ideas?
> > > > >
> > > > > Thank you!
> > > > >
> > > > > Ross Wille
> > > > > _______________________________________________
> > > > > Alsa-devel mailing list
> > > > > Alsa-devel@alsa-project.org
> > > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > > >
> > > >
> > >
> >
>
