From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000397]: Bad sound quality on Asus K8V SE Deluxe (VIA8237 + AD1980)
Date: Sat, 26 Feb 2005 15:18:09 +0100
Message-ID: <bc671f8c7ff11c701c041ec22cd78017@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 39E3A268
	for <alsa-devel@alsa-project.org>; Sat, 26 Feb 2005 15:18:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=397> 
======================================================================
Reported By:                durval
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   397
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               My own, based on Redhat 6.2
Kernel Version:             2.4.26
======================================================================
Date Submitted:             07-18-2004 16:41 CEST
Last Modified:              02-26-2005 15:18 CET
======================================================================
Summary:                    Bad sound quality on Asus K8V SE Deluxe (VIA8237 +
AD1980)
Description: 
Sound quality is noticiably bad; even someone with not-so-sensitive ears as
me perceives the low-frequency and high-frequency components of sound
getting mixed up and losing definition. I thought it could be a problem
with my hardware or speaker system, but rebooting the machine under
Windows2000 and playing the same music showed much better quality. 
======================================================================

----------------------------------------------------------------------
 dvega - 01-25-05 22:46 
----------------------------------------------------------------------
I've similar problems on my ASUS A7V600-X MotherBoard (VIA8237 + AD1888).
I'm using kernel 2.6.10 on Gentoo. I've tried different values for
dxs_support and ac97_quirk parameters with no success

It's difficult to explain. You can hear some high frecuency ticks/pauses
intermixed with the sound.

I've compiled the driver with DEBUG, but I can't see anything usefull.

=========== dmesg output at boot ============
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:11.5 to 64
ALSA sound/pci/via82xx.c:587: codec_read: codec 0 is not valid [0xfe0000]
ALSA sound/pci/via82xx.c:587: codec_read: codec 0 is not valid [0xfe0000]
ALSA sound/pci/via82xx.c:587: codec_read: codec 0 is not valid [0xfe0000]
ALSA sound/pci/via82xx.c:587: codec_read: codec 0 is not valid [0xfe0000]
=============================================

============= lspci -vv extract ==============
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 810d
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at e000
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
=============================================

----------------------------------------------------------------------
 Xe - 02-26-05 15:18 
----------------------------------------------------------------------
I have the same problem on my Board (VT8237 with via VT1617A - Sound). The
Support of via told me I should set dxs_support to a value of 2 or 3, but
this didn't work for me.
Hm, mutes your soundcard automatic - mine does.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-18-04 16:41 durval         New Issue                                    
07-18-04 16:41 durval         Distribution              => My own, based on
Redhat 6.2
07-18-04 16:41 durval         Kernel Version            => 2.4.26          
07-18-04 16:43 durval         Note Added: 0001457                          
07-18-04 17:16 durval         Note Added: 0001458                          
07-18-04 17:17 durval         Issue Monitored: durval                      
07-30-04 17:32 tiwai          Note Added: 0001502                          
09-25-04 08:54 fangel         Note Added: 0001908                          
09-25-04 08:55 fangel         Note Added: 0001909                          
10-12-04 14:56 tiwai          Note Added: 0002101                          
10-27-04 00:27 badbunny       Note Added: 0002267                          
01-25-05 22:26 dvega          Issue Monitored: dvega                       
01-25-05 22:46 dvega          Note Added: 0003412                          
02-26-05 15:18 Xe             Note Added: 0003740                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
