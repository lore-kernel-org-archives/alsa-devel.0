From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000597]: Audigy 2 Value detected
Date: Sat, 23 Oct 2004 08:59:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <8c4e99bc33f482103b1f7aec970641cd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 57A6F270
	for <alsa-devel@alsa-project.org>; Sat, 23 Oct 2004 08:59:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=597> 
======================================================================
Reported By:                mohammed_imran
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   597
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.4.20-8
======================================================================
Date Submitted:             10-23-2004 08:59 CEST
Last Modified:              10-23-2004 08:59 CEST
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

Tested on RedHat Linux 9
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-23-04 08:59 mohammed_imran New Issue                                    
10-23-04 08:59 mohammed_imran File Added: alsa-driver-1.0.6-mod.tar.bz2         
          
10-23-04 08:59 mohammed_imran Kernel Version            => 2.4.20-8        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
