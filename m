From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Unsupported Realtek ALC260 (snd-hda-intel)
Date: Tue, 24 Oct 2006 11:54:53 +0930 (CST)
Message-ID: <200610240224.k9O2Oruo000769@turbo.physics.adelaide.edu.au>
References: <mailman.41803.1161639871.22397.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.41803.1161639871.22397.alsa-devel@lists.sourceforge.net>
	from "alsa-devel-request@lists.sourceforge.net" at Oct 23,
	2006 02:44:31 PM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: David.Friggens@mcs.vuw.ac.nz, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi David

> > Hi. I've been trying to get the Realtek ALC260 sound card in my new
> > (HP) Compaq Presario B1900 laptop to work. I followed Jonathan
> > Woithe's recent advice to Andrew Neporada - I compiled the 1.0.13
> > drivers with the debug option and used model=test. With all "pin
> > mode" controls set to headphone I'm getting sound through the
> > microphone jack.
> 
> Is anyone able to help me get this card to work? Let me know if I need
> to provide any more information. I'm pleased to have got some sound
> through the test driver, but I don't know where to go from here.

Could you please send me:

 * the output of the
     lspci -nvv
   command

 * the make and model number of your laptop

 * a list of the audio inputs/outputs provided on your laptop (jacks,
   internal speakers, internal microphones etc)

I also need a few more details about what you achieved with the "model=test"
tests.  Was the mic jack the only place you were able to get sound out of?
Did you unmute every control under alsamixer and turn every volume control
to maximum?  Did you try to change the GPIO controls to see if that made any
difference to any of the jacks and/or the internal speaker?

Best regards
  jonathan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
