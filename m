From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001574]: mpd loops in random manner.
Date: Thu, 17 Nov 2005 17:47:32 +0100
Message-ID: <dc1557cad4385dad01bc24874cff7b8f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3631C1AA
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2005 17:47:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1574> 
======================================================================
Reported By:                dothebart
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1574
Category:                   0_general
Reproducibility:            random
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-17-2005 17:45 CET
Last Modified:              11-17-2005 17:47 CET
======================================================================
Summary:                    mpd loops in random manner.
Description: 
happenes once a week. mpd runs and runs, and suddenly, it loops over 3
seconds or so. Killing mpd and restarting it makes all work fine again.
While looping it starts consuming all cpu it can get.
The guys in #mpd told me, that this was an issue of mmap use in lib alsa.

======================================================================

----------------------------------------------------------------------
 dothebart - 11-17-05 17:47 
----------------------------------------------------------------------
lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 03)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133
AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
South] (rev 40)
0000:00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 16)
0000:00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 16)
0000:00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
0000:00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M
[Tornado] (rev 78)
0000:00:0b.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97]
(rev 06)
0000:00:0e.0 Mass storage controller: Triones Technologies, Inc.
HPT366/368/370/370A/372/372N (rev 04)
0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450
(rev 04)


cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) 
stepping        : 0
cpu MHz         : 1252.862
cache size      : 256 KB

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-17-05 17:45 dothebart      New Issue                                    
11-17-05 17:47 dothebart      Note Added: 0006749                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
