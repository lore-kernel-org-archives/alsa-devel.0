From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Test model
Date: Wed, 22 Feb 2006 09:50:27 +1030 (CST)
Message-ID: <200602212320.k1LNKRX7028237@auster.physics.adelaide.edu.au>
References: <43FAE8B8.4000400@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43FAE8B8.4000400@akl.lt> from "Rimas Kudelis" at Feb 21, 2006 12:17:28 PM
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

> > In a vast majority of cases this will only record from the first PCM, so
> > even though alsamixer had both ADCs selected, odds are you were still
> > only recording one of them. This probably explains the silence in your
> > initial test - you were still only recording ADC0, but in that case it
> > didn't have any source enabled.
> >
> > Therefore the only odd thing about that test is the fact that you didn't
> > get any signal from the mic.
> >   
> Yes, and I also wonder, where could that hiss have come from...

At this stage, anywhere.  If a relevant gain control was turned up
high you'll get plenty of hiss if that signal is then selected as an ADC
input.  Again, the odd thing is that the signal didn't show at the ADC,
not the fact that there was a lot of hiss.

> >> I tried it with the internal mic. I could clearly hear in the speakers
> >> when I tapped the computer with my fingers, so I assumed I should be
> >> able to record that sound too. However, all I got was the hiss ...
> >>     
> > I would have expected that to work.  Which speakers did you hear the tapping
> > in?  The internal ones and the headphone jack aren't currently functional,
> > so that leaves only the external mic jack operating as an output, doesn't
> > it?  If so then perhaps it's some kind of coupling.
> >   
> No, I used the Line-In jack (LINE1 channel) operating as output. Mic
> (MIC1 channel) was set to 50pc or 80pc mic, of course. I could clearly
> hear my tapping from the external amplified speakers connected to the
> Line-In jack, but nothing was recorded no matter which ADC(s) I selected
> for capture.

Hmm, ok.  So for this test we had:
 - MIC1 pin mode set to 50pc / 80pc
 - The mode of the pin we've worked out previously is connected to the 
   Line-In jack was set to line-out or headphone (it wouldn't matter which)
 - The "MIC1 Playback Volume" was set high-ish and "MIC1 Playback Switch"
   was unmuted (so you can hear it through your speakers)
 - The "Input Source" was set to "MIC1"
 - The "Input Source" volume control was turned up high and was unmuted.
 - "Input Source" *might* have to be enabled too - I can't recall if alsamixer
   has a control for this or not.

If you can't recall for sure, it might be worth running through this
checklist next time you have access to the computer.

Also note that alsamixer does not select any particular ADC for capture.  All
it does is sets up up the signal routing to the available ADCs.  "Input
Source" refers to pcm0 while "Input Source 1" refers to pcm1.  Unless
otherwise instructed, capture programs will *always* capture from "Input
Source", not "Input Source 1" - that is, it will always capture from pcm0
unless you tell it otherwise.  The method of "telling it otherwise" depends
on the recording program and is a function which must be provided by the
program.  If the program doesn't allow you to select the pcm to use as
source then it's stuck with pcm0.

> >>>> Also, not sure if it's alsamixer's or driver's fault, alsamixer always 
> >>>> says "Input Source 1" is "1", even though it selects the required source.
> >>>>         
> >>> I'm confused by this - "1" isn't an option AFAIK.  "MIC1", "MIC2", "LINE1",
> >>> "LINE2" etc are the options.
> >>>       
> >> Right. So I can select MIC1, LINE1 etc in the alsamixer, but the
> >> indicator at the top always says "1" no matter what I select.
> >>     
> > I'll have to check this on my laptop tonight - in particular, I'm not sure
> > what the "indicator at the top" is off-hand.
> >   
> There's an informational block at top-left of alsamixer.

Ah, right, up there.  Thanks - I'll check it out.

> > The initverbs for the test model unmute both the input and output of NIDs
> > 0x0f to 0x15, so they are ready for whichever mode is configured by the mode
> > switch.  This is why there are no explicit switches in the mixer for this.
> > Having switches for this would add significantly to the number of things a
> > tester would have to think about.  It was clear from my tests that having
> > both input and output unmuted didn't cause any trouble (beyond perhaps
> > contributing to a slight increase in the noise level when sampling), so
> > there was no basis to include manual switches for these.
> >   
> That's why I said it should probably go to the extended test model.
> However, on the other hand, if unmuting those ports indeed increases
> noise level, maybe it would indeed be better to mute certain unused
> ports in certain models that don't have anything connected to them anyways.

Let's put this into perspective: we're talking about an *inaudible* increase
in the noise floor - probably much less than 1 dB, although I am yet to
measure it explicitly.  This is why there is really no practically
observable problem in enabling both the input and output simultaneously.

> > This is simply to enable or disable the SPDIF control.  Having it disabled 
> > puts it into the Hi-Z state, which is short for "high impedence".  Essentially
> > this means that the current driver/receiver is disconnected from the pin.
> > It doesn't mean that analog audio is enabled.
> >   
> Oh, I see.

And by "current" here I was referring to electrical current (in case the
sentence didn't read right for some).

> Another thing: hda_local.h defines six pinctl values:
> #define PIN_IN 0x20
> #define PIN_VREF80 0x24
> #define PIN_VREF50 0x21
> #define PIN_OUT 0x40
> #define PIN_HP 0xc0
> #define PIN_HP_AMP 0x80
> Did you miss the PIN_HP_AMP option when adding channel mode switchers,
> or is it not available for ALC260, or what? If it's available in ALC260,
> I think it should be added to the list of options. Just to make sure
> we're not missing anything...

It wasn't missed.  You'll notice that PIN_HP_AMP sets a single bit (bit 7)
while PIN_HP sets two (bits 6 and 7).  Bit 7 enables the headphone amp in a
retasking pin while bit 6 enables the pin's output.  PIN_HP_AMP is provided
for convenience for those times when the amp bit itself needs to be directly
manipulated - it's not actually a completely specified mode since it doesn't
make practical sense to enable the power amplifier without also enabling
output (otherwise the amplifier would be amplifying a muted signal).  To
perhaps make this clearer, the PIN_HP definition could be thought of as
being

  #define PIN_HP (PIN_OUT | PIN_HP_AMP)

> Another weird detail. Look at the picture here:
> http://notebooky.idnes.cz/obrazek/acer_tm4600_aspire1690_09.jpg. On my
> mothers notebook (which is almost identical to the one in the pic), the
> outside of Line In and Mic jacks is made of metal, while the outside of
> Headphones jack is made of black plastic. I wonder what is the reason
> for this...

No idea.  Someone in the design section obviously had a reason.  Perhaps
they've done some odd ground isolation arrangement for the headphone output,
but I think it's more likely to be either purely for looks.  Either that or
space constrains required that they use sockets with different dimensions,
and those with a size suitable for the headphone socket only came in plastic.
In any case I very much doubt that this is relevant to the problems at hand.

> >> Well, having no sound from internal speakers in Linux, while having it
> >> in Windows, doesn't seem sensible too... ;) It's as I said - when no
> >> sane options are left, it's probably the time to try those that seem
> >> insane. Just to make sure.
> >>     
> > No arguments there.  I can't help but think that we're missing something
> > though.
> I think so too. However, there's one weird thing - one user of a similar
> laptop said on Ubuntu forums that the sound worked for him initially.

Do you have a URL to the post?

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
