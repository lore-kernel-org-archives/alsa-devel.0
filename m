From: ST <st@iss.tu-darmstadt.de>
Subject: Tascam US122 on ARM [PATCH] and error :-(
Date: Fri, 21 Sep 2007 22:48:47 +0200
Message-ID: <200709212248.47757.st@iss.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lnx131.hrz.tu-darmstadt.de (lnx131.hrz.tu-darmstadt.de
	[130.83.174.25]) by alsa0.perex.cz (Postfix) with ESMTP id A38B924684
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Sep 2007 22:49:11 +0200 (CEST)
Received: from mailserver3.hrz.tu-darmstadt.de (lnx116.hrz.tu-darmstadt.de
	[130.83.174.28])
	by lnx131.hrz.tu-darmstadt.de (8.13.4/8.12.10) with ESMTP id
	l8LKmskT011666
	for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2007 22:48:54 +0200
Received: from [213.157.27.41] (helo=IP-213157027041.dialin.heagmedianet.de)
	by mailserver3.hrz.tu-darmstadt.de with esmtpsa
	(TLS-1.0:DHE_RSA_AES_128_CBC_SHA:16) (Exim 4.50) id 1IYpQk-0002Fv-8L
	for alsa-devel@alsa-project.org; Fri, 21 Sep 2007 22:48:54 +0200
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

I managed to get the snd_usb_usx2y driver running on an Linksys NSLU2.
The whole stuff is running under debian etch. 

Kernel Version is 2.6.18 with Debian patches. Below is a little patch 
to be able to enable the driver. Unfortunatly the driver gives the error:

Sequence Error!(hcd_frame=7 ep=8in;wait=65539,frame=3).
Most propably some urb of usb-frame 65539 is still missing.
Cause could be too long delays in usb-hcd interrupt handling.

Which is the output of the function usX2Y_error_sequence. This function is 
only called from usbusx2yaudio.c:328. Since all numbers lie just above 65535
(They are all between 65537 and 65540) is suspect that there is some wrap 
around error, especially because the values are anded with a 16 bit mask 
(0xffff). But unfortunatly i don't know to much about usb right now. Any 
hints to resolve this problem?

The cpu runs with 266Mhz, so it could be that it would be really to slow, but 
i really suspect an wrap-around error. Any hints or ideas to solve this 
issue?

Thanks
ST
 
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -18,7 +18,7 @@ config SND_USB_AUDIO

 config SND_USB_USX2Y
        tristate "Tascam US-122, US-224 and US-428 USB driver"
-       depends on SND && USB && (X86 || PPC || ALPHA)
+       depends on SND && USB && (X86 || PPC || ALPHA ||ARM)
        select SND_HWDEP
        select SND_RAWMIDI
        select SND_PCM
