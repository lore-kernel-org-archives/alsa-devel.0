From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000914]: nm256 causes kernel to hard freeze
Date: Fri, 25 Feb 2005 16:29:54 +0100
Message-ID: <49d4ba7e7eba7aa87068938cd5a9453d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1C88318B
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2005 16:29:55 +0100 (MET)
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
Last Modified:              02-25-2005 16:29 CET
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

----------------------------------------------------------------------
 tiwai - 02-24-05 22:04 
----------------------------------------------------------------------
Unfortunately not.  This is a known bug of nm256 driver.  But I have no
clue yet since I don't have the hardware.

AFAIK, the freeze occurs in the AC97 part.  Although the driver tries to
avoid the access of invalid registers, it seems not enough.
Or, the allocation of video-ram buffer might be slightly different from
OSS version.  Anyway, this hardware is really hard to debug.

----------------------------------------------------------------------
 vaxen - 02-25-05 16:29 
----------------------------------------------------------------------
I finally got OSS module to work on the 2.6.10. The problem was the APIC,
OSS worked after I disabled it. Unfortunately, the alsa is still broken. I
am also resolving similar issue with the developers of 4front OSS driver,
since OSS will soon be out of the 2.6 kernel. Eventhough it would be hard
to debug this monster chipset, I won't give up. Please tell me what I
should do to start debugging. Thanks

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
