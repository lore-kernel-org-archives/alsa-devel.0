From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Test model
Date: Mon, 20 Feb 2006 17:02:28 +1030 (CST)
Message-ID: <200602200632.k1K6WSL8016070@auster.physics.adelaide.edu.au>
References: <43F95455.1030502@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43F95455.1030502@akl.lt> from "Rimas Kudelis" at Feb 20, 2006 07:32:05 AM
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

> BTW one of the actions I tried last weekend was recording something from
> the microphone. And it failed too. selecting one (don't remember which,
> though) of the capture channels for capture resulted in continuous noise
> being recorded, and selecting the other one resulted in silence. Also,
> selecting both resulted in sum of these, hence, noise again...

What sort of noise - hiss I assume?  Secondly, what do you mean by
"selecting both"?  Do you mean that both capture sources were pointed at the
same source?  If so you wouldn't have recorded the sum; the two ADCs are on
separate pcms, so you would only have been recording one or the other in
this case.

What kind of microphone were you using?  Did you have a bias setting
configured for the jack the mic was connected to?

> Also, not sure if it's alsamixer's or driver's fault, alsamixer always 
> says "Input Source 1" is "1", even though it selects the required source.

I'm confused by this - "1" isn't an option AFAIK.  "MIC1", "MIC2", "LINE1",
"LINE2" etc are the options.

> Jonathan, I think that maybe the "test" model should have even more 
> controls to play with, even those that may seem like should never be 
> used? For example, there seem to be no checkboxes or something similar 
> to control S/PDIF NIDs

That's because I cannot test SPDIF inputs since they are not brought out
to the outside world on my laptop.  Therefore I can't test prospective
controls.

> or jack (pin) widgets and so on.

With the exception of the SPDIF pins, all output pins provided by the ALC260
are already available in the mixer controls of the test model.  In other
words, all the *analog* outputs should be present.  Have I missed some? 
Which NIDs in particular are you referring to?

> Such controls might be useful for testing, when nothing else seems to work
> out

If all analog pins are already catered for there's really no other options
left.  Again, perhaps if you could elaborate on which controls you're
thinking about things might become clearer.  In terms of the ongoing Acer
saga, we probably need to take a step back and recap between yourself,
Paulo and me precisely what works, what doesn't and what's been tried.  I'll
pick this up in a day or so after giving things a bit more thought.

> In order not to clutter the default tester's mixer interface, maybe this
> (at least partially) should go to some kind of an "extended test" model, i
> don't know.

No, all controls belong in the test model.  It's a *test* model, so
cluttering of the mixer isn't really a problem.

> BTW, if I haven't misunderstood the datasheet, I think it says that 
> S/PDIF NIDs (0x03 and 0x06, if I remember correctly) can be told to 
> output Analog audio, along with the other channels.

I never noticed this - what page(s) of the datasheet appear to suggest this
to you?

> Could this possibly be Acer's case? I'm asking this because these were
> probably the only NIDs that I didn't even try to play with...

Digital outputs are digital outputs I would have thought - I can't imagine
why they would be retaskable to analog, and I certainly didn't notice this
possibility myself when I went through the datasheet.  If you had a page
number I could look at I'll investigate further.

The only way I would have thought the digital outputs could come into play
is if for some reason the internal speaker and headphone jack were driven
off an external DAC.  As I mentioned in a previous post though this doesn't
seem sensible from where we stand.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
