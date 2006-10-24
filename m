From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Unsupported Realtek ALC260 (snd-hda-intel)
Date: Tue, 24 Oct 2006 14:40:01 +0930 (CST)
Message-ID: <200610240510.k9O5A1X2007019@turbo.physics.adelaide.edu.au>
References: <453D9685.6060606@mcs.vuw.ac.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <453D9685.6060606@mcs.vuw.ac.nz> from "David Friggens" at Oct 24,
	2006 05:28:53 PM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: David Friggens <david.friggens@mcs.vuw.ac.nz>
Cc: alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi David

> >  * the output of the lspci -nvv command
> attached

Thanks.  Could you also sent the output of
  lspci
please?  It'll save me cross-referencing PCI IDs.

> >  * a list of the audio inputs/outputs provided on your laptop (jacks,
> >    internal speakers, internal microphones etc)
> 
> Internal speaker, headphone jack and microphone jack.
> 
> > Was the mic jack the only place you were able to get sound out of?
> 
> Yes - nothing from the headphone jack or speakers.
> :
> Yes - full volume everywhere and everything unmuted.
> :
> Yes, I tried all permutations of the four GPIO controls and nothing changed.

It would seem that both the headphone jack and the internal speaker are
being driven by an amplifier outside the ALC260 which is switched on using
mechanisms independent of the ALC260 chip itself.  This would be the second
laptop we've encountered with a similar issue - even though everything's
up these two outputs refuse to produce any sound.

I'll be pondering this issue over the next few days to see if there's
something obvious that I've missed - perhaps there's an obscure object in
the ALC260 that the test model doesn't unmute which is needed by these HP
laptops.  Maybe others on the list have ideas as well.

Final thought for the day: could you use alsamixer to change all the
pin modes to "Line-in" and then back to "Line-out" or "headphones".  Then
try the tests again and see if you get audio from any additional jacks or
the internal speaker.

Regards
  jonathan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
