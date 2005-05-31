From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000395]: No Sound-Output on FSC D1219 Mainboard (OSS-Free from Kenrel works)
Date: Tue, 31 May 2005 17:57:00 +0200
Message-ID: <49ec472c9c09c3dece55a5e3bf299164@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 05DF51C6
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 17:57:01 +0200 (MEST)
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
Status:                     closed
Distribution:               Fedora Core 2
Kernel Version:             2.6.6-1.435.2.3
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             07-17-2004 11:32 CEST
Last Modified:              05-31-2005 17:57 CEST
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
 thorstenl - 03-25-05 15:27 
----------------------------------------------------------------------
jdthood, thanks for the tip. I removed the system/boards two weeks ago, so
I can't try it anymore.

----------------------------------------------------------------------
 thorstenl - 03-25-05 15:31 
----------------------------------------------------------------------
Seems I'm blind. I can't find any option to close this bug...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-17-04 11:32 thorstenl      New Issue                                    
07-17-04 11:32 thorstenl      File Added: fsc_d1219                        
07-17-04 11:32 thorstenl      Distribution              => Fedora Core 2   
07-17-04 11:32 thorstenl      Kernel Version            => 2.6.6-1.435.2.3 
07-17-04 11:33 thorstenl      Issue Monitored: thorstenl                    
03-23-05 16:11 jdthood        Note Added: 0004176                          
03-25-05 15:27 thorstenl      Note Added: 0004208                          
03-25-05 15:27 thorstenl      Issue End Monitor: thorstenl                    
03-25-05 15:31 thorstenl      Note Added: 0004209                          
03-25-05 15:46 jdthood        Status                   new => resolved     
03-25-05 15:46 jdthood        Resolution               open => unable to
duplicate
05-31-05 17:57 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
