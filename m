From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000604]: sound loop problem
Date: Thu, 28 Oct 2004 02:14:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5bd59a6ed0ba4adb4d105465272ab92d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C1DD32CD
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2004 02:14:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=604> 
======================================================================
Reported By:                chomwitt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   604
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               slackware10
Kernel Version:             2.6.7
======================================================================
Date Submitted:             10-26-2004 01:29 CEST
Last Modified:              10-28-2004 02:14 CEST
======================================================================
Summary:                    sound loop problem
Description: 
i get a sound loop which gets correctet only 
while moving the mouse!
======================================================================

----------------------------------------------------------------------
 chomwitt - 10-27-04 21:07 
----------------------------------------------------------------------
i haven't installed gnome,kde etc,so i dont have esound or alike.
i removed the usb "mouse" modules from the kernel but 
the problem remains.
Its strange that will moving the usb mouse
the sound-loop (playing the first 0,2sec of a sound file endlessly )
stops andyou can hear the next 0.2sec and the next 0.2 ... as long as you
move the usb mouse.While mouving the touchpad mouse the sound loop doesnt
break.

----------------------------------------------------------------------
 chomwitt - 10-28-04 02:14 
----------------------------------------------------------------------
this is output from dmesg.

/root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec read
timeout (reg 1c)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec
read timeout (reg 0)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec
read timeout (reg 3c)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec
read timeout (reg 1c)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec
read timeout (reg 0)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec
read timeout (reg 3c)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec
read timeout (reg 1c)
....... (many many lines like the above)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/ac97/ac97_codec.c:1904:
AC'97 2 does not respond - RESET
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/ac97/ac97_codec.c:1912:
AC'97 2 access is not valid [0xffffffff], removing mixer.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-26-04 01:29 chomwitt       New Issue                                    
10-26-04 01:29 chomwitt       Distribution              => slackware10     
10-26-04 01:29 chomwitt       Kernel Version            => 2.6.7           
10-27-04 21:07 chomwitt       Note Added: 0002280                          
10-28-04 02:14 chomwitt       Note Added: 0002281                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
