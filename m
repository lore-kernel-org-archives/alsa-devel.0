From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Documentation Bugs
Date: Sun, 25 Jan 2004 18:23:51 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40138B27.4050001@boosthardware.com>
References: <1074896628.13428.189.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www3.webhosting.cx (IDENT:EsDxkAIhi7Xwa7weJAIQorrbB7lyy/V4@www3.webhosting.cx [207.44.248.26])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA12306
	for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2004 10:25:27 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Torrey Hoffman wrote:
> I've been working through the .asoundrc documentation and have found
> several errors.
> 

Thanks for the detailed report.

I have fixed the obvious errors but I'm not sure what the problem is 
with the rate_convert example. I have left it as is for now.



> 
> ------------------------------------------------------
> 3. The rate conversion plug documentation (or code?) is broken.
> 
> I'm not sure if this is a documentation bug or a driver/alsa-lib bug. 
> 
> My .asoundrc at this point closely follows the documentation (with
> corrections as noted in bug#2) and looks like:
> 
> pcm.ac97 {
> 	type hw
> 	card 0
> 	device 0
> }
> 
> pcm_slave.sl2 {
> 	pcm ac97
> 	rate 44100
> }
> 
> pcm.rate_convert {
> 	type rate
> 	slave sl2
> }
> 
> The documentation says:  
> "Now you can call this newly created virtual device by: aplay -D
> rate_convert test.wav"
> 
> But when I try that, I get this error:
> 
> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> aplay: set_params:805: Broken configuration for this PCM: no configurations available
> 
> Note that "aplay -D ac97 test.wav" works, but plays too fast (at 48000),
> and gives the warning "please, try the plug plugin (-Dplug:ac97)". If I
> do that, it works perfectly.
> 
> So I think the documentation is wrong, or at least incomplete, or rate
> conversion does not work.
> 


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================


  Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
