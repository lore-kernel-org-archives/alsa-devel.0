From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001283]: Allegro-1 does not generate interrupts - but does on linux 2.4.27
Date: Wed, 22 Mar 2006 03:05:29 +0100
Message-ID: <241beeed21e7437604f065bccf796a5e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DEBB11A1
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:05:29 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1283> 
======================================================================
Reported By:                sclark46
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1283
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1398_FC4
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-27-2005 03:51 CEST
Last Modified:              03-22-2006 03:05 CET
======================================================================
Summary:                    Allegro-1 does not generate interrupts - but does on
linux 2.4.27
Description: 
Aplay fails with a write error and the following error message:
Jul 26 21:06:14 joker4 kernel: ALSA
/home/sclark/alsa-driver-1.0.9rc4a/acore/pcm_native.c:1442: playback drain
error (DMA or IRQ trouble?)

The sound clip plays repeatedly until that error pops up.

I booted a Knoppix CD to verify the HW worked and sound played correctly.
The Knoppix kernel was 2.4.27


======================================================================

----------------------------------------------------------------------
 rlrevell - 07-30-05 09:11 
----------------------------------------------------------------------
This should be reported to the kernel bugzilla.

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:05 
----------------------------------------------------------------------
Not an ALSA bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-27-05 03:51 sclark46       New Issue                                    
07-27-05 03:51 sclark46       Distribution              => Fedora Core 4   
07-27-05 03:51 sclark46       Kernel Version            => 2.6.12-1.1398_FC4
07-27-05 03:52 sclark46       Issue Monitored: sclark46                    
07-27-05 03:52 sclark46       Issue End Monitor: sclark46                    
07-30-05 05:21 sclark46       Note Added: 0005588                          
07-30-05 09:11 rlrevell       Note Added: 0005590                          
03-22-06 03:05 rlrevell       Status                   assigned => closed  
03-22-06 03:05 rlrevell       Note Added: 0008794                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
