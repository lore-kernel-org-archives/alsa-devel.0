From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000395]: No Sound-Output on FSC D1219 Mainboard (OSS-Free from Kenrel works)
Date: Wed, 23 Mar 2005 16:11:25 +0100
Message-ID: <8ba235f37e633632c89b638c2771e86c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 91B3A289
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 16:11:25 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=395> 
======================================================================
Reported By:                thorstenl
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   395
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 2
Kernel Version:             2.6.6-1.435.2.3
======================================================================
Date Submitted:             07-17-2004 11:32 CEST
Last Modified:              03-23-2005 16:11 CET
======================================================================
Summary:                    No Sound-Output on FSC D1219 Mainboard (OSS-Free
from Kenrel works)
Description: 
On my Fujitsu Siemens D1219 Mainboard the snd-intel8x0 from alsa 1.05a
(compiled by myself) or the version that comes with the Fedora Core 2
Kernel (2.6.6-1.435.2.3; alsa 1.04a) are not able to output any sound.
Trying to experiment with the different volume settings in alsamixer did
not help. With the oss-free module i810_audio (compiled from the Fedora
Core 2 kernel-sourcecode) it works fine.  
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 16:11 
----------------------------------------------------------------------
Try switching 'External Amplifier' off.   Or on.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-17-04 11:32 thorstenl      New Issue                                    
07-17-04 11:32 thorstenl      File Added: fsc_d1219                        
07-17-04 11:32 thorstenl      Distribution              => Fedora Core 2   
07-17-04 11:32 thorstenl      Kernel Version            => 2.6.6-1.435.2.3 
07-17-04 11:33 thorstenl      Issue Monitored: thorstenl                    
03-23-05 16:11 jdthood        Note Added: 0004176                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
