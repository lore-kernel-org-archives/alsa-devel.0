From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000881]: Distorted sound with enabled dmix plugin
Date: Fri, 4 Feb 2005 10:39:06 +0100
Message-ID: <ccdde4d11c535040c2cd3730cbffe91a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 403C71F4
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2005 10:39:06 +0100 (MET)
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
Last Modified:              02-04-2005 10:39 CET
======================================================================
Summary:                    Distorted sound with enabled dmix plugin
Description: 
After 10-20 minutes listening music with xmms or beep-media-player I hear
distorted sound. Appear noise.
This problem is appear when enabled dmix plugin through configuration file
~/.asoundrc.
======================================================================

----------------------------------------------------------------------
 yure - 02-04-05 10:39 
----------------------------------------------------------------------
Additional information from alsamixer:

Card: Intel ICH5
Chip: Analog Devices AD1980
View: Playback
Item: Master

lspci
00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub
Interface (rev 02)
00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev
02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
(rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev
02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100
Storage Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev
02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R)
AC'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2
Model 64/Model 64 Pro] (rev 15)
02:08.0 Ethernet controller: Intel Corp. 82562EZ 10/100 Ethernet
Controller (rev 02)
02:09.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-05 12:25 yure           New Issue                                    
02-04-05 10:39 yure           Note Added: 0003497                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
