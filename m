From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000881]: Distorted sound with enabled dmix plugin
Date: Wed, 23 Feb 2005 13:35:31 +0100
Message-ID: <5e7cc7b292bf2550ad60a77921163c8f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3CAA51E3
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 13:35:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=881> 
======================================================================
Reported By:                yure
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   881
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-03-2005 12:25 CET
Last Modified:              02-23-2005 13:35 CET
======================================================================
Summary:                    Distorted sound with enabled dmix plugin
Description: 
After 10-20 minutes listening music with xmms or beep-media-player I hear
distorted sound. Appear noise.
This problem is appear when enabled dmix plugin through configuration file
~/.asoundrc.
======================================================================

----------------------------------------------------------------------
 yure - 02-04-05 15:36 
----------------------------------------------------------------------
This problem also become apparented with previous version alsa lib on
another system:
Card: Intel 82801DB-ICH4
Chip: Realtek ALC650F

But with version 1.0.8 I can't reproduce this bug on this system.

lspci for this card
00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM
Controller/Host-Hub Interface (rev 03)
00:01.0 PCI bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE Host-to-AGP
Bridge (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
(rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2
(rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3
(rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Bridge (rev
02)
00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) UltraATA-100
IDE Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX
400] (rev b2)
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)

----------------------------------------------------------------------
 yure - 02-23-05 13:35 
----------------------------------------------------------------------
I think it's maybe help.
When I disable HT on P4 or use Uniprocessor kernel sound not distorted on
this system.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-05 12:25 yure           New Issue                                    
02-04-05 10:39 yure           Note Added: 0003497                          
02-04-05 10:39 yure           Issue Monitored: yure                        
02-04-05 14:53 tiwai          Note Added: 0003506                          
02-04-05 15:30 yure           Note Added: 0003508                          
02-04-05 15:36 yure           Note Added: 0003509                          
02-23-05 13:35 yure           Note Added: 0003711                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
