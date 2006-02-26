From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000305]: sound is locked up after suspend/resume (APM)
Date: Sun, 26 Feb 2006 16:31:36 +0100
Message-ID: <79edab428b3b7e507286a962b8b7070d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 84D0A18E
	for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2006 16:31:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=305> 
======================================================================
Reported By:                klausr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   305
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             Debian kernel 2.6.5-4-686
======================================================================
Date Submitted:             05-25-2004 14:49 CEST
Last Modified:              02-26-2006 16:31 CET
======================================================================
Summary:                    sound is locked up after suspend/resume (APM)
Description: 
Until recently I was running oss driver cs46xx without a problem. I could
suspend in the middle of playback and xmms would keep playing after resume
as if nothing happend at all.
After switching to the 2.6 kernel, currently running 2.6.5, I also
switched to ALSA beeing the new sound architecture of choice.
Unforunately now when I suspend and resume my notebook sound stops working
at all. Sometimes unloading all ALSA modules helps, sometimes even that is
not possible anymore.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000226 Sound hangs after APM resume
======================================================================

----------------------------------------------------------------------
 rlrevell - 02-26-06 04:44 
----------------------------------------------------------------------
So you are using suspend2 to suspend?  That's completely different.

What happens if you suspend the normal way?

----------------------------------------------------------------------
 cull - 02-26-06 16:31 
----------------------------------------------------------------------
Disabling suspend2 does not seem to make any difference. 
Well, it does sleep using ACPI anyway, but with additional scripts (I use
it since it allowes one to kill all application that use sound before
sleep/suspend)
Anyway, here are dmesg that I get with ACPI sleep without suspend2:

[4294858.354000] ACPI: PCI interrupt for device 0000:00:07.2 disabled
[4294861.984000] ACPI: PCI interrupt for device 0000:00:05.0 disabled
[4294861.995000] ACPI: PCI interrupt for device 0000:00:02.1 disabled
[4294861.995000] ACPI: PCI interrupt for device 0000:00:02.0 disabled
[4294861.995000] Back to C!
[4294865.000000] WARNING: Interrupts reenabled while resuming sysdev class
speci
[4294865.000000] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI
11 (l
[4294865.031000] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LNKB] -> GSI
11 (l
[4294865.073000] ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [LNKC] -> GSI
11 (l
[4294865.073000] ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LNKA] -> GSI
11 (l
[4294867.358000] e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
[4294867.358000] e100: Copyright(c) 1999-2005 Intel Corporation
[4294867.370000] ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKC] -> GSI
11 (l
[4294867.469000] e100: eth0: e100_probe: addr 0xe8120000, irq 11, MAC addr
00:03
[4294867.514000] USB Universal Host Controller Interface driver v2.3
[4294867.579000] ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI
11 (l
[4294867.579000] uhci_hcd 0000:00:07.2: UHCI Host Controller
[4294867.644000] uhci_hcd 0000:00:07.2: new USB bus registered, assigned
bus num
[4294867.644000] uhci_hcd 0000:00:07.2: irq 11, io base 0x00001860
[4294867.660000] hub 1-0:1.0: USB hub found
[4294867.661000] hub 1-0:1.0: 2 ports detected
[4294868.035000] usb 1-1: new low speed USB device using uhci_hcd and
address 2
[4294868.074000] e100: eth0: e100_watchdog: link up, 10Mbps, full-duplex
[4294868.252000] input: Logitech USB Mouse as /class/input/input4
[4294868.265000] input: USB HID v1.10 Mouse [Logitech USB Mouse] on
usb-0000:00:
[4294869.085000] ACPI: AC Adapter [AC] (on-line)
[4294869.156000] ACPI: Battery Slot [BAT0] (battery present)
[4294869.753000] ACPI: Power Button (FF) [PWRF]
[4294869.753000] ACPI: Lid Switch [LID]
[4294869.754000] ACPI: Sleep Button (CM) [SLPB]
[4294869.876000] ACPI: Thermal Zone [THM0] (59 C)
[4294869.931000] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
[4294869.931000] ibm_acpi: http://ibm-acpi.sf.net/
[4294869.932000] ibm_acpi: dock device not present
[4294878.466000] eth0: no IPv6 routers present

the sound doesn't come up after suspend, rmmod modprobe enables it as
before.
I have also enabled debug mode when configured alsa (--with-debug=full).
This gives me some more messages when I try to sleep while playing some
audio (in xmms or xine). Those messages appear right after I start to
resume:

[4295810.805000] ALSA
/usr/src/alsa/1.0.11rc3/alsa-driver-1.0.11rc3/acore/../alsa-kernel/core/pcm_lib.c:157:
BUG: stream = 0, pos = 0x12fb29a, buffer size = 0x4000, period size =
0x200
[4295810.805000] ALSA
/usr/src/alsa/1.0.11rc3/alsa-driver-1.0.11rc3/acore/../alsa-kernel/core/pcm_lib.c:157:
BUG: stream = 0, pos = 0x12fb29a, buffer size = 0x4000, period size =
0x200
[4295810.805000] ALSA
/usr/src/alsa/1.0.11rc3/alsa-driver-1.0.11rc3/acore/../alsa-kernel/core/pcm_lib.c:157:
BUG: stream = 0, pos = 0x12fb29a, buffer size = 0x4000, period size =
0x200
[4295810.805000] ALSA
/usr/src/alsa/1.0.11rc3/alsa-driver-1.0.11rc3/acore/../alsa-kernel/core/pcm_lib.c:157:
BUG: stream = 0, pos = 0x12fb29a, buffer size = 0x4000, period size =
0x200
[4295810.805000] ALSA
/usr/src/alsa/1.0.11rc3/alsa-driver-1.0.11rc3/acore/../alsa-kernel/core/pcm_lib.c:157:
BUG: stream = 0, pos = 0x12fb29a, buffer size = 0x4000, period size =
0x200
[4295810.805000] ALSA
/usr/src/alsa/1.0.11rc3/alsa-driver-1.0.11rc3/acore/../alsa-kernel/core/pcm_lib.c:157:
BUG: stream = 0, pos = 0x12fb29a, buffer size = 0x4000, period size =
0x200
[4295810.805000] ALSA
/usr/src/alsa/1.0.11rc3/alsa-driver-1.0.11rc3/acore/../alsa-kernel/core/pcm_lib.c:157:
BUG: stream = 0, pos = 0x12fb29a, buffer size = 0x4000, period size =
0x200
[4295810.805000] ALSA
/usr/src/alsa/1.0.11rc3/alsa-driver-1.0.11rc3/acore/../alsa-kernel/core/pcm_lib.c:157:
BUG: stream = 0, pos = 0x12fb29a, buffer size = 0x4000, period size =
0x200
[4295810.805000] ALSA
/usr/src/alsa/1.0.11rc3/alsa-driver-1.0.11rc3/acore/../alsa-kernel/core/pcm_lib.c:157:
BUG: stream = 0, pos = 0x12fb29a, buffer size = 0x4000, period size =
0x200

Note that I get no sound after resume regardless whether the sound device
is used or not - it suffices if the module snd_cs46xx is loaded.

Just an observation: I tried to figure out what has been changed since
v.1.0.10, however, I noticed that the content of
alsa-driver-1.0.****/pci/cs46xx/ is identical in v.1.0.10, v.1.0.11rc1 and
v.1.0.11rc3.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 14:49 klausr         New Issue                                    
05-25-04 14:49 klausr         Kernel Version            => Debian kernel
2.6.5-4-686
05-25-04 15:02 tiwai          Note Added: 0001213                          
05-25-04 15:31 klausr         Note Added: 0001215                          
05-25-04 15:59 klausr         Note Added: 0001217                          
05-25-04 16:02 klausr         Issue Monitored: klausr                      
05-25-04 16:05 tiwai          Note Added: 0001218                          
05-25-04 16:44 klausr         Note Added: 0001220                          
05-25-04 16:56 klausr         Note Edited: 0001220                         
05-27-04 08:49 klausr         Issue End Monitor: klausr                    
05-28-04 17:08 tiwai          Note Added: 0001269                          
05-29-04 09:36 klausr         Note Added: 0001276                          
01-17-05 10:57 jdthood        Note Added: 0003226                          
03-22-05 15:02 jdthood        Relationship added       has duplicate 0000226
03-23-05 00:39 rlrevell       Note Added: 0004145                          
03-28-05 15:42 sboehler       Issue Monitored: sboehler                    
06-20-05 01:59 tromer         Issue Monitored: tromer                      
12-12-05 11:12 bheung         Issue Monitored: bheung                      
12-13-05 12:49 jdthood        Note Added: 0007003                          
12-13-05 22:06 jdthood        Note Added: 0007025                          
02-26-06 03:52 cull           Note Added: 0008193                          
02-26-06 04:24 cull           Note Added: 0008194                          
02-26-06 04:44 rlrevell       Note Added: 0008195                          
02-26-06 16:31 cull           Note Added: 0008204                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
