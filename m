From: Ross Wille <audio@cornerbrick.com>
Subject: Re: i.MX6 SGTL5000 hangs with EIO error
Date: Fri, 13 May 2016 10:56:41 -0600
Message-ID: <201605131056.41115.audio@cornerbrick.com>
References: <201605121154.48951.audio@cornerbrick.com>
 <CAG5mAdxDs=r5tQytTW-ot4+Y9fZKgeS1GrTAtCU8vGmXOiuo2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.willeweb.com (willeweb.com [166.70.233.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 38B5026070F
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 18:56:43 +0200 (CEST)
In-Reply-To: <CAG5mAdxDs=r5tQytTW-ot4+Y9fZKgeS1GrTAtCU8vGmXOiuo2g@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Caleb,

Thank you for your response!

The LINEIN1 protection on the Wandboard kicks in at around 5 to 5.5 Volts 
and, as you pointed out, doesn't include a current-limiting resistor.  The 
max-voltage range for the SGTL5000 audio input is spec'd at GND-0.3 to 
Vdda+0.3.  I believe the Wandboard Vdda is 2.5V, so the on-board protection 
is likely insufficient to limit the input voltage to the datasheet specs.

To mitigate this I have done the following:

1. I've isolated the audio between the signal generator and the codec chip 
using a professional-grade audio transformer having a breakdown voltage of 
250 V RMS, so ground loops should not be an issue, but it might not 
eliminate ESD completely.

2. For transient protection, I have a bidirectional TVS diode with a 
breakdown voltage of 1.0V(typ) between the transformer output and ground. 
The TVS diode meets IEC 61000-4-2 for contact discharge of 8 kV and air 
discharge of 15 kV and I don't believe its an ESD problem (see #3).  The 
circuit impedance at the TVS diode is about 10 kohms.

3. I'm working on a static mat and I'm grounded.

In spite of doing all this, I still get the error.  If latch-up is the 
culprit (which is possible) I am running out of things to try.  I may need 
to add an active buffer stage to ensure the audio voltage never exceeds the 
voltage rails (but that'll require a new PCB design--sigh).

I was hoping to find a software recovery solution because rebooting and 
power-cycling the board are a rather drastic measures.

Thanks!

-Ross

On Thursday 12 May 2016 14:13, Caleb Crome wrote:
> On Thu, May 12, 2016 at 10:54 AM, Ross Wille <audio@cornerbrick.com> 
wrote:
> 
> > Hello all,
> >
> > I am doing an ALSA capture on a Wandboard Quad (i.MX6 quad core with
> > SGTL5000 codec chip) from the LINEIN1 jack.  I'm using a 
4.6.0-rc3-armv7-x0
> > kernel.
> >
> > Sometimes when the audio glitches (for example, when I plug/unplug the
> > audio
> > cable or adjust my signal generator) the snd_pcm_readi() function will
> > start returning -5 (EIO).
> >
> 
> This sounds like an ESD strike. (when you plug in the cable the ESD on the
> cable wacks some electronics internally).
> 
> See if you can ground yourself, the signal generator, the wand board, and
> anything else with some ESD straps, and see if you can reproduce the 
error.
> 
> 
> Looking at the wandboard baseboard, the linein1 jack *does* have ESD
> protection diodes on it.
> 
> Interestingly, the mic1 jack does not have ESD diodes.  not sure why.
> 
> This shouldn't be a software issue, because there's no microphone 
detection
> going on in hardware -- the software doesn't know you've inserted 
anything.
> 
> 
> Another possibility is a different type of electrical over stress.  There
> might be a large voltage between your wandboard GND and generator GND.
> This is common, and is a result of the inter-widing capacitance on the
> respective 'isolated' power supplies.  If that capacitance is large 
enough,
> it might be able to drive enough current into the pins to wreck up the
> SGTL5000 until re-power.   But... the wandboard's transient suppression
> should be enough to deal with that.
> 
> Oh, looking at the schematic again, there are TVS, diodes D36/D37, but
> there is *no* series resistance between the connector and the codec!  That
> could easily be the problem -- an external signal can drive lots of (ac)
> current in through those lines and cause latch-up.  That's why you require
> a power off/on to reset it.   Even a hard reset won't fix latchup.
> 
> See if your codec starts to get warm when in this state :-/  Definitely
> damaging to the codec though.
> 
> -Caleb
> 
> 
> 
> 
> 
> >
> > Once this happens, the only way I've been able to recover is to reboot 
the
> > computer.  Calling snd_pcm_close(), snd_pcm_prepare(), snd_pcm_start(),
> > etc. doesn't help.  When in this state, running arecord returns IO 
errors
> > as well.
> >
> > It's interesting that, on rare occasions, I must do a power cycle in 
order
> > to recover.  When a reboot is not effective I've noticed that the 
capture
> > device doesn't appear in /proc/asound/devices.
> >
> > I don't believe my specific ALSA settings are important, but I'm calling
> > snd_pcm_readi() with ALSA set to a sample rate of 48000, format of 
S16_LE,
> > channels=1, frames per period of 960 (20 mS periods), and 4 periods per
> > buffer.
> >
> > This same problem happens on two different Wandboards, so I don't think
> > it's
> > a defective board or chip.  It has happened on older kernels as well.
> >
> > Any ideas?
> >
> > Thank you!
> >
> > Ross Wille
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> 
