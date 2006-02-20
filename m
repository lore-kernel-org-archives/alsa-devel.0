From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Test model
Date: Tue, 21 Feb 2006 09:47:25 +1030 (CST)
Message-ID: <200602202317.k1KNHPMb021810@auster.physics.adelaide.edu.au>
References: <43F96BFF.8090705@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43F96BFF.8090705@akl.lt> from "Rimas Kudelis" at Feb 20, 2006 09:13:03 AM
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

Hi

> >> BTW one of the actions I tried last weekend was recording something from
> >> the microphone. And it failed too. selecting one (don't remember which,
> >> though) of the capture channels for capture resulted in continuous noise
> >> being recorded, and selecting the other one resulted in silence. Also,
> >> selecting both resulted in sum of these, hence, noise again...
> >>     
> > What sort of noise - hiss I assume? 
> Yes, it was hiss.

Interesting.

> > Secondly, what do you mean by "selecting both"?  Do you mean that both
> > capture sources were pointed at the same source?  If so you wouldn't
> > have recorded the sum; the two ADCs are on separate pcms, so you would
> > only have been recording one or the other in this case.
> >   
> I think I pointed both capture sources at MIC1 (my internal/external
> microphone), then selected both channels for capture in capture mixer.

What program did you then use to do the recording?  In a vast majority of
cases this will only record from the first PCM, so even though alsamixer had
both ADCs selected, odds are you were still only recording one of them.
This probably explains the silence in your initial test - you were still
only recording ADC0, but in that case it didn't have any source enabled.

Therefore the only odd thing about that test is the fact that you didn't
get any signal from the mic.

> > What kind of microphone were you using?  Did you have a bias setting
> > configured for the jack the mic was connected to?
> >   
> I tried it with the internal mic. I could clearly hear in the speakers
> when I tapped the computer with my fingers, so I assumed I should be
> able to record that sound too. However, all I got was the hiss ...

I would have expected that to work.  Which speakers did you hear the tapping
in?  The internal ones and the headphone jack aren't currently functional,
so that leaves only the external mic jack operating as an output, doesn't
it?  If so then perhaps it's some kind of coupling.

> >> Also, not sure if it's alsamixer's or driver's fault, alsamixer always 
> >> says "Input Source 1" is "1", even though it selects the required source.
> >>     
> > I'm confused by this - "1" isn't an option AFAIK.  "MIC1", "MIC2", "LINE1",
> > "LINE2" etc are the options.
> >   
> Right. So I can select MIC1, LINE1 etc in the alsamixer, but the
> indicator at the top always says "1" no matter what I select.

I'll have to check this on my laptop tonight - in particular, I'm not sure
what the "indicator at the top" is off-hand.

> Just to be clear: i'm referring to the console version of the alsamixer.

Sure.

> OTOH, I haven't recompiled ALSA utils (I think, Im using what Ubuntu has
> provided me with), so it might just be version incompatibility.

Which version of alsautils is that - the version number should be at the top
of alsamixer.

> >> Jonathan, I think that maybe the "test" model should have even more 
> >> controls to play with, even those that may seem like should never be 
> >> used? For example, there seem to be no checkboxes or something similar 
> >> to control S/PDIF NIDs
> >>     
> > That's because I cannot test SPDIF inputs since they are not brought out
> > to the outside world on my laptop.  Therefore I can't test prospective
> > controls.
> >   
> Well, I think you could try adding those controls. Just the fact that
> S/PDIF pins are not connected to anything on your laptop won't stop the
> driver from err'ing in case you implement something in a wrong way.

That wasn't the point.  The issue was that I couldn't test them to see if
they did what I expected - they would just be a stab in the dark.  Someone
trying them and getting no effect therefore would not know if the failure
was due to their hardware or a bug in the driver.

However, since there seems to be a call for this I'll look at adding
*something* for the SPDIF pins tonight.

> >> or jack (pin) widgets and so on.
> > With the exception of the SPDIF pins, all output pins provided by the ALC260
> > are already available in the mixer controls of the test model.  In other
> > words, all the *analog* outputs should be present.  Have I missed some? 
> > Which NIDs in particular are you referring to?
> >   
> NIDs 0x0f - 0x15 don't have input/output mute checkboxes. Of course, you
> may say these are useless, and I would agree with you. :)

The initverbs for the test model unmute both the input and output of NIDs
0x0f to 0x15, so they are ready for whichever mode is configured by the mode
switch.  This is why there are no explicit switches in the mixer for this.
Having switches for this would add significantly to the number of things a
tester would have to think about.  It was clear from my tests that having
both input and output unmuted didn't cause any trouble (beyond perhaps
contributing to a slight increase in the noise level when sampling), so
there was no basis to include manual switches for these.

Having said all that, I think it's actually possible to include manipulation
of these mute switches as part of the jack mode control.  Doing so will reduce
the ADC noise level slightly.

> Then again, when it comes to a situation like mine where none of the sane
> options are helpfull, it's better to have insane options available too, i
> think. :)

No arguments there in principle.

> > In terms of the ongoing Acer saga, we probably need to take a step back
> > and recap between yourself, Paulo and me precisely what works, what
> > doesn't and what's been tried.  I'll pick this up in a day or so after
> > giving things a bit more thought.
> >
> OK. I'll just remind again, that I don't have direct access to the lappy
> in question now. However, if we come up with something interesting to
> test, I wouldn't mind visiting my mother and giving her speakers one
> more chance to speak. ;) She'd be happy to see me anyways.

No worries.  We'll see how we go.

> >> BTW, if I haven't misunderstood the datasheet, I think it says that 
> >> S/PDIF NIDs (0x03 and 0x06, if I remember correctly) can be told to 
> >> output Analog audio, along with the other channels.
> >>     
> > I never noticed this - what page(s) of the datasheet appear to suggest this
> > to you?
> >   
> Page 67 (marked as 60), first table (continued from the last page):
> Bit: 0
> Description: DigEn (Digital Enable).
>           0: OFF (S/PDIF-OUT is in Hi-Z)
>           1: ON
> 
> Now again, I'm not sure if I understood it correctly.

This is simply to enable or disable the SPDIF control.  Having it disabled 
puts it into the Hi-Z state, which is short for "high impedence".  Essentially
this means that the current driver/receiver is disconnected from the pin.
It doesn't mean that analog audio is enabled.

> > The only way I would have thought the digital outputs could come into play
> > is if for some reason the internal speaker and headphone jack were driven
> > off an external DAC.  As I mentioned in a previous post though this doesn't
> > seem sensible from where we stand.
>
> Well, having no sound from internal speakers in Linux, while having it
> in Windows, doesn't seem sensible too... ;) It's as I said - when no
> sane options are left, it's probably the time to try those that seem
> insane. Just to make sure.

No arguments there.  I can't help but think that we're missing something
though.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
