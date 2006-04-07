From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002008]: No Sound with snd-hda-intel driver Asus P5VDC-MX
Date: Sat, 8 Apr 2006 00:19:05 +0200
Message-ID: <fce2228ac653cdf769e542b3c4c8d1f1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B6737157
	for <alsa-devel@alsa-project.org>; Sat,  8 Apr 2006 00:19:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2008> 
======================================================================
Reported By:                mborsick
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2008
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Redhat/Fedora
Kernel Version:             2.6.16-1.2080 and with Xen
======================================================================
Date Submitted:             04-07-2006 00:43 CEST
Last Modified:              04-08-2006 00:19 CEST
======================================================================
Summary:                    No Sound with snd-hda-intel driver Asus P5VDC-MX
Description: 
Kernel is up-to-date Xen kernel.

Initial install did not recognize the sound on an ASUS P5VDC-MX
motherboard.
Motherboard has southbridge VIA VT8251. CODEC is Realtek ACL653 AC'97 6
channel
Audio. Tried the updated drivers in 002404, but was unsuccessful. Also
tried
drivers on VIA site and Realltek site. The last couple of tries show no
errors
in compiling, make, etc. However, as I am just above novice in
understanding
everything about Linux, this has thrown me for a loop.

======================================================================

----------------------------------------------------------------------
 buboleck - 04-08-06 00:16 
----------------------------------------------------------------------
YES :)

BEFORE

buboleck ~ # cat /proc/interrupts
           CPU0       CPU1
  0:     206694          0    IO-APIC-edge  timer
  1:        412          0    IO-APIC-edge  i8042
  7:          0          0    IO-APIC-edge  parport0
  8:          2          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:       3341          0    IO-APIC-edge  i8042
 14:      10171          0    IO-APIC-edge  ide0
 15:        638          0    IO-APIC-edge  ide1
 16:      14053          0   IO-APIC-level  fglrx
 17:          0          0   IO-APIC-level  cx88[0]
 18:        394          0   IO-APIC-level  eth0, uhci_hcd:usb4
 19:          0          0   IO-APIC-level  uhci_hcd:usb1
 20:          3          0   IO-APIC-level  uhci_hcd:usb2, ehci_hcd:usb5,
VIA8237
 21:          0          0   IO-APIC-level  uhci_hcd:usb3
NMI:          0          0
LOC:     206528     206629
ERR:          0
MIS:          0

AFTER sound

buboleck ~ # cat /proc/interrupts
           CPU0       CPU1
  0:     217168          0    IO-APIC-edge  timer
  1:        418          0    IO-APIC-edge  i8042
  7:          0          0    IO-APIC-edge  parport0
  8:          2          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:       4581          0    IO-APIC-edge  i8042
 14:      10842          0    IO-APIC-edge  ide0
 15:        668          0    IO-APIC-edge  ide1
 16:      14943          0   IO-APIC-level  fglrx
 17:          0          0   IO-APIC-level  cx88[0]
 18:        414          0   IO-APIC-level  eth0, uhci_hcd:usb4
 19:          0          0   IO-APIC-level  uhci_hcd:usb1
 20:         11          0   IO-APIC-level  uhci_hcd:usb2, ehci_hcd:usb5,
VIA8237
 21:          0          0   IO-APIC-level  uhci_hcd:usb3
NMI:          0          0
LOC:     217004     217105
ERR:          0
MIS:          0

Plays for a sec stops and amarok dies. I kill amarok, start it again and
same, one sec sound and dies.

----------------------------------------------------------------------
 buboleck - 04-08-06 00:19 
----------------------------------------------------------------------
lspci with onboard sound enabled:

00:00.0 Host bridge: VIA Technologies, Inc. P4M800CE Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. P4M800CE Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. P4M800CE Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. PT890 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. P4M800CE Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. P4M800CE Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:0f.0 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 07)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 90)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 90)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 90)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 90)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 90)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8251 PCI to ISA Bridge
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 70)
00:11.7 Host bridge: VIA Technologies, Inc. VT8251 Ultra VLINK Controller
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev
7c)
00:13.0 PCI bridge: VIA Technologies, Inc. VT8251 PCI to PCIE Bridge
00:13.1 PCI bridge: VIA Technologies, Inc. VT8251 PCI to PCI Bridge
01:00.0 VGA compatible controller: ATI Technologies Inc RV410 [Radeon X700
(PCIE)]
01:00.1 Display controller: ATI Technologies Inc RV410 [Radeon X700
(PCIE)] (Secondary)
02:00.0 PCI bridge: VIA Technologies, Inc. VT8251 PCIE Root Port
02:00.1 PCI bridge: VIA Technologies, Inc. VT8251 PCIE Root Port
05:08.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
05:09.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video and
Audio Decoder (rev 05

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-07-06 00:43 mborsick       New Issue                                    
04-07-06 00:43 mborsick       Distribution              => Redhat/Fedora   
04-07-06 00:43 mborsick       Kernel Version            => 2.6.16-1.2080 and
with Xen
04-07-06 01:07 rlrevell       Note Added: 0009129                          
04-07-06 02:13 mborsick       Note Added: 0009130                          
04-07-06 02:35 rlrevell       Note Added: 0009131                          
04-07-06 06:38 mborsick       Note Added: 0009135                          
04-07-06 22:45 buboleck       Note Added: 0009156                          
04-07-06 22:47 buboleck       Note Edited: 0009156                         
04-07-06 22:49 buboleck       Note Edited: 0009156                         
04-07-06 23:06 rlrevell       Note Added: 0009157                          
04-07-06 23:16 buboleck       Issue Monitored: buboleck                    
04-07-06 23:26 buboleck       Note Added: 0009158                          
04-07-06 23:32 rlrevell       Note Added: 0009159                          
04-07-06 23:39 buboleck       Note Added: 0009160                          
04-07-06 23:40 buboleck       Note Edited: 0009160                         
04-07-06 23:43 buboleck       Note Edited: 0009160                         
04-07-06 23:46 buboleck       Note Edited: 0009160                         
04-07-06 23:47 rlrevell       Note Added: 0009161                          
04-07-06 23:52 buboleck       Note Added: 0009162                          
04-08-06 00:02 rlrevell       Note Added: 0009163                          
04-08-06 00:16 buboleck       Note Added: 0009164                          
04-08-06 00:19 buboleck       Note Added: 0009165                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
