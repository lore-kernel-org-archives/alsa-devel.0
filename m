From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Test model
Date: Fri, 17 Feb 2006 12:29:34 +1030 (CST)
Message-ID: <200602170159.k1H1xYkI018018@auster.physics.adelaide.edu.au>
References: <20060216092927.GA32525@soften.ktu.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060216092927.GA32525@soften.ktu.lt> from "Rimas Kudelis" at Feb 16, 2006 11:29:27 AM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Rimas Kudelis <rq@akl.lt>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

> > Excellent.  Out of interest, which control appears to be connected to
> > the internal mic?
> 
> Well it's not too surprising. The internal microphone is connected to
> the "MIC1" control. And the external too. Whenever I plug something into
> the external microphone jack, the internal one gets automatically muted.

Right - it's as I suspected then: the switching between internal and external
microphone is done by hardware: there is no software control over this.

> The Line In jack is connected to LINE1 control.
> Master volume seems to be controlled by LOUT1 control. By muting this, i
> get absolute silence.

Good, that all makes sense.

> And the last thing i've found so far is that PCM channel is the one that
> Totem media player uses to play its sound. Also, it's used by Sound
> Juicer to play the CD. I wonder though - why isn't a Mute control
> available for it?

The "PCM" control is (AFAIK) a software control created when something opens
the ALSA driver for audio I/O.  I've never fully understood why this control
appears and I'm not entirely sure what it controls.  At some point I thought
it could be software-only (ie: having no connection to actual hardware) but
it might instead control the gain cell on the output of the DAC.  If this is
the case though I don't know why it only appears when something has used
ALSA for output - why not have it present in alsamixer at all times?  In any
case there's obviously something special about this particular control which
explains why there is no mute.

> > > However, I haven't heard any sound from either integrated speakers nor the
> > > headphones jack. Even after switching a lot of controls in mixer.
> > 
> > Interesting.  Perhaps the easiest way forward in that case is to switch
> > every jack control to "line out" or "headphone out", unmute everything and
> > turn up every control to maximum. Then see if you get sound out in any form
> > from the internal speaker.  If we get sound at least we know it's possible
> > and you can then work backwards to find the controls which affect it.  If we
> > don't then there's some head-scratching to do.
> 
> That's what I tried yesterday. Switched all controls to Line Out. That's
> how I found out what Mic and Line In jacks are connected to. Now these
> two are set to Mic and Line In types, respectively. And everything else
> is Line Out. Nothing... Same happens when everything else is set to
> Headphones.

Very interesting.  The only difference between the "line out" and "headphone"
setting is that the latter enables an onboard amplifier which allows it
to drive headphones to a louder volume.  On the headphones I've tried 
you still get adequate output when the pin is "lineout" - it's just slightly
louder when "headphone" mode is selected.

> Btw, when I redirect the output to Line In, and make everything else
> (HP-OUT, LINE-OUT, LINE2 and MIC2) be "Headphone" pins, I get a lot of
> noise from the speakers connected to the Line In jack. These seem to catch
> some interference even from the video card (just noticed). That electronic
> noise differs depending on what I see in the screen atm. Weird...

Which output - the headphone jack?  What kind of noise - squeals or hiss?

> > It is available, yes.  It's pin widget 0x15, referred to as "LINE2" in
> > the mixer controls.  Including it in the test model didn't appear to cause
> > any trouble on my laptop during development so I left it in.  I'm yet to
> > revisit the reasons as to why I had trouble with this NID during the
> > initial S7020 development - currently I suspect a typo which I failed to
> > notice at the time.
> > 
> > Note also that the problem I had was that sending an initverb to this pin
> > caused *all* sound to stop.  Since you get sound out of other jacks when
> > using the test model I don't think your lack of sound from the headphone
> > jack is due to this problem.
> 
> Maybe. I just though that maybe it doesn't really mute all the sound,
> but just some pins?

Not sure at this stage.  Feel free to comment out the things which touch
node ID 0x15 and try again (after recompiling/reboot), but based on
experience to date I don't think it will change things.  In the face of no
other suggestions however it might be worth trying.

> I'm almost out of any ideas. :/ Could it be that the notebook uses
> digital i/o for its internal speakers/heaphone jack or something like
> this?

That would be extremely strange - as a system designer, why require the use
of an external DAC when you have a perfectly servieable one already in the
laptop?

A couple of other random thoughts:

  1) You're not using a docking station, are you?

  2) Does the laptop have an external volume control?  If so, is it turned
     up to maximum?

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
