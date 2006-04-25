From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002070]: Hard lockup from aplay with low buffersizes on Tascam us-122 (snd_usb_usx2y)
Date: Tue, 25 Apr 2006 23:07:54 +0200
Message-ID: <1bd468fa639e4c5d5c1d3c89c10fec44@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 24442173
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2006 23:07:55 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2070> 
======================================================================
Reported By:                jaime
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   2070
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo ~x86
Kernel Version:             2.6.17-rc1
======================================================================
Date Submitted:             04-25-2006 23:07 CEST
Last Modified:              04-25-2006 23:07 CEST
======================================================================
Summary:                    Hard lockup from aplay with low buffersizes on
Tascam us-122 (snd_usb_usx2y)
Description: 
Hi.

Here's the original I'm playing (440Hz sine wave):
www.carbon.eclipse.co.uk/origSine.wav

aplay --buffer-size=1024 origSine.wav sounds great:
www.carbon.eclipse.co.uk/aplay1024.wav

aplay --buffer-size=512 origSine.wav sounds bad:
www.carbon.eclipse.co.uk/aplay512.wav

aplay --buffer-size=256 origSine.wav sounds very bad:
www.carbon.eclipse.co.uk/aplay256.wav

aplay --buffer-size=128 origSine.wav gives only a very short click,
and then locks up the machine completely:
www.carbon.eclipse.co.uk/aplay128.wav

I've tried this using different usb cards/controllers, and I get the
same problem, so I think it is an alsa driver problem.

Thank you for any help you can offer.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-06 23:07 jaime          New Issue                                    
04-25-06 23:07 jaime          Distribution              => Gentoo ~x86     
04-25-06 23:07 jaime          Kernel Version            => 2.6.17-rc1      
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
