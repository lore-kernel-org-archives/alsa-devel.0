From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000596]: Audigy 2 Value detected
Date: Wed, 10 Nov 2004 12:52:27 +0100
Message-ID: <ef0f03702bc872796da609e8506326dd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 670D623B
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 12:52:27 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=596> 
======================================================================
Reported By:                mohammed_imran
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   596
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 duplicate
Duplicate:                  597
Fixed in Version:           
======================================================================
Date Submitted:             10-23-2004 08:58 CEST
Last Modified:              11-10-2004 12:52 CET
======================================================================
Summary:                    Audigy 2 Value detected
Description: 
I have tried pzad's suggestion and added the PCI ID to the table along with
some modifications (support to detect rev 8 and 0 as audigy 2)
(emu->rev==0)..

RedHat Linux 9 reports the card having rev 0 do i added rev 0 support. Now
it detects the card as an audigy 2, alsa mixer runs but no sound out put
is given when i play sound using xmms/aplay/realplayer...perhaps some more
modifications needed? or a new driver needed?

Also: PCI ID for Audigy 2 card is not 1102:1008 as i saw in the forum
reports but it is: 1102:0008 as listed by cat /proc/pci:

 Bus  3, device   2, function  0:
    Multimedia audio controller: PCI device 1102:0008 (Creative Labs) (rev
0).
      IRQ 12.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0xc800 [0xc83f].

please correct me if i am wrong.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000597 Audigy 2 Value detected
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-23-04 08:58 mohammed_imran New Issue                                    
10-23-04 08:58 mohammed_imran File Added: alsa-driver-1.0.6-mod.tar.bz2         
          
11-10-04 12:52 tiwai          Relationship added       duplicate of 0000597
11-10-04 12:52 tiwai          Duplicate ID             0 => 597            
11-10-04 12:52 tiwai          Status                   assigned => resolved
11-10-04 12:52 tiwai          Resolution               open => duplicate   
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
