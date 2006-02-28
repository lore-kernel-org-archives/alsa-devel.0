From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001736]: No sound on my acertravelmate 4062nwlmi
Date: Wed, 1 Mar 2006 00:54:01 +0100
Message-ID: <5387f7314403941ff8236f1a2c568010@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BD2491C0
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 00:54:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1736> 
======================================================================
Reported By:                clamath
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1736
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               No sound on acer Travelmate 4062wnlmi
Kernel Version:             2.6.15
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-11-2006 11:24 CET
Last Modified:              03-01-2006 00:54 CET
======================================================================
Summary:                    No sound on my acertravelmate 4062nwlmi
Description: 
alsa counf found drivers; modprobe snd-hda-intel succes; chanels NOT muted
; but still no sound any ideas????also a tried drvers 1.0.11rc2 but still
no sound

lspci
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express
Proce
ssor to DRAM Controller (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Ex
press Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML
Express G
raphics Controller (rev 03)
00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
High
Definition Audio Controller (rev 04)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI E
xpress Port 1 (rev 04)
00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI E
xpress Port 2 (rev 04)
00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI E                               xpress Port 3 (rev 04)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) U                               SB UHCI #1 (rev 04)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) U                               SB UHCI #2 (rev 04)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) U                               SB UHCI #3 (rev 04)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) U                               SB UHCI #4 (rev 04)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) U                               SB2 EHCI Controller (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (re                               v 04)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001517 No sound on hda-intel on Acer TravelMat...
duplicate of        0001618 No Sound on Acer with Intel ICH6 HDA an...
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-01-06 00:54 
----------------------------------------------------------------------
Fixed in CVS

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 11:24 clamath        New Issue                                    
01-11-06 11:24 clamath        Distribution              => No sound on acer
Travelmate 4062wnlmi
01-11-06 11:24 clamath        Kernel Version            => 2.6.15          
03-01-06 00:53 rlrevell       Relationship added       duplicate of 0001517
03-01-06 00:53 rlrevell       Relationship added       duplicate of 0001618
03-01-06 00:54 rlrevell       Status                   assigned => resolved
03-01-06 00:54 rlrevell       Resolution               open => fixed       
03-01-06 00:54 rlrevell       Note Added: 0008254                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
