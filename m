From: ST <st@iss.tu-darmstadt.de>
Subject: Tascam US122 on Arm
Date: Sun, 30 Sep 2007 01:16:50 +0200
Message-ID: <200709300116.50747.st@iss.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lnx131.hrz.tu-darmstadt.de (lnx131.hrz.tu-darmstadt.de
	[130.83.174.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6C396244E5
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Sep 2007 01:17:05 +0200 (CEST)
Received: from mailserver3.hrz.tu-darmstadt.de (lnx116.hrz.tu-darmstadt.de
	[130.83.174.28])
	by lnx131.hrz.tu-darmstadt.de (8.13.4/8.12.10) with ESMTP id
	l8TNGxlt029555
	for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2007 01:16:59 +0200
Received: from [213.157.9.213] (helo=IP-213157009213.dialin.heagmedianet.de)
	by mailserver3.hrz.tu-darmstadt.de with esmtpsa
	(TLS-1.0:DHE_RSA_AES_128_CBC_SHA:16) (Exim 4.50) id 1IblYQ-0008DG-W0
	for alsa-devel@alsa-project.org; Sun, 30 Sep 2007 01:16:59 +0200
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi 

I am a little irritated that there has been no replies to my questions to this 
list  
(http://mailman.alsa-project.org/pipermail/alsa-devel/2007-September/003387.html,
http://mailman.alsa-project.org/pipermail/alsa-devel/2007-September/003083.html).

Am i on the wrong list? Please tell me if so.

Probably its also that i didn't make clear in my last post that the tascam 
driver works on arm with my US122 sound card, for ca. 51 seconds. After that 
i get the following error:

Sequence Error!(hcd_frame=6 ep=8in;wait=65538,frame=2).
Most propably some urb of usb-frame 65538 is still missing.
Cause could be too long delays in usb-hcd interrupt handling.

I also tried 
insmod ./2.6.18/kernel/sound/usb/usx2y/snd-usb-usx2y.ko nrpacks=X
with X=[1,2,4,8]. I thought that if it is really an CPU performance problem 
than probably a bigger buffer would eliminate the problem. However the error 
persisted. Even commenting out /* #define USX2Y_NRPACKS_VARIABLE y */ and 
setting #define USX2Y_NRPACKS 1 didn't help.

So my question is now, is the 250Mhz ARM really to slow or is there any chance 
that there is an error in either the usb stack or the driver exposed only on 
the ARM architecture? Things speaking for the latter are:
*Error allways in the 65536-65540 value.
*Error happens most of the times after about 50secs.

Since i do not know much about USB any hint is apreciated.
ST
