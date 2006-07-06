From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002250]: No/Broken Master/PCM volume
	control
Date: Thu, 6 Jul 2006 20:23:54 +0200
Message-ID: <d21ac490b5144bb6797a98b318dc2fbd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 27BD425F
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 20:23:55 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2250> 
======================================================================
Reported By:                jengelh
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2250
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               SUSE LINUX 10.1 (i586)
Kernel Version:             
======================================================================
Date Submitted:             07-02-2006 00:51 CEST
Last Modified:              07-06-2006 20:23 CEST
======================================================================
Summary:                    No/Broken Master/PCM volume control
Description: 
My onboard soundcard does not show any volume control for "Master" in
`alsamixer` (see attached file). Changing the "PCM" volume also has no
effect (it is always loud, even when set to 2%), only Mute works.

$ lspci
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
AC'97 Sound Controller (rev a0)
$ lspci -n
00:02.7 Class 0401: 1039:7012 (rev a0)
$ cat /etc/SuSE-release 
SUSE LINUX 10.1 (i586)
VERSION = 10.1
$ rpm -q alsa
alsa-1.0.11-32

I believe this is a hardware limitation, though.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-06-06 20:23 
----------------------------------------------------------------------
There is no master control on your codec.  The PCM volume is implemented in
alsa-lib plugin, so it doesn't work for kernel OSS emulation, which I
guess you're doing.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-02-06 00:51 jengelh        New Issue                                    
07-02-06 00:51 jengelh        File Added: alsamixer-c1.png                    
07-02-06 00:51 jengelh        Distribution              => SUSE LINUX 10.1
(i586)
07-06-06 20:23 tiwai          Note Added: 0010878                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
