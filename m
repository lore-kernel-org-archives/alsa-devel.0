From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002128]: timeout: still 8 active urbs.. when using plantronics usb headset on my asus a6km notebook
Date: Tue, 16 May 2006 00:11:14 +0200
Message-ID: <1457c9ca36bb938e4e4053249f3986b1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 250DF23A
	for <alsa-devel@alsa-project.org>; Tue, 16 May 2006 00:11:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2128> 
======================================================================
Reported By:                eNTi
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2128
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               arch linux
Kernel Version:             Linux defiler 2.6.16-beyond-git #16 PREEMPT Mon May
15 22:51:30 CEST 2006 i686 AMD Turion(tm) 64 Mobile Technology MT-30
AuthenticAMD GNU/Linux
======================================================================
Date Submitted:             05-16-2006 00:11 CEST
Last Modified:              05-16-2006 00:11 CEST
======================================================================
Summary:                    timeout: still 8 active urbs.. when using
plantronics usb headset on my asus a6km notebook
Description: 
i've tried to listen to music via my plantronics usb headset, because the
sound from the notebook i just ugly. i compiled the alsa-usb as module and
could listen to music in audacious from my usb-mounted external harddrive.
this works for about 1/2 to 1 1/2 songs. then the sound stops apruptly and
audacious tries hard to play another song, after it somehow "realizes"
that the current one cant be played any longer. no playback is possible
any longer and even other processes start to behave very unresponsive. ps
uax or top will hang and can't be killed. cpu utilization rises and dmesg
spills some:

timeout: still X active urbs..

where X was a int between 4 and 8 (from my observation).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-16-06 00:11 eNTi           New Issue                                    
05-16-06 00:11 eNTi           Distribution              => arch linux      
05-16-06 00:11 eNTi           Kernel Version            => Linux defiler
2.6.16-beyond-git #16 PREEMPT Mon May 15 22:51:30 CEST 2006 i686 AMD Turion(tm)
64 Mobile Technology MT-30 Authent
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
