From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000616]: codec read/write timeout is reported on module load, and card is not detected
Date: Fri, 12 Nov 2004 15:12:47 +0100
Message-ID: <c5670e19ee2827cdc19f6c3d60de498c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3216E24B
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2004 15:12:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=616> 
======================================================================
Reported By:                jcpetruzza
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   616
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.8-gentoo-r3
======================================================================
Date Submitted:             10-29-2004 17:09 CEST
Last Modified:              11-12-2004 15:12 CET
======================================================================
Summary:                    codec read/write timeout is reported on module load,
and card is not detected
Description: 
My Ensoniq 1371 rev 7 based card is not detected.

dmesg shows:

PCI: Found IRQ 12 for device 0000:00:09.0
codec write timeout at 0xec14 [0x40000000]
es1371: codec read timeout at 0xec14 [0x40000000]
es1371: codec read timeout at 0xec14 [0x40000000]
es1371: codec read timeout at 0xec14 [0x40000000]
.
.
.
codec write timeout at 0xec14 [0x40000000]
es1371: codec read timeout at 0xec14 [0x40000000]
AC'97 0 does not respond - RESET
es1371: codec read timeout at 0xec14 [0x40000000]
es1371: codec read timeout at 0xec14 [0x40000000]
AC'97 0 access is not valid [0x0], removing mixer.
ENS1371: probe of 0000:00:09.0 failed with error -5

======================================================================

----------------------------------------------------------------------
 jcpetruzza - 11-12-04 15:12 
----------------------------------------------------------------------
I'd be glad to help in the diagnose and fixup of this problem if any
directions are given

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-29-04 17:09 jcpetruzza     New Issue                                    
10-29-04 17:09 jcpetruzza     Kernel Version            => 2.6.8-gentoo-r3 
11-12-04 15:12 jcpetruzza     Note Added: 0002397                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
