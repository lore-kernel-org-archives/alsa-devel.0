From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000597]: Audigy 2 Value detected
Date: Mon, 27 Dec 2004 15:49:50 +0100
Message-ID: <097840f00ecb23afd91280566892cc84@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E57FD244
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 15:49:50 +0100 (MET)
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
Status:                     closed
Distribution:               
Kernel Version:             2.4.20-8
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-23-2004 08:59 CEST
Last Modified:              12-27-2004 15:49 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000596 Audigy 2 Value detected
has duplicate       0000598 Audigy 2 Value detected
has duplicate       0000599 Audigy 2 Value detected
has duplicate       0000595 No support for Audigy 2 rev 8 (Audigy 2...
======================================================================

----------------------------------------------------------------------
 tiwai - 11-10-04 12:50 
----------------------------------------------------------------------
Yes the file seems broken.  Tar stops in the middle of extraction.

Please upload the patch instead of the whole driver tree codes...

----------------------------------------------------------------------
 pzad - 11-24-04 12:57 
----------------------------------------------------------------------
Support was added to CVS. Thanks to James Courtier-Dutton.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-23-04 08:59 mohammed_imran New Issue                                    
10-23-04 08:59 mohammed_imran File Added: alsa-driver-1.0.6-mod.tar.bz2         
          
10-23-04 08:59 mohammed_imran Kernel Version            => 2.4.20-8        
10-23-04 12:30 jcdutton       Note Added: 0002254                          
11-10-04 12:50 tiwai          Note Added: 0002370                          
11-10-04 12:52 tiwai          Relationship added       has duplicate 0000596
11-10-04 12:53 tiwai          Relationship added       has duplicate 0000598
11-10-04 12:53 tiwai          Relationship added       has duplicate 0000599
11-24-04 12:40 pzad           Relationship added       has duplicate 0000595
11-24-04 12:41 pzad           Relationship deleted     has duplicate 0000595
11-24-04 12:42 pzad           Relationship added       has duplicate 0000595
11-24-04 12:57 pzad           Status                   assigned => resolved
11-24-04 12:57 pzad           Resolution               open => fixed       
11-24-04 12:57 pzad           Note Added: 0002554                          
12-27-04 15:49 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
