From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000914]: nm256 causes kernel to hard freeze
Date: Thu, 16 Mar 2006 07:55:26 +0100
Message-ID: <cd20cf6516a601eb1bf9b570ebf08842@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4185216
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 07:55:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=914> 
======================================================================
Reported By:                vaxen
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   914
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.9 2.6.10
======================================================================
Date Submitted:             02-16-2005 20:39 CET
Last Modified:              03-16-2006 07:55 CET
======================================================================
Summary:                    nm256 causes kernel to hard freeze
Description: 
Hi, here is my specs:

Gateway solo 3300
http://support.gateway.com/support/manlib/Notebooks/Solo3300/8506533/06533.htm
Audio chipset NM2200 interface to AC97 CODEC

pegasos vaxen # lspci -tv
-[00]-+-00.0  Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
      +-01.0-[01]--+-00.0  Neomagic Corporation NM2200 [MagicGraph 256AV]
      |            \-00.1  Neomagic Corporation NM2200 [MagicMedia 256AV
Audio]
      +-07.0  Intel Corp. 82371AB/EB/MB PIIX4 ISA
      +-07.1  Intel Corp. 82371AB/EB/MB PIIX4 IDE
      +-07.2  Intel Corp. 82371AB/EB/MB PIIX4 USB
      +-07.3  Intel Corp. 82371AB/EB/MB PIIX4 ACPI
      +-0a.0  Texas Instruments PCI1211
      +-0d.0  3Com Corporation 3c905C-TX/TX-M [Tornado]
      \-10.0  Agere Systems (former Lucent Microelectronics) WinModem 56k

I am using a custom patched kernel at
http://morph-sources.sourceforge.net/?q=node/27 

It is using 2.6.10 with 1.08 alsa drivers wth alsa-bk-2005-01-05.patch and
alsa-bk-2005-01-14.patch.

I compiled the drivers into the kernel, the kernel hard freezes after
displaying these message:
nm256:found card signature in video RAM: 0x27ec00
nm256:Mapping port 1 from 0x2709a0-0x27ec00
I have to switch off the laptop as it does not respond to any inputs.

I also tried compiling the drivers as modules, when I tried to modprobe
snd-nm256, the kernel hard freezes without any warning message.

I also tried vanilla 2.6.9 which contains alsa 1.0.6 driver. It freezes
like 2.6.10.

I have not tried alsa 1.0.7 driver.

Please let me know if you need more diagnostic information to fix this
problem.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000328 snd-nm256 freezes Dell Latitude LS
======================================================================

----------------------------------------------------------------------
 jpeak - 06-26-05 15:10 
----------------------------------------------------------------------
I didn't see any recent activity on this and was wondering if there were
any planned fixes.  I have this same lockup problem on my Dell Inspiron
3500 using a custom 2.6.11-5 kernel.  I would also be glad to help do any
testing.  Thanks.

----------------------------------------------------------------------
 rlrevell - 03-16-06 07:55 
----------------------------------------------------------------------
This bug should be fixed in CVS, can you please test it?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-16-05 20:39 vaxen          New Issue                                    
02-16-05 20:39 vaxen          Kernel Version            => 2.6.9 2.6.10    
02-16-05 21:36 vaxen          Note Added: 0003626                          
02-16-05 21:38 vaxen          Note Edited: 0003626                         
02-16-05 21:56 vaxen          Note Edited: 0003626                         
02-17-05 18:31 tiwai          Note Added: 0003632                          
02-17-05 20:44 vaxen          Note Added: 0003638                          
02-17-05 20:45 vaxen          Note Edited: 0003638                         
02-17-05 21:28 vaxen          Note Added: 0003641                          
02-17-05 22:40 vaxen          Note Added: 0003644                          
02-24-05 03:55 vaxen          Note Added: 0003717                          
02-24-05 04:01 vaxen          Note Added: 0003718                          
02-24-05 22:04 tiwai          Note Added: 0003727                          
02-25-05 16:29 vaxen          Note Added: 0003735                          
03-10-05 12:50 interfaSys     Note Added: 0003849                          
03-10-05 14:38 tiwai          Note Added: 0003852                          
03-10-05 14:38 tiwai          File Added: nm256-test.diff                    
03-10-05 18:56 vaxen          Note Added: 0003870                          
03-10-05 19:57 vaxen          Note Added: 0003871                          
03-11-05 12:15 tiwai          Note Added: 0003886                          
03-11-05 14:25 vaxen          Note Added: 0003888                          
05-09-05 22:08 MeneM          Note Added: 0004630                          
05-09-05 22:17 MeneM          Note Edited: 0004630                         
05-09-05 22:20 MeneM          Note Edited: 0004630                         
06-26-05 15:10 jpeak          Note Added: 0005264                          
08-01-05 01:05 jpeak          Issue Monitored: jpeak                       
03-16-06 07:54 rlrevell       Relationship added       duplicate of 0000328
03-16-06 07:55 rlrevell       Note Added: 0008586                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
