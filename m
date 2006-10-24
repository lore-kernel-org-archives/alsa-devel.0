From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Unsupported Realtek ALC260 (snd-hda-intel)
Date: Tue, 24 Oct 2006 16:23:51 +0930 (CST)
Message-ID: <200610240653.k9O6rpah011042@turbo.physics.adelaide.edu.au>
References: <1161671494.6960.6.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1161671494.6960.6.camel@razman> from "Tobin Davis" at Oct 23,
	2006 11:31:34 PM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

> Hang tight.  With this info we should be able to get a driver working
> for you.  Fortunately, Realtek is one of the friendly companies, and all
> of their specs are online.

This is all true.  However, the outcomes posted by David and Andrea suggest
that in their particular laptops there is something *outside* the ALC260
chip itself which is preventing the speaker and headphone jack from passing
audio.  The alc260 test model provides access to almost all the control
ports offered by the ALC260.  If one doesn't get audio when using the test
mode with all pins configured as outputs, everything unmuted and all volumes
set to maximum, there's not much left at the chip level to try.

For example there are some Acer laptops which appear to implement their own
amplifier for the internal speaker which is only powered up when one of the
ALC260's GPIO lines is raised.  However, there's nothing stopping the
manufacturers from using some other enabling mechanism and if this is done
it's outside the scope of the Realtek chip; thus in this case Realtek might
not have the information themselves to provide assistance.

Having said all that I'm still hoping that there's something obvious I've
missed in the test mode configuration.

Regards
  jonathan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
