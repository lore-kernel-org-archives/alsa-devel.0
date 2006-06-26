From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002233]: No sound on speakers,
	low volume on the headphones, Samsung X60 Chane
Date: Mon, 26 Jun 2006 12:21:09 +0200
Message-ID: <7e39937de8c2390a115efba38c72b937@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B6A0B1A8
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 12:21:09 +0200 (MEST)
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
Last Modified:              06-26-2006 12:21 CEST
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
 max - 06-26-06 12:20 
----------------------------------------------------------------------
lsmod |grep snd*
snd_pcm_oss            47104  0
snd_mixer_oss          20480  1 snd_pcm_oss
snd_seq                53360  0
snd_seq_device         11916  1 snd_seq
snd_hda_intel          21652  1
snd_hda_codec         137856  1 snd_hda_intel
snd_pcm                86788  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              25860  2 snd_seq,snd_pcm
snd                    57092  10
snd_pcm_oss,snd_mixer_oss,snd_seq,snd_seq_device,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
soundcore              13024  1 snd
snd_page_alloc         13576  2 snd_hda_intel,snd_pcm

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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-06 12:17 max            New Issue                                    
06-26-06 12:17 max            Distribution              => suse 10.1       
06-26-06 12:17 max            Kernel Version            => 2.6.16.13-4     
06-26-06 12:20 max            Note Added: 0010527                          
06-26-06 12:21 max            Note Added: 0010528                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
