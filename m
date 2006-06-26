From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002222]: Mitac 8258D,
	no sound   Intel ICH7 HDA Realtek ALC883 codec
Date: Mon, 26 Jun 2006 16:15:58 +0200
Message-ID: <9692572c7185ebad285011eac34f80ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0813413E
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 16:15:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2222> 
======================================================================
Reported By:                jolly67
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2222
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               OpenSuSE 10.1 i386
Kernel Version:             Linux 2.6.16.13-4-smp (geeko@buildhost) (gcc 4.1.0)
#1 SMP Wed May 3 04:53:23 UTC 2006
======================================================================
Date Submitted:             06-21-2006 15:02 CEST
Last Modified:              06-26-2006 16:15 CEST
======================================================================
Summary:                    Mitac 8258D, no sound   Intel ICH7 HDA Realtek
ALC883 codec
Description: 
No working configuration for this hardware. The system is detect the sound
card and setup hda_intel module for them. But no sound. No master
control.
Only PCM, Front, Line, CD and Mic
======================================================================

----------------------------------------------------------------------
 tiwai - 06-26-06 16:15 
----------------------------------------------------------------------
There is no "Master" volume control for ALC883.

Anyway, you can try different model options described in
ALSA-Configuration.txt.

Also, I have some fix patches for ALC883, and will commit later to HG repo
after some clean up / fixes.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-21-06 15:02 jolly67        New Issue                                    
06-21-06 15:02 jolly67        File Added: hwinfo.log                       
06-21-06 15:02 jolly67        Distribution              => OpenSuSE 10.1 i386
06-21-06 15:02 jolly67        Kernel Version            => Linux 2.6.16.13-4-smp
(geeko@buildhost) (gcc 4.1.0) #1 SMP Wed May 3 04:53:23 UTC 2006
06-21-06 15:09 jolly67        File Added: lspci.log                        
06-22-06 08:21 jolly67        File Added: card0_codec#0                    
06-22-06 08:21 jolly67        File Added: card0_codec#1                    
06-26-06 16:15 tiwai          Note Added: 0010545                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
