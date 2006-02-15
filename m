From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Test model
Date: Thu, 16 Feb 2006 10:18:04 +1030 (CST)
Message-ID: <200602152348.k1FNm4nq021338@auster.physics.adelaide.edu.au>
References: <20060215224941.GB11143@soften.ktu.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060215224941.GB11143@soften.ktu.lt> from "Rimas Kudelis" at Feb 16, 2006 12:49:41 AM
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

Hi Rimas

> I'm now trying out the test model for ALC260. I've already managed to
> get sound from the Line In jack and Microphone jack. I've also managed
> to get the internal Mic working.

Excellent.  Out of interest, which control appears to be connected to
the internal mic?

> However, I haven't heard any sound from either integrated speakers nor the
> headphones jack. Even after switching a lot of controls in mixer.

Interesting.  Perhaps the easiest way forward in that case is to switch
every jack control to "line out" or "headphone out", unmute everything and
turn up every control to maximum. Then see if you get sound out in any form
from the internal speaker.  If we get sound at least we know it's possible
and you can then work backwards to find the controls which affect it.  If we
don't then there's some head-scratching to do.

> I remembered you mentioning some nasty pin that "should be better not be
> touched", and wanted to ask you if this pin is available for control, if I
> choose the text model?

It is available, yes.  It's pin widget 0x15, referred to as "LINE2" in
the mixer controls.  Including it in the test model didn't appear to cause
any trouble on my laptop during development so I left it in.  I'm yet to
revisit the reasons as to why I had trouble with this NID during the
initial S7020 development - currently I suspect a typo which I failed to
notice at the time.

Note also that the problem I had was that sending an initverb to this pin
caused *all* sound to stop.  Since you get sound out of other jacks when
using the test model I don't think your lack of sound from the headphone
jack is due to this problem.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
