From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: More detailed Acer (Intel HDA)
Date: Wed, 22 Mar 2006 10:15:27 +1030 (CST)
Message-ID: <200603212345.k2LNjRCl007981@auster.physics.adelaide.edu.au>
References: <441D52F3.9010107@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <441D52F3.9010107@akl.lt> from "Rimas Kudelis" at Mar 19, 2006 02:47:47 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rimas Kudelis <rq@akl.lt>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi guys

Sorry for the delay in responding - I was out of the office for a few days.

> I asked a user on Ubuntu forums to test Acer jack modes more
> extensively. The results are a bit surprising. You may want to check
> out http://ubuntuforums.org/showthread.php?p=3D825101#post825101.

This URL seemed to point to a thread discussing Java things.  I can't
see anything in there related to audio.

> It's strange for me that it seems like Mic Preamplifier seems to be
> always off for LINE1 channel.

Without being able to see the post it's difficult to comment.  What lead
to this conclusion?

> It's also a bit strange that a jack connected to MIC1 always outputs
> in mono when set as output, but maybe that's just how Acer engineers
> decided it should be.

A vast majority of laptops only have a mono jack in use for anything labeled
"mic".  I guess the reasoning is that microphones are mono by nature so they
can save a few cents and have only a mono jack.  Unless anyone can come up
with evidence to the contrary, I would say that the reason the sound only
comes out in mono out of the Acer "mic" jack is because it's only a mono
jack.

> And the third interesting thing is that the user could not select Mic
> modes at all for LINE-OUT channel. Did I skip this part in the
> datasheet, or is it undocumented?

I have found that some of the ALC260 pin widgets don't allow one to choose
the mic modes - see the comments above the alc_pin_mode_names[] definition
in patch_realtek.c (at or around line 237).  The widgets appear to accept
the message selecting these modes, but when you request the pin mode status
you see that it has been ignored.  NIDs 0x0f and 0x10 have been observed to
suffer from the problem; there might be more.  If either 0x0f or 0x10 are
used for the LINE-OUT channel (and there's every likelihood that they are)
then this would explain the observation.

In other words, it appears to be an undocumented hardware "feature" which we
can do nothing about.

> Also, is there really a difference between Mic 50% and Mic 80%? Maybe
> it's enough to only make one of these modes available in the mixer if
> there's no big difference between them?

The difference is the voltage level output by the pin widget.  50% is 50% of
the ADC supply voltage; 80% is 80% of the supply voltage.  50% is
technically better since it's symmetric - negative and positive signals will
clip at the same amplitude.  It also gives more headroom so the potential
exists for one to achieve a higher signal-to-noise ratio (SNR).  The problem
is that for some mics, the 50% voltage level is not sufficient to power the
mic; they need the 80% level instead.  However, the trade-off is that the
maximum positive input voltage is now quite a bit less than the maximum
negative input voltage, so clipping is far more likely in the presence of
higher level signals.

In this respect I would argue that it is best to keep both levels.  People
can use the superior 50% if it works for them, but fall back to 80% if their
particular microphones need it.

> Same goes for Headphone/Line-Out modes.

There is a big difference; "headphone" enables an on-chip power amplifier
(PA) while "line-out" does not.  The PA allows the chip to drive low
impedence headphones (8-32 ohms for example) to a "reasonable" volume (for
some definition of "reasonable").  However, being an on-chip amplifier its
noise level is quite high - when feeding a line-level input of an external
amplifier or mixer (for example), using the onboard amplifier is less than
optimal.

Therefore both settings should remain; they are both needed since they allow
for two very different ways of using the outputs.  More technically, they
allow the chip to optimally drive two very different types of loads: low
impedence headphones and higher impedence equipment inputs.

Technically, "line-out" mode has a higher output impedence with higher SNR
while "headphone out" activates an amplifier with a much lower output
impedence but with a lower SNR.  "line-out" mode is therefore suitable for
driving high impedence loads such as the line-level inputs of mixing desks,
minidisc decks etc (which have input impedences of the order to 1-10
k-ohms).  "Headphone" mode is best matched to low impedence (8-32 ohm) loads
such as most headphones; the noise floor is elevated but that's not usually
an issue for general listening.

Finally, it should be noted that normally low impedence outputs are best
in terms of noise performance.  The reason that's different in this case
is that the low impedence mode corresponds with an additional voltage gain
stage which itself is housed in a very electrically noisy environment.

> What airbuds did you mention previously (you said Headphone mode might be
> useful for them)? Is it those small headphones that one can put INTO their
> ear and then hear poor sound? :) I don't have them handy ATM, so I can't
> test if there's any difference between Line-Out and Headphones modes for
> them...

Any headphone-type thing with an impedence less than (say) 100 ohms will
benefit from "headphone" mode (I can't give exact figures since I haven't
measured the output impedence of line-out mode).  BTW, while it is true that
typical consumer earbuds sound pretty ordinary, there are units designed for
in-ear monitoring systems which sound awesome.

So in conclusion, based on the information I have at hand I suspect that the
limitations reported by the Ubantu user come about due to hardware issues;
as far as I can tell things seem to be behaving pretty much as I would
expect.  Furthermore, I would argue very strongly that the pin mode choices
need to remain as they are for the reasons detailed above.  The different
modes are optimised for different uses and I see no reason to lock
particular users out of their optimal configuration just to save an entry in
a mode list.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
