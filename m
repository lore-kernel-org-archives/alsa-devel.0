From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Test model
Date: Thu, 23 Feb 2006 10:20:12 +1030 (CST)
Message-ID: <200602222350.k1MNoC0I002418@auster.physics.adelaide.edu.au>
References: <43FC0758.6080902@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43FC0758.6080902@akl.lt> from "Rimas Kudelis" at Feb 22, 2006 08:40:24 AM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net, Rimas Kudelis <rq@akl.lt>
List-Id: alsa-devel@alsa-project.org

Hi

> > Hmm, ok.  So for this test we had:
> >  - MIC1 pin mode set to 50pc / 80pc
> >  - The mode of the pin we've worked out previously is connected to the 
> >    Line-In jack was set to line-out or headphone (it wouldn't matter which)
> >  - The "MIC1 Playback Volume" was set high-ish and "MIC1 Playback Switch"
> >    was unmuted (so you can hear it through your speakers)
> >  - The "Input Source" was set to "MIC1"
> >  - The "Input Source" volume control was turned up high and was unmuted.
> >  - "Input Source" *might* have to be enabled too - I can't recall if alsamixer
> >    has a control for this or not.
> >
> > If you can't recall for sure, it might be worth running through this
> > checklist next time you have access to the computer.
> >
> > Also note that alsamixer does not select any particular ADC for capture.  All
> > it does is sets up up the signal routing to the available ADCs.  "Input
> > Source" refers to pcm0 while "Input Source 1" refers to pcm1.  Unless
> >   
> I'd vote for "Input Source 0" and "Input Source 1" though. Numbering
> both controls would make sense, imho.

That's not up to the driver - that's the way the alsa mixer API enumerates
the two controls the driver says it needs.

> > otherwise instructed, capture programs will *always* capture from "Input
> > Source", not "Input Source 1" - that is, it will always capture from pcm0
> > unless you tell it otherwise.  The method of "telling it otherwise" depends
> > on the recording program and is a function which must be provided by the
> > program.  If the program doesn't allow you to select the pcm to use as
> > source then it's stuck with pcm0.
> >   
> Ah. I thought that it's enough to select it for capture in alsamixer...

Um, no.  All that effectively does (as far as I can tell) is unmute the
ADC input.  It doesn't connect that ADC to pcm0 or make it the default
ADC for recording applications (or whatever).

I did some more tests overnight with the "test" model which will hopefully
assist in clearing some points up.  Below are the mixer settings I needed
to use to get sound happening to/from the various points on my S7020.

 1) Playing to a jack:
     * set the pin's mode to "headphone" or "lineout".  For me, "line-out"
       jack is connected to the "LINE1" pin.
     * LOUT1: unmute *and* turn up.  If no sound, try the same for LOUT2.

 2) Playing to the internal speaker:
     * set the mode of the pin connected to the internal speaker to
       "headphone".  On the S7020, this is the HP-OUT pin.
     * LOUT2: unmute *and* turn up.  If no sound, try the same for LOUT1.

 3) Recording from mic jack.  For the S7020 this is the MIC1 pin which 
    is assumed below.  Substitute whichever pin is appropriate in your
    situation.
     * In the "playback" view in alsamixer:
        - "Input source" control: select MIC1.
        - "MIC1": unmute, turn volume up (if you want to hear the mic signal 
          through the card's output).  This shouldn't affect the recording 
          of the signal though.
        - "MIC1" pin mode: "mic bias 80pc", "mic bias 50pc" or "line-in"
          depending on what you're using as the source.  If it's a mic,
          perhaps try "mic bias 80pc" first.
     * In the "capture" view in alsamixer:
        - enable the "Capture" channel by highlighting it and pressing 
          <space>.
        - turn the "Capture" volume up.

My laptop doesn't have an internal mic, so I couldn't test that.  I would
expect it to be similar for (3) except the pin in question may be different.

In addition, when playing a sound to the "mic" jack (which on the S7020 is
actually a stereo line-in jack) the sound lacked bass - as if a high-pass
filter was active on that channel.  I noticed this earlier in my development
too and didn't pursue it at the time because the ALC260 only has one DAC so
there was no real need to retask the "mic/line" input on my laptop.  At this
stage I've been putting this down to the details of the circuitry used on
that pin, but there are a small number of ALC260 things I still want to
check yet.  I'll do this soon hopefully.

Finally, if there's still no joy recording (and to make sure we're not
dealing with some other strange alsalib thing), maybe grab batchrec from
my website:

  http://www.physics.adelaide.edu.au/~jwoithe/batchrec-1.2.0.tgz

Run it in NULL mode initially:

  batchrec -n foo.wav

It's a text-mode program using the OSS API, so you'll need the alsa oss
emulation modules loaded for it to work.  This opens pcm0 effectively and
will display some simple level meters which should be sufficient to indicate
whether you're seeing signal from the mic.  <Ctrl>C will quit.  This is the
program I used to test the recording configuration described above, and using
it will remove one more variable from the equation.

Actually, I've just had another thought: you said you used gnome-recorder.
I've never used it, but I wonder if it has its own input volume control
which is being made active when you run the program.  If so and it's set to
a minimum that may explain why you're not recording any signal.

> > Let's put this into perspective: we're talking about an *inaudible* increase
> > in the noise floor - probably much less than 1 dB, although I am yet to
> > measure it explicitly.  This is why there is really no practically
> > observable problem in enabling both the input and output simultaneously.
> >   
> Nor is there a problem in disabling them for models known not to use
> relevant pins at all.

Most (if not all) models currently do this, including "fujitsu".

> >> Another weird detail. Look at the picture here:
> >> http://notebooky.idnes.cz/obrazek/acer_tm4600_aspire1690_09.jpg. On my
> >> mothers notebook (which is almost identical to the one in the pic), the
> >> outside of Line In and Mic jacks is made of metal, while the outside of
> >> Headphones jack is made of black plastic. I wonder what is the reason
> >> for this...
> >>     
> > No idea.  Someone in the design section obviously had a reason.  Perhaps
> > they've done some odd ground isolation arrangement for the headphone output,
> > but I think it's more likely to be either purely for looks.  Either that or
> > space constrains required that they use sockets with different dimensions,
> > and those with a size suitable for the headphone socket only came in plastic.
> >   
> Well that would be a weird reason IMO.

Strange, but not unheard of, especially if there are space constraints at
different points inside the laptop.  These sockets come in all sorts of
shapes, sizes and configurations (in terms of internal switches etc) - some
with plastic surrounds, others with metal.  However, not all combinations
are made, obviously.  Therefore if there was a space constraint for one of
the sockets the manufacturer might have had to move to a plastic one because
there were none with metal in a sutiable size and configuration to fit. 
These kinds of compromises are made all the time in manufacturing.  I admint
that it would be odd, but I can quite believe that this could be the case.

> >> I think so too. However, there's one weird thing - one user of a similar
> >> laptop said on Ubuntu forums that the sound worked for him initially.
> > Do you have a URL to the post?
> http://ubuntuforums.org/showthread.php?t=99222

You're right.  Not a lot of detail there unfortunately.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
