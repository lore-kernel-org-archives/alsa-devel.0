From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000501]: on-board vt1720 doesn't work in Albatron 865PE Pro II mobo.
Date: Sat, 9 Apr 2005 14:31:50 +0200
Message-ID: <baa7a82b99c342f3db36b4b54ba4524c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5E04221D
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 14:31:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=501> 
======================================================================
Reported By:                byly
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   501
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               debian
Kernel Version:             2.4.26, 2.6.7
======================================================================
Date Submitted:             09-14-2004 17:28 CEST
Last Modified:              04-09-2005 14:31 CEST
======================================================================
Summary:                    on-board vt1720 doesn't work in Albatron 865PE Pro
II mobo.
Description: 
on-board vt1720 doesn't work in Albatron 865PE Pro II mobo.

I've tried alsa-drivers-1.0.6a, 1.0.7rc1
with kernel 2.4.26, 2.6.7

I use SB live! (snd_emu10k1) as a reference card and I've seen
no problem with it (but may be it's related to it's multiple open()
capability?)

After modprobe snd-ice1724 I have an
'ice1724: Invalid EEPROM version 0' message.

More or less reproducable behaviour is:

1. in kmix presense 'mplayer -ao alsa9' hangs on audio init.

2. in kmix absense mplayer works but stalls sometimes for several
seconds.

3. xmms (using oss output, I use devfs and snd_pcm_oss)
plays ok but after each track it stops and you need to press 'play' to
play next track.

As for the technical aspects:

Chips on board likely related are:
'Envy24PT VT1720', VT1616, WM8728, RT9131 and CS8415A-CS on the SPDIF
bracket.

There is unlikely EEPROM on board.

According to common sense my mobo should be almost identical to
Albatron K8X800 Pro II supported in alsa.

Subvendor: 0x12142417 is similar to amp.h but it's likely wrong.

Anyway I've tried to recompile swapping subvendor id's but w/o great
difference in behaviour.

I've attached a couple of files below:

greza:card1# cat /proc/interrupts
           CPU0
  0:   35336377    IO-APIC-edge  timer
  1:      15799    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  3:     131866    IO-APIC-edge  serial
  7:          2    IO-APIC-edge  parport0
  8:          3    IO-APIC-edge  rtc
 12:     325712    IO-APIC-edge  PS/2 Mouse
 14:    3877075    IO-APIC-edge  ide0
 15:    3810592    IO-APIC-edge  ide1
 16:          0   IO-APIC-level  usb-uhci, usb-uhci
 17:       3115   IO-APIC-level  ICE1724
 18:    9347119   IO-APIC-level  ide2, ide3, eth1, usb-uhci
 19:     668864   IO-APIC-level  usb-uhci, EMU10K1
 20:     595115   IO-APIC-level  ncr53c8xx
 21:    5203249   IO-APIC-level  ide4, ide5
 23:    1201336   IO-APIC-level  eth0

greza:card1# cat ice1724
AMP Ltd AUDIO2000 at 0x8800, irq 17

EEPROM:
  Subvendor        : 0x12142417
  Size             : 32 bytes
  Version          : 7
  System Config    : 0x18
  ACLink           : 0x40
  I2S              : 0x7
  S/PDIF           : 0x38
  GPIO direction   : 0x3e0
  GPIO mask        : 0x70078
  GPIO state       : 0x74058
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=18        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=19        : 0x7
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=20        : 0x18
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=21        : 0xf0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=22        : 0x3
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=23        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=24        : 0xe0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=25        : 0x1
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=27        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=28        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=29        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=30        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=31        : 0x0

Registers:
  PSDOUT03 : 0x00000000
  CCS00    : 0x00
  CCS01    : 0xa0
  CCS02    : 0x00
  CCS03    : 0x00
  CCS04    : 0x18
  CCS05    : 0x00
  CCS06    : 0x07
  CCS07    : 0x78
  CCS08    : 0x00
  CCS09    : 0x00
  CCS0a    : 0x00
  CCS0b    : 0x00
  CCS0c    : 0x00
  CCS0d    : 0x0a
  CCS0e    : 0x00
  CCS0f    : 0x00
  CCS10    : 0x00
  CCS11    : 0x00
  CCS12    : 0x00
  CCS13    : 0x00
  CCS14    : 0x17
  CCS15    : 0xf8
  CCS16    : 0x78
  CCS17    : 0x00
  CCS18    : 0xe0
  CCS19    : 0x03
  CCS1a    : 0x00
  CCS1b    : 0x00
  CCS1c    : 0x00
  CCS1d    : 0x00
  CCS1e    : 0x57
  CCS1f    : 0x07
  MT00     : 0x00
  MT01     : 0x00
  MT02     : 0x00
  MT03     : 0x08
  MT04     : 0x3c
  MT05     : 0x08
  MT06     : 0x00
  MT07     : 0x00

======================================================================

----------------------------------------------------------------------
 jdthood - 04-09-05 14:31 
----------------------------------------------------------------------
Submitter: Has there been any progress on this issue?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-14-04 17:28 byly           New Issue                                    
09-14-04 17:28 byly           Distribution              => debian          
09-14-04 17:28 byly           Kernel Version            => 2.4.26, 2.6.7   
04-09-05 14:31 jdthood        Note Added: 0004400                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
