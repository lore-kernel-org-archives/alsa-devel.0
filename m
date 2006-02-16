From: Rimas Kudelis <rq@akl.lt>
Subject: Re: Test model
Date: Thu, 16 Feb 2006 11:29:27 +0200
Message-ID: <20060216092927.GA32525@soften.ktu.lt>
References: <20060215224941.GB11143@soften.ktu.lt> <200602152348.k1FNm4nq021338@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200602152348.k1FNm4nq021338@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Rimas Kudelis <rq@akl.lt>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Good morning,

On Thu, Feb 16, 2006 at 10:18:04AM +1030, Jonathan Woithe wrote:
> I'm now trying out the test model for ALC260. I've already managed to
> > get sound from the Line In jack and Microphone jack. I've also managed
> > to get the internal Mic working.
> 
> Excellent.  Out of interest, which control appears to be connected to
> the internal mic?

Well it's not too surprising. The internal microphone is connected to
the "MIC1" control. And the external too. Whenever I plug something into
the external microphone jack, the internal one gets automatically muted.

The Line In jack is connected to LINE1 control.

Master volume seems to be controlled by LOUT1 control. By muting this, i
get absolute silence.

And the last thing i've found so far is that PCM channel is the one that
Totem media player uses to play its sound. Also, it's used by Sound
Juicer to play the CD. I wonder though - why isn't a Mute control
available for it?


> > However, I haven't heard any sound from either integrated speakers nor the
> > headphones jack. Even after switching a lot of controls in mixer.
> 
> Interesting.  Perhaps the easiest way forward in that case is to switch
> every jack control to "line out" or "headphone out", unmute everything and
> turn up every control to maximum. Then see if you get sound out in any form
> from the internal speaker.  If we get sound at least we know it's possible
> and you can then work backwards to find the controls which affect it.  If we
> don't then there's some head-scratching to do.

That's what I tried yesterday. Switched all controls to Line Out. That's
how I found out what Mic and Line In jacks are connected to. Now these
two are set to Mic and Line In types, respectively. And everything else
is Line Out. Nothing... Same happens when everything else is set to
Headphones.

Btw, when I redirect the output to Line In, and make everything else
(HP-OUT, LINE-OUT, LINE2 and MIC2) be "Headphone" pins, I get a lot of noise 
from the speakers connected to the Line In jack. These seem to catch
some interference even from the video card (just noticed). That
electronic noise differs depending on what I see in the screen atm. Weird...

> It is available, yes.  It's pin widget 0x15, referred to as "LINE2" in
> the mixer controls.  Including it in the test model didn't appear to cause
> any trouble on my laptop during development so I left it in.  I'm yet to
> revisit the reasons as to why I had trouble with this NID during the
> initial S7020 development - currently I suspect a typo which I failed to
> notice at the time.
> 
> Note also that the problem I had was that sending an initverb to this pin
> caused *all* sound to stop.  Since you get sound out of other jacks when
> using the test model I don't think your lack of sound from the headphone
> jack is due to this problem.

Maybe. I just though that maybe it doesn't really mute all the sound,
but just some pins?

I'm almost out of any ideas. :/ Could it be that the notebook uses
digital i/o for its internal speakers/heaphone jack or something like
this?

Rimas



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
