From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000674]: sound modules loaded, unmuted channels, progressbar moving STILL no output
Date: Wed, 24 Nov 2004 13:19:08 +0100
Message-ID: <70232da06da80d90b5ecc44d20496421@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 99FDF2AD
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 13:19:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=674> 
======================================================================
Reported By:                IceRAM
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   674
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               ArchLinux
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-24-2004 13:12 CET
Last Modified:              11-24-2004 13:19 CET
======================================================================
Summary:                    sound modules loaded, unmuted channels, progressbar
moving STILL no output
Description: 
I can't get any sound out of the integrated sound card, even though I've
tried everything possible (I think - oh, I haven't tried Windows, yet)
======================================================================

----------------------------------------------------------------------
 IceRAM - 11-24-04 13:19 
----------------------------------------------------------------------
Distro: ArchLinux (http://www.archlinux.org) [^]
Kernel: 2.6.9 vanilla
ALSA: 1.0.7
(http://www.archlinux.org/packages.php?s_repo=all&s_category=all&s_keyword=alsa&s_lastupdate=&pp=50)
[^]
Motherboard: GigaByte 8IK1100
Chipset: ALC655 (in the specs*), detected as ALC658 rev 0 by ALSA
*
http://www.giga-byte.com/MotherBoard/Products/Products_Spec_GA-8IK1100.htm),
[^]

# lspci | grep audio
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R)
AC'97 Audio Controller (rev 02)

Attached:
/etc/asound.state
/etc/modprobe.conf
~/.asoundrc
lsmod.txt (lsmod | grep snd)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 13:12 IceRAM         New Issue                                    
11-24-04 13:12 IceRAM         File Added: asound.state                     
11-24-04 13:12 IceRAM         Distribution              => ArchLinux       
11-24-04 13:12 IceRAM         Kernel Version            => 2.6.9           
11-24-04 13:13 IceRAM         File Added: .asoundrc                        
11-24-04 13:17 IceRAM         File Added: modprobe.conf                    
11-24-04 13:19 IceRAM         Note Added: 0002560                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
