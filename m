From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001181]: ice1724: Invalid EEPROM version 1
Date: Fri, 17 Jun 2005 22:48:26 +0200
Message-ID: <5332c1c87fa9fdb58ba741f9b49d83c3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C5D2A14E
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2005 22:48:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1181> 
======================================================================
Reported By:                bjl667
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1181
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo 2005.0
Kernel Version:             2.6.12-rc4-love2
======================================================================
Date Submitted:             06-10-2005 22:28 CEST
Last Modified:              06-17-2005 22:48 CEST
======================================================================
Summary:                    ice1724: Invalid EEPROM version 1
Description: 
 Upon starting alsa, in dmesg I get:
 EcX / # dmesg | grep ice
 ice1724: Invalid EEPROM version 1

 EcX / # cat /proc/asound/cards
 0 [AV710          ]: ICE1724 - Chaintech AV-710
                      Chaintech AV-710 at 0xa000, irq 16

 I can play music in XMMS.. Then close it after that my sound stops
working I gotta restart alsasound to make it work again. I dunno wtf it is
my card is a Chaintech AV-710 (ENVY24HT-S)

 From what it seems this is another version of the Chaintech card..
======================================================================

----------------------------------------------------------------------
 bjl667 - 06-16-05 00:00 
----------------------------------------------------------------------
EcX / # cat /proc/asound/AV710/ice1724
Chaintech AV-710 at 0xa000, irq 18

EEPROM:
  Subvendor        : 0x12142417
  Size             : 28 bytes
  Version          : 1
  System Config    : 0x2
  ACLink           : 0x2
  I2S              : 0x10
  S/PDIF           : 0xc1
  GPIO direction   : 0xff
  GPIO mask        : 0xff
  GPIO state       : 0xff
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=18        : 0x1
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=19        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=20        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=21        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=22        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=23        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=24        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=25        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26        : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=27        : 0x0

Registers:
  PSDOUT03 : 0x00000000
  CCS00    : 0x00
  CCS01    : 0xa0
  CCS02    : 0x00
  CCS03    : 0x00
  CCS04    : 0x02
  CCS05    : 0x02
  CCS06    : 0x10
  CCS07    : 0x41
  CCS08    : 0x00
  CCS09    : 0x00
  CCS0a    : 0x00
  CCS0b    : 0x00
  CCS0c    : 0x00
  CCS0d    : 0x0a
  CCS0e    : 0x00
  CCS0f    : 0x00
  CCS10    : 0x37
  CCS11    : 0x06
  CCS12    : 0x01
  CCS13    : 0x80
  CCS14    : 0x00
  CCS15    : 0xaa
  CCS16    : 0xff
  CCS17    : 0x00
  CCS18    : 0xff
  CCS19    : 0x00
  CCS1a    : 0x00
  CCS1b    : 0x00
  CCS1c    : 0x00
  CCS1d    : 0x00
  CCS1e    : 0x2a
  CCS1f    : 0x00
  MT00     : 0x00
  MT01     : 0x08
  MT02     : 0x00
  MT03     : 0x08
  MT04     : 0x5a
  MT05     : 0x08
  MT06     : 0x21
  MT07     : 0x82
  MT08     : 0x00
  MT09     : 0x00
  MT0a     : 0x00
  MT0b     : 0x00
  MT0c     : 0x00
  MT0d     : 0x00
  MT0e     : 0x00
  MT0f     : 0x00
  MT10     : 0xe0
  MT11     : 0x9f
  MT12     : 0x44
  MT13     : 0x2c
  MT14     : 0x07
  MT15     : 0x18
  MT16     : 0x00
  MT17     : 0x00
  MT18     : 0x00
  MT19     : 0x03
  MT1a     : 0x00
  MT1b     : 0x00
  MT1c     : 0xff
  MT1d     : 0x07
  MT1e     : 0x00
  MT1f     : 0x00
  MT20     : 0x00
  MT21     : 0x00
  MT22     : 0x00
  MT23     : 0x00
  MT24     : 0x00
  MT25     : 0x00
  MT26     : 0x00
  MT27     : 0x00
  MT28     : 0x00
  MT29     : 0x00
  MT2a     : 0x00
  MT2b     : 0x00
  MT2c     : 0x00
  MT2d     : 0x00
  MT2e     : 0x00
  MT2f     : 0x00



----------------------------------------------------------------------
 bjl667 - 06-17-05 22:48 
----------------------------------------------------------------------
Some more info for the devs.

 DAC: Wolfson WM8728
 Chipset: Envy24HT-S VT1721-0445CD
   Other: VT1616 (AC97 Codec)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-10-05 22:28 bjl667         New Issue                                    
06-10-05 22:28 bjl667         Distribution              => Gentoo 2005.0   
06-10-05 22:28 bjl667         Kernel Version            => 2.6.12-rc4-love2
06-14-05 01:56 bjl667         Note Added: 0005014                          
06-15-05 22:35 bjl667         Note Added: 0005047                          
06-16-05 00:00 bjl667         Note Edited: 0005047                         
06-17-05 22:48 bjl667         Note Added: 0005081                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
