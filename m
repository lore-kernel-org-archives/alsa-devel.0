From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002233]: No sound on speakers,
	low volume on the headphones, Samsung X60 Chane
Date: Mon, 26 Jun 2006 12:23:33 +0200
Message-ID: <6d072322d2e3810927a1e1d9a406729a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4C9C01A8
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 12:23:34 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2233> 
======================================================================
Reported By:                max
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2233
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               suse 10.1
Kernel Version:             2.6.16.13-4
======================================================================
Date Submitted:             06-26-2006 12:17 CEST
Last Modified:              06-26-2006 12:23 CEST
======================================================================
Summary:                    No sound on speakers, low volume on the headphones,
Samsung X60 Chane
Description: 
installation ok. (82801G)
but
no sound on speakers 
low volume on the headphones and sometimes a verry high frequenz...

thanks for help

======================================================================

----------------------------------------------------------------------
 max - 06-26-06 12:21 
----------------------------------------------------------------------
lspci
00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
945GT Express Memory Controller Hub (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile
945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/940GML
Express Integrated Graphics Controller (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 02)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1
(rev 02)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2
(rev 02)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3
(rev 02)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4
(rev 02)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial
ATA Storage Controller IDE (rev 02)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 02)
02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet
Controller (rev 01)
03:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Network
Connection (rev 02)
09:09.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b4)
09:09.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
(rev 09)
09:09.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter
(rev 18)
09:09.3 System peripheral: Ricoh Co Ltd Unknown device 0843
09:09.4 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host
Adapter (rev 09)
09:09.5 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev
04)

----------------------------------------------------------------------
 max - 06-26-06 12:23 
----------------------------------------------------------------------
modinfo snd_hda_intel
filename:      
/lib/modules/2.6.16.13-4-smp/kernel/sound/pci/hda/snd-hda-intel.ko
license:        GPL
description:    Intel HDA driver
vermagic:       2.6.16.13-4-smp SMP 586 REGPARM gcc-4.1
supported:      yes
depends:        snd-pcm,snd-page-alloc,snd-hda-codec,snd
alias:          pci:v00008086d00002668sv*sd*bc*sc*i*
alias:          pci:v00008086d000027D8sv*sd*bc*sc*i*
alias:          pci:v00008086d0000269Asv*sd*bc*sc*i*
alias:          pci:v00008086d0000284Bsv*sd*bc*sc*i*
alias:          pci:v00001002d0000437Bsv*sd*bc*sc*i*
alias:          pci:v00001002d00004383sv*sd*bc*sc*i*
alias:          pci:v00001106d00003288sv*sd*bc*sc*i*
alias:          pci:v00001039d00007502sv*sd*bc*sc*i*
alias:          pci:v000010B9d00005461sv*sd*bc*sc*i*
alias:          pci:v000010DEd0000026Csv*sd*bc*sc*i*
alias:          pci:v000010DEd00000371sv*sd*bc*sc*i*
srcversion:     44A21C189B714ADE086A08A
parm:           enable:bool
parm:           single_cmd:Use single command to communicate with codecs
(for debugging only). (bool)
parm:           probe_mask:Bitmask to probe codecs (default = -1). (int)
parm:           position_fix:Fix DMA pointer (0 = auto, 1 = none, 2 =
POSBUF, 3 = FIFO size). (int)
parm:           model:Use the given board model. (charp)
parm:           id:ID string for Intel HD audio interface. (charp)
parm:           index:Index value for Intel HD audio interface. (int)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-06 12:17 max            New Issue                                    
06-26-06 12:17 max            Distribution              => suse 10.1       
06-26-06 12:17 max            Kernel Version            => 2.6.16.13-4     
06-26-06 12:20 max            Note Added: 0010527                          
06-26-06 12:21 max            Note Added: 0010528                          
06-26-06 12:23 max            Note Added: 0010529                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
