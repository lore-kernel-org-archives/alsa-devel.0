From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000624]: crash with alc850 when driver alsa intel8x0 is use
Date: Thu, 11 Nov 2004 14:48:06 +0100
Message-ID: <1f5880c17fd2aa5a1c28c0167223d7db@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5A53426F
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2004 14:48:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=624> 
======================================================================
Reported By:                xmoucheron
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   624
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.8.1 mdk
======================================================================
Date Submitted:             11-02-2004 20:24 CET
Last Modified:              11-11-2004 14:48 CET
======================================================================
Summary:                    crash with alc850 when driver alsa intel8x0 is use
Description: 
When mandrakelinux boot and when a song is played then the song is stopped
and the acess to internet is stopped too.

This problem isreproducibility every days and allways.
======================================================================

----------------------------------------------------------------------
 xmoucheron - 11-10-04 21:16 
----------------------------------------------------------------------
My system environnement is a mandrakelinux 10.1 officiel with default
installation.

I have

a motherboard asus K8N-E delux with 
CPU  	- Socket 754 for AMD Athlon 64
- AMD64 architecture enables simultaneous 32- and 64-bit computing
Chipset 	NVIDIA nForce3 250Gb
System Bus 	800 MHz
 	Chipset:
&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8231;2 x UltraDMA
133/100/66/33
&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8231;2 x Serial ATA,
support RAID 0, RAID 1, RAID 0+1, JBOD
Silicon Image Sil 3114 SATA controller:
&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8231;4 x Serial ATA
&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8231;RAID 0, RAID 1,
RAID 10, RAID 5, JBOD
AI Audio 	Realtek ALC850, 8-channel CODEC
Audio Sensing and Enumeration Technology
Coaxial/Optical S/PDIF out ports on back I/O
Gigabit LAN 	- Chipset built-in Gigabit MAC with external Marvell PHY
supporting
- 10/100/1000 BASE-T Ethernet
IEEE 1394 	VIA VT6307 controller supports 2 x 1394 ports


A processeur amd64 3200+.

The symptom are simple:

If a sound is player by an application as xmms, totem, mozilla, gaim,   or
any all application,   the sound stop immediatly and the access to
ethernet card is stopped. This problem arrive with a time different
according to the application used. 
For exemple with xmms, the problem is immediately. But with totem, it is
after a small time.

If , I forbidden the boot of alsa durind boot of the system and all server
of sound, there isn't crash of sound system and acess to ethernet card is
ok.

There are on my mandrake 10.1: alsa +  sound ( it is the name that there
are in mandrake control center in the section system -- service) 

by defect, the acess od ethernet card is ok,  excep if sound system
crash.
I want to say, when sound system crash, the acess to ethernet card is
immediately stopped.

the driver od alsa :  intel8x0 is used by the system ans this is the only
that can played a sound but it is temporary.

But with this problem, I can to words with my computer on openoffice or
others if server sound is stopped.

Actually, alsa and server sound are stopped, but I would like to listen
and to look music, video and used all applications who use sound.

edited on: 11-10-04 21:16

----------------------------------------------------------------------
 xmoucheron - 11-11-04 14:48 
----------------------------------------------------------------------
I come to install the mandrakelinux 10.1  64bit edition with alsa driver
1.0.6 and the problem with this driver (intel 8x0) on mandrakelinux 64bit
is most important.

There is none sound with this version 64bit with alsa 1.0.6.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-02-04 20:24 xmoucheron     New Issue                                    
11-02-04 20:24 xmoucheron     Kernel Version            => 2.6.8.1 mdk     
11-04-04 13:36 xmoucheron     Note Added: 0002304                          
11-09-04 10:46 tiwai          Note Added: 0002318                          
11-09-04 10:47 tiwai          Note Added: 0002319                          
11-10-04 21:12 xmoucheron     Note Added: 0002376                          
11-10-04 21:16 xmoucheron     Note Edited: 0002376                         
11-11-04 14:48 xmoucheron     Note Added: 0002386                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
