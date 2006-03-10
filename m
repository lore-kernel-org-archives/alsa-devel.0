From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001658]: Capture happens only on one channel
Date: Fri, 10 Mar 2006 19:15:11 +0100
Message-ID: <0966761501c7501a36247659d3580ad1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A7E9219A
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2006 19:15:11 +0100 (MET)
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


The following issue has been REOPENED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1658> 
======================================================================
Reported By:                phil_troin
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1658
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               Gentoo
Kernel Version:             2.6.14-gentoo-r2
======================================================================
Date Submitted:             12-18-2005 08:40 CET
Last Modified:              03-10-2006 19:15 CET
======================================================================
Summary:                    Capture happens only on one channel
Description: 
When I am playing a CD, if I capture the sound output via the capture
channel OR the CD channel (amixer output attached), the captured sound is
only one one channel (the right one) and is very distorted.
The audio plays normally in stereo on the speakers.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001784 line input not recording right channel
======================================================================

----------------------------------------------------------------------
 Matthias Koenig - 01-18-06 11:53 
----------------------------------------------------------------------
Indeed, updating alsa-lib to the latest version fixes the problem.
I misleadingly assumed the bug in the kernel driver.
Thank you very much!

----------------------------------------------------------------------
 jdthood - 03-10-06 19:15 
----------------------------------------------------------------------
In Debian bug report 350138 it is reported that the bug is still present in
1.0.11rc2.

    http://bugs.debian.org/350138

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-18-05 08:40 phil_troin     New Issue                                    
12-18-05 08:40 phil_troin     File Added: amixout                          
12-18-05 08:40 phil_troin     Distribution              => Gentoo          
12-18-05 08:40 phil_troin     Kernel Version            => 2.6.14-gentoo-r2
12-18-05 12:00 linuxbear      Note Added: 0007071                          
12-18-05 12:02 linuxbear      Note Edited: 0007071                         
12-27-05 10:34 linuxbear      Issue Monitored: linuxbear                    
01-07-06 06:24 tgutwin        Note Added: 0007508                          
01-07-06 06:25 tgutwin        Issue Monitored: tgutwin                     
01-09-06 01:34 legluondunet   Note Added: 0007529                          
01-09-06 01:35 legluondunet   File Added: alsa.conf.record1channel              
     
01-09-06 01:37 legluondunet   File Added: alsa.conf.ubuntu                    
01-09-06 01:43 legluondunet   Note Added: 0007530                          
01-13-06 02:17 rlrevell       Note Added: 0007615                          
01-13-06 14:29 Matthias KoenigNote Added: 0007640                          
01-13-06 17:12 legluondunet   Note Added: 0007644                          
01-13-06 17:46 vsu            Note Added: 0007645                          
01-13-06 17:49 vsu            Issue Monitored: vsu                         
01-13-06 17:51 tiwai          Note Added: 0007646                          
01-13-06 18:17 vsu            Note Added: 0007647                          
01-18-06 11:53 Matthias KoenigNote Added: 0007709                          
01-18-06 18:16 rlrevell       Status                   new => resolved     
01-18-06 18:16 rlrevell       Resolution               open => fixed       
01-18-06 18:16 rlrevell       Assigned To               => rlrevell        
01-26-06 20:45 rlrevell       Relationship added       has duplicate 0001784
03-10-06 19:15 jdthood        Status                   resolved => feedback
03-10-06 19:15 jdthood        Resolution               fixed => reopened   
03-10-06 19:15 jdthood        Note Added: 0008409                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
